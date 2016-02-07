#########################################################################
#Exploratory DA 
#Assignment 1: Plot 2
#Purpose : exploring the relationship of power consumption in household
#               and the day of the week
#########################################################################

library(data.table)
library(lubridate)
library(dplyr)

#raed in the electric powe consumption data
classes <- fread("household_power_consumption.txt", sep =";",header = TRUE, nrows = 3)
classes <- sapply(classes, class)
pw_data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?",header = TRUE, colClasses = classes, stringsAsFactors = F)

#keep only the column of interest : global active power (gap)
gap <- select(pw_data, Date, Global_active_power)
gap <- data.frame(gap)
#reformat the Date variable
gap$Date <- as.Date(gap$Date, format = "%d/%m/%Y")
gap$lg_date <- paste(gap$Date, gap$Time)

#subset the observations of interest
gap <- filter(gap, Date == "2007-02-01" | Date =="2007-02-02")
gap$lg_date <- wday(gap$Date, label = TRUE)

#plot the graph
png("plot2.png", width=480, height=480)

# Plot the graph
plot(gap$Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)")

# Turn off device
dev.off()
