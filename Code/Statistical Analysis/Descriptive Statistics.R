library(dplyr)
library(stargazer)


dataset <- read.csv('Data/Data Sets/cleaned_dataset.csv')



merseyside <- dataset %>% 
                        filter(PoliceDept == "Merseyside")%>% 
                        dplyr::select(StopCount,
                                      StopCountDrugs,
                                      gini,
                                      PopulationLSOA,
                                      EthnicMinority, 
                                      IncomeDomainScore,
                                      CrimeSum,
                                      DrugCrimeSum,
                                      MeanHousePrice
                                      )

london <- dataset %>% 
                    filter(PoliceDept == "London")%>% 
                    dplyr::select(StopCount,
                                  StopCountDrugs,
                                  gini,
                                  PopulationLSOA,
                                  EthnicMinority, 
                                  IncomeDomainScore,
                                  CrimeSum,
                                  DrugCrimeSum,
                                  MeanHousePrice
                                  )


# Create the first table for London with label
stargazer(london, 
          type = 'text', 
          digits = 0, 
          covariate.labels = c("Total Stop Count", 
                               "Drug Related Stop Count", 
                               "Gini",
                               "LSOA Population", 
                               "Ethnic Minority Percentage", 
                               "Income Domain Score", 
                               "Total Crime Count", 
                               "Drug-Related Crime Count", 
                               "Mean House Price"),
          out = "Figures/Regression Tables/Descriptive_Statistics_London.tex",
          title = "Descriptive Statistics for Stop and Search Data in London",
          label = "tab:descriptive_london"
)

# Create the second table for Merseyside with label
stargazer(merseyside, 
          type = 'text', 
          digits = 0, 
          covariate.labels = c("Total Stop Count", 
                               "Drug Related Stop Count", 
                               "Gini",
                               "LSOA Population", 
                               "Ethnic Minority Percentage", 
                               "Income Domain Score", 
                               "Total Crime Count", 
                               "Drug-Related Crime Count", 
                               "Mean House Price"),
          title = "Descriptive Statistics for Stop and Search Data in Merseyside",
          label = "tab:descriptive_merseyside",
          out = "Figures/Regression Tables/Descriptive_Statistics_Merseyside.tex"
          
)








stargazer(london, 
          type = 'text')

stargazer(merseyside, 
          type = 'text')
