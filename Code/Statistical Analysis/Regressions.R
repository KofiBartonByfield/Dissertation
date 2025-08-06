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




# 
# 
# 
# london_regression_1.1 <- fenegbin(StopCount ~ 
#                                     gini + 
#                                     IncomeDomainScore_z + 
#                                     MeanHousePrice_z + 
#                                     CrimeSum_z + 
#                                     DrugCrimeSum_z +
#                                     EthnicMinority_z,
#                                   data = london)
# 
# london_regression_1.2 <- fenegbin(StopCount ~ 
#                                 gini + 
#                                 IncomeDomainScore_z + 
#                                 MeanHousePrice_z + 
#                                 CrimeSum_z + 
#                                   DrugCrimeSum_z +
#                                   EthnicMinority_z | Borough,
#                                 cluster = "Borough",                                
#                               data = london)
# 
# 
# london_regression_1.3 <- fenegbin(StopCount ~ 
#                                     gini + 
#                                     IncomeDomainScore_z + 
#                                     MeanHousePrice_z + 
#                                     CrimeSum_z + 
#                                     DrugCrimeSum_z +
#                                     EthnicMinority_z +
#                                     gini*EthnicMinority_z| Borough,
#                                     cluster = "Borough",
#                                   data = london)
# 
# 
# london_regression_1.4 <- fenegbin(StopCount ~ 
#                                     gini + 
#                                     IncomeDomainScore_z + 
#                                     MeanHousePrice_z + 
#                                     CrimeSum_z + 
#                                     DrugCrimeSum_z +
#                                     EthnicMinority_z +
#                                     IncomeDomainScore_z*EthnicMinority_z| Borough,
#                                     cluster = "Borough",
#                                   data = london)
# 
# 
# 
# 
# 
# 
# etable(london_regression_1.1, 
#        london_regression_1.2,
#        london_regression_1.3, 
#        london_regression_1.4)
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# merseyside_regression_1.1 <- fenegbin(StopCount ~ 
#                                     gini + 
#                                     IncomeDomainScore_z + 
#                                     MeanHousePrice_z + 
#                                     CrimeSum_z + 
#                                       DrugCrimeSum_z +
#                                       EthnicMinority_z,
#                                   data = merseyside)
# 
# merseyside_regression_1.2 <- fenegbin(StopCount ~ 
#                                     gini + 
#                                     IncomeDomainScore_z + 
#                                     MeanHousePrice_z + 
#                                     CrimeSum_z + 
#                                       DrugCrimeSum_z +
#                                       EthnicMinority_z | Borough,
#                                   cluster = "Borough",                                
#                                   data = merseyside)
# 
# 
# merseyside_regression_1.3 <- fenegbin(StopCount ~ 
#                                     gini + 
#                                     IncomeDomainScore_z + 
#                                     MeanHousePrice_z + 
#                                     CrimeSum_z + 
#                                       DrugCrimeSum_z +
#                                       EthnicMinority_z +
#                                     gini*EthnicMinority_z| Borough,
#                                   cluster = "Borough",
#                                   data = merseyside)
# 
# 
# merseyside_regression_1.4 <- fenegbin(StopCount ~ 
#                                     gini + 
#                                     IncomeDomainScore_z + 
#                                     MeanHousePrice_z + 
#                                     CrimeSum_z + 
#                                       DrugCrimeSum_z +
#                                       EthnicMinority_z +
#                                     IncomeDomainScore_z*EthnicMinority_z| Borough,
#                                   cluster = "Borough",
#                                   data = merseyside)
# 
# 
# 
# 
# 
# 
# etable(merseyside_regression_1.1, 
#        merseyside_regression_1.2,
#        merseyside_regression_1.3, 
#        merseyside_regression_1.4)
# 
# 
# 
# 
# 
# 
# vars <- c(
#   gini = "Gini Coefficient",
#   IncomeDomainScore_z = "Income Deprivation (z)",
#   MeanHousePrice_z = "Mean House Price (z)",
#   CrimeSum_z = "Crime Rate (z)",
#   EthnicMinority_z = "Ethnic Minority (z)",
#   DrugCrimeSum_z = "Drug Crime Rate (z)",
#   `gini x EthnicMinority_z` = "Gini x Ethnic Minority",
#   `IncomeDomainScore_z x EthnicMinority_z` = "Income x Ethnic Minority"
# )
# 
# 
# 
# etable(
#   merseyside_regression_1.1,
#   merseyside_regression_1.2,
#   merseyside_regression_1.3,
#   merseyside_regression_1.4,
#   tex = TRUE,
#   style.tex = style.tex("base"),
#   digits = 3,
#   dict = vars,
#   signif.code = c("***" = 0.001, "**" = 0.01, "*" = 0.05, "." = 0.1, " " = 1)
# )
# 
# 
# etable(
#   london_regression_1.1,
#   london_regression_1.2,
#   london_regression_1.3,
#   london_regression_1.4,
#   tex = TRUE,
#   style.tex = style.tex("base"),
#   digits = 3,
#   dict = vars,
#   signif.code = c("***" = 0.001, "**" = 0.01, "*" = 0.05, "." = 0.1, " " = 1)
#   )
# 
# 
# 
# 
# 
# 
# london_regression_1.2
# merseyside_regression_1.2
# 
# 
# 
# 
# 
# library(broom)
# library(dplyr)
# library(ggplot2)
# library(scales)  
# 
# 
# df_london <- tidy(london_regression_1.2, conf.int = TRUE) %>% mutate(region = "London")
# df_merseyside <- tidy(merseyside_regression_1.2, conf.int = TRUE) %>% mutate(region = "Merseyside")
# 
# df_all <- bind_rows(df_london, df_merseyside)
# 
# df_all <- df_all %>% filter(p.value < 0.05)
# 
# # Define custom names for your terms
# custom_names <- c(
#   gini = "Gini Coefficient",
#   IncomeDomainScore_z = "Income Score (z)",
#   MeanHousePrice_z = "Mean House Price (z)",
#   CrimeSum_z = "Crime Sum (z)",
#   EthnicMinority_z = "Ethnic Minority (z)",
#   DrugCrimeSum_z = "Drug Crime Sum (z)",
#   .theta = "Over Disperson")
# 
# 
# 
# ggplot(df_all, aes(x = estimate, y = term, colour = region)) +
#   geom_point(position = position_dodge(width = 0.6), size = 4, alpha = 0.85) +
#   geom_errorbarh(aes(xmin = conf.low, xmax = conf.high),
#                  position = position_dodge(width = 0.6), height = 0.25, linewidth = 0.8) +
#   geom_vline(xintercept = 0, linetype = "dashed", colour = "grey60") +
#   scale_colour_manual(values = c("London" = "#2C7BB6", "Merseyside" = "#D7191C")) +
#   scale_y_discrete(labels = custom_names) +   # custom labels here
#   labs(
#     x = "Coefficient Estimate",
#     y = NULL,
#     colour = "Region",
#     title = "Coefficients: London vs Merseyside"
#   ) +
#   theme_minimal(base_size = 14) +
#   theme(
#     axis.text.y = element_text(face = "bold"),
#     axis.title.x = element_text(face = "bold"),
#     plot.title = element_text(face = "bold", size = 16, hjust = 0.5, margin = margin(b = 15)),
#     legend.position = "right",
#     legend.title = element_text(face = "bold"),
#     legend.text = element_text(size = 12)
#   )
# 
# 
# 
# 
# 
# 
# 
# 
# 
# df_all <- bind_rows(df_london, df_merseyside) %>%
#   filter(term != ".theta") %>%
#   mutate(
#     estimate_adj = ifelse(term == "gini", estimate * 0.1, estimate),
#     conf.low_adj = ifelse(term == "gini", conf.low * 0.1, conf.low),
#     conf.high_adj = ifelse(term == "gini", conf.high * 0.1, conf.high),
#     
#     percent_change = (exp(estimate_adj) - 1) * 100,
#     conf.low.pc = (exp(conf.low_adj) - 1) * 100,
#     conf.high.pc = (exp(conf.high_adj) - 1) * 100
#   )
# 
# 
# 
# 
# 
# coef_plot <- ggplot(df_all, aes(x = percent_change, y = term, colour = region, shape = region)) +
#   geom_point(position = position_dodge(width = 0.6), size = 4, alpha = 0.85) +
#   geom_errorbarh(aes(xmin = conf.low.pc, xmax = conf.high.pc),
#                  position = position_dodge(width = 0.6), height = 0.25, linewidth = 0.8) +
#   geom_vline(xintercept = 0, linetype = "dashed", colour = "grey60") +
#   scale_colour_manual(values = c("London" = "#2C7BB6", "Merseyside" = "#D7191C")) +
#   scale_shape_manual(values = c("London" = 16, "Merseyside" = 17)) +  # 16 = solid circle, 17 = solid triangle
#   scale_y_discrete(labels = custom_names) +
#   labs(
#     x = "Percentage Change in Expected Count",
#     y = NULL,
#     colour = "Region",
#     shape = "Region",
#     title = "Regression Coefficients: London vs Merseyside"
#   ) +
#   theme_minimal(base_size = 14) +
#   theme(
#     axis.text.y = element_text(face = "bold"),
#     axis.title.x = element_text(face = "bold"),
#     plot.title = element_text(face = "bold", size = 16, hjust = 0.5, margin = margin(b = 15)),
#     legend.position = "right",
#     legend.title = element_text(face = "bold"),
#     legend.text = element_text(size = 12)
#   )
# 
# 
# coef_plot
# 
# 
# 
# 
# ggsave("Figures/Graphs/Coefficient_Graph.png", plot = coef_plot, width = 10, height = 6, dpi = 300)
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# #
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# london_crime <- fenegbin(StopCount ~ 
#                                     CrimeSum_z + 
#                                     DrugCrimeSum_z,
#                                   data = london)
# 
# london_crime_fe <- fenegbin(StopCount ~ 
#                                     CrimeSum_z + 
#                                     DrugCrimeSum_z | Borough,
#                                   cluster = "Borough",                                
#                                   data = london)
# 
# 
# 
# merseyside_crime <- fenegbin(StopCount ~ 
#                            CrimeSum_z,
#                          data = merseyside)
# 
# merseyside_crime <- fenegbin(StopCount ~ 
#                               CrimeSum_z | Borough,
#                             cluster = "Borough",                                
#                             data = merseyside)
# 
# merseyside_crimes_and_drugs <- fenegbin(StopCount ~ 
#                                 CrimeSum_z + 
#                                 DrugCrimeSum_z| Borough,
#                                 cluster = "Borough",
#                              data = merseyside)
# 
# 
# 
# 
# 
# etable(merseyside_crime, merseyside_crimes_and_drugs)
# 
# library(car)
# vif(merseyside_crimes)
# 
# 
# 
# cor(merseyside[, c("CrimeSum_z", "DrugCrimeSum_z")], use = "complete.obs")
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# merseyside_regression_1.4 <- fenegbin(StopCount ~
#                                         IncomeDomainScore_z*EthnicMinority_z,
#                                       cluster = "Borough",
#                                       data = merseyside)
# 
# 
# etable(merseyside_regression_1.4)
# 
# library(interactions)
# interact_plot(merseyside_regression_1.4, pred = IncomeDomainScore_z, modx = EthnicMinority_z)
# 
# 
# 
# 
# 
# 


























################################################################################
rm(list = ls()) 

out <- c('latex')

library(dplyr)
library(fixest)
library(MASS)
library(car)
library(stargazer)




dataset <- read.csv('Data/Data Sets/cleaned_dataset.csv')

merseyside <- dataset %>% filter(PoliceDept == "Merseyside")
london <- dataset %>% filter(PoliceDept == "London")


# For Merseyside
merseyside <- merseyside %>%
  mutate(CrimeDomainDecile = factor(CrimeDomainDecile, levels = sort(unique(CrimeDomainDecile)))) %>%
  mutate(CrimeDomainDecile = relevel(CrimeDomainDecile, ref = "5"))

# For London
london <- london %>%
  mutate(CrimeDomainDecile = factor(CrimeDomainDecile, levels = sort(unique(CrimeDomainDecile)))) %>%
  mutate(CrimeDomainDecile = relevel(CrimeDomainDecile, ref = "5"))





merseyside_regression_1 <- fenegbin(StopCount ~ 
                                        gini + 
                                        IncomeDomainScore_z + 
                                        MeanHousePrice_z +
                                        DrugCrimeSum_z +
                                        EthnicMinority_z+
                                        CrimeDomainDecile| Borough,
                                      cluster = "Borough",
                                      data = merseyside)


merseyside_regression_1.1 <- fenegbin(StopCount ~ 
                                        gini + 
                                        IncomeDomainScore_z + 
                                        MeanHousePrice_z +
                                        DrugCrimeSum_z +
                                        EthnicMinority_z| Borough,
                                      cluster = "Borough",
                                      data = merseyside)



merseyside_regression_1.2 <- fenegbin(StopCount ~ CrimeDomainDecile| Borough,
                                      cluster = "Borough",
                                      data = merseyside)


merseyside_regression_1.3 <- fenegbin(StopCount ~ 
                                        gini + 
                                        IncomeDomainScore_z + 
                                        MeanHousePrice_z + 
                                        DrugCrimeSum_z +
                                        EthnicMinority_z +CrimeDomainDecile+
                                        gini*EthnicMinority_z| Borough,
                                      cluster = "Borough",
                                      data = merseyside)


merseyside_regression_1.4 <- fenegbin(StopCount ~ 
                                        gini + 
                                        IncomeDomainScore_z + 
                                        MeanHousePrice_z + 
                                        DrugCrimeSum_z +
                                        EthnicMinority_z +CrimeDomainDecile+
                                        IncomeDomainScore_z*EthnicMinority_z| Borough,
                                      cluster = "Borough",
                                      data = merseyside)



vars <- c(
  gini = "Gini Coefficient",
  IncomeDomainScore_z = "Income Deprivation (z)",
  MeanHousePrice_z = "Mean House Price (z)",
  DrugCrimeSum_z = "Drug Crime Rate (z)",
  EthnicMinority_z = "Ethnic Minority (z)",
  `gini x EthnicMinority_z` = "Gini Coefficient x Ethnic Minority (z)",
  `IncomeDomainScore_z x EthnicMinority_z` = "Income Deprivation (z) x Ethnic Minority (z)",
  `CrimeDomainDecile1` = 'Crime Domain Decile = 1',
  `CrimeDomainDecile2` = 'Crime Domain Decile = 2',
  `CrimeDomainDecile3` = 'Crime Domain Decile = 3',
  `CrimeDomainDecile4` = 'Crime Domain Decile = 4',
  `CrimeDomainDecile5` = 'Crime Domain Decile = 5',
  `CrimeDomainDecile6` = 'Crime Domain Decile = 6',
  `CrimeDomainDecile7` = 'Crime Domain Decile = 7',
  `CrimeDomainDecile8` = 'Crime Domain Decile = 8',
  `CrimeDomainDecile9` = 'Crime Domain Decile = 9',
  `CrimeDomainDecile10` = 'Crime Domain Decile = 10')





etable(merseyside_regression_1,
  # merseyside_regression_1.1,
  # merseyside_regression_1.2,
  merseyside_regression_1.3,
  merseyside_regression_1.4,
  tex = T,
  style.tex = style.tex("base"),
  digits = 3,
  dict = vars,
  signif.code = c("***" = 0.001, "**" = 0.01, "*" = 0.05, "." = 0.1, " " = 1)
)

# ------------------------------------------------------------------------------



london_regression_1 <- fenegbin(StopCount ~ 
                                      gini + 
                                      IncomeDomainScore_z + 
                                      MeanHousePrice_z +
                                      DrugCrimeSum_z +
                                      EthnicMinority_z+
                                      CrimeDomainDecile| Borough,
                                    cluster = "Borough",
                                    data = london)


london_regression_1.1 <- fenegbin(StopCount ~ 
                                        gini + 
                                        IncomeDomainScore_z + 
                                        MeanHousePrice_z +
                                        DrugCrimeSum_z +
                                        EthnicMinority_z| Borough,
                                      cluster = "Borough",
                                      data = london)



london_regression_1.2 <- fenegbin(StopCount ~ CrimeDomainDecile| Borough,
                                      cluster = "Borough",
                                      data = london)


london_regression_1.3 <- fenegbin(StopCount ~ 
                                        gini + 
                                        IncomeDomainScore_z + 
                                        MeanHousePrice_z + 
                                        DrugCrimeSum_z +
                                        EthnicMinority_z +CrimeDomainDecile+
                                        gini*EthnicMinority_z| Borough,
                                      cluster = "Borough",
                                      data = london)


london_regression_1.4 <- fenegbin(StopCount ~ 
                                        gini + 
                                        IncomeDomainScore_z + 
                                        MeanHousePrice_z + 
                                        DrugCrimeSum_z +
                                        EthnicMinority_z +CrimeDomainDecile+
                                        IncomeDomainScore_z*EthnicMinority_z| Borough,
                                      cluster = "Borough",
                                      data = london)




etable(london_regression_1,
  # london_regression_1.1,
  # london_regression_1.2,
  london_regression_1.3,
  london_regression_1.4,
  tex = T,
  style.tex = style.tex("base"),
  digits = 3,
  dict = vars,
  signif.code = c("***" = 0.001, "**" = 0.01, "*" = 0.05, "." = 0.1, " " = 1)
)






################################################################################





library(broom)
library(dplyr)
library(ggplot2)
library(stringr)

# Tidy the models and filter .theta
tidy_merseyside <- broom::tidy(merseyside_regression_1, conf.int = TRUE) %>%
  filter(term != ".theta") %>%
  mutate(model = "Merseyside")

tidy_london <- broom::tidy(london_regression_1, conf.int = TRUE) %>%
  filter(term != ".theta") %>%
  mutate(model = "London")

# Combine datasets
tidy_both <- bind_rows(tidy_merseyside, tidy_london)

# Make term a factor ordered by estimate magnitude (optional)
tidy_both$term <- factor(tidy_both$term, levels = rev(unique(tidy_both$term)))

# Extract numeric decile from term strings, e.g. "Crime Domain Decile 1" -> 1
get_decile_num <- function(x) {
  as.numeric(str_extract(x, "\\d+"))
}

# Your filtered data before adding fake labels
tidy_both_filtered <- tidy_both %>%
  filter(str_detect(term, "CrimeDomainDecile")) %>%
  mutate(term = as.character(term)) %>%
  mutate(term = str_replace_all(term, "CrimeDomainDecile", "Crime Domain Decile ")) 

# Get unique decile labels sorted by numeric decile
unique_deciles <- unique(tidy_both_filtered$term)
decile_order <- data.frame(
  term = unique_deciles,
  decile_num = get_decile_num(unique_deciles)
) %>%
  arrange(decile_num) %>%
  pull(term)

# Add fake labels at top and bottom
new_levels <- c("High Crime", decile_order, "Low Crime")

# Add fake rows with NA estimates
fake_rows <- data.frame(
  term = c("High Crime", "Low Crime"),
  estimate = NA_real_,
  conf.low = NA_real_,
  conf.high = NA_real_,
  model = 'Baseline'
)




# Combine data + fake rows
tidy_both_combined <- bind_rows(tidy_both_filtered, fake_rows)


baseline_rows <- data.frame(
  term = "Crime Domain Decile 5",
  estimate = 0,
  conf.low = 0,
  conf.high = 0,
  model = "Baseline"  # label for legend
)

tidy_both_combined <- bind_rows(tidy_both_combined, baseline_rows)

new_levels <- c(
  "High Crime",
  paste0("Crime Domain Decile ", 1:4),
  "Crime Domain Decile 5",  # baseline
  paste0("Crime Domain Decile ", 6:10),
  "Low Crime"
)



# Set factor levels in reverse order so 'High Crime' is top on y-axis, 'Low Crime' bottom
tidy_both_combined <- tidy_both_combined %>%
  # mutate(term = factor(term, levels = rev(new_levels)))
  mutate(term = factor(term, levels = new_levels))%>%
  mutate((across(c(estimate, conf.low, conf.high), exp)-1)* 100)


crime_plot <- ggplot(tidy_both_combined, aes(x = estimate, y = term, colour = model, shape = model)) +
    geom_vline(xintercept = 0, linetype = "dashed", colour = "grey0") +
    geom_point(position = position_dodge(width = 0.7), size = 4, na.rm = TRUE) +
    geom_errorbarh(aes(xmin = conf.low, xmax = conf.high),
                   position = position_dodge(width = 0.7), height = 0.2, size = 1.2, na.rm = TRUE) +
    scale_colour_manual(
      values = c(
        "London" = "#2C7BB6",
        "Merseyside" = "#D7191C",
        "Baseline" = "black"      # choose colour for baseline
      )
    ) +
    scale_shape_manual(
      values = c(
        "London" = 16,
        "Merseyside" = 17,
        "Baseline" = 16           # square or other distinct shape
      )
    ) +
    labs(title = "Coefficient Plot: Crime Domain Deciles",
         x = "Percentage Change in Expected Count", y = NULL, colour = "Location", shape = "Location") +
    theme_minimal() +
    theme(
      legend.position = "bottom",
      axis.text.y = element_text(size = 12)
    )

crime_plot
ggsave("Figures/Graphs/Crime_Decile_Plot.png", plot = crime_plot, width = 10, height = 6, dpi = 300)









# ------------------------------------------------------------------------------


tidy_both_filtered <- tidy_both %>%
  filter(!str_detect(term, "CrimeDomainDecile")) %>%
  mutate((across(c(estimate, conf.low, conf.high), exp)-1)* 100)



custom_names <- c(
  gini = "Gini Coefficient",
  IncomeDomainScore_z = "Income Deprivation (z)",
  MeanHousePrice_z = "Mean House Price (z)",
  CrimeSum_z = "Crime Sum (z)",
  EthnicMinority_z = "Ethnic Minority (z)",
  DrugCrimeSum_z = "Drug Crime Sum (z)")


coef_plot <- ggplot(tidy_both_filtered, aes(x = estimate, y = term, colour = model, shape = model)) +
  geom_point(position = position_dodge(width = 0.6), size = 4, alpha = 0.85) +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high),
                 position = position_dodge(width = 0.6), height = 0.25, linewidth = 0.8) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey60") +
  scale_colour_manual(values = c("London" = "#2C7BB6", "Merseyside" = "#D7191C")) +
  scale_shape_manual(values = c("London" = 16, "Merseyside" = 17)) +  # 16 = solid circle, 17 = solid triangle
  scale_y_discrete(labels = custom_names) +
  labs(title = "Coefficient Plot",
       x = "Percentage Change in Expected Count", y = NULL, colour = "Location", shape = "Location") +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    axis.text.y = element_text(size = 12)
  )



coef_plot

ggsave("Figures/Graphs/Coefficient_Graph.png", plot = coef_plot, width = 10, height = 6, dpi = 300)









