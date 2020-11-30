getwd()
setwd("~/Desktop/datasciencecoursera/Exploratory_data_analysis/")

library("data.table")

Plot4 <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
Plot4[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
Plot4[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
Plot4 <- Plot4[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png")
par(mfrow=c(2,2))

# Plot 1
plot(Plot4[, dateTime], Plot4[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(Plot4[, dateTime],Plot4[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(Plot4[, dateTime], Plot4[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(Plot4[, dateTime], Plot4[, Sub_metering_2], col="red")
lines(Plot4[, dateTime], Plot4[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(Plot4[, dateTime], Plot4[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()



