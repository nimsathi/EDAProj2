library(dplyr)
library(stringr)
library(ggplot2)

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# identify all coal sources
coalSources <- SCC %>%
  filter(str_detect(EI.Sector, 'Coal'))

# total emissions from coal sources grouped by year
coalEmissions <- NEI %>%
  filter(SCC %in% coalSources$SCC) %>%
  group_by(year) %>%
  summarise(totalEmissions = sum(Emissions)/1000)

coalEmissions$year <- as.factor(coalEmissions$year)

png('plot4.png', width=480, height=480)
g <- ggplot(data=coalEmissions, aes(x=year, y=totalEmissions)) +
  geom_bar(stat="identity", fill="blue") +
  labs(title="PM25 Emissions from coal sources", x="Year", y="PM2.5 Emissions (kiloton)")
print(g)
dev.off()
