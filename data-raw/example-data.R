## code to prepare `example-data` dataset goes here

df <- read.csv("https://storage.googleapis.com/covid19-open-data/v2/epidemiology.csv")

library(dplyr)

df2 <- df %>%
  filter(key == "US_NY") %>%
  transmute(date = as.Date(date),
            new_cases = new_confirmed,
            new_deaths = new_deceased,
            new_recoveries = new_recovered)

saveRDS(df2, "inst/extdata/covid19_ny.rds")
