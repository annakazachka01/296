library(NMF)
library(tidyverse)
library(readxl)

#load the data
star_ratings = read_excel('C:/Users/jbecerra/Documents/UCSB/Winter 2023/PSTAT 296B (TA)/JD_Model/Benefit_Dummy2.xlsx') %>%
  select('Star_Rating_3',
         'Star_Rating_3.5',
         'Star_Rating_4',
         'Star_Rating_4.5')
#pull the results from the nmf
load('C:/Users/jbecerra/Documents/UCSB/Winter 2023/PSTAT 296B (TA)/nmfResults296_20230202.RData')
#plot a single method
plot(brunet)
#compare two methods -- triangles correspond to the second argument
plot(brunet, lee)
#plot scores of interest
plot(lee, snmfl, what = c('cophenetic', 'rss'))
#measures are extractable:
snmfl$measures$rss

#Task: Make a nice ggplot with the cophenetic and rss measures.


#Winner: snmf/l with rank r = 3 (maybe r = 7)
basismap(snmfl$fit$`3`)
coefmap(snmfl$fit$`3`)



coef(snmfl$fit$`3`)

