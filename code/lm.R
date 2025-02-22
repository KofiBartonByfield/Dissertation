rm(list = ls())


library(stargazer)


setwd("~/Trintiy College/Dissertation")



data <- read.csv('data/london2022.csv', 
                 header=T, 
                 stringsAsFactors = TRUE)




sample <- sample_n(data, 100)


model <- lm(hprice ~ IMDRank,
             data = sample)



stargazer(model,
          type = 'text')
