##  _____________________
##
## Script: Heatmaps in R
##
## Purpose of script:Lesson from maddison
##
## Author: Laci Cartmell
##
## Date Created: 2022-12-01
##
##
## _____________________
##
## Notes:
##   
##
## _____________________

## load the packages needed:  

library(stats)
library(ggplot2)


pheromone_data <- read.csv("pheromone_data.csv")
#in order to use the heatmap() function, we need to transform the csv file into a numeric data frame
#this also allows us to make sure we keep our rownames
pheromone_data1 <- as.matrix(pheromone_data[,-1])
rownames(pheromone_data1) <- pheromone_data[,1]
heatmap(pheromone_data1)

heatmap(pheromone_data1, 
        Colv = NA, #get rid of column clustering
        Rowv = NA, #get rid of row clustering
        margins = c(7,5), #change the margins so we can fit in the column names with the axis title
        cexCol = 1, #change the size of the column names
        main = "Pheromone Gene Expression", #add a title
        xlab = "Groups", #add an x axis label
        ylab = "Gene") #add a y axis label

heatmap(pheromone_data1, 
        Colv = NA, #get rid of column clustering
        Rowv = NA, #get rid of row clustering
        margins = c(7,5), #change the margins so we can fit in the column names with the axis title
        cexCol = 1, #change the size of the column names
        col = terrain.colors(10), #changing the color palette and selecting how many colors to use
        main = "Pheromone Gene Expression", #add a title
        xlab = "Groups", #add an x axis label
        ylab = "Gene") #add a y axis label


## ggplot2
pheromone_data2 <- read.csv("pheromone_data2.csv")
ggplot(pheromone_data2, #give it the data
       aes(x = Sample, y = Gene, fill = Expression)) + #set our x and y and what data we want to "fill" our heatmap with
  geom_tile() #the heatmap plot function


ggplot(pheromone_data2, aes(x = Sample, y = Gene, fill = Expression)) +
  geom_tile(colour="black", size=0.5)+ #here we are adding outlines around our tiles
  #we can change the colour and thickness of this outline
  scale_fill_gradient(low = "black", high = "green")+ #change the color gradient
  theme_grey(base_size=12)+ #change our theme and make our base size font 12
  theme(axis.ticks = element_blank(), #get rid of the tick marks
        #get rid of all the background ggplot2 aesthetics
        plot.background = element_blank(), 
        panel.background = element_blank(),
        panel.border = element_blank())

ggplot(pheromone_data2, aes(x = Sample, y = Gene, fill = Expression)) +
  geom_tile(colour="black", size=0.5)+ 
  scale_fill_gradient(low = "black", high = "green")+
  theme_grey(base_size=12)+
  ggtitle(label = "Pheromone Gene Expression") + #add a plot title
  theme(plot.title = element_text(face="bold"), #make the plot title bold
        legend.title = element_text(face = "bold"), #make the legend title bold
        axis.title = element_text(face="bold"), #make the axis titles bold
        axis.text.y =element_text(color = "black"), #make the axis labels black instead of grey
        axis.text.x =element_text(angle = 270, hjust = 0, color = "black"), #change the angle of the axis labels,
        #the position, and the color
        axis.ticks= element_blank(),
        plot.background=element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())

ggplot(pheromone_data2, aes(x = Sample, y = Gene, fill = Expression)) +
  geom_tile(colour="black", size=0.5)+ 
  scale_fill_gradient(low = "black", high = "green")+
  theme_grey(base_size=12)+
  facet_grid(~ Gland) + #here we are faceting by gland
  ggtitle(label = "Pheromone Gene Expression") +
  scale_x_discrete(labels=c('D.brim', 'E.tyn M', 'E.tyn P', 'P.alb', 'D.brim', 'E.tyn M', 'E.tyn P', 'P.alb'))+ #here we are changing the x axis labels
  theme(plot.title = element_text(face="bold"),
        legend.title = element_text(face = "bold"),
        axis.title = element_text(face="bold"),
        axis.title.x = element_blank(),
        axis.text.y =element_text(color = "black"),
        axis.text.x =element_text(color = "black"),
        axis.ticks=element_blank(),
        plot.background=element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())

ggplot(pheromone_data2, aes(x = Sample, y = Gene, fill = Expression)) +
  geom_tile(colour="black", size=0.5)+ 
  scale_fill_gradient(low = "black", high = "green")+
  theme_grey(base_size=12)+
  facet_grid(~ Gland, switch = "x", scales = "free_x", space = "free_x") + #switch moves the facet labels to the bottom
  #applying "free_x" removes the columns for which there is no data and
  #applying "free_x" to space makes the columns the same width
  ggtitle(label = "Pheromone Gene Expression") +
  scale_x_discrete(labels=c('D.brim', 'E.tyn M', 'E.tyn P', 'P.alb', 'D.brim', 'E.tyn M', 'E.tyn P', 'P.alb'))+
  theme(plot.title = element_text(face="bold"),
        strip.placement = "outside", #this places the facet label outside the x axis labels
        strip.text = element_text(face = "bold"), #this bolds the text in the facet label
        legend.title = element_text(face = "bold"),
        axis.title = element_text(face="bold"),
        axis.title.x = element_blank(),
        axis.text.y =element_text(color = "black"),
        axis.text.x =element_text(color = "black"),
        axis.ticks=element_blank(),
        plot.background=element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())

