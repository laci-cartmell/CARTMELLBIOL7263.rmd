##  _____________________
##
## Script: R script - r package
##
## Purpose of script: Creating R Packages
##
## Author: Laci Cartmell
##
## Date Created: 2022-12-01
##
##
## _____________________
##
## Notes:
##   
##
## _____________________

## load the packages needed: 

install.packages(c("devtools", "roxygen2"))
library("devtools") # for 'create_package' function now, and other functions later
library("roxygen2") # automatically generates some of the package documentation for you

#pause here to make sure your working directory is set to your packages project folder. It's important to have the correct working directory before the next step!

create_package("rateLawOrders")


