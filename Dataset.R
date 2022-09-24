library(tidyverse)

#install.packages("wbstats")
library(wbstats)

#Show list structure
str(wb_cachelist, max.level=1)

glimpse(wb_cachelist$countries)

country <- wb_cachelist$countries %>% 
  select(country, income_level, longitude, latitude)

glimpse(country)

------------------------------------------------------------

Pov <- wb_search("Poverty") %>%
  filter(str_detect(indicator, "Multidimensional"))

unique(Pov$indicator)

Pov <- Pov %>%
  filter(indicator %in% 
           "Multidimensional poverty headcount ratio (% of total population)")

Pov <- Pov$indicator_id[1:1]
str(Pov)

Poverty <- wb(country="countries_only",
                 indicator = Pov,
                 startdate = 2010,
                 enddate= 2022,
                 POSIXct = TRUE)

glimpse(Poverty)

Poverty <- Poverty %>%
  select(iso3c, date, country, indicator, value) %>% 
  spread(key= "indicator", value = "value")

join <- left_join(Poverty, country)
glimpse(join)

write.csv(join, 'join.csv')
