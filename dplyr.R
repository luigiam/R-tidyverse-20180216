library("tidyverse")

gapminder <- gapminder::gapminder

gapminder


gapminder %>% 
  select(-gdpPercap)

year_country_gdp <- gapminder %>% 
  select(year, country, gdpPercap)

gapminder %>% 
  filter(year==2002) %>% 
  ggplot(aes(x=continent, y=pop))+
  geom_boxplot()

gapminder %>% 
  filter(continent=="Europe") %>% 
  select(year, country, gdpPercap)

gapminder %>% 
  filter(country=="Norway") %>% 
  select(gdpPercap, lifeExp, year)

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap = mean(gdpPercap))

gapminder %>%
  filter(continent=="Asia") %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot(aes(x=country, y=mean_lifeExp))+
    geom_point()+
    coord_flip()

gapminder %>%
  filter(continent=="Asia") %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  filter(mean_lifeExp == min(mean_lifeExp) | 
           mean_lifeExp == max(mean_lifeExp))

gapminder %>% 
  group_by(continent, year) %>%  #this bit confuses me for some reason
  summarize(mean_gdpPercap = mean(gdpPercap))
#ah.. so what this does is not just mean gdPpercap by continent, BUT its for EACH continent for EACH year

gapminder %>% 
  group_by(continent, year) %>%  
  summarize(mean_gdpPercap = mean(gdpPercap),
            sd_gdpPercap = sd(gdpPercap),
            mean_pop = mean(pop),
            sd_pop = sd(pop)) #a new column for each thingy in summarize

gapminder %>% 
  mutate(gdp_bill = gdpPercap * pop / 10^9)


#in this case, the order of mutate, filter and group_by doesn't matter
gapminder %>% 
  mutate(gdp_bill = gdpPercap * pop / 10^9) %>% 
  filter(year==1987) %>%
  group_by(continent) %>% 
  summarize(mean_life = mean(lifeExp),
             mean_gdp_bill = mean(gdp_bill))
  
gapminder_country_summary <- gapminder %>% 
  group_by(country) %>% 
  summarize(meanlife = mean(lifeExp))



map_data("world") %>%  #this is just a dataset
  rename(country = region) %>% 
  left_join(gapminder_country_summary, by = "country") %>% 
  ggplot()+
  geom_polygon(mapping = aes(x = long, y = lat, group = group,
                             fill = meanlife))
