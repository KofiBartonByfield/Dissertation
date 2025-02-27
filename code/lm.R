rm(list = ls())


library(stargazer)


setwd("~/Trintiy College/Dissertation")



data <- read.csv('data/london2022.csv', 
                 header=T, 
                 stringsAsFactors = TRUE)

colnames(data)


# sample <- sample_n(data, 100)


model <- glm(stopsLSOAtotal ~ obj*borough,
             data = data,
             family = poisson)



stargazer(model,
          type = 'text')



# Extract the coefficients
coefficients <- model$coefficients

# Create a data frame for plotting
coef_df <- data.frame(
  borough = names(coefficients),
  coefficient = coefficients
)

# Remove the intercept from the borough names
coef_df$borough <- gsub("borough", "", coef_df$borough)


# Plot the coefficients using a bar plot
barplot(coef_df$coefficient,
        names.arg = coef_df$borough,
        main = "Coefficients of Borough Effects",
        xlab = "Borough",
        ylab = "Coefficient Value",
        las = 2, # Rotate x-axis labels
        horiz = TRUE, # Horizontal bar plot
        
        cex.names = 0.8) # Adjust x-axis label size

# Add a horizontal line at y=0
abline(v=0, col="red", lty=2)

