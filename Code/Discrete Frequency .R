# Install
install.packages("NMF")
# Load
library(NMF)

# how to make frequency table in r (nicer version)
install.packages('epiDisplay')
library(epiDisplay)

setwd("/Users/annakazachka/PSTAT296/OurDataSets")
benefits <- read.csv('Benefit_Total.csv')


tab1(benefits$Drug_Coverage, cum.percent = TRUE)
tab1(benefits$In_Inpatient_numdays, cum.percent = TRUE)
tab1(benefits$In_Inpatient_inf, cum.percent = TRUE)
tab1(benefits$Out_Inpatient_numdays, cum.percent = TRUE)
tab1(benefits$Out_Inpatient_inf, cum.percent = TRUE)

tab1(benefits$X..of.preventive.Dental.Coverage, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X..of.comprehensive.Dental.Coverage, cum.percent = TRUE)
tab1(benefits$X14c1_Health_Education, cum.percent = TRUE)
tab1(benefits$X14c2_Nutritional.Dietary_Benefit, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c3_Smoking_Tobacco_Counseling, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c4_Fitness_Benefit, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c5_Enhanced_Disease_Management, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c6_Telemonitoring_Services, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c7_Remote_Access_Technologies, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c8_Bathroom_Safety_Devices, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c9_Counseling_Services, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c10_In.Home_Safety_Assessment, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c11_Personal_Emergency_Response_System, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c12_Medical_Nutrition_Therapy, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c13_In.Home_Medication_Reconciliation, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c14_Re.admission_Prevention, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c15_Wigs_for_Hair_Loss, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c16_Weight_Management_Programs, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c17_Alternative_Therapies, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c18_Therapeutic_Massage, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c19_Adult_Day_Health_Services, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c20_Home.Based_Palliative_Care, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c21_In.Home_Support_Services, sort.group = "decreasing", cum.percent = TRUE)
tab1(benefits$X14c22_Support_for_Caregivers_of_Enrollees, sort.group = "decreasing", cum.percent = TRUE)










