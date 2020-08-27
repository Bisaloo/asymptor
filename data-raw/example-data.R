## code to prepare `example-data` dataset goes here

df <- read.csv("https://storage.googleapis.com/covid19-open-data/v2/epidemiology.csv")

library(tidyverse)

df2 <- df %>%
  filter(key == "US_NY") %>%
  transmute(date = as.Date(date),
            cases = new_confirmed,
            deaths = new_deceased,
            recoveries = new_recovered)

saveRDS(df2, "inst/extdata/covid19_nyc.rds")
