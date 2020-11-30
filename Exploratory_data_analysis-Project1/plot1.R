getwd()
setwd("~/Desktop/datasciencecoursera/Exploratory_data_analysis/")

library("data.table")
Plot1 <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
Plot1[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
Plot1[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
Plot1 <- Plot1[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png")
hist(Plot1[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
