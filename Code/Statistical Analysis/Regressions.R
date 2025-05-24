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






london_regression_1.2
merseyside_regression_1.2





library(broom)
library(dplyr)

df_london <- tidy(london_regression_1.2, conf.int = TRUE) %>% mutate(region = "London")
df_merseyside <- tidy(merseyside_regression_1.2, conf.int = TRUE) %>% mutate(region = "Merseyside")

df_all <- bind_rows(df_london, df_merseyside)

df_sig <- df_all %>% filter(p.value < 0.05)

# Define custom names for your terms
custom_names <- c(
  gini = "Gini Coefficient",
  IncomeDomainScore_z = "Income Score (z)",
  MeanHousePrice_z = "Mean House Price (z)",
  CrimeSum_z = "Crime Sum (z)",
  EthnicMinority_z = "Ethnic Minority %",
  DrugCrimeSum_z = "Drug Crime Sum (z)"
  # add all variables you want to rename here
)

# Replace terms with custom names, keeping order
df_sig$term <- factor(df_sig$term, levels = names(custom_names), labels = custom_names)


library(ggplot2)
library(scales) 

ggplot(df_sig, aes(x = estimate, y = term, colour = region)) +
  
  geom_point(position = position_dodge(width = 0.6), size = 4, alpha = 0.85) +
  
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high),
                 position = position_dodge(width = 0.6), height = 0.25, linewidth = 0.8) +
  
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey60") +
  
  scale_colour_manual(values = c("London" = "#2C7BB6", "Merseyside" = "#D7191C")) +
  
  labs(
    x = "Coefficient Estimate",
    y = NULL,
    colour = "Region",
    title = "Statistically Significant Coefficients: London vs Merseyside"
  ) +
  
  theme_minimal(base_size = 14) +
  
  theme(
    axis.text.y = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5, margin = margin(b = 15)),
    legend.position = "right",
    legend.title = element_text(face = "bold"),
    legend.text = element_text(size = 12)
  )

