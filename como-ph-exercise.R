## Load comoparams fron Github ------------
if(!require(remotes)) install.packages("remotes")
remotes::install_github("como-ph/comoparams")

## install and load zscorer from CRAN repository
if(!require(zscorer)) install.packages("zscorer")  ## Best practice
library(zscorer)

## More than one package from CRAN
if(!require(c(zscorer, ggplot2))) install.packages(c("zscorer", "ggplot2"))

if(!require(zscorer)) install.packages("zscorer")
if(!require(ggplot2)) install.packages("ggplot2")
   
## Loading any package
library(comoparams)


## Get population data ----------

## Some notes on the topic - This is the approach to create objects in R
link <- "https://psa.gov.ph/sites/default/files/attachments/hsd/pressrelease/"
fname <- "Updated%20Population%20Projections%20based%20on%202015%20POPCEN_0.xlsx"

paste(link, fname, sep = "")

## Use function
population_psa_2015 <- ph_get_psa2015_pop(file = paste(link, fname, sep = ""))

## converting to data.frame
data.frame(population_psa_2015)
as.data.frame(population_psa_2015)

## Template syntax
#population_psa_2015[r, c]

## Use of index - get row 100, all columns
population_psa_2015[100, ]

## Get all rows of data for year 2020
population_psa_2015[population_psa_2015$year == 2020, ]

## Get all rows of data for age group 0-4
population_psa_2015[population_psa_2015$age_category == "0-4", ]

## Get all rows of data for year 2020 and age group = 5-9 total population
population_psa_2015[population_psa_2015$year == 2020 & population_psa_2015$age_category == "5-9", 4]
population_psa_2015[population_psa_2015$year == 2020 & population_psa_2015$age_category == "5-9", "total"]

population_psa_2015[population_psa_2015$year == 2020 & population_psa_2015$age_category == "5-9", ]

## with function
population_psa_2015[with(population_psa_2015, year == 2020 & age_category == "5-9"), 4]
population_psa_2015[with(population_psa_2015, year == 2020 & age_category == "5-9"), "total"]

population_psa_2015[with(population_psa_2015, year == 2020 & age_category == "5-9"), ]

with(population_psa_2015, total[year == 2020 & age_category == "5-9"])


## Using dplyr to arrive at the same output above
if(!require(dplyr)) install.packages("dplyr")
if(!require(magrittr)) install.packages("magrittr")


## Get population for 2020
population_psa_2015 %>% 
  filter(year == 2020)        ## filter rows of data based on a condition
  
## Get population for age group 0-4
population_psa_2015 %>%
  filter(age_category == "0-4")

## Get population for year 2020 and age group 5-9
population_psa_2015 %>%
  filter(year == 2020 & age_category == "5-9") %>%
  select(total)              ## select columns of data




