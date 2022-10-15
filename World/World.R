#World Happiness Index

library(tidyverse)

#install.packages("wbstats")
library(wbstats)

#Show list structure
str(wb_cachelist, max.level=1)

glimpse(wb_cachelist$countries)

country <- wb_cachelist$countries %>% 
  select(country,region, income_level, longitude, latitude)

glimpse(country)

############################################################################

World <- read_excel("World.xlsx")

glimpse(World)

World <- World %>%
  mutate(country = `Country name`,
         region = `Regional indicator`)  %>%
  select(country, region, `Ladder score`, `Logged GDP per capita`, `Social support`, `Healthy life expectancy`, `Freedom to make life choices`,
         Generosity, `Perceptions of corruption`)

############################################################################

ll <- read_csv("world_country_and_usa_states_latitude_and_longitude_values.csv")

ll <- ll %>%
  select(country, latitude, longitude)

glimpse(ll)

Data <- left_join(World, ll)

write.csv(Data, 'Data.csv')
