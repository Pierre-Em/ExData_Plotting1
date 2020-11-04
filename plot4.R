## This scripts load the data frame for assignment #1 of Exploratory Data Analysis
## and creates the fourth plot

library(dplyr)
library(lubridate)

## Downloading data and extracting elements corresponding to the two days: 
## 2007/01/01 and 2007/01/02. Dates are first converted to a class date to be able
## to use logical expression
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("exdata_data_household_power_consumption")
DT <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
DT <- mutate(DT, Date = as.Date(Date, format = "%d/%m/%Y "))
DT_sub <- filter(DT, Date >= "2007/2/1" & Date<"2007/2/3")
rm(DT)

## Add a variable called Date_full to the dataset integrating both date and time
DT_sub <- mutate(DT_sub, Date_full = ymd_hms(paste(DT_sub$Date,DT_sub$Time)))

## Generate plot#4
setwd("..")
png(file="plot4.png",width=480, height=480)
par(mfrow = c(2,2))
plot(DT_sub$Date_full, DT_sub$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(DT_sub$Date_full, DT_sub$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
plot(DT_sub$Date_full, DT_sub$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
points(DT_sub$Date_full, DT_sub$Sub_metering_1, type = "l")
points(DT_sub$Date_full, DT_sub$Sub_metering_2, type = "l", col = "red")
points(DT_sub$Date_full, DT_sub$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = names(DT_sub)[7:9], col = c("black","red","blue"), lty = c(1,1), bty = "n")

plot(DT_sub$Date_full,DT_sub$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

dev.off()