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
