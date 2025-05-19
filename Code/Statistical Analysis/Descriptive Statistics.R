library(dplyr)
library(stargazer)


dataset <- read.csv('Data/Data Sets/cleaned_dataset.csv')



merseyside <- dataset %>% 
                        filter(PoliceDept == "Merseyside")%>% 
                        dplyr::select(StopCount,
                                      StopCountDrugs,
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
                                  gini,
                                  StopCountDrugs,
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
                               "Gini",
                               "Drug Related Stop Count", 
                               "LSOA Population", 
                               "Percentage of EthnicMinority Individuals", 
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
          type = 'latex', 
          digits = 0, 
          covariate.labels = c("Total Stop Count", 
                               "Drug Related Stop Count", 
                               "LSOA Population", 
                               "Percentage of EthnicMinority Individuals", 
                               "Income Domain Score", 
                               "Total Crime Count", 
                               "Drug-Related Crime Count", 
                               "Mean House Price"),
          title = "Descriptive Statistics for Stop and Search Data in Merseyside",
          label = "tab:descriptive_merseyside",
          out = "Figures/Regression Tables/Descriptive_Statistics_Merseyside.tex"
          
)















star <- stargazer(london, 
          type = 'text', 
          covariate.labels = c("Total Stop Count", 
                               "Gini",
                               "Drug Related Stop Count", 
                               "LSOA Population", 
                               "Percentage of EthnicMinority Individuals", 
                               "Income Domain Score", 
                               "Total Crime Count", 
                               "Drug-Related Crime Count", 
                               "Mean House Price"),
          out = "Figures/Regression Tables/Descriptive_Statistics_London.tex",
          title = "Descriptive Statistics for Stop and Search Data in London",
          label = "tab:descriptive_london"
)

star
# 0.250       0.146       0.000        0.930  


















