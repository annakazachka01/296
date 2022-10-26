library(tidyverse)

## Set working direction
setwd("~/Desktop/PSTAT296 Data/Enrollment")


## Reading file   File name: Enrol_sub
Enrol_sub <- read.csv("SCC_Enrollment_MA_Alt_2021_01.csv") %>%
  data.frame()
Month <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")


Enrol_sub$Month <- Month[1]

## Create Combined file    File name: Enrol
Enrol <- subset(Enrol_sub, State=="CT")

file_name <- c("SCC_Enrollment_MA_Alt_2021_01.csv",
               "SCC_Enrollment_MA_Alt_2021_02.csv",
               "SCC_Enrollment_MA_Alt_2021_03.csv",
               "SCC_Enrollment_MA_Alt_2021_04.csv",
               "SCC_Enrollment_MA_Alt_2021_05.csv",
               "SCC_Enrollment_MA_Alt_2021_06.csv",
               "SCC_Enrollment_MA_Alt_2021_07.csv",
               "SCC_Enrollment_MA_Alt_2021_08.csv",
               "SCC_Enrollment_MA_Alt_2021_09.csv",
               "SCC_Enrollment_MA_Alt_2021_10.csv",
               "SCC_Enrollment_MA_Alt_2021_11.csv",
               "SCC_Enrollment_MA_Alt_2021_12.csv")

m <- 2
while (m <= 12){
  Enrol_sub <- read.csv(file_name[m]) %>%
    data.frame()
  Enrol_sub$Month <- Month[m]
  Enrol_add <- subset(Enrol_sub, State == "CT")
  Enrol <- rbind(Enrol,Enrol_add)
  m = m + 1
}

write_csv(Enrol,"~/Desktop/PSTAT296 Data/Enrollment/Enrollment Combined.csv")






