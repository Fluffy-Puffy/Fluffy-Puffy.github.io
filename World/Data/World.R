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

Data <- Data %>%
  mutate(score = `Ladder score`,
         x2021.1 = `Logged GDP per capita`,
         x2021.2 = `Social support`,
         x2021.3 = `Healthy life expectancy`,
         x2021.4 = `Freedom to make life choices`,
         x2021.5 = `Generosity`,
         x2021.6 = `Perceptions of corruption`) %>%
  select(country, region, score, x2021.1, x2021.2, x2021.3, x2021.4, x2021.5, x2021.6,
         latitude, longitude)

#write.csv(Data, 'Data.csv')

###########################################################################

x2020 <- read_csv("2020.csv")

x2020 <- x2020 %>%
  mutate(country = `Country name`,
         region =`Regional indicator`,
          score = `Ladder score`,
         x2020.1 = `Logged GDP per capita`,
         x2020.2 = `Social support`,
         x2020.3 = `Healthy life expectancy`,
         x2020.4 = `Freedom to make life choices`,
         x2020.5 = `Generosity`,
         x2020.6 = `Perceptions of corruption`) %>%
  select(country, region, score, x2020.1, x2020.2, x2020.3, x2020.4, x2020.5, x2020.6)

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

j = left_join(Data, x2020, by = "country")

jj = left_join(j, x2015, by = "country")

j1 = left_join(jj, x2016, by = "country")

j2 = left_join(j1, x2017, by = "country")

j3 = left_join(j2, x2018, by = "country")

j4 = left_join(j3, x2019, by = "country")

glimpse(j4)

j4 <- j4 %>%
  pivot_longer(cols=c(x2020.1, x2021.1),
               names_to='erase',
               values_to='Logged GDP per Capita')

j4 <- j4 %>%
  pivot_longer(cols=c(x2020.2, x2021.2),
               names_to='erase1',
               values_to='Social support')

j4 <- j4 %>%
  pivot_longer(cols=c(x2020.3, x2021.3),
               names_to='erase2',
               values_to='Healthy Life Expectancy')

j4 <- j4 %>%
  pivot_longer(cols=c(x2020.4, x2021.4),
               names_to='erase3',
               values_to='Freedom')

j4 <- j4 %>%
  pivot_longer(cols=c(x2020.5, x2021.5),
               names_to='erase4',
               values_to='Generosity')

j4 <- j4 %>%
  pivot_longer(cols=c(region.x, region.y),
               names_to='erase6',
               values_to='region')

j4 <- j4 %>%
  pivot_longer(cols=c(score.x, score.y),
               names_to='erase7',
               values_to='score')

j4 <- j4 %>%
  pivot_longer(cols=c(x2020.6, x2021.6),
               names_to='erase5',
               values_to='Perceptions of Corruption')

Final <- j4 %>%
  pivot_longer(cols=c('2015', '2016', '2017', '2018', '2019'),
               names_to='Year',
               values_to='Score')

glimpse(Score)

Final = Final %>% 
        select(country, region, score, latitude, longitude, `Logged GDP per Capita`, `Social support`,
               `Healthy Life Expectancy`, Freedom, Generosity, `Perceptions of Corruption`)

Score = Final %>%
        select(country, region, score, latitude, longitude)

colSums(is.na(Final))

Final <- na.omit(Final)

colSums(is.na(Score))

Score <- na.omit(Score)

#write.csv(Final, 'Final.csv')

#write.csv(Score, 'Score.csv') 
