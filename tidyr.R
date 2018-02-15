library("readxl")

raw_fert <- read_excel("indicator undata total_fertility.xlsx") #read first sheet only.. can tell it which sheet to read

raw_fert %>% 
  rename(country = `Total fertility rate`) %>% 
  gather(key = year, value = fert, -country)  #you want to keep country as it is
#so basically, doing -country is saying "gather" (reformat) by variables EXCEPT for country
#if you DON'T do -country, you will get more rows (because there is one less column)

#you can TECHINICALLY call key and value whatever you want
#key should be the VARIABLE that is repeated a lot in the data (in this case, year.. what you want to GROUP by)
#and value is the value that comes under these "variables" (in this case, fert)

#switching what goes in key and value does not seem to matter (when doing -country)?

#so the way the data was organized was..

####wide format
#country  year1 year2 year3 year4 year5
#country1 value value value
#country2
#country3

###turning to long format
#country  key   value
#country1 
#country1
#country1
#.
#.
#.
#country2
#country2
#.


fert<- raw_fert %>% 
  rename(country = `Total fertility rate`) %>% 
  gather(key = year, value = fert, -country) %>% 
  mutate(year=as.integer(year))  #b/c the years were headers, R reads them as characters



raw_mort <- read_excel("indicator gapminder infant_mortality.xlsx") 

mort<- raw_mort %>% 
  rename(country = `Infant mortality rate`) %>% 
  gather(key = year, value = mort, -country) %>% 
  mutate(year=as.integer(year), 
         mort = as.numeric(mort))  


gapminder_plus = gapminder %>% 
  left_join(fert, by = c("year", "country")) %>% #so left join will ONLY add whats in the OVERLAP between two datasets (mort and fert are technically MUCH larger)
  left_join(mort, by = c("year", "country"))

write_csv(gapminder_plus, "gapminder_plus.csv")
