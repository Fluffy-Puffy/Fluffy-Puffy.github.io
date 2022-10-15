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

#write.csv(Data, 'Data.csv')

###########################################################################

Data <- read_delim("Data.csv", delim = ";", 
                   escape_double = FALSE, trim_ws = TRUE)

x2015 <- read_delim("2015.csv", delim = ";", 
                    escape_double = FALSE, trim_ws = TRUE)

x2015 <- x2015 %>%
  mutate(country = `Country`) %>%
  select(country, `2015`)

x2016 <- read_delim("2016.csv", delim = ";", 
                    escape_double = FALSE, trim_ws = TRUE)

x2016 <- x2016 %>%
  mutate(country = `Country`) %>%
  select(country, `2016`)

x2017 <- read_delim("2017.csv", delim = ";", 
                    escape_double = FALSE, trim_ws = TRUE)

x2017 <- x2017 %>%
  mutate(country = `Country`) %>%
  select(country, `2017`)

x2018 <- read_delim("2018.csv", delim = ";", 
                    escape_double = FALSE, trim_ws = TRUE)

x2018 <- x2018 %>%
  mutate(country = `Country or region`) %>%
  select(country, `2018`)

x2019 <- read_delim("2019.csv", delim = ";", 
                    escape_double = FALSE, trim_ws = TRUE)

x2019 <- x2019 %>%
  mutate(country = `Country or region`) %>%
  select(country, `2019`)

j = left_join(Data, x2015, by = "country")

j1 = left_join(j, x2016, by = "country")

j2 = left_join(j1, x2017, by = "country")

j3 = left_join(j2, x2018, by = "country")

j4 = left_join(j3, x2019, by = "country")

glimpse(j4)

Final <- j4 %>%
  pivot_longer(cols=c('2015', '2016', '2017', '2018', '2019', '2020', '2021'),
               names_to='Year',
               values_to='Score')

glimpse(Final)

#write.csv(Final, 'Final.csv')
 