## code to prepare `example-data` dataset goes here

df_all <- read.csv("https://storage.googleapis.com/covid19-open-data/v2/epidemiology.csv")

library(dplyr)

df_it <- df_all %>%
  na.omit() %>%
  filter(key == "IT") %>%
  transmute(date = as.Date(date),
            new_cases = new_confirmed,
            new_deaths = new_deceased,
            new_recoveries = new_recovered)

saveRDS(df_it, "inst/extdata/covid19_italy.rds")