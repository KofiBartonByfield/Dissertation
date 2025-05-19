library(dplyr)
library(fixest)
library(MASS)
library(car)
library(stargazer)


dataset <- read.csv('Data/Data Sets/cleaned_dataset.csv')

merseyside <- dataset %>% filter(PoliceDept == "Merseyside")
london <- dataset %>% filter(PoliceDept == "London")

head(merseyside)
head(london)










london_regression_1.1 <- fenegbin(StopCount ~ 
                                gini + 
                                IncomeDomainScore_z + 
                                MeanHousePrice_z + 
                                CrimeSum_z + 
                                BAME_z + 
                                DrugCrimeSum_z | Borough,
                              data = london)

london_regression_1.2 <- fenegbin(StopCount ~ 
                                CrimeSum_z + 
                                DrugCrimeSum_z | Borough,
                              data = london)




etable(london_regression_1.1, london_regression_1.2)







