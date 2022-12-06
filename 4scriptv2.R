
## Install Packages

install.packages("readr")
install.packages("tidyverse")
library(tidyverse)

## Read in file

MBT_ebird <- read.csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/MBT_ebird.csv?raw=true") #read in my ebird csv file from github account

View(MBT_ebird)   #View the file

## Problem 2
## Which year has the most individual birds, how many?

# group by year, the summarize count for each year?
<<<<<<< HEAD

MBT_COUNT2 <- MBT_ebird %>%
  group_by(year) %>%
  summarise(year)

View(MBT_COUNT2)


MBT_COUNT <- MBT_ebird %>%
  group_by(year) %>%
  mutate(year_count = n())
=======
# Now, group by year, and create col of year counts
MBT_COUNT <- MBT_ebird %>%
  group_by(year) %>%
  mutate(year_count = n())
#Check year count worked
>>>>>>> 29582be94020f2340208a29ae3dd90329e4a4741
View(MBT_COUNT)
#    good2go

<<<<<<< HEAD
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
=======
#output max value w/in year count
maxcount <- max(MBT_COUNT$year_count)
#tibble with only values from the year with most counts
maxyear <- filter(MBT_COUNT, year_count == val)
View(maxyear)
 
## Problem 2
## in that year, how many different species did I observe?
#count all unique instance of name
species_count <- n_distinct(maxyear$scientific_name)
species_count

## Problem 3
## Which state, most freq. observe red-winged blackbirds
#use search to find pattern of red-winged blackbirds
#create new tibble with only those matches
#group by state, create count var
#print resutlsyear has the most individual birds, how many?


## Problem 4
## Filter 5-200min duration. Find mean rate per checklist that I encounter species each year
# calculate number of species in each checklist / duration - take mean for year

#use search to find pattern of red-winged blackbirds
#create new tibble with only those matches
#group by state, create count var
#print resutlsyear has the most individual birds, how many?



## Problem 5
## tibble w/10 top freq.obsv.species. 
# make a top ten list _ sort by observations, then remove unique species ,  head of ten
# filter observations with that list
# export tibble to csv in folder 'Results' w/in R project
# add link to markdown doc.











#select all species names and put in list
species_count <- maxyear %>%
  group_by(scientific_name) %>%
  mutate(scientific_name_count = n())

View(species_count)
#find max value
maxcountspecies <- max(species_count$scientific_name_count)

print(maxcountspecies)
>>>>>>> 29582be94020f2340208a29ae3dd90329e4a4741
