library(dplyr)
library(ggplot2)
library(here)

colon = read.csv(here("ajz-colon-stg-sta3n.csv"), header=FALSE, col.names=c('station', 'stage', 'count'))
lung  = read.csv(here("ajz-lung-stg-sta3n.csv"), header=FALSE, col.names=c('station', 'stage', 'count'))

colon %>%
mutate_at(vars(station, stage), ~ as.factor(.)) ->
colon_tidy

head(colon_tidy)
