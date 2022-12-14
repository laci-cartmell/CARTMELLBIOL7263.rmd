##  _____________________
##
## Script: Amy West Lesson HW
##
## Purpose of script: Learning about models!
##
## Author: Laci Cartmell
##
## Date Created: 2022-11-03
##
## _____________________
##
## Notes: Create an AICc table
##   GLM w/3 independent vars
##   Create an AICc table
##   
## _____________________

## load the packages needed: 

install.packages("MuMIn") 

#Stands for Multi-Model Inference
#Calculates AICc scores
#Automated model generation

install.packages("AICcmodavg") 

library(MuMIn)
library(AICcmodavg)

#remove NA's with glm
banding <- SD_banding_data
banding_na <- na.omit(banding)


#view the data
View(banding_na)

glm_mass <- glm(mass ~ fat + tarsus*wing + temp,
                data=banding_na,
                family = gaussian)
#view model
summary(glm_mass)

#add p-values
anova(glm_mass, test="F")

#
#
#
### AIC

AIC(glm_mass)
AICc(glm_mass)

#large model with thoughtful vars
# i still want to see what temp does
band_model<- glm(mass~fat+tarsus*wing + temp,
                 data = banding_na, family=gaussian,
                 na.action = na.fail) # Amy's notes: have to include line to knit, but it works better if you run code without na.action

#modeling dredging - constructs all possible models, w/aicc
AICc_band_models <- dredge(
  band_model,
  rank = "AICc",
  fixed = "year") 
## use NULL if you don't want to include

#list of ALL (subset=TRUE)models from dredges
model_list <- get.models(AICc_band_models, 
                         subset = TRUE) 

# view parts of the model
model_list[1]
model_list[2]
model_list[4]


library(AICcmodavg)

#Messy but informative!
#aicc table !
AICc_table1 <- model.sel(model_list)

### better view

#Amy's Trick: create a list of model names
#make an empty list
model_name_list<-NULL

#loopy loops
#   extract formula for each model

for (i in 1:10){
  model_name_list = c(model_name_list,
                      as.character(model_list[[i]][['formula']]))
} 

# seq - selects elements and puts into new list thats named
model_name_listb <- model_name_list[seq(3, 
                                        length(model_name_list), 3)] 

#creates the tables
modavg_table<-aictab(model_list, 
                     modnames = model_name_listb, 
                     second.ord = TRUE,   #Use AICc (FALSE=AIC)
                     soTRUE) #Order based on model weight

#View table
table2 <- modavg_table

####
#
####
# Compare the two tables
#v1
AICc_table1
print(AICc_table1)

#v2
print(modavg_table)



