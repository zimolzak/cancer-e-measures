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
pivot_wider(names_from = stage, values_from = count) %>%
mutate(early =`0` + I + II, late=III +IV, total = early+late, measure = late / (early+late))->
colon_tidy

lung %>%
mutate_at(vars(station, stage), ~ as.factor(.)) %>%
pivot_wider(names_from = stage, values_from = count) %>%
mutate(early =`0` + I + II, late=III +IV, total = early+late,  measure = late / (early+late))->
lung_tidy

qplot(colon_tidy$measure) + labs(title='Distribution of colon late/total measure by VAMC', x='Measure', y='Count') + xlim(0,1)
qplot(lung_tidy$measure) + labs(title='Distribution of lung late/total measure by VAMC', x='Measure', y='Count') + xlim(0,1)


#### plot volume and stage by station

colon_tidy %>%
pivot_longer(cols = early:late, names_to = 'stage', values_to = 'count') %>%
select(station, stage, count, total) %>%
mutate(sta_reo = fct_reorder(station, total, .desc=TRUE)) %>%
filter(!is.na(total))->
colon_el

lung_tidy %>%
pivot_longer(cols = early:late, names_to = 'stage', values_to = 'count') %>%
select(station, stage, count, total) %>%
mutate(sta_reo = fct_reorder(station, total, .desc=TRUE)) %>%
filter(!is.na(total))->
lung_el

ggplot(colon_el, aes(sta_reo, count)) + geom_col(aes(fill=stage)) + labs(title='Colon early and late, by VAMC', x='VA medical center')
ggplot(lung_el, aes(sta_reo, count)) + geom_col(aes(fill=stage)) + labs(title='Lung early and late, by VAMC', x='VA medical center')