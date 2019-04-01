## Tonight we are only going to use the tidyverse package and Base R for programming
install.packages(c("tidyverse","lubridate"))
library(tidyverse)
library(lubridate)

### Loading and cleaning Data at Data Science Night Workshop 
### Download from https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time
# selected variables from checklist:  
#FL_DATE,CARRIER,ORIGIN,ORIGIN_CITY_NAME,DEST,DEST_CITY_NAME,DEP_TIME,DEP_DELAY,ARR_TIME,	ARR_DELAY
# December 2017 flights

### Load in the data from a csv

# Need to tell R where your data is stored (your working directory)
setwd("C:/Users/maurerkt/Downloads")

# Read the data into R
flights <- read_csv("December2017FlightDelays.csv")
head(flights)
glimpse(flights)

### Basic aggregate summary statistics withfunctions from dplyr package


###-------------------------------
# General Plot Building with ggplot2

# Let's make a scatterplot of departure time vs departure delay




###-------------------------------
# Saving cleaned data for future use
# Restart R Fresh from here just to check that it is ready to send to the team

# loading saved Rdata files


###------------------------------
# plot and clean up - focus on a narrative


###---------------------------------
### load in external weather data and find way to match to airports

# load both sets (daily weather and weather station)
stations <- read_csv("WeatherStationsUSA.csv")
load("December2017Weather.RData")
head(stations)
head(weather2017)


## Fuzzy matching.... 


## Now can merge with the 


