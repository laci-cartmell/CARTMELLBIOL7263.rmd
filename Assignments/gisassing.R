##  _____________________
##
## Script: GIS in R
##
## Purpose of script: Class script
##
## Author: Laci Cartmell
##
## Date Created: 2022-10-20
##
##
## _____________________
##
## Notes: Work on GIS files in R - Raster and Shapefiles
##   created global map with climate data
##   add in click points, create random clicks, mapping model
## _____________________

## load the packages needed: 
install.packages(c("sp","rgdal","raster","rgeos","geosphere","dismo"))
require(tidyverse)

library(sp) # classes for vector data (polygons, points, lines)
library(rgdal) # basic operations for spatial data

library(raster) # handles rasters
library(rgeos) # methods for vector files
library(dismo)

#add in public data

#load a raster
bio1<-raster('GIS LESSONS/WORLDCLIM_Rasters/wc2.1_10m_bio_1.tif')
plot(bio1)
bio1
bio1_f=bio1*(9/5)+32  #c-->F

clim_stack <- stack(list.files('GIS LESSONS/WORLDCLIM_Rasters', full.names = TRUE, pattern = ".tif"))
plot(clim_stack, nc =5)

#subset of climate vars
my_clim_stack <- stack(
  raster('GIS LESSONS/WORLDCLIM_Rasters/wc2.1_10m_bio_1.tif'),
  raster('GIS LESSONS/WORLDCLIM_Rasters/wc2.1_10m_bio_3.tif'),
  raster('GIS LESSONS/WORLDCLIM_Rasters/wc2.1_10m_bio_12.tif')
)
#Look up the variable on https://www.worldclim.org/data/bioclim.html and rename the variable with a more descriptive name.  
names(my_clim_stack) <- c("mean_annual_temp", "Isothermality", "Annual_Precipitation")


plot(my_clim_stack)
pairs(my_clim_stack) #pairs is a base R function that plots univariate distribution and bivariate relationships


#load contry shape files
countries <- shapefile('GIS LESSONS/Country_Shapefiles/ne_10m_admin_0_countries.shp')
countries
head(countries)

nrow(countries) # how many rows?
countries$wantToBeHere <- FALSE # add a column
mexico <- subset(countries, NAME=='Mexico') # subset using subset command
uzbek <- countries[countries$NAME=='Uzbekistan', ] # subset by row
sovereign <- countries[ , 4] # 4th column... but still has all shapes associated with it
countries[ , 'SOVEREIGNT']  # 4th column again... still has all shapes associated with it
countriesDf <- as.data.frame(countries) # remove shape data but keep data frame
plot(countries, col='goldenrod', border='darkblue') #takes time to load, may need to remove

# now to add points

dev.new()
plot(my_clim_stack[[2]]) # plot mean annual temperature
plot(countries, add=TRUE) # add countries shapefile
# pick points to model our climate niche
my_sites <-as.data.frame(click(n=10))


names(my_sites) <- c('longitude', 'latitude')

my_sites

##############

env <- as.data.frame(extract(my_clim_stack, my_sites))
env

# join environmental data and your site data
my_sites <- cbind(my_sites, env)
my_sites


# Creating shapefiles of my sites
myCrs <- projection(my_clim_stack) # get projection info
myCrs
# make into points file
my_sites_shape <- SpatialPointsDataFrame(coords=my_sites, data=my_sites, proj4string=CRS(myCrs))
my_sites_shape

#plot shapefile 
plot(my_clim_stack[[2]])
plot(countries, add=TRUE)  #adds outline but takes a while so can skip
points(my_sites_shape, pch=16) # show sites on the map

#selecting random points
#look for regions that fit in the climate space of you
bg <- as.data.frame(randomPoints(my_clim_stack, n=10000))
head(bg)
names(bg) <- c('longitude', 'latitude')
head(bg)
plot(my_clim_stack[[1]])
points(bg, pch='.') # plot on map

# extract enviro variables for the random points
bgEnv <- as.data.frame(extract(my_clim_stack, bg))
head(bgEnv)

bg <- cbind(bg, bgEnv)
head(bg)

#train the model
pres_bg <- c(rep(1, nrow(my_sites)), rep(0, nrow(bg)))
pres_bg
train_data <- data.frame(
  pres_bg=pres_bg,
  rbind(my_sites, bg)
)

head(train_data)
#"mean_annual_temp", "Isothermality", "Annual_Precipitation

# the model
my_model <- glm(
  pres_bg ~ mean_annual_temp*Isothermality*Annual_Precipitation + I(mean_annual_temp^2) + I(Isothermality^2) + I(Annual_Precipitation^2),
  data = train_data,
  family='binomial',
  weights=c(rep(1, nrow(my_sites)), rep(nrow(my_sites) / nrow(bg), nrow(bg)))
)
summary(my_model)
summary(my_sites)
# use model to predict
my_world <- predict(
  my_clim_stack,
  my_model,
  type='response'
)

my_world

plot(my_world)
plot(countries, add=TRUE)
points(my_sites_shape, col='red', pch=16)

writeRaster(my_world, 'GIS LESSONS/My_Climate_Space/my_world', format='GTiff', overwrite=TRUE, progress='text')
# threshold your "preferred" climate
my_world_thresh <- my_world >= quantile(my_world, 0.75)
plot(my_world_thresh)

# convert all values not equal to 1 to NA...
# using "calc" function to implement a custom function
my_world_thresh <- calc(my_world_thresh, fun=function(x) ifelse(x==0 | is.na(x), NA, 1))

# get random sites
my_best_sites <- randomPoints(my_world_thresh, 10000)
my_best_env <- as.data.frame(extract(my_clim_stack, my_best_sites))


# plot world's climate
smoothScatter(x=bgEnv$mean_annual_temp, y=bgEnv$Annual_Precipitation, col='lightblue')

points(my_best_env$mean_annual_temp, my_best_env$Annual_Precipitation, col='red', pch=16, cex=0.2)
points(my_sites$mean_annual_temp, my_sites$Annual_Precipitation, pch=16)
legend(
  'topleft',
  inset=0.01,
  legend=c('my_world_thresh', 'my niche', 'my locations'),
  pch=16,
  col=c('lightblue', 'red', 'black'),
  pt.cex=c(1, 0.4, 1)
  
)

### ERROR
# > smoothScatter(x=bgEnv$temperature_seasonality, y=bgEnv$precip_driest_quarter, col='lightblue')
# Error in if (!missing(bandwidth) && min(bandwidth) <= 0) stop("'bandwidth' must be strictly positive") : 
#   missing value where TRUE/FALSE needed
# In addition: Warning messages:
#   1: In min(x) : no non-missing arguments to min; returning Inf
# 2: In max(x) : no non-missing arguments to max; returning -Inf
# 3: In min(x) : no non-missing arguments to min; returning Inf
# 4: In max(x) : no non-missing arguments to max; returning -Inf