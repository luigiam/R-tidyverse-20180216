#' ---
#' title: "R tidyverse workshop"
#' author: "fixme"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---
 
#' Uncomment the following lines to install necessary packages

#install.packages("tidyverse")
#install.packages("maps")
#install.packages("gapminder")

#' First we need to load libraries installed previously
library(tidyverse)

#' We will source `gapminder` dataset into the session and assign it 
#' to the variable with the same name
gapminder <- gapminder::gapminder

#' Let's make our first plot
ggplot(gapminder)+
  geom_point(mapping = aes(x=gdpPercap, y=lifeExp))

#' Generally speaking ggplot2 syntax follows the template:
#' 
#' `ggplot(<DATA>) +
#'   geom_<GEOM_FUNCTION>(mapping=aes(<AESTETICS>))`
#' 
#' Let's learn some more about `ggplot2` and its functions!