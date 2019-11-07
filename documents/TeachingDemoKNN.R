### Teaching Demo Code - KNN regression for house prices
# Presenter: Dr. Karsten Maurer

#--------------------------------------------------------------------------------------
### Load a few helpful libraries for working with the data and building knn models
library(tidyverse)
library(caret)
library(ggvoronoi)
# If you don't have them installed, then uncomment and run the following:
# install.packages(c("tidyverse","caret","ggvoronoi"))

#--------------------------------------------------------------------------------------
### Load up Oxford Ohio house prices data scraped from Zillow webpages (accessed: 11/3/19) 
# Data gathering and processing used tools from the following R packages: 
#     rvest, XML, xml2, ZillowR, stringr, dplyr
real_estate <- read.csv("http://kmaurer.github.io/documents/data/oxford_houses.csv", 
                        stringsAsFactors = FALSE)
head(real_estate)

ggplot() +
  geom_point(aes(x=std_sqft, y=std_lot, color=sale_price), 
             data=real_estate) +
  scale_color_viridis_c("Price", limits=c(0,400000),
                        breaks=seq(0,400000, by= 100000),
                        labels=paste0("$",seq(0,400,by=100),"k"))+
  labs(x="Floor Size (standarized)", y="Lot Size (Standardized)")+
  theme_bw()

#--------------------------------------------------------------------------------------
### Start coding knn for predictions here:

