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


#factor month
MBT_month_fact <- totals_MBT %>%
  mutate(class = factor(month, levels = unique(MBT_ebird$month)))
view(MBT_month_fact)

#Plot # of species each month 
#   - color points = year, facet by location
species_month_plot <- ggplot(MBT_month_fact, 
                             aes(month, total_species)) +
  geom_point(aes(color = year), size = 3) +
  facet_wrap(~location) +
  xlab("Month") +
  ylab("Total # of Species")
species_month_plot


# Part 2
# use dataset from Assn. 5 
part2 <- read.csv("Assignments/Results/Assn5_Whole.csv")

view(part2)
#Plot a comparison of mass by treatment
mass_treatment_plot <- ggplot(part2, 
                              aes(Treatment, mass)) +
  geom_jitter(size = 3, aes(Treatment, mass, color = Sex)) +
  xlab("Treatment") +
  ylab("Mass") +
  #add our  stats
  stat_summary(fun = mean, geom = "crossbar", color = "grey") +
  stat_summary(geom = "errorbar") +
  labs(color = "Sex")
mass_treatment_plot



years <- unique(MBT_ebird$year)
locations <- unique(MBT_ebird$location)
months <- unique(MBT_ebird$month)



group_by(year) %>%
  mutate(month_count = n())
View(month_count)
