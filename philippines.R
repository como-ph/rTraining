## Exercise: Get Philippines specific data on cases from Data Drop #############

## Load libraries
remotes::install_github("como-ph/comoparams")
library(comoparams)
library(dplyr)
library(magrittr)
library(ggplot2)
library(openxlsx)

## Get daily cases, deaths and recovered for Quezon City
cases <- ph_get_cases() %>%
  ph_calculate_cases()

## Get rates for Quezon City
rates <- ph_get_cases() %>%
  ph_calculate_rates()

## Save results as XLSX file
params <- openxlsx::createWorkbook()

openxlsx::addWorksheet(wb = params, sheetName = "cases")
openxlsx::writeData(wb = params, x = cases, sheet = "cases")

openxlsx::addWorksheet(wb = params, sheetName = "rates")
openxlsx::writeData(wb = params, x = rates, sheet = "rates")

openxlsx::saveWorkbook(wb = params, file = "parametersPH.xlsx", overwrite = TRUE)