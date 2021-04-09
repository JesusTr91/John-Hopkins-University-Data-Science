library("data.table")
library("ggplot2")

setwd("C:/Users/Propietario/Desktop/Exploratory_data_analysis/Assignament_2")
summary <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
source <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

baltimore <- summary[fips=="24510",]

png("plot3.png")
ggplot(baltimore,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("Baltimore Pm"[2.5]*" Emissions 1999-2008")) +
  scale_fill_brewer(palette = "Set2")
dev.off()
