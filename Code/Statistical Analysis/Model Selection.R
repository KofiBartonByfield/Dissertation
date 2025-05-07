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


# London
# ==============================================================================
# Evaluate Poisson vs Negative Binomial
# ==============================================================================



# poisson model
london_poisson_model <- glm(StopCount ~ IncomeDomainScore_z + 
                                 MeanHousePrice_z + 
                                 CrimeSum_z + 
                                 BAME_z + 
                                 DrugCrimeSum_z,
                     data = london, 
                     family = poisson)

# negative binomial
london_negbin_model <- glm.nb(StopCount ~ IncomeDomainScore_z + 
                                   MeanHousePrice_z + 
                                   CrimeSum_z + 
                                   BAME_z + 
                                   DrugCrimeSum_z,
                       data = london)



summary(london_poisson_model)
summary(london_negbin_model)


stargazer(london_poisson_model, london_negbin_model,
          type='text')


# check for multicolineararity
vif(london_poisson_model)
vif(london_negbin_model)


anova(london_poisson_model, london_negbin_model, test = "Chisq")

# An ANOVA comparing Poisson and Negative Binomial models using a Chi-squared 
# test yielded a significant improvement in fit for the latter, with residual 
# deviance dropping from 206,475 to 5,701. This confirms the presence of 
# overdispersion in the data and supports the use of a Negative Binomial 
# specification.




library(knitr)

# Extract values
aic_poisson <- AIC(london_poisson_model)
aic_negbin <- AIC(london_negbin_model)

loglik_poisson <- as.numeric(logLik(london_poisson_model))
loglik_negbin <- as.numeric(logLik(london_negbin_model))

# Create a data frame
comparison_table <- data.frame(
  Metric = c("AIC", "Log Likelihood"),
  `Poisson Model` = c(round(aic_poisson, 2), round(loglik_poisson, 2)),
  `Negative Binomial Model` = c(round(aic_negbin, 2), round(loglik_negbin, 2))
)

# Print LaTeX table
tab <- kable(
  comparison_table, 
  format = "latex", 
  booktabs = TRUE, 
  caption = "Model Fit Comparison: Poisson vs Negative Binomial (London)",
  label = "tab:model_comparison_london"
)



# Save to file
writeLines(tab, "Figures/Regression Tables/model_comparison_london.tex")


# ------------------------------------------------------------------------------
# Fixed Effects
# ------------------------------------------------------------------------------




# negative binomial
london_negbin_model <- fenegbin(StopCount ~ IncomeDomainScore_z + 
                           MeanHousePrice_z + 
                           CrimeSum_z + 
                           BAME_z + 
                           DrugCrimeSum_z,
                         data = london)

# fe negative binomial
london_fe_negbin_model <- fenegbin(StopCount ~ IncomeDomainScore_z + 
                                         MeanHousePrice_z + 
                                         CrimeSum_z + 
                                         BAME_z + 
                                         DrugCrimeSum_z | Borough,
                            data = london)



summary(london_fe_negbin_model)


# ---------------------------
# comparing the two models
# ---------------------------



logLik(london_negbin_model)
logLik(london_fe_negbin_model)

# Since the fixed effects model has a higher (less negative) log-likelihood, 
# it means the fixed effects model fits the data better than the regular 
# negative binomial model.


AIC(london_negbin_model, london_fe_negbin_model)

etable(london_negbin_model, london_fe_negbin_model)
etable(london_negbin_model, london_fe_negbin_model, 
       tex = TRUE, 
       file = "Figures/Regression Tables/london_nb_vs_fenb_table.tex")





































# Merseyside
# ==============================================================================
# Evaluate Poisson vs Negative Binomial
# ==============================================================================



# poisson model
merseyside_poisson_model <- glm(StopCount ~ IncomeDomainScore_z + 
                              MeanHousePrice_z + 
                              CrimeSum_z + 
                              BAME_z + 
                              DrugCrimeSum_z,
                            data = merseyside, 
                            family = poisson)

# negative binomial
merseyside_negbin_model <- glm.nb(StopCount ~ IncomeDomainScore_z + 
                                MeanHousePrice_z + 
                                CrimeSum_z + 
                                BAME_z + 
                                DrugCrimeSum_z,
                              data = merseyside)



summary(merseyside_poisson_model)
summary(merseyside_negbin_model)


stargazer(merseyside_poisson_model, merseyside_negbin_model,
          type='text')


# check for multicolineararity
vif(merseyside_poisson_model)
vif(merseyside_negbin_model)


anova(merseyside_poisson_model, merseyside_negbin_model, test = "Chisq")

# An ANOVA comparing Poisson and Negative Binomial models using a Chi-squared 
# test yielded a significant improvement in fit for the latter, with residual 
# deviance dropping from 40,501 to 1036. This confirms the presence of 
# overdispersion in the data and supports the use of a Negative Binomial 
# specification.


# Extract values
aic_poisson <- AIC(merseyside_poisson_model)
aic_negbin <- AIC(merseyside_negbin_model)

loglik_poisson <- as.numeric(logLik(merseyside_poisson_model))
loglik_negbin <- as.numeric(logLik(merseyside_negbin_model))

# Create a data frame
comparison_table <- data.frame(
  Metric = c("AIC", "Log Likelihood"),
  `Poisson Model` = c(round(aic_poisson, 2), round(loglik_poisson, 2)),
  `Negative Binomial Model` = c(round(aic_negbin, 2), round(loglik_negbin, 2))
)

# Print LaTeX table
tab <- kable(
  comparison_table, 
  format = "latex", 
  booktabs = TRUE, 
  caption = "Model Fit Comparison: Poisson vs Negative Binomial (Merseyside)",
  label = "tab:model_comparison_london"
)


# Save to file
writeLines(tab, "Figures/Regression Tables/model_comparison_merseyside.tex")


# ------------------------------------------------------------------------------
# Fixed Effects
# ------------------------------------------------------------------------------




# negative binomial
merseyside_negbin_model <- fenegbin(StopCount ~ IncomeDomainScore_z + 
                                  MeanHousePrice_z + 
                                  CrimeSum_z + 
                                  BAME_z + 
                                  DrugCrimeSum_z,
                                data = merseyside)

# fe negative binomial
merseyside_fe_negbin_model <- fenegbin(StopCount ~ IncomeDomainScore_z + 
                                     MeanHousePrice_z + 
                                     CrimeSum_z + 
                                     BAME_z + 
                                     DrugCrimeSum_z | Borough,
                                   data = merseyside)



summary(merseyside_fe_negbin_model)


# ---------------------------
# comparing the two models
# ---------------------------



logLik(merseyside_negbin_model)
logLik(merseyside_fe_negbin_model)

# Since the fixed effects model has a higher (less negative) log-likelihood, 
# it means the fixed effects model fits the data better than the regular 
# negative binomial model.


AIC(merseyside_negbin_model, merseyside_fe_negbin_model)

etable(merseyside_negbin_model, merseyside_fe_negbin_model)


etable(negbin_model, fe_negbin_model, 
       tex = TRUE, 
       file = "Figures/Regression Tables/merseyside_nb_vs_fenb_table.tex")


































