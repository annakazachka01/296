###############################################################################
#                              PSTAT296 Project
#                       Enrollment & Performance Script
#                                  Team 5
###############################################################################

#Imports the Enrollment & Performance data
library(readxl)
library(tidyverse)
library(stringr)


#1. Enrollment Data
Enrollment <- 
  read_csv("/Users/candiceyu/Documents/PSTAT296A/MyCode/Enrolled_Star/Enrollment_Combined.csv", 
           col_types = cols(Enrolled = col_number()))
Enrollment_main <- Enrollment[, c("State", "Contract.ID", "Organization.Name", 
                                                   "Enrolled", "Month")]

#2. Performance
Performance <- 
  read_csv("/Users/candiceyu/Documents/PSTAT296A/MyCode/Enrolled_Star/performance_subset.csv", 
           col_types = cols(Enrolled = col_number()))
Performance<- Performance[, -1]

#3. Combination according to Contract ID

Enrollment_Performance<-merge(Enrollment_main, Performance, by.x="Contract.ID",by.y="Contract Number")

setwd("/Users/candiceyu/Documents/PSTAT296A/MyCode/Enrolled_Star")
write.csv(Enrollment_Performance, "Enrollment_Performance.csv")
