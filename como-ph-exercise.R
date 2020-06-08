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

## Some notes on the topic
link <- "https://psa.gov.ph/sites/default/files/attachments/hsd/pressrelease/"
fname <- "Updated%20Population%20Projections%20based%20on%202015%20POPCEN_0.xlsx"

paste(link, fname, sep = "")

## Use function
population_psa_2015 <- ph_get_psa2015_pop(file = paste(link, fname, sep = ""))

## Template syntax
population_psa_2015[r, c]

## Use of index - get row 100, all columns
population_psa_2015[100, ]

##


##

## June 8, 2020 session

## Pulling data ----------------------------

## DataDropPH ------------------------------

ph_get_cases()
ph_get_cases(date = "2020-06-07")


## PSA2015 ---------------------------------

##https://psa.gov.ph/sites/default/files/attachments/hsd/pressrelease/
##Updated%20Population%20Projections%20based%20on%202015%20POPCEN_0.xlsx

link <- "https://psa.gov.ph/sites/default/files/attachments/hsd/pressrelease/"
fname <- "Updated%20Population%20Projections%20based%20on%202015%20POPCEN_0.xlsx"

data_psa_2015 <- ph_get_psa2015_pop(file = paste(link, fname, sep = ""))

data_psa_2015

## tibble to data frame 
data.frame(data_psa_2015)
as.data.frame(data_psa_2015)

## Use of index - get row 100, all columns -

data_psa_2015[100, ]
names(data_psa_2015)

## all rows of data year 2020
data_psa_2015[data_psa_2015$year == 2020, ]
## all rows of data age 0-4
data_psa_2015[data_psa_2015$age_category == "0-4", ]
## all rows 2020 and 5-9

data_psa_2015[data_psa_2015$year == 2020 & data_psa_2015$age_category == "5-9", 4]
data_psa_2015[data_psa_2015$year == 2020 & data_psa_2015$age_category == "5-9", "total"]

## with function 

data_psa_2015[with(data_psa_2015, year == 2020 & age_category == "5-9"), 4]


## UN 2019 ---------------------------------





