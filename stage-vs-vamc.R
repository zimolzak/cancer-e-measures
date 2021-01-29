library(dplyr)
library(tidyr)
library(ggplot2)
library(here)

colon = read.csv(here("ajz-colon-stg-sta3n.csv"), header=FALSE, col.names=c('station', 'stage', 'count'))
lung  = read.csv(here("ajz-lung-stg-sta3n.csv"), header=FALSE, col.names=c('station', 'stage', 'count'))

colon %>%
mutate_at(vars(station, stage), ~ as.factor(.)) %>%
pivot_wider(names_from = stage, values_from = count) %>%
mutate(early =`0` + I + II, late=III +IV, measure = late / (early+late))->
colon_tidy

qplot(colon_tidy$measure) + labs(title='Distribution of early/late measure by VAMC', x='Measure', y='Count')