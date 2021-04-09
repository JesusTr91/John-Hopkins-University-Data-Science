library("data.table")
setwd("C:/Users/Propietario/Desktop/Exploratory_data_analysis/Assignament_2")
summary <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

summary[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
total <- summary[fips=='24510', lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

png('plot2.png')
barplot(total[, Emissions],
         names = total[, year],
         xlab = "Year", ylab = "Emissions",
         main = "Emissions over the Years")
dev.off()
