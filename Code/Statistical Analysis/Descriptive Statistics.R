library(dplyr)
library(stargazer)


dataset <- read.csv('Data/Data Sets/cleaned_dataset.csv')



merseyside <- dataset %>% 
                        filter(PoliceDept == "Merseyside")%>% 
                        dplyr::select(StopCount,
                                      StopCountDrugs,
                                      PopulationLSOA,
                                      BAME, 
                                      IncomeDomainScore,
                                      CrimeSum,
                                      DrugCrimeSum,
                                      MeanHousePrice
                                      )

london <- dataset %>% 
                    filter(PoliceDept == "London")%>% 
                    dplyr::select(StopCount,
                                  StopCountDrugs,
                                  PopulationLSOA,
                                  BAME, 
                                  IncomeDomainScore,
                                  CrimeSum,
                                  DrugCrimeSum,
                                  MeanHousePrice
                                  )


stargazer(merseyside, 
          type = 'text', 
          digits = 0, 
          covariate.labels = c("Total Stop Count", 
                               "Drug Related Stop Count", 
                               "LSOA Population", 
                               "Percentage of BAME Individuals", 
                               "Income Domain Score", 
                               "Total Crime Count", 
                               "Drug-Related Crime Count", 
                               "Mean House Price"))



stargazer(london, 
          type = 'text', 
          digits = 0, 
          covariate.labels = c("Total Stop Count", 
                               "Drug Related Stop Count", 
                               "LSOA Population", 
                               "Percentage of BAME Individuals", 
                               "Income Domain Score", 
                               "Total Crime Count", 
                               "Drug-Related Crime Count", 
                               "Mean House Price"))



















# Save the stargazer output to the specified file
stargazer(london, merseyside, 
          type = 'latex', 
          digits = 0, 
          covariate.labels = c("Total Stop Count", 
                               "Drug Related Stop Count", 
                               "LSOA Population", 
                               "Percentage of BAME Individuals", 
                               "Income Domain Score", 
                               "Total Crime Count", 
                               "Drug-Related Crime Count", 
                               "Mean House Price"),
          out = "Figures/Regression Tables/Descriptive_Statistics.tex") 




