getwd()
setwd("~/Desktop/datasciencecoursera/Exploratory_data_analysis/")

library("data.table")

Plot3 <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
Plot3[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
Plot3[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
Plot3 <- Plot3[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png")
plot(Plot3[, dateTime], Plot3[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(Plot3[, dateTime], Plot3[, Sub_metering_2],col="red")
lines(Plot3[, dateTime], Plot3[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))
dev.off()
