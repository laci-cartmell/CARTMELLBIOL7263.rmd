#
##  _____________________
##
## Script: ggplot notes
##
## Purpose of script: class lecture record
##
## Author: Laci Cartmell
##
## Date Created: 2022-10-06
##
##
## _____________________
##
## Notes:
##   
##
## _____________________

## load the packages needed: 
require(ggplot2) 
require(tidyverse)
require(ggthemes)
require(patchwork)
install.packages("ggplot")
install.packages(c("ggthemes", "patchwork"))

#ggplot template
p1 <- ggplot(data= <DATA>,mapping=aes(<MAPPINGS>) + 
               <GEOM_FUNCTION>(aes(<MAPPINGS>),
                               stat=<STAT>,
                               position=<POSITION>) +
               <COORDINATE_FUNCTION> +
               <FACET_FUNCTION>
               
print(p1)
ggsave(plot=p1, filename="MyPlot",width=5,height=3,units="in",device="svg") 

#cmd for saving a plot

             
# now for actual data
?mpg

# simple histogram
qplot(x=mpg$cty) #y-axis is count of observation with a given value of the x
qplot(x=mpg$cty,fill=I("goldenrod"),color=I("black")) 
qplot(x=mpg$city, fill = mpg$trans)

# simple density plot
qplot(x=mpg$hwy,geom="density")    


# simple scatter plot with linear regression line
qplot(x=mpg$cty,y=mpg$hwy,geom=c("point","smooth"), method="lm")
qplot(x=mpg$cty,y=mpg$hwy, col = mpg$class, geom=c("point"))


?qplot
?ggplot
