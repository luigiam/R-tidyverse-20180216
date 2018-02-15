#' ---
#' title: "R tidyverse workshop"
#' author: "`Carpentry@UiO`"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

#' *Read more about this type of document in 
#' [Chapter 20 of "Happy Git with R"](http://happygitwithr.com/r-test-drive.html)*
#'  
#' Uncomment the following lines to install necessary packages

#install.packages("tidyverse")
#install.packages("maps")
#install.packages("gapminder")

#' First we need to load libraries installed previously
library(tidyverse)

#' We will source `gapminder` dataset into the session and assign it 
#' to the variable with the same name
gapminder <- gapminder::gapminder   #this is actually a tibble (a tibble can also store "variables" like a dataframe)


gapminder



#' Let's make our first plot
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))

#' Generally speaking ggplot2 syntax follows the template:
# ggplot(<DATA>) +
#   geom_<GEOM_FUNCTION>(mapping=aes(<AESTETICS>))

#' Let's learn some more about `ggplot2` and its functions!
#' 

ggplot(gapminder)+
  geom_jitter(mapping = aes(x=gdpPercap, y=lifeExp, 
                            color=continent))


ggplot(gapminder)+
  geom_jitter(mapping = aes(y=gdpPercap, x=pop, 
                            color=continent))

ggplot(gapminder)+
  geom_jitter(mapping = aes(x=continent, y=lifeExp,  
                            color=year))



ggplot(gapminder)+
  geom_point(mapping = aes(x=log(gdpPercap),
                           y=lifeExp, color=continent,
                           size=pop))
             
ggplot(gapminder)+
  geom_point(mapping = aes(x=log(gdpPercap),
                           y=lifeExp, color=year,
                           size=pop, shape=continent))



ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp),
             color="blue", alpha=0.1)


#new geom funciton LINES
ggplot(gapminder)+
  geom_line(mapping = aes(x=year, y=lifeExp,
                          color=continent))  #here it doesn't make sense

ggplot(gapminder)+
  geom_line(mapping = aes(x=year, y=lifeExp, 
                          group=country,
                          color=continent))       #here, groups the lines by country, colors by continent


ggplot(gapminder)+
  geom_boxplot(mapping = aes(x=year, y=lifeExp, 
                          color=continent))       



ggplot(gapminder)+
  geom_jitter(mapping=aes(x=continent, y=lifeExp,
                          color=continent))+
  geom_boxplot(mapping = aes(x=continent, y=lifeExp,
                             color=continent))

ggplot(gapminder, mapping=aes(x=continent, y=lifeExp,
                              color=continent))+
  geom_jitter()+
  geom_boxplot()



#more examples of multiple layers
ggplot(gapminder, mapping = aes(x=log(gdpPercap),
                                y=lifeExp, color=continent))+ #here, one line per continent
         geom_point()+
         geom_smooth(method="lm")


ggplot(gapminder, mapping = aes(x=log(gdpPercap),
                                y=lifeExp))+
  geom_point(aes(color=continent))+ #here, one regression line
  geom_smooth(method="lm")


ggplot(gapminder, mapping = aes(x=log(gdpPercap),
                                y=lifeExp, color=continent))+ 
  geom_point()+
  geom_smooth(method="lm", color="black") #this OVERWRITES the color=continent that gets inherited (huh)





ggplot(gapminder, mapping = aes(x=gdpPercap,
                                y=lifeExp, color=continent))+ 
  geom_point()+
  geom_smooth(method="lm")+ #this is NOT a layer
  scale_x_log10() #ah.. instead of doing log(gdpercap) #now the x-axis dislplays the "normal" values


#boxplot by year
ggplot(gapminder, mapping=aes(y=lifeExp, x=year, group=year))+  #here, it forces year into bins
         geom_boxplot()

#different way
ggplot(gapminder, mapping=aes(y=lifeExp, x=as.character(year)))+   #the advantage of this is it uses the ACTUAL years
  geom_boxplot()




ggplot(gapminder, mapping=aes(y=gdpPercap, x=year, group=year))+  
  geom_boxplot()+
  scale_y_log10() #boxplots are statistically misleading (i.e. small diffs in boxplots are actually HUGE differences)


ggplot(gapminder, mapping=aes(x=gdpPercap))+  
  geom_histogram(bins=100)

ggplot(gapminder, mapping=aes(x=gdpPercap))+  
  geom_histogram(bins=100)+
  scale_x_log10()

ggplot(gapminder, mapping=aes(x=gdpPercap))+  
  geom_density()

ggplot(gapminder, mapping=aes(x=gdpPercap,fill=continent))+  
  geom_density(alpha=0.5)+
  scale_x_log10()


ggplot(gapminder, mapping=aes(x=gdpPercap))+  
  geom_density2d(aes(y=lifeExp), alpha=0.5)+
  scale_x_log10()





### faceting
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))+
  facet_wrap(~continent)


##play with this.. facet_grid is like facet_wrap but you can order...
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))+
  facet_grid(year~continent)

ggplot(gapminder)+
  geom_point(mapping=aes(x=gdpPercap,
                         y=lifeExp,
                         color=continent,
                         size=pop))+
  scale_x_log10()+
  labs(x="GDP per capita in 1000 USD",
       y="Life expectancy at birth, years",
       color="Continent",
       title="GDP per cap vs. Life Expectancy",
       subtitle="money makes you live longer",
       caption="Source: GAPMINDER.ORG")

  