##  _____________________
##
## Script: Assignment 5
##
## Purpose of script: Practice tidyr and merge
##
## Author: Laci Cartmell
##
## Date Created: 2022-12-12
##
#### _____________________
##
## Notes:
##   
## _____________________

## load the packages needed: 
require(tidyverse)

#Download and import data
Part1 <- read_csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/assignment6part1.csv?raw=true")
Part2 <- read_csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/assignment6part2.csv?raw=true")
View(Part1) # body_length, age
View(Part2) # mass

############
## Problem 1

# part 1 has 2 rows (body_length, age) with Sample00_Sex_Treatment 
# Part 2 has 1 row (mass) with Sample00_Treatment 
# 
# so when joining better to join 2 with 1
# Wide data - Each row is seperate groupingbest if converted to 3 col
# Want long data - each row own observation

#seperate out subject column into 3 cols
p1_1 <- Part1 %>%
  pivot_longer(cols = !ID, names_to = c("Subject", "Sex", "Treatment"), names_sep= "_")
View(p1_1)

#change ID col, into 2
p1_2 <- p1_1 %>%
  pivot_wider(names_from = ID, values_from = value)
View(p1_2)

p2_1 <- Part2 %>%
  pivot_longer(col=!ID, names_to = c("Subject"),
                        names_pattern = "(Sample1?.)..*")
View(p2_1)  #id, subject, value

#now join for mass
p2_2 <- p2_1 %>%
  pivot_wider(names_from = ID, values_from = value)
View(p2_2)

## Join Parts together to make a whole
#export as .csv in folder called Results
write_csv(p1_2 %>%
  inner_join(p2_2, by = "Subject"),
  "Results/Assn5_Whole.csv")

############
## Problem 2

#New tibble w/ mean +/- standard deviation of the residual mass (mass/body length) 
#   by treatment and sex - group-by?
#export as a .csv file to "Results" folder within your R projec

#add in our tibble
Whole <- read_csv("Results/Assn5_Whole.csv")
View(Whole)
#mean and st.dev for residual mass (mass/body length)
Whole_T <- Whole %>%
  group_by(Treatment) %>%
  mutate(resid_mass = mass / body_length) %>%
  summarize(mean_resid_mass = mean(resid_mass),
            SD_resid_mass = sd(resid_mass))
View(Whole_T)  

Whole_S <- Whole %>%
  group_by(Sex) %>%
  mutate(resid_mass = mass / body_length) %>%
  summarize(mean_resid_mass = mean(resid_mass),
            SD_resid_mass = sd(resid_mass))
View(Whole_S)


#Now we need to combine T and S tibbles
write_csv(Whole_T %>%
            full_join(Whole_S), "Results/Assign5_Whole_Complete.csv")
