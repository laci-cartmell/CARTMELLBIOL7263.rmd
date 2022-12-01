
## Install Packages

install.packages("readr")
install.packages("tidyverse")
library(tidyverse)

## Read in file

MBT_ebird <- read.csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/MBT_ebird.csv?raw=true") #read in my ebird csv file from github account

View(MBT_ebird)   #View the file


## Most individual birds, how many?
# group by year, the summarize count for each year?

MBT_COUNT2 <- MBT_ebird %>%
  group_by(year) %>%
  summarise(year)

View(MBT_COUNT2)


MBT_COUNT <- MBT_ebird %>%
  group_by(year) %>%
  mutate(year_count = n())
View(MBT_COUNT)

val <- max(MBT_COUNT$year_count)
print(paste("The max count is", val))

years <- filter(MBT_COUNT, year_count == 1672)
yearmaxval <- max(years$year)
print(paste(yearmaxval, "had the max count of birds"))
  
## Problem 2
#in that year, how many different species did I obser\
years %>%
  group_by(scientific_name) %>%
  mutate(year_count = n())


d
