##  _____________________
##
## Script: Week 6 Notes
##
## Purpose of script: Class notes
##
## Author: Laci Cartmell
##
## Date Created: 2022-09-29
##
##
## _____________________
##
## Notes:
##  Tidy data 3 rules;
##
## _____________________

## load the packages needed: 
require(tidyverse)

relig_income

# income var is spread across rows. observation =count
# want religion, income range, and count as our 3 var

relig_income %>% pivot_longer(cols = c("<$10k", "$10-20k", "$20-30k", "$30-40k", "$40-50k", "$50-75k", "$75-100k", "$100-150k", ">150k", "Don't know/refused"), names_to = "income", values_to = "count")

#We can simplify this by specifying the range of columns
relig_income %>% 
  pivot_longer(cols = "<$10k":"Don't know/refused", names_to = "income", values_to = "count")

#We can simplify this by selected the "not religion" rather than specifying all of the columns individually
relig_income %>% 
  pivot_longer(cols = !religion, names_to = "income", values_to = "count") # ! "are not"

# if we want it in our environment, 
relig_inc_tidy <- relig_income %>% 
  pivot_longer(cols = !religion, names_to = "income", values_to = "count") # ! "are not"

## column name to numberic var
billboard %>%
  pivot_longer(
    cols = starts_with("wk"), #pivot all columns with names beginning with "wk"
    names_to = "week", #convert column names to a variable called week
    values_to = "rank", #reorganize observations in each column into a variable called rank
    values_drop_na = TRUE #drop NAs from the pivoted data set
  )
arrange(billboard, by =wk1)

billboard %>% 
  pivot_longer(
    cols = starts_with("wk"), #pivot all columns with names beginning with "wk"
    names_to = "week", #convert column names to a variable called week
    values_to = "rank", #reorganize observations in each column into a variable called rank
    values_drop_na = TRUE #drop NAs from the pivoted data set
  )

billboard %>% 
  pivot_longer(
    cols = starts_with("wk"), #pivot all columns with names beginning with "wk"
    names_to = "week", #convert column names to a variable called week
    names_prefix = "wk", #this command strips off the "wk" prefie from the column name
    names_transform = list(week = as.integer), #this option transforms the variable type from a string to integer
    values_to = "rank", #reorganize observations in each column into a variable called rank
    values_drop_na = TRUE, #drop NAs from the pivoted data set
  )


who %>% pivot_longer(
  cols = new_sp_m014:newrel_f65, #specify the range of columns to pivot
  names_to = c("diagnosis", "gender", "age"), #specify the new names for the variables that will be extracted from the column names
  names_pattern = "new_?(.*)_(.)(.*)", #use "("")" to select elements of the regular expression. Here the "?" indicates 0 or 1 "_" is possible after "new". 
  values_to = "count") %>%
  glimpse()

#

family <- tribble(
  ~family,  ~dob_child1,  ~dob_child2, ~gender_child1, ~gender_child2,
  1L, "1998-11-26", "2000-01-29",             1L,             2L,
  2L, "1996-06-22",           NA,             2L,             NA,
  3L, "2002-07-11", "2004-04-05",             2L,             2L,
  4L, "2004-10-10", "2009-08-27",             1L,             1L,
  5L, "2000-12-05", "2005-02-28",             2L,             1L,
) 

family <- family %>% mutate_at(vars(starts_with("dob")), parse_date)

family %>% 
  pivot_longer(
    col = !family, #pivot columns that are not family
    names_to = c(".value", "child"), #transform column names to two variables. The special name ".value" tells pivot_longer() that that part of the column name specifies the "value" being measured (which will become a variable in the output) 
    names_sep = "_", #This tells pivot_longer() to split the column names at the "_". 
    values_drop_na = TRUE
  )


table2
table2 %>%
  pivot_wider(names_from = type, values_from = count)

table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")

table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)

#split by number of characters
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = 5)


## seperate notes from excel
field_notes<-tibble(
  ID = c(023, 456, 167, 897), 
  sex = c("F","F","M","F"),
  mass = c("15.6 first sample of the day","16.0","17.2 caught with female 456","14.9 last sample of the day"))

field_notes_sep <- field_notes %>% 
  separate(mass, 
           into = c("mass","notes"), 
           sep = " ", 
           extra = "merge",
           convert = TRUE)
field_notes_sep


## make two different folders in Class Project
# - results, scripts, then link to scripts 