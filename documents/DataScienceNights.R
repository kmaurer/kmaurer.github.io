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
delays <- flights %>%
  mutate(dow = wday(FL_DATE, label=TRUE, abbr=FALSE)) %>%
  group_by(dow) %>%
  summarise(avg_delay = mean(DEP_DELAY, na.rm=T))
delays

###-------------------------------
# General Plot Building with ggplot2

# Let's make a scatterplot of departure time vs departure delay
flights <- flights %>%
  mutate(hour =as.numeric(str_sub(flights$DEP_TIME,1,2)) , 
         minute = as.numeric(str_sub(flights$DEP_TIME,3,4)))

set.seed(1)
flights_small <- sample_n(flights, 10000)

ggplot(aes(x=(hour+minute/60), y=DEP_DELAY),
       data=flights_small)+
  geom_point()



###-------------------------------
# Saving cleaned data for future use
save(delays,file="Dec2017Flights.Rdata")

# Restart R Fresh from here just to check that it is ready to send to the team

# loading saved Rdata files
load(file="Dec2017Flights.Rdata")


###-------------------------------

# shift for day starting at 5am
plot_data <- flights_small %>%
  mutate(time_shift = ifelse((hour+minute/60)<5, (hour+minute/60)+24 , (hour+minute/60))) %>%
  filter(DEP_DELAY <= quantile(DEP_DELAY, .99, na.rm=T))

# plot and clean up
ggplot(aes(x=time_shift, y=DEP_DELAY),
       data=plot_data)+
  geom_point(alpha=.2)+
  stat_smooth()+
  scale_x_continuous(breaks=seq(5,31,6),
                     labels=c("5am","11am","5pm","11pm","5am"))+
  labs(x="Time of Day", y="Departure Delay (minutes)")+
  theme_bw()

# Save to production quality image file
ggsave(filename="MyBeautifulPlot.png", dpi=700)
?ggsave


# Add column
flights_small <- flights_small %>%
  mutate(on_time = ifelse(DEP_DELAY <=0, "On Time","Late")) 
head(flights_small)

###---------------------------------
### load in external weather data and find way to match to airports

# load both sets (daily weather and weather station)
stations <- read_csv("WeatherStationsUSA.csv")
load("December2017Weather.RData")
head(stations)
head(weather2017)


## Fuzzy matching.... 
cvg <- stations %>% 
  filter(str_detect(name, pattern="CINCINNATI NORTHERN"))

cvg.weather <- weather2017 %>%
  filter(ID %in% cvg$ID) %>%
  mutate(date= ymd(date))

cvg.wide <- cvg.weather %>%
  dplyr::select(-ID) %>%
  spread(key=element, value)

## Now can merge with the 

flights <- read_csv("December2017FlightDelays.csv")
cvg.flights <- flights %>% 
  filter(ORIGIN=="CVG") %>%
  mutate(FL_DATE= mdy(FL_DATE))

cvg.data <- left_join(cvg.flights, cvg.wide, by=c("FL_DATE" = "date"))
glimpse(cvg.data)

ggplot(cvg.data) + 
  geom_point(aes(x=PRCP, y=DEP_DELAY), alpha=0.5)
