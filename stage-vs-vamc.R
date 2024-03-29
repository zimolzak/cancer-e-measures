library(dplyr)
library(tidyr)
library(ggplot2)
library(here)
library(forcats)

colon = read.csv(here("ajz-colon-stg-sta3n.csv"), header=FALSE, col.names=c('station', 'stage', 'count'))
lung  = read.csv(here("ajz-lung-stg-sta3n.csv"), header=FALSE, col.names=c('station', 'stage', 'count'))




#### calculate the measure, plot simple distribution

colon %>%
mutate_at(vars(station, stage), ~ as.factor(.)) %>%
pivot_wider(names_from = stage, values_from = count, values_fill = 0) %>%
mutate(early =`0` + I + II, late=III +IV, total = early+late, measure = late / (early+late)) %>%
mutate(tot_missing = `NULL` + `NA` + `Unk/Uns`, proportion_missing = tot_missing / (total + tot_missing) ) %>%
mutate(missing_is_late_meas = (late + tot_missing) / (total + tot_missing)) ->
colon_tidy

lung %>%
mutate_at(vars(station, stage), ~ as.factor(.)) %>%
pivot_wider(names_from = stage, values_from = count, values_fill = 0) %>%
mutate(early =`0` + I + II, late=III +IV, total = early+late, measure = late / (early+late)) %>%
mutate(tot_missing = `NULL` + `NA` + `Unk/Uns`, proportion_missing = tot_missing / (total + tot_missing) ) %>%
mutate(missing_is_late_meas = (late + tot_missing) / (total + tot_missing)) ->
lung_tidy

qplot(colon_tidy$measure) + labs(title='Distribution of colon late/total measure by VAMC', x='Measure', y='Count') + xlim(0,1)
qplot(lung_tidy$measure) + labs(title='Distribution of lung late/total measure by VAMC', x='Measure', y='Count') + xlim(0,1)

cat('\n\nTotal cases ajz-colon-stg-sta3n.csv')
colon_tidy %>%
select(`NULL`, `0`, I, II, III, IV, `Unk/Uns`, early, late, total, tot_missing) %>%
summarise_all(sum)

cat('\n\nTotal cases ajz-lung-stg-sta3n.csv')
lung_tidy %>%
select(`NULL`, `0`, I, II, III, IV, `Unk/Uns`, early, late, total, tot_missing) %>%
summarise_all(sum)

cat('\n\nColorectal stage measure by VAMC\n')
quantile(colon_tidy$measure, probs = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1), na.rm=TRUE)
cat('\n\nLung stage measure by VAMC\n')
quantile(lung_tidy$measure, probs = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1), na.rm=TRUE)

write.csv(colon_tidy, here("colon-tidy.csv"))
write.csv(lung_tidy, here("lung-tidy.csv"))




#### plot volume and stage by station

colon_tidy %>%
pivot_longer(cols = early:late, names_to = 'stage', values_to = 'count') %>%
select(station, stage, count, total) %>%
mutate(sta_reo = fct_reorder(station, total, .desc=TRUE)) ->
colon_el

lung_tidy %>%
pivot_longer(cols = early:late, names_to = 'stage', values_to = 'count') %>%
select(station, stage, count, total) %>%
mutate(sta_reo = fct_reorder(station, total, .desc=TRUE)) ->
lung_el

ggplot(colon_el, aes(sta_reo, count)) + geom_col(aes(fill=stage)) + labs(title='Colon early and late, by VAMC', x='VA medical center')
ggplot(lung_el, aes(sta_reo, count)) + geom_col(aes(fill=stage)) + labs(title='Lung early and late, by VAMC', x='VA medical center')

# Two more plots starting to think about large/small VAs

qplot(colon_tidy$total, colon_tidy$measure) + labs(title='Colon late/total measure, by volume', x = 'Total cancer cases', y='Measure') + geom_smooth() + ylim(0,1)
qplot(lung_tidy$total, lung_tidy$measure) + labs(title='Lung late/total measure, by volume', x = 'Total cancer cases', y='Measure') + geom_smooth() + ylim(0,1)

# UK like plots

qplot(colon_tidy$proportion_missing, colon_tidy$measure) + labs(title='Complete-case colon cancer measure', x = 'Proportion of all tumors which have missing stage', y='Late stage proportion') + geom_smooth() + ylim(0,1) + xlim(0,1)

qplot(colon_tidy$proportion_missing, colon_tidy$missing_is_late_meas) + labs(title='Missing-is-late colon cancer measure', x = 'Proportion of all tumors which have missing stage', y='Late stage proportion') + geom_smooth() + ylim(0,1) + xlim(0,1)

qplot(lung_tidy$proportion_missing, lung_tidy $measure) + labs(title='Complete-case lung cancer measure', x = 'Proportion of all tumors which have missing stage', y='Late stage proportion') + geom_smooth() + ylim(0,1) + xlim(0,1)

qplot(lung_tidy$proportion_missing, lung_tidy $missing_is_late_meas) + labs(title='Missing-is-late lung cancer measure', x = 'Proportion of all tumors which have missing stage', y='Late stage proportion') + geom_smooth() + ylim(0,1) + xlim(0,1)




#################### Second data pull, by YEAR now!

lung2  = read.csv(here("sta3n-stage-year-lung.tsv"),  header=TRUE, sep = "\t", stringsAsFactors=FALSE)

lung2 %>%
mutate(station = as.factor(sta3n), stage = as.factor(stagegroupingajcc), year = as.numeric(yeardx)) %>%
rename(count = n) %>%
select(station, stage, count, year) %>%
pivot_wider(names_from = stage, values_from = count, values_fill = 0) %>%
mutate(early=`0`+I+II, late=III+IV, total=early+late, measure = late / (early+late)) %>%
mutate(tot_missing = `NULL` + `NA` + `Unk/Uns`, proportion_missing = tot_missing / (total + tot_missing) ) %>%
select(-`NULL`, -`NA`, -`Unk/Uns`, -I, -II, -III, -IV, -`0`) ->
lung2_tidy

lung2_tidy %>%
select(station, year, total, measure) %>%
group_by(station) %>%
summarise(s = sum(total)) ->
sum_by_station

sum_by_station %>%
summarise(m = median(s)) ->
med

MEDIAN_VOLUME = med$m

lung2_tidy %>%
inner_join(sum_by_station) %>%
filter(s >= MEDIAN_VOLUME, year >= 2010) ->
lung2_hivol

lung2_tidy %>%
group_by(year) %>%
summarise(grand_tot = sum(total)) ->
lung_by_year

cat('\n\nTotal cases sta3n-stage-year-lung.tsv')
lung2_tidy %>%
select(early, late, total, tot_missing) %>%
summarise_all(sum)

# FIXME - need to implement all the above for colon2 as well.




#### plots

ggplot(lung_by_year, aes(year, grand_tot)) + geom_col() + labs(title='Lung cancer cases by year')

big_facet_theme =   theme(panel.background = element_rect(fill = "white"), axis.text = element_text(size=rel(0.5)), strip.text = element_text(size=rel(0.5)), axis.text.x = element_text(color="white"), axis.ticks.x = element_line(color="white"))

ggplot(lung2_tidy, aes(year, total)) + geom_col() + facet_wrap(vars(station)) + big_facet_theme + scale_y_continuous(breaks=c(0,250)) + labs(title='Lung cancer cases by station by year, 2000-2020', y='') + xlim(2000,2020)

# ggplot(lung2_tidy, aes(year, measure)) + geom_line() + facet_wrap(vars(station)) + big_facet_theme + xlim(2010,2020) + labs(title="Lung stage measure, 2010-2020", y='')

ggplot(lung2_hivol, aes(year, measure)) + geom_hline(yintercept = 0.5, color="gray70") + geom_line() + facet_wrap(vars(station)) + big_facet_theme + xlim(2010,2020) + labs(title="Lung stage measure, 2010-2020, busiest stations", y='')

ggplot(lung2_hivol, aes(year, measure, color=station)) + geom_line() + xlim(2010,2020) + labs(title="Lung stage measure, 2010-2020, busiest stations") + theme(legend.position="none")
