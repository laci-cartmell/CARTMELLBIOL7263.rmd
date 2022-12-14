
## Install Packages

install.packages("readr")
install.packages("tidyverse")
library(tidyverse)

## Read in file

MBT_ebird <- read.csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/MBT_ebird.csv?raw=true") #read in my ebird csv file from github account

View(MBT_ebird)   #View the file
#count_tot -> total number of birds seen that day
#count -> count of times a species was observed

############
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
## Which  ,li
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
## Filter 5-200min duration. 
## Find mean rate per checklist that I encounter species each year
## calculate number of species in each checklist / duration - take mean for year

#reminder of file format
View(MBT_ebird)

#filter by duration
filtered <- filter(MBT_ebird, duration >= 5 & duration <= 200)
View(filtered)

# Rate of species per list_ID 
rpc <- filtered %>%
  group_by(list_ID) %>%
  mutate(count = n()) %>%    #count of list_id observations
  mutate(rate = count / duration)
View(rpc)

# Take a mean for the year
mean_rate_list <- rpc %>%
  group_by(year) %>%
  summarize(mean_rate_f=mean(rate))
  #mutate(mean_rate = rate / year))
View(mean_rate_list)


############
## Problem 5
## tibble w/10 top freq.obs.species. 
# make a top ten list _ sort by observations, then remove unique species ,  head of ten
# filter observations with that list
# export tibble to csv in folder 'Results' w/in R project
# add link to markdown doc.

#create a ranking of species observations
species_rank_top10 <- MBT_ebird %>%
  group_by(scientific_name) %>%
  summarize(freq = sum(count)) %>%
  arrange(by = desc(freq)) %>%
  head(n=10)
View(species_rank_top10)

#top ten list
top10 <- select(species_rank_top10, 1)

MBT_TOP10 <- MBT_ebird %>%  filter(scientific_name == species_rank_top10$scientific_name)

View(MBT_TOP10)
#write csv
write_csv(MBT_TOP10, "~/CARTMELLBIOL7263.rmd/Assignments/Results/MBT_top10.csv")
