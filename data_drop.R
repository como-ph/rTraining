## Libraries
library(comoparams)
library(dplyr)
library(magrittr)
library(ggplot2)

## Pull Data Drop data for current date
data_drop <- ph_get_cases("2020-06-07")

## Calculate number of cases and deaths per day
cases_data <- ph_calculate_cases("2020-06-07")

#data_drop <- ph_get_cases("2020-06-07") %>%
#  ph_calculate_cases()


## Calculate ihr, ifr, hfr
rates_data <- ph_calculate_rates("2020-06-07")

## Calculate length of recovery when hospitalised
nus <- ph_calculate_nus("2020-06-07")


## Calculate probability of dying when hospitalised
pdeath <- ph_calculate_pdeath("2020-06-07")


## plot curves for daily cases and deaths using ggplot2
ph_calculate_cases("2020-06-07") %>%
  ggplot(mapping = aes(x = repDate, y = cases)) +
  geom_line()

ph_calculate_cases("2020-06-07") %>%
  ggplot() +
  geom_line(mapping = aes(x = repDate, y = cases)) +
  geom_line(mapping = aes(x = repDate, y = deaths))


ph_calculate_cases("2020-06-07") %>%
  ggplot() +
  geom_line(mapping = aes(x = repDate, y = cases)) +
  geom_line(mapping = aes(x = repDate, y = deaths))


ph_calculate_cases("2020-06-07") %>%
  ggplot() +
  geom_line(mapping = aes(x = repDate, y = cases), colour = "blue") +
  geom_line(mapping = aes(x = repDate, y = deaths), colour = "red") +
  scale_colour_manual(name = "", values = c("blue", "red"), guide = guide_legend())


