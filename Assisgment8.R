##  _____________________
##
## Script: Tanner Mierow Lesson
##
## Purpose of script: AcuityView
##
## Author: Laci Cartmell
##
## Date Created: 2022-10-27
##
##
## _____________________
##
## Notes:
##   
##    https://tanman6711.github.io/MierowBIOL7263/Assignments/AcuityViewLesson.html
## _____________________

## load the packages needed: 
install.packages("AcuityView")
install.packages('magrittr')
install.packages('imager')
install.packages('fftwtools')

library(AcuityView) 
library(fftwtools) 
library(imager)

img <- load.image('Assignments/Jumping-spider.jpg')

dim(img)

img <- resize(img, 512, 512)



bird <- load.image('Assignments/deadsparrow.jpg')
dim(bird)
bird <- resize(bird, 512, 512)

can <- load.image(('Assignments/can.jpeg'))
can <- resize(spider, 512, 512)


#ANIMAL ACUITY
AcuityView(photo = img, distance = 2, realWidth = 4, eyeResolutionX = 8.14, eyeResolutionY = NULL, plot = T, output = "firstimage.jpg" )

### Animal - CPD - MRA
# House Sparrow - 4.8 - 0.208
# Black Vulture - 15.8 - 0.06
# Jumping Spider - 12 - 0.083
# Wolf Spider - 0.2 - 5

# House Sparrow
AcuityView(photo = bird, distance = 6, realWidth = 6, eyeResolutionX = 0.12, eyeResolutionY = NULL, plot = T, output = "HouseSparrow6.jpg" )
AcuityView(photo = bird, distance = 18, realWidth = 6, eyeResolutionX = 0.12, eyeResolutionY = NULL, plot = T, output = "HouseSparrow12.jpg" )
AcuityView(photo = bird, distance = 30, realWidth = 6, eyeResolutionX = 0.12, eyeResolutionY = NULL, plot = T, output = "HouseSparrow18.jpg" )

#Vulture
AcuityView(photo = bird, distance = 6, realWidth = 6, eyeResolutionX = 0.06, eyeResolutionY = NULL, plot = T, output = "vulture6.jpg" )
AcuityView(photo = bird, distance = 18, realWidth = 6, eyeResolutionX = 0.06, eyeResolutionY = NULL, plot = T, output = "vulture12.jpg" )
AcuityView(photo = bird, distance = 30, realWidth = 6, eyeResolutionX = 0.06, eyeResolutionY = NULL, plot = T, output = "vulture18.jpg" )


# Jumping Spider
AcuityView(photo = can, distance = 6, realWidth = 2.5, eyeResolutionX = 0.083, eyeResolutionY = NULL, plot = T, output = "HouseSparrow6.jpg" )
AcuityView(photo = can, distance = 12, realWidth = 2.5, eyeResolutionX = 0.083, eyeResolutionY = NULL, plot = T, output = "HouseSparrow12.jpg" )
AcuityView(photo = can, distance = 18, realWidth = 2.5, eyeResolutionX = 0.083, eyeResolutionY = NULL, plot = T, output = "HouseSparrow18.jpg" )

# Wold Spider
AcuityView(photo = can, distance = 6, realWidth = 2.5, eyeResolutionX = 5, eyeResolutionY = NULL, plot = T, output = "vulture6.jpg" )
AcuityView(photo = can, distance = 12, realWidth = 2.5, eyeResolutionX = 5, eyeResolutionY = NULL, plot = T, output = "vulture12.jpg" )
AcuityView(photo = can, distance = 18, realWidth = 2.5, eyeResolutionX = 5, eyeResolutionY = NULL, plot = T, output = "vulture18.jpg" )

