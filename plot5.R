library(dplyr)
library(stringr)
library(ggplot2)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# identify all motor vehicle sources of emissions
vehicleSources <- SCC %>%
  filter(str_detect(EI.Sector, 'Vehicles'))

# total emissions from vehicles in Baltimore city grouped by year
vehicleEmissions <- NEI %>%
  filter(fips == "24510") %>%
  filter(SCC %in% vehicleSources$SCC) %>%
  group_by(year) %>%
  summarise(totalEmissions = sum(Emissions))

vehicleEmissions$year <- as.factor(vehicleEmissions$year)

png('plot5.png', width=480, height=480)
g <- ggplot(data=vehicleEmissions, aes(x=year, y=totalEmissions)) +
  geom_bar(stat="identity", fill="#008000") +
  labs(x="Year", y="PM2.5 Emissions (T)") +
  ggtitle("Total PM2.5 Emissions in Baltimore City by Motor Vehicles")
print(g)
dev.off()
