library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")

# get total PM2.5 emissions for Baltimore City, Maryland (fips == "24510") from 1999 to 2008
summaryData <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarize(totalEmissions = sum(Emissions))

png(filename="plot2.png", width=480, height=480)
barplot(height=summaryData$totalEmissions, names.arg=summaryData$year, xlab="Year", ylab="Emissions (T)", main="Total PM2.5 Emissions for Balitmore city")
dev.off()
