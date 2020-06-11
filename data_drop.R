## Libraries
remotes::install_github("como-ph/comoparams")
library(comoparams)
library(dplyr)
library(magrittr)
library(ggplot2)

## Pull Data Drop data for current date
data_drop <- ph_get_cases()

data_drop <- read.csv("data/DOH COVID Data Drop_ 20200610 - 04 Case Information.csv")
data_drop <- read.table(file = "data/DOH COVID Data Drop_ 20200610 - 04 Case Information.csv",
                        header = TRUE, sep = ",")

## Calculate number of cases and deaths per day
cases_data <- data_drop %>% ph_calculate_cases()

## Calculate ihr, ifr, hfr
rates_data <- ph_calculate_rates()

## Calculate length of recovery when hospitalised
nus <- ph_calculate_nus()

## Calculate probability of dying when hospitalised
pdeath <- ph_calculate_pdeath()

## plot curves for daily cases and deaths using ggplot2
ph_calculate_cases() %>%
  ggplot(mapping = aes(x = repDate, y = cases)) +
  geom_line()

ph_calculate_cases() %>%
  ggplot() +
  geom_line(mapping = aes(x = repDate, y = cases)) +
  geom_line(mapping = aes(x = repDate, y = deaths))


ph_calculate_cases() %>%
  ggplot() +
  geom_line(mapping = aes(x = repDate, y = cases)) +
  geom_line(mapping = aes(x = repDate, y = deaths))


ph_calculate_cases("2020-06-07") %>%
  ggplot() +
  geom_line(mapping = aes(x = repDate, y = cases), colour = "blue") +
  geom_line(mapping = aes(x = repDate, y = deaths), colour = "red") +
  scale_colour_manual(name = "", values = c("blue", "red"), guide = guide_legend())


###


ph_calculate_cases <- function (df) 
{
  repDate <- seq.Date(from = as.Date("2020-01-01"), to = as.Date(Sys.Date()), 
                      by = 1)
  cases <- 1
  deaths <- ifelse(df$RemovalType != "Died" | is.na(df$RemovalType), 
                   0, 1)
  x <- data.frame(df[, "DateRepConf"], cases)
  testDateFormat <- tryCatch(expr = lubridate::dmy(x$DateRepConf), 
                             warning = function(w) w)
  if (lubridate::is.Date(testDateFormat)) {
    x$DateRepConf <- testDateFormat
  }
  else {
    testDateFormat <- tryCatch(expr = lubridate::mdy(x$DateRepConf), 
                               warning = function(w) w)
    if (lubridate::is.Date(testDateFormat)) {
      x$DateRepConf <- testDateFormat
    }
    else {
      x$DateRepConf <- lubridate::ymd(x$DateRepConf)
    }
  }
  y <- data.frame(df[, "DateDied"], deaths)
  testDateFormat <- tryCatch(expr = lubridate::dmy(y$DateDied), 
                             warning = function(w) w)
  if (lubridate::is.Date(testDateFormat)) {
    y$DateDied <- testDateFormat
  }
  else {
    testDateFormat <- tryCatch(expr = lubridate::mdy(y$DateDied), 
                               warning = function(w) w)
    if (lubridate::is.Date(testDateFormat)) {
      y$DateDied <- testDateFormat
    }
    else {
      y$DateDied <- lubridate::ymd(y$DateDied)
    }
  }
  dailyCases <- stats::aggregate(cases ~ DateRepConf, data = x[, 
                                                               c("DateRepConf", "cases")], FUN = sum, drop = FALSE)
  dailyCases <- merge(data.frame(repDate), dailyCases, by.x = "repDate", 
                      by.y = "DateRepConf", all.x = TRUE)
  dailyCases$cases <- ifelse(is.na(dailyCases$cases), 0, dailyCases$cases)
  dailyDeaths <- stats::aggregate(deaths ~ DateDied, data = y[, 
                                                              c("DateDied", "deaths")], FUN = sum, drop = FALSE)
  dailyDeaths <- merge(data.frame(repDate), dailyDeaths, by.x = "repDate", 
                       by.y = "DateDied", all.x = TRUE)
  dailyDeaths$deaths <- ifelse(is.na(dailyDeaths$deaths), 0, 
                               dailyDeaths$deaths)
  casesDeaths <- merge(dailyCases, dailyDeaths, all.x = TRUE)
  return(casesDeaths)
}


