library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")

# plot the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008
summaryData <- NEI %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions)/1000)

png(filename="plot1.png", width=480, height=480)
barplot(height=summaryData$totalEmissions, names.arg=summaryData$year, xlab="Year", ylab="PM 2.5 Emissions (kiloton)", main="Total PM2.5 Emissions in the US")
dev.off()
