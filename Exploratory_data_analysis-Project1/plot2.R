getwd()
setwd("~/Desktop/datasciencecoursera/Exploratory_data_analysis/")

library("data.table")

Plot2 <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
Plot2[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
Plot2[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
Plot2 <- Plot2[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png")
plot(x = Plot2[, dateTime]
     , y = Plot2[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
