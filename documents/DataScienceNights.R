## Tonight we are only going to use the tidyverse package and Base R for programming
install.packages("tidyverse")
library(tidyverse)

### Loading and cleaning Data at Data Science Night Workshop 
### Download from https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time
# selected variables from checklist:  
#FL_DATE,CARRIER,ORIGIN,ORIGIN_CITY_NAME,DEST,DEST_CITY_NAME,DEP_TIME,DEP_DELAY,ARR_TIME,	ARR_DELAY
# December 2017 flights

### Load in the data from a csv

# Need to tell R where your data is stored (your working directory)
setwd("C:/Users/maurerkt/Downloads")
# Read and save the data to R
flights <- as.data.frame(read_csv("December2017FlightDelays.csv"))

head(flights)
str(flights)

### Basic aggregate summary statistics withfunctions from dplyr package
delays <- flights  %>%
  select(-X12) %>%
  group_by(ORIGIN) %>%
  summarize(mean_delay = mean(DEP_DELAY, na.rm=T),
            sd_delay = sd(DEP_DELAY, na.rm=T),
            count=n())
head(delays)

###-------------------------------
# Saving cleaned data for future use
save(delays,file="Dec2017Flights.Rdata")

# loading saved Rdata files
load(file="Dec2017Flights.Rdata")


###-------------------------------
# General Plot Building with ggplot2

