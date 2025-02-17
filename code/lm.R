rm(list = ls())


library(dplyr)


setwd("~/Trintiy College/Dissertation")



data <- read.csv('data/london2022.csv')


colnames(data) <- c('index', 'date', 'LSOA', 'latitude', 'longitude', 'type',
                    'gender', 'age', 'ethnicity', 'officer_ethnicity', 'legistlation',
                    'object', 'outcome', 'LSOA_pop', 'house_price', 'drugs', 'violent_crime',
                    'prosecution', 'crime', 'train')

# data$gender <- ifelse(data$gender == "Male", 1, 0)
data$prosecuted <- ifelse(data$outcome == "Arrest", 1, 0)
data$notwhite <- ifelse(data$ethnicity != 'White - English/Welsh/Scottish/Northern Irish/British', 1,0)

data$age <- as.factor(data$age)
# data$LSOA <- as.factor(data$LSOA)

# Subset the data for the relevant columns
lm_data <- data[, c('latitude', 'longitude', 'type',
                    'gender', 'age', 'notwhite', 'officer_ethnicity', 'legistlation',
                    'object', 'LSOA_pop', 'house_price', 'drugs', 'violent_crime',
                    'crime', 'train', 'prosecuted')]




sample <- sample_n(lm_data, 100)


model <- glm(prosecuted ~ .,
             data = sample,
             family = 'binomial')


options(scipen = 999)

summary(model)

