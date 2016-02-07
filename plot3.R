#########################################################################
#Exploratory DA 
#Assignment 1: Plot 3
#########################################################################

library(data.table)
library(lubridate)
library(dplyr)

#raed in the electric powe consumption data
classes <- fread("household_power_consumption.txt", sep =";",header = TRUE, nrows = 3)
classes <- sapply(classes, class)
pw_data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?",header = TRUE, colClasses = classes, stringsAsFactors = F)

#keep the variables of interest
sub_mtg <- select(pw_data, Date, Sub_metering_1,Sub_metering_2, Sub_metering_3)
sub_mtg$Date <- as.Date(sub_mtg$Date, format = "%d/%m/%Y")

#subset the observations of interest
sub_mtg<- filter(sub_mtg, Date == "2007-02-01" | Date =="2007-02-02")
sub_mtg$lg_date <- wday(sub_mtg$Date, label = TRUE)

# plot the data
png("plot3.png", width=480, height=480)

plot(as.numeric(sub_mtg$Sub_metering_1), type="l", col="black",
     xlab="", ylab="Energy sub metering", ylim=c(0,40))
lines(sub_mtg$Sub_metering_2, col="red")
lines(sub_mtg$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1)

dev.off()