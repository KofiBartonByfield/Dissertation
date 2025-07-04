rm(list = ls()) 


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
library(ggplot2)
library(scales)  


df_london <- tidy(london_regression_1.2, conf.int = TRUE) %>% mutate(region = "London")
df_merseyside <- tidy(merseyside_regression_1.2, conf.int = TRUE) %>% mutate(region = "Merseyside")

df_all <- bind_rows(df_london, df_merseyside)

df_all <- df_all %>% filter(p.value < 0.05)

# Define custom names for your terms
custom_names <- c(
  gini = "Gini Coefficient",
  IncomeDomainScore_z = "Income Score (z)",
  MeanHousePrice_z = "Mean House Price (z)",
  CrimeSum_z = "Crime Sum (z)",
  EthnicMinority_z = "Ethnic Minority (z)",
  DrugCrimeSum_z = "Drug Crime Sum (z)",
  .theta = "Over Disperson")



ggplot(df_all, aes(x = estimate, y = term, colour = region)) +
  geom_point(position = position_dodge(width = 0.6), size = 4, alpha = 0.85) +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high),
                 position = position_dodge(width = 0.6), height = 0.25, linewidth = 0.8) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey60") +
  scale_colour_manual(values = c("London" = "#2C7BB6", "Merseyside" = "#D7191C")) +
  scale_y_discrete(labels = custom_names) +   # custom labels here
  labs(
    x = "Coefficient Estimate",
    y = NULL,
    colour = "Region",
    title = "Coefficients: London vs Merseyside"
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









df_all <- bind_rows(df_london, df_merseyside) %>%
  filter(term != ".theta") %>%
  mutate(
    estimate_adj = ifelse(term == "gini", estimate * 0.1, estimate),
    conf.low_adj = ifelse(term == "gini", conf.low * 0.1, conf.low),
    conf.high_adj = ifelse(term == "gini", conf.high * 0.1, conf.high),
    
    percent_change = (exp(estimate_adj) - 1) * 100,
    conf.low.pc = (exp(conf.low_adj) - 1) * 100,
    conf.high.pc = (exp(conf.high_adj) - 1) * 100
  )





coef_plot <- ggplot(df_all, aes(x = percent_change, y = term, colour = region, shape = region)) +
  geom_point(position = position_dodge(width = 0.6), size = 4, alpha = 0.85) +
  geom_errorbarh(aes(xmin = conf.low.pc, xmax = conf.high.pc),
                 position = position_dodge(width = 0.6), height = 0.25, linewidth = 0.8) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey60") +
  scale_colour_manual(values = c("London" = "#2C7BB6", "Merseyside" = "#D7191C")) +
  scale_shape_manual(values = c("London" = 16, "Merseyside" = 17)) +  # 16 = solid circle, 17 = solid triangle
  scale_y_discrete(labels = custom_names) +
  labs(
    x = "Percentage Change in Expected Count",
    y = NULL,
    colour = "Region",
    shape = "Region",
    title = "Regression Coefficients: London vs Merseyside"
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


coef_plot




ggsave("Figures/Graphs/Coefficient_Graph.png", plot = coef_plot, width = 10, height = 6, dpi = 300)
