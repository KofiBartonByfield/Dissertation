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
london_poisson_model <- glm(StopCount ~ gini+
                                IncomeDomainScore_z + 
                                 MeanHousePrice_z + 
                                 CrimeSum_z + 
                                 EthnicMinority_z + 
                                 DrugCrimeSum_z,
                     data = london, 
                     family = poisson)

# negative binomial
london_negbin_model <- glm.nb(StopCount ~ 
                              gini + 
                              IncomeDomainScore_z + 
                              MeanHousePrice_z + 
                              CrimeSum_z + 
                              EthnicMinority_z + 
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



# Extract values
l_aic_poisson <- AIC(london_poisson_model)
l_aic_negbin <- AIC(london_negbin_model)

l_loglik_poisson <- as.numeric(logLik(london_poisson_model))
l_loglik_negbin <- as.numeric(logLik(london_negbin_model))

# Create a data frame
l_comparison_table <- data.frame(
  Metric = c("AIC", "Log Likelihood"),
  `Poisson Model` = c(round(l_aic_poisson, 0), round(l_loglik_poisson, 0)),
  `Negative Binomial Model` = c(round(l_aic_negbin, 0), round(l_loglik_negbin, 0))
)


stargazer(l_comparison_table,
          type = 'text',
          summary = FALSE,
          rownames = FALSE,
          title = "Model Fit Comparison: London",
          dep.var.caption = "",
          dep.var.labels.include = FALSE)



# ------------------------------------------------------------------------------
# Fixed Effects
# ------------------------------------------------------------------------------


# negative binomial
london_negbin_model <- fenegbin(StopCount ~ gini + IncomeDomainScore_z + 
                           MeanHousePrice_z + 
                           CrimeSum_z + 
                           EthnicMinority_z + 
                           DrugCrimeSum_z,
                         data = london)

# fe negative binomial
london_fe_negbin_model <- fenegbin(StopCount ~ gini + IncomeDomainScore_z + 
                                         MeanHousePrice_z + 
                                         CrimeSum_z + 
                                         EthnicMinority_z + 
                                         DrugCrimeSum_z | Borough,
                            data = london)



summary(london_fe_negbin_model)


# ---------------------------
# comparing the two models
# ---------------------------

# 
# 
# logLik(london_negbin_model)
# logLik(london_fe_negbin_model)
# 
# # Since the fixed effects model has a higher (less negative) log-likelihood, 
# # it means the fixed effects model fits the data better than the regular 
# # negative binomial model.
# 
# 
# AIC(london_negbin_model, london_fe_negbin_model)
# 
# etable(london_negbin_model, london_fe_negbin_model)
# # etable(london_negbin_model, london_fe_negbin_model, 
# #        tex = TRUE, 
#        file = "Figures/Regression Tables/london_nb_vs_fenb_table.tex")





# 
# logLik(london_negbin_model)
# logLik(london_fe_negbin_model)
# 
# AIC(london_negbin_model, london_fe_negbin_model)
# BIC(london_negbin_model, london_fe_negbin_model)
# 
# 
# 
# 
# # Get deviance and degrees of freedom
# deviance(london_poisson_model) / london_poisson_model$df.residual
# 

# # 
# library(stargazer)
# 
# # Extract model metrics
aic_values <- c(AIC(london_negbin_model), AIC(london_fe_negbin_model))
loglik_values <- c(logLik(london_negbin_model), logLik(london_fe_negbin_model))
pseudo_r2_values <- c(london_negbin_model$pseudo_r2, london_fe_negbin_model$pseudo_r2)
theta_values <- c(london_negbin_model$theta, london_fe_negbin_model$theta)

# Create a matrix of values for the table
comparison_matrix <- matrix(c(
  round(aic_values, 2),
  round(as.numeric(loglik_values), 2),
  round(pseudo_r2_values, 3),
  round(theta_values, 2)
), ncol = 2, byrow = TRUE)


# Convert matrix to data frame and set row names
comparison_df <- as.data.frame(comparison_matrix)
rownames(comparison_df) <- c("AIC", "Log Likelihood", "Pseudo R-squared", "Dispersion (Theta)")

# Set column names directly
colnames(comparison_df) <- c("No Fixed Effects", "With Fixed Effects")

# Pass to stargazer
stargazer(comparison_df, 
          summary = FALSE,
          rownames = TRUE,
          type = "text",
          title = "Fixed Effects Model Fit Statistics: London",
          dep.var.caption = "",
          dep.var.labels.include = FALSE)














# Merseyside
# ==============================================================================
# Evaluate Poisson vs Negative Binomial
# ==============================================================================



# poisson model
merseyside_poisson_model <- glm(StopCount ~ 
                                gini + 
                                IncomeDomainScore_z + 
                                MeanHousePrice_z + 
                                CrimeSum_z + 
                                EthnicMinority_z + 
                                DrugCrimeSum_z,
                            data = merseyside, 
                            family = poisson)

# negative binomial
merseyside_negbin_model <- glm.nb(StopCount ~ 
                                  gini + 
                                  IncomeDomainScore_z + 
                                  MeanHousePrice_z + 
                                  CrimeSum_z + 
                                  EthnicMinority_z + 
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
m_aic_poisson <- AIC(merseyside_poisson_model)
m_aic_negbin <- AIC(merseyside_negbin_model)

m_loglik_poisson <- as.numeric(logLik(merseyside_poisson_model))
m_loglik_negbin <- as.numeric(logLik(merseyside_negbin_model))

# Create a data frame
m_comparison_table <- data.frame(
  Metric = c("AIC", "Log Likelihood"),
  `Poisson Model` = c(round(m_aic_poisson, 2), round(m_loglik_poisson, 2)),
  `Negative Binomial Model` = c(round(m_aic_negbin, 2), round(m_loglik_negbin, 2))
)

stargazer(m_comparison_table,
          type = 'text',
          summary = FALSE,
          rownames = FALSE,
          title = "Model Fit Comparison: Merseyside",
          dep.var.caption = "",
          dep.var.labels.include = FALSE)

















# ------------------------------------------------------------------------------
# Fixed Effects
# ------------------------------------------------------------------------------




# negative binomial
merseyside_negbin_model <- fenegbin(StopCount ~ gini + IncomeDomainScore_z + 
                                  MeanHousePrice_z + 
                                  CrimeSum_z + 
                                  EthnicMinority_z + 
                                  DrugCrimeSum_z,
                                data = merseyside)

# fe negative binomial
merseyside_fe_negbin_model <- fenegbin(StopCount ~ gini + IncomeDomainScore_z + 
                                     MeanHousePrice_z + 
                                     CrimeSum_z + 
                                     EthnicMinority_z + 
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

# etable(merseyside_negbin_model, merseyside_fe_negbin_model)


# etable(negbin_model, fe_negbin_model, 
#        tex = TRUE, 
#        file = "Figures/Regression Tables/merseyside_nb_vs_fenb_table.tex")




aic_values <- c(AIC(merseyside_negbin_model), AIC(merseyside_fe_negbin_model))
loglik_values <- c(logLik(merseyside_negbin_model), logLik(merseyside_fe_negbin_model))
pseudo_r2_values <- c(merseyside_negbin_model$pseudo_r2, merseyside_fe_negbin_model$pseudo_r2)
theta_values <- c(merseyside_negbin_model$theta, merseyside_fe_negbin_model$theta)

# Create a matrix of values for the table
comparison_matrix <- matrix(c(
  round(aic_values, 2),
  round(as.numeric(loglik_values), 2),
  round(pseudo_r2_values, 3),
  round(theta_values, 2)
), ncol = 2, byrow = TRUE)


# Convert matrix to data frame and set row names
comparison_df <- as.data.frame(comparison_matrix)
rownames(comparison_df) <- c("AIC", "Log Likelihood", "Pseudo R-squared", "Dispersion (Theta)")

# Set column names directly
colnames(comparison_df) <- c("No Fixed Effects", "With Fixed Effects")

# Pass to stargazer
stargazer(comparison_df, 
          summary = FALSE,
          rownames = TRUE,
          type = "text",
          title = "Fixed Effects Model Fit Statistics: Merseyside",
          dep.var.caption = "",
          dep.var.labels.include = FALSE)





























