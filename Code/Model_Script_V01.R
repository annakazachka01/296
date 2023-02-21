rm(list = ls())

library(tidyverse)
library(nlme)
library(readxl)
library(glmmLasso)
library(NMF)

setwd("W:/UPMC/Juan Diego's Project/UPMC")


enrollment_eligibles <- 
  read.csv("Benefits_Enrollment_Eligibles_20230215.csv") %>% 
  select(c('Contract_ID', 
           'Plan_ID', 
           'Segment_ID',
           'Year',
           'Contract_Plan_Segment',
           'Star_Rating_3',
           'Star_Rating_3.5',
           'Star_Rating_4',
           'Star_Rating_4.5',
           'State_Enrollment',
           'Total.Eligibles'))

enrollment_benefits_eligibles <-
  read.csv("Benefits_Enrollment_Eligibles_20230215.csv") %>%
  mutate(t = Year - 2019)
  

load('nmfResults296_20230216.RData')

data <- cbind(enrollment_eligibles, t(coef(snmfl$fit$`15`)))

data <- data %>% mutate(t = Year - 2019)

names(data)[12:26] <- c('x1',  'x2',  'x3',  'x4',  'x5',
                        'x6',  'x7',  'x8',  'x9', 'x10',
                        'x11', 'x12', 'x13', 'x14','x15')

model <- lme(log(State_Enrollment / Total.Eligibles) ~ 
               t + 
               Star_Rating_3 + 
               Star_Rating_3.5 + 
               Star_Rating_4 +
               Star_Rating_4.5 + 
               x1  +  x2 +  x3  +  x4  +  x5  +
               x6  +  x7 +  x8  +  x9  + x10  +
               x11 + x12 + x13  + x14  +  x15,
             data = data, 
             random = list(Contract_ID = ~t,
                           Contract_Plan_Segment = ~t))

summary(model)
plot(model)
ranef(model)
qqnorm(residuals(model))
qqline(residuals(model))

model_reduced <- lme(log(State_Enrollment / Total.Eligibles) ~ 
                       t + 
                       Star_Rating_3 + 
                       Star_Rating_3.5 + 
                       Star_Rating_4 +
                       Star_Rating_4.5 + 
                       x1  +  x2 +  x3  +  x4  +  x5  +
                       x6  +  x7 +  x8  +  x9  + x10  +
                       x11 + x12 + x13  + x14  +  x15,
                     data = data, 
                     random = list(Contract_ID = ~t,
                                   Contract_Plan_Segment = ~t))

#write.csv(basis(snmfl$fit$`15`), file = 'snmfl_15_basis.csv')

#beta_benefits <- fixef(model)[7:21]


#Inversion procedure:
#X <- basis(snmfl$fit$`15`)
#Inv <- solve(t(X) %*% X) %*% t(X)
#View(Inv)

#beta_benefits %*% Inv %>% t()


data_snmfl_6 <- cbind(enrollment_eligibles, t(coef(snmfl$fit$`6`)))
names(data_snmfl_6)[12:17] <- c('x1', 'x2', 'x3', 'x4', 'x5', 'x6')
data_snmfl_6 <- data_snmfl_6 %>% mutate(t = Year - 2019)

model_6 <- lme(log(State_Enrollment / Total.Eligibles) ~ 
               t + 
               Star_Rating_3 + 
               Star_Rating_3.5 + 
               Star_Rating_4 +
               Star_Rating_4.5 + 
               x1  +  x2 +  x3  +  x4  +  x5  + x6,
             random = list(Contract_ID = ~t,
                           Contract_Plan_Segment = ~t),
             data = data_snmfl_6)

summary(model_6)
plot(model_6)
ranef(model_6)
qqnorm(residuals(model_6))
qqline(residuals(model_6))



#basis(snmfl$fit$`15`)

model_raw_data <- lme(log(State_Enrollment/Total.Eligibles) ~
                        t + 
                        Star_Rating_3 + 
                        Star_Rating_3.5 + 
                        Star_Rating_4 +
                        Star_Rating_4.5 + 
                        Premium + 
                        Annual_Deductible + 
                        Drug_Coverage +
                        In_Specialist_Min +
                        In_Specialist_Max +
                        X14c4_Fitness_Benefit +
                        X14c7_Remote_Access_Technologies,
                        data = enrollment_benefits_eligibles, 
                        random = list(Contract_ID = ~t,
                                    Contract_Plan_Segment = ~t))
summary(model_raw_data)
plot(model_raw_data)
ranef(model_raw_data)
qqnorm(residuals(model_raw_data))
qqline(residuals(model_raw_data))

#write.csv(basis(snmfl$fit$`6`), file = 'snmfl_6_basis.csv')


##GLMM Lasso Model

enrollment_benefits_eligibles$Contract_ID <-
  as.factor(enrollment_benefits_eligibles$Contract_ID)


enrollment_benefits_eligibles$Contract_Plan_Segment <-
  as.factor(enrollment_benefits_eligibles$Contract_Plan_Segment)


formula_lasso <- log(State_Enrollment/Total.Eligibles) ~
  t + Star_Rating_3 + Star_Rating_3.5 + Star_Rating_4 + Star_Rating_4.5 +
  Premium +Annual_Deductible + Drug_Coverage +
  In_MOOP + Out_MOOP + In_HP_Deductible + Out_MOOP + 
  In_HP_Deductible + Out_HP_Deductible + In_Inpatient + In_Inpatient_inf +
  Out_Inpatient + Out_Inpatient_inf + Out_Inpatient_Coin + In_Primary_Min +
  In_Primary_Max + Out_Primary_Min + Out_Primary_Max + Out_Primary_Coin +
  In_Specialist_Min + In_Specialist_Max + Out_Specialist_Min + 
  Out_Specialist_Max + Out_Specialist_Coin + Emergency_Care +
  Urgent_Care_Min + Urgent_Care_Max + In_Ambulance + Out_Ambulance_Min +
  Out_Ambulance_Max + Out_Ambulance_Coin + In_Vision_Exam + 
  Out_Vision_Exam + Out_Vision_Exam_Coin + In_Hearing_Exam +
  Out_Hearing_Exam_Min + Out_Hearing_Exam_Max + 
  Out_Hearing_Exam_Coin + Tier1 + Tier2 + Tier3 + Tier4 + 
  Tier4_Coin + Tier5_Coin + OTC_Yearly + 
  X14c1_Health_Education + X14c10_In.Home_Safety_Assessment +
  X14c11_Personal_Emergency_Response_System +
  X14c12_Medical_Nutrition_Therapy + 
  X14c15_Wigs_for_Hair_Loss +
  X14c16_Weight_Management_Programs +
  X14c2_Nutritional.Dietary_Benefit +
  X14c3_Smoking_Tobacco_Counseling +
  X14c4_Fitness_Benefit +
  X14c7_Remote_Access_Technologies +
  X14c8_Bathroom_Safety_Devices +
  X14c9_Counseling_Services +
  Annual_Deductible_NA +
  Out_MOOP_NA +
  Out_HP_Deductible_NA +
  In_Inpatient_numdays_NA +
  Out_Inpatient_NA +
  Out_Inpatient_numdays_NA + 
  Out_Inpatient_Coin_NA +
  Out_Primary_Min_NA +
  Out_Primary_Max_NA +
  Out_Primary_Coin_NA +
  Out_Specialist_Min_NA +
  Out_Specialist_Min_NA +
  Out_Specialist_Coin_NA +
  Out_Ambulance_Min_NA +
  Out_Ambulance_Max_NA +
  Out_Ambulance_Coin_NA +
  In_Vision_Exam_NA +
  Out_Vision_Exam_NA +
  Out_Vision_Exam_Coin_NA +
  Out_Hearing_Exam_Min_NA +
  Out_Hearing_Exam_Max_NA +
  Out_Hearing_Exam_Coin_NA +
  Tier1_NA + Tier2_NA + Tier3_NA + Tier4_NA + Tier4_Coin_NA +
  Tier5_Coin_NA + OTC_Yearly_NA + 
  In_Inpatient_numdays_3 + 
  In_Inpatient_numdays_4 +
  In_Inpatient_numdays_5 +
  In_Inpatient_numdays_6 +
  In_Inpatient_numdays_90 +
  Out_Inpatient_numdays_1 +
  Out_Inpatient_numdays_3 +
  Out_Inpatient_numdays_4 +
  Out_Inpatient_numdays_5 +
  Out_Inpatient_numdays_6 +
  Out_Inpatient_numdays_90 +
  X..of.preventive.Dental.Coverage_0 +
  X..of.preventive.Dental.Coverage_2 +
  X..of.preventive.Dental.Coverage_3 +
  X..of.preventive.Dental.Coverage_4 +
  X..of.comprehensive.Dental.Coverage_0 +
  X..of.comprehensive.Dental.Coverage_2 +
  X..of.comprehensive.Dental.Coverage_5 +
  X..of.comprehensive.Dental.Coverage_6 +
  X..of.comprehensive.Dental.Coverage_7
  
  

for(i in 1:600)
  tryCatch({
  lmmlasso <- glmmLasso(formula_lasso,
                          data = enrollment_benefits_eligibles, 
                          rnd = list(Contract_ID = ~t,
                                     Contract_Plan_Segment = ~t), 
                          switch.NR = F,
                          final.re = F,
                          lambda = i/10,
                      control = glmmLassoControl(print.iter = T))
  print(paste('Success', i))
  },
  error = function(e){
    message(paste('Error', i))
  }
  )
summary(lmmlasso)
  
                            
lmmlasso <- glmmLasso(formula_lasso,
                      data = enrollment_benefits_eligibles, 
                      rnd = list(Contract_ID = ~1,
                                 Contract_Plan_Segment = ~1), 
                      switch.NR = F,
                      final.re = F,
                      lambda = 57,
                      control = glmmLassoControl(print.iter = T))
summary(lmmlasso)

#Possible Directions:
#(1) Fit an LMM with the resulting coefficients from a NMF with low rank (r = 6), 
#we would conclude on the type of plan that yields higher market share. (Check)
#(2) Stay with the LMM based on NMF with rank r = 15 and aim for a model with 
#high predictive capabilities but rather difficult (but feasible) 
#interpret ability.
#(3) Opt for an LMM with raw variables and no NMF for interpretation feasibility
#we would need to implement a variable selection approach and perhaps advanced
#estimation techniques.
#(4) Opt for a hybrid approach: Take a few variables of interest and apply NMF
#to the remaining ones and potentially enhance the outcome.
#(5) Enhance implementation of GLMMLasso probably using a MCMC sampler
#(6) Try PCA instead of NMF
