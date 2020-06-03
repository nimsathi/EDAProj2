library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

# Baltimore PM2.5 emissions grouped by year and point type
summaryData <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarise(totalEmissions = sum(Emissions));

png('plot3.png', width=480, height=480)
g <- ggplot(data=summaryData, aes(x=year, y=totalEmissions, color=type)) +
  geom_point() +
  geom_smooth(method="lm") + 
  facet_wrap(~ type) +
  labs(title="Baltimore - total PM2.5 emissions by type", x="Year", y="PM2.5 Emissions (T)")

print(g)
dev.off()
  
