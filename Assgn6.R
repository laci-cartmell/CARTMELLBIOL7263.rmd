##  _____________________
##
## Script: Assignment 6
##
## Purpose of script: ggplot and Inkscape
##
## Author: Laci Cartmell
##
## Date Created: 2022-12-12
##
##
## _____________________
##
## Notes:  ebird already saved
##   
##
## _____________________

## load the packages needed: 
require(tidyverse)
require(ggplot2)
require(dplyr)

#load in data
MBT_ebird <- read_csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/MBT_ebird.csv?raw=true")
View(MBT_ebird)

# Part 1
# Total # of species each month, each year, in each location
#

totals_MBT <- MBT_ebird %>%
  group_by(location, year, month) %>%
  count(scientific_name) %>%
  summarise(total_species = n())
view(totals_MBT)

#What are our vars
years <- unique(MBT_ebird$year)
locations <- unique(MBT_ebird$location)
months <- unique(MBT_ebird$month)

#factor them with levels for 
MBT_fact <- MBT_ebird %>%
  mutate(class = factor(location, levels = unique(MBT_ebird$location)))



group_by(year) %>%
  mutate(month_count = n())
View(month_count)
# Plot # of species each month - color points = yeawr, facet by location
