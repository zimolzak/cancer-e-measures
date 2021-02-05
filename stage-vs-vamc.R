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




#### re-create

colon_el %>%
select(station, stage, count, sta_reo) %>%
mutate(lateness = case_when(stage=='early' ~ 0, stage=='late' ~ 1)) %>%
uncount(weights = count) ->
colon_uncounted

col_model = aov(lateness ~ station, data=colon_uncounted)
summary(col_model)
plot(col_model)
