# Load necessary libraries
library(ggplot2)
library(reshape)
data(diamonds)
data(Titanic)

#-------------------------------------------------------------------
### SCATTERPLOTS
#-------------------------------------------------------------------
# Basic scatter plot of diamond price vs carat weight
  ggplot(aes(x=carat, y=price), data=diamonds) +
  geom_point()

# Scatter plot of diamond price vs carat weight showing versitility of options in qplot
  ggplot(aes(x=carat, y=log(price), color=color), data=diamonds, alpha=I(.2))+
  geom_point() + ggtitle("Log price by carat weight, grouped by color")

### Your Turn
# All of the your turns for this section will use the tips data set 
#(loaded in with reshape package)

data(tips, package="reshape2")

# Use qplot to build a scatterplot of variables tips and total bill\medskip
# Use options within qplot to color points by smokers\medskip
# Clean up axis labels and add main plot title\medskip

#-------------------------------------------------------------------
### HISTOGRAMS
#-------------------------------------------------------------------
#Basic histogram of carat weight
  ggplot() +
  geom_histogram(aes(x=carat), data=diamonds)

#Carat weight histograms faceted by cut
  ggplot(aes(x=carat), data=diamonds) +
  geom_histogram(binwidth=.2) + 
  facet_grid(.~cut )

###Your Turn
# Create a new variable in tips data frame rate = tip/total bill\medskip
# Use qplot to create a histogram of rate\medskip
# Change the bin width on that histogram to 0.05\medskip
# Facet this histogram by size of the group

#-------------------------------------------------------------------  
### BOXPLOTS
#-------------------------------------------------------------------  
#Side by side boxplot of diamond prices within cut groupings
  ggplot(aes(x=cut, y=price), data=diamonds) +
  geom_boxplot()

#Side by side boxplot of log prices within cut groupings with jittered values overlay
  ggplot(aes(x=cut, y=log(price)), data=diamonds, 
         main="Boxplots of log Diamond Prices Grouped by Cut Quality") +
  geom_boxplot(color="blue") +
  geom_jitter(alpha=I(.025))

### Your Turn
# Make side by side boxplots of tipping rate for males and females\medskip
# Overlay jittered points for observed values onto this boxplot

#-------------------------------------------------------------------
### BARPLOTS
#-------------------------------------------------------------------  
#To investigate bar plots we will switch over to the Titanic data set
  titanic <- as.data.frame(Titanic)

#Basic bar plot of survival outcomes
  ggplot(aes(x=Survived, weight=Freq), data=titanic) +
  geom_bar()

#Bar plot faceted by gender and class
  ggplot(aes(x=Survived, weight=Freq), data=titanic) +
  geom_bar()+
  facet_grid(Sex~Class)
