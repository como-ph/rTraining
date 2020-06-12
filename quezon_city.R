## Exercise: Get Quezon City specific data on cases from Data Drop #############

## Load libraries
library(comoparams)
library(dplyr)
library(magrittr)
library(ggplot2)

## Pull cases data
cases <- ph_get_cases()

## Extract Quezon City specific data from cases
casesQC <- cases %>%
  filter(CityMunRes == "QUEZON CITY")

## Create data.frame of per day cases, deaths and recovered

## Cases by day
casesQCbyDay <- casesQC %>%
  group_by(DateRepConf) %>%
  count() %>%
  rename(repDate = DateRepConf,
         cases = n)

## Deaths by day
deathsQCbyDay <- casesQC %>%
  filter(DateDied != "") %>%
  group_by(DateDied) %>%
  count() %>%
  rename(repDate = DateDied,
         deaths = n)

## Recovered by day
recoverQCbyDay <- casesQC %>%
  filter(DateRecover != "") %>%
  group_by(DateRecover) %>%
  count() %>%
  rename(repDate = DateRecover,
         recovered = n)

## Merge cases, deaths and recovered
casesDeathsRecovered <- casesQCbyDay %>%
  inner_join(deathsQCbyDay) %>%
  inner_join(recoverQCbyDay) %>%
  mutate(repDate = as.Date(repDate))

## Fill the missing dates
repDate <- seq.Date(from = as.Date(casesDeathsRecovered$repDate[1]), 
                    to = as.Date("2020-06-11"), 
                    by = 1)

## Convert repDate to data.frame
repDate <- data.frame(repDate)

## Merge repDate to casesDeathsRecovered to fill days with no cases/deaths/recovered
casesDeathsRecovered <- repDate %>%
  left_join(casesDeathsRecovered) %>%
  mutate(cases = ifelse(is.na(cases), 0, cases),
         deaths = ifelse(is.na(deaths), 0, deaths),
         recovered = ifelse(is.na(recovered), 0, recovered))





  