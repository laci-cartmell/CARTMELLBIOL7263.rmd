##  _____________________
##
## Script: Amy West Lesson
##
## Purpose of script:
##
## Author: Laci Cartmell
##
## Date Created: 2022-11-03
##
##
## _____________________
##
## Notes:
##   
##
## _____________________

## load the packages needed: 

install.packages("MuMIn") 

#Stands for Multi-Model Inference
#Calculates AICc scores
#Automated model generation

install.packages("AICcmodavg") 

#stands for AICc model averaging
#Does other things, but we will primarily use it to make pretty AIC tables

library(MuMIn)
library(AICcmodavg)

#simple way to get rid of NA's
##glm will automatically drop NA's in independent variables, but not dependent 
banding <- SD_banding_data
banding_na<-na.omit(banding)

glm_example<- glm(  #glm function to run model
  mass~  #dependent variables that you want to predict
    species+fat+wing*tarsus, #independent variables that you want to use to predict
  ## * indicates interaction
  data = banding_na,  #reference data set
  family=gaussian, #reference family name (here is where you would also put your link function)
)



#Trick: turn your binomial variable into 1's and 0's
banding$location_numeric<-ifelse( #name a new variable, and use if else function
  banding$location=="Forb",0,1) #if location equals "Forb" turn into a 0 else turn it into a 1

#binomial glm, same as gaussian, but change family name
Band_binomial<- glm(location_numeric~temp, data= banding, family=binomial)
#not very useful, gives you intercepts for each variable
glm_example

#nicer, but this is not a t-test
summary(glm_example)

#Heck yeah! P-values, but have to go to one of above summaries to get intercept estimates
anova(glm_example, test="F")

#################################
### PART 2 - IC
#################################
AIC(glm_example)
AICc(glm_example)
#create a large model with thoughtful variables
band_model<- glm(mass~species+tarsus*wing+fat, data = banding_na, family=gaussian,
                 na.action = na.fail) #have to include line to knit, but it works better if you run code without na.action

#modeling dredging
AICc_band_models <- dredge( #construct all possible models
  band_model,    #use band model as a reference
  rank = "AICc", #use AICc scores to compare
  fixed = "species") #list variables that you want to include in every model
## use NULL if you don't want to include

#Make a list of all the models
model_list <- get.models(AICc_band_models, #retrieve models from dredged data
                         subset = TRUE) #select which models to retrieve
##1:10 gives you top 10 models
## subset = TRUE gives you all the models

model_list[1] #check out info from a single model

library(AICcmodavg)
#Make a messy but informative AICc table
AICc_table_band<-model.sel(model_list)

#Trick: create a list of model names
model_name_list<-NULL #make an empty list

for (i in 1:10){
  model_name_list = c(model_name_list, as.character(model_list[[i]][['formula']]))
} #loop through model output to extract formula for each model

model_name_listb <- model_name_list[seq(3, length(model_name_list), 3)] #select every third element from list and put it in a new list

modavg_table<-aictab(model_list, #make a table with models from your list
                     modnames = model_name_listb, #label the models with your names list
                     second.ord = TRUE,   #Use AICc (FALSE gives you AIC)
                     sort = TRUE) #Order based on model weight

#View table
modavg_table


