
rm(list=ls())


# Set working directory 
setwd("C:/Users/15kof/OneDrive/Documents/Trintiy College/Dissertation/code/")



library(tidyverse)



df <- read_csv('../data/uk_stop_and_search.csv')

names(df)

View(df)





# 
# 
# dim(df)
# 
# df <- df %>% drop_na()
# 
# dim(df)


summary(lm(df$Outcome_encoded ~ df$`Self defined indentity`))







