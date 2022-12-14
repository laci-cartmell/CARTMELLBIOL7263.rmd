##  _____________________
##
## Script: Learn how to do Heatmaps in R
##
## Purpose of script:Lesson from Madison H. 
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

## Load in the dataset

heatmap_practice <- read_csv("MAH_assignment_data.csv")
View(heatmap_practice)

## Create heatmap w/ggplot2 faceted by tissue type

# transform data to numeric
#remove rownames and saves them
heatmap_num <- as.matrix(heatmap_practice[,-1])
rownames(heatmap_num) <- heatmap_practice[,1]

#view with basic functions
heatmap(heatmap_num)

# Make it pretty with ggplot



# create heatmap with 
ggplot(heatmap_num, aes(x = Sample, y = Gene, fill = Expression)) +
  geom_tile(colour="black", size=0.5)+ 
  scale_fill_gradient(low = "black", high = "green")+
  theme_grey(base_size=12)+
  #now create the facets by tissue type
  facet_grid(~ Tissue, switch = "x", scales = "free_x", space = "free_x")
  ggtitle(label = "Pheromone Gene Expression by Tissue Type") +
  scale_x_discrete(labels=c('A.tri', 'D.brim', 'E.tyn M', 'E.tyn P', 'P.alb', 'R.kez'))+
    theme(plot.title = element_text(face="bold"),
        strip.placement = "outside", 
        legend.title = element_text(face = "bold"),
        axis.title = element_text(face="bold"),
        axis.title.x = element_blank(),
        axis.text.y =element_text(color = "black"),
        axis.text.x =element_text(color = "black", angle = 315, hjust = 0, vjust = 0.5,),
        axis.ticks=element_blank(),
        plot.background=element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())

