#########################################################################
#Exploratory DA 
#Assignment 1: Plot 4
#Purpose : plotting 4 differents plots on the same graph
#########################################################################

library(data.table)
library(lubridate)
library(dplyr)

#raed in the electric powe consumption data
classes <- fread("household_power_consumption.txt", sep =";",header = TRUE, nrows = 3)
classes <- sapply(classes, class)
power <- fread("household_power_consumption.txt", sep = ";", na.strings = "?",header = TRUE, colClasses = classes, stringsAsFactors = F)

#convert date
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power$dateTime <- paste(power$Date, power$Time)
#subset the observations of interest
power <- filter(power, Date == "2007-02-01" | Date =="2007-02-02")
power$dateTime <- wday(power$dateTime, label = TRUE)


#construct plots
attach(power)
png("plot4.png", width=480, height=480)

#set the graph parameters
par(mfrow=c(2,2))
plot(as.numeric(as.character(Global_active_power)), type="l", xlab="", ylab="Global Active Power")

             plot(as.numeric(Voltage), type="l", xlab="datetime", ylab="Voltage")

            plot(as.numeric(Sub_metering_1), type="l", xlab="", ylab="Energy sub metering", ylim=c(0,40))
            lines(as.numeric(Sub_metering_2), col="red")
            lines(as.numeric(Sub_metering_3), col="blue")
            legend("topright", lty=1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

            plot(as.numeric(as.character(Global_reactive_power)), type="l", xlab="datetime", ylab="Global_reactive_power")
detach(power)    
dev.off()
