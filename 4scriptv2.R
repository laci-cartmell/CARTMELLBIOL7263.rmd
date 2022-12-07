
## Install Packages

install.packages("readr")
install.packages("tidyverse")
library(tidyverse)

## Read in file

MBT_ebird <- read.csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/MBT_ebird.csv?raw=true") #read in my ebird csv file from github account

View(MBT_ebird)   #View the file
#count_tot -> total number of birds seen that day
#count -> count of times a species was observed


## Problem 1
## Which year has the most individual birds, how many?

# group by year, the summarize count for each year?


MBT_COUNT <- MBT_ebird %>%
  group_by(year) %>%
  mutate(year_count = n())

# Now, group by year, and create col of year counts
MBT_COUNT <- MBT_ebird %>%
  group_by(year) %>%
  mutate(year_count = n())
#Check year count worked
View(MBT_COUNT)
#    good2go

val <- max(MBT_COUNT$year_count)
print(paste("The max count is", val))

years <- filter(MBT_COUNT, year_count == 1672)
yearmaxval <- max(years$year)
print(paste(yearmaxval, "had the max count of birds"))
  
View(years)

############
## Problem 2
## in that year, how many different species did I observe?


#count all unique instance of name
species_count <- n_distinct(years$scientific_name)
species_count
print(paste(species_count, "species were observed."))

############
## Problem 3
## Which state, most freq. observe red-winged blackbirds
#use filter to find pattern of red-winged blackbirds
#create new tibble with only those matches
#group by state, create count var

RWB_COUNT <- MBT_ebird %>%
  filter(common_name == "Red-winged Blackbird") %>%
  group_by(location) %>%
  mutate(location_count = n())
View(RWB_COUNT)

# Location_count * count to give total # of rwb in each state
RWB_COUNT <- mutate(RWB_COUNT, stateobs = location_count * count)
View(RWB_COUNT)

#max ohs. from RWB Counts
toprwb <- max(RWB_COUNT$stateobs)

statetoprwb <- filter(RWB_COUNT, stateobs == toprwb)
View(statetoprwb)

print(paste(statetoprwb$location, "is where most RWBs were found in "))


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
