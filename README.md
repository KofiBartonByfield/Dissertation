# Dissertation: 
# The Price of Policing: Uncovering Local Economic Divides in Stop and Search A Study of London and Merseyside

This repository contains the full research workflow, data and LaTeX manuscript for my MSc dissertation in Applied Social Data Science. The project investigates the relationship between socioeconomic inequality, ethnic composition and stop and search activity across Greater London and Merseyside.

## Overview

The dissertation explores how structural inequalities measured through income deprivation and housing inequality, interact with ethnic demographics to influence stop and search patterns. Using spatially disaggregated data at the Lower Layer Super Output Area (LSOA) level, the analysis employs count-based regression models to assess these relationships.

## Repository Structure

- `Code/`: R and Python scripts for data processing, analysis, and visualisation.
- `Data/`: Cleaned and processed datasets used in the analysis.
- `Documents/`: Backups and drafts of the dissertation manuscript.
- `Figures/`: All generated figures and visualisations used in the dissertation.
- `Dissertation.pdf`
- `README.md`: This file.

## Key Components

 **Research Aims & Questions**
Research Aim
The primary aim is to explore how the spatial distribution of stop and search practices in Merseyside and Greater London correlates with local economic inequality at the LSOA level.

**Research Questions**
The guiding research question is: How do stop and search patterns in Merseyside and Greater London relate to local economic disparities across LSOAs, given their different social compositions?


### Hypotheses
This study tests three core hypotheses:

- Hypothesis 1: Higher levels of economic inequality within an LSOA are associated with increased rates of stop and search.

- Hypothesis 2: The relationship between social make-up, inequality, and stop and search will differ significantly between Greater London and Merseyside.

- Hypothesis 3: Areas characterized by both higher economic inequality and greater ethnic diversity will experience disproportionately higher levels of stop and search activity due to the interaction of these factors.

## Methodology
This dissertation uses a quantitative research design with publicly available data from local police authorities in Merseyside and Greater London.

### Data Sources
UK Police Data: Provides records of stop and search incidents, including geographic coordinates, from the Metropolitan Police Service and Merseyside Police.

Office for National Statistics (ONS): Supplies socio-economic and demographic data, including LSOA boundaries, 2021 Census ethnicity data, and mean house prices for 2022.

GOV.UK: Provides data from the Indices of Deprivation 2019, including income and employment domain scores, Crime Domain Decile, and house sales data to calculate the Gini coefficient for housing inequality.

#### Analytical Approach
Spatial Mapping: To identify policing hotspots.

Negative Binomial Regression Models: Used to assess the relationship between economic inequality and the frequency of stop and search.

## Key Findings
Economic Inequality: The Gini coefficient for housing inequality is a consistent predictor of stop and search incidents in both London and Merseyside.

Regional Differences: Merseyside policing shows a pronounced focus on crime, particularly drug-related offenses. In contrast, London's Metropolitan Police demonstrate clearer evidence of discrimination against ethnic minorities in their stop and search practices.

Crime & Stop and Search: Higher-crime areas in both regions are associated with more stop and search activity, with Merseyside showing a sharper policing gradient between high and low-crime areas.

## Author

**Kofi Barton-Byfield**

- MSc Applied Social Data Science  
- BSc Mathematics  
- [LinkedIn](https://uk.linkedin.com/in/kofi-barton-byfield-b7b83a293)
