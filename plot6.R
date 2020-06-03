library(dplyr)
library(stringr)
library(ggplot2)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# identify all motor vehicle sources of emissions
vehicleSources <- SCC %>%
  filter(str_detect(EI.Sector, 'Vehicles'))

# total emissions from vehicles in Baltimore city and Los Angles grouped by year
vehicleEmissions <- NEI %>%
  filter(fips %in% c("24510", "06037")) %>%
  filter(SCC %in% vehicleSources$SCC) %>%
  group_by(fips, year) %>%
  summarise(totalEmissions = sum(Emissions))

vehicleEmissions$year <- as.factor(vehicleEmissions$year)

fipsCityMapping <- data.frame(fips = c("06037", "24510"), city = c("Los Angeles", "Baltimore"))
vehicleEmissions <- merge(vehicleEmissions, fipsCityMapping)


png('plot6.png', width=480, height=480)
g <- ggplot(data=vehicleEmissions, aes(x=year, y=totalEmissions, fill=city)) +
  geom_bar(stat="identity") +
  facet_wrap(~ city) + 
  labs(x="Year", y="PM2.5 Emissions (T)") +
  ggtitle("Total PM2.5 Emissions by Motor Vehicles")
print(g)
dev.off()
