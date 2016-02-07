#########################################################################
#Exploratory DA 
#Assignment 1: Plot 1
#Purpose : exploring the distribution of power consumption in household
#########################################################################

library(data.table)
library(dplyr)

#raed in the electric powe consumption data
classes <- fread("household_power_consumption.txt", sep =";",header = TRUE, nrows = 3)
classes <- sapply(classes, class)
pw_data <- fread("household_power_consumption.txt", sep = ";",header = TRUE, colClasses = classes)

#keep only the column of interest : global active power (gap)
gap <- select(pw_data, Date, Global_active_power)
gap <- data.frame(gap)

#reformat the Date variable
gap$Date <- as.Date(gap$Date, format = "%d/%m/%Y")

#subset the observations of interest
gap <- filter(gap, Date == "2007-02-01" | Date =="2007-02-02")

#open the png device
png("plot1.png", width=480, height=480)
#construct histogram
hist(as.numeric(gap$Global_active_power), col = "red", xlab = "Global Active Power (Kilowatts)",main = "Global Active Power")
#close the device
dev.off()
