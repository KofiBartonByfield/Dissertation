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
                                    EthnicMinority_z + 
                                    DrugCrimeSum_z,
                                  data = london)

london_regression_1.2 <- fenegbin(StopCount ~ 
                                gini + 
                                IncomeDomainScore_z + 
                                MeanHousePrice_z + 
                                CrimeSum_z + 
                                EthnicMinority_z + 
                                DrugCrimeSum_z | Borough,
                                cluster = "Borough",                                
                              data = london)


london_regression_1.3 <- fenegbin(StopCount ~ 
                                    gini + 
                                    IncomeDomainScore_z + 
                                    MeanHousePrice_z + 
                                    CrimeSum_z + 
                                    EthnicMinority_z + 
                                    DrugCrimeSum_z +
                                    gini*EthnicMinority_z| Borough,
                                    cluster = "Borough",
                                  data = london)


london_regression_1.4 <- fenegbin(StopCount ~ 
                                    gini + 
                                    IncomeDomainScore_z + 
                                    MeanHousePrice_z + 
                                    CrimeSum_z + 
                                    EthnicMinority_z + 
                                    DrugCrimeSum_z +
                                    IncomeDomainScore_z*EthnicMinority_z| Borough,
                                    cluster = "Borough",
                                  data = london)






etable(london_regression_1.1, 
       london_regression_1.2,
       london_regression_1.3, 
       london_regression_1.4)




















merseyside_regression_1.1 <- fenegbin(StopCount ~ 
                                    gini + 
                                    IncomeDomainScore_z + 
                                    MeanHousePrice_z + 
                                    CrimeSum_z + 
                                    EthnicMinority_z + 
                                    DrugCrimeSum_z,
                                  data = merseyside)

merseyside_regression_1.2 <- fenegbin(StopCount ~ 
                                    gini + 
                                    IncomeDomainScore_z + 
                                    MeanHousePrice_z + 
                                    CrimeSum_z + 
                                    EthnicMinority_z + 
                                    DrugCrimeSum_z | Borough,
                                  cluster = "Borough",                                
                                  data = merseyside)


merseyside_regression_1.3 <- fenegbin(StopCount ~ 
                                    gini + 
                                    IncomeDomainScore_z + 
                                    MeanHousePrice_z + 
                                    CrimeSum_z + 
                                    EthnicMinority_z + 
                                    DrugCrimeSum_z +
                                    gini*EthnicMinority_z| Borough,
                                  cluster = "Borough",
                                  data = merseyside)


merseyside_regression_1.4 <- fenegbin(StopCount ~ 
                                    gini + 
                                    IncomeDomainScore_z + 
                                    MeanHousePrice_z + 
                                    CrimeSum_z + 
                                    EthnicMinority_z + 
                                    DrugCrimeSum_z +
                                    IncomeDomainScore_z*EthnicMinority_z| Borough,
                                  cluster = "Borough",
                                  data = merseyside)






etable(merseyside_regression_1.1, 
       merseyside_regression_1.2,
       merseyside_regression_1.3, 
       merseyside_regression_1.4)






vars <- c(
  gini = "Gini Coefficient",
  IncomeDomainScore_z = "Income Deprivation (z)",
  MeanHousePrice_z = "Mean House Price (z)",
  CrimeSum_z = "Crime Rate (z)",
  EthnicMinority_z = "Ethnic Minority (z)",
  DrugCrimeSum_z = "Drug Crime Rate (z)",
  `gini x EthnicMinority_z` = "Gini x Ethnic Minority",
  `IncomeDomainScore_z x EthnicMinority_z` = "Income x Ethnic Minority"
)



etable(
  merseyside_regression_1.1,
  merseyside_regression_1.2,
  merseyside_regression_1.3,
  merseyside_regression_1.4,
  tex = TRUE,
  style.tex = style.tex("base"),
  digits = 3,
  dict = vars,
  signif.code = c("***" = 0.001, "**" = 0.01, "*" = 0.05, "." = 0.1, " " = 1)
)


etable(
  london_regression_1.1,
  london_regression_1.2,
  london_regression_1.3,
  london_regression_1.4,
  tex = TRUE,
  style.tex = style.tex("base"),
  digits = 3,
  dict = vars,
  signif.code = c("***" = 0.001, "**" = 0.01, "*" = 0.05, "." = 0.1, " " = 1)
  )

















