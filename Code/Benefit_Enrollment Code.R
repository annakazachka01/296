setwd("/Users/ancher/Desktop")
library(tidyverse)
library(dplyr)

enrol <- read.csv("Enrollment.csv")

enrol <- mutate(enrol, Contract_Plan_Segment = paste(Contract.Number, Plan.ID, Segment.ID,sep = "-"))
enrol <- subset(enrol, select = -c(Contract.Number, Plan.ID, Segment.ID, State_Penetration))

Benef <- read.csv("Benefit.csv")

data <- left_join(Benef,enrol)

write.csv(data,file = "Benefit_Enrollment.csv")
?write.csv
