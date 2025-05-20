# Dissertation: Spatial and Socioeconomic Analysis of Stop and Search in England

This repository contains the full research workflow, data, and LaTeX manuscript for my MSc dissertation in Applied Social Data Science. The project investigates the relationship between socioeconomic inequality, ethnic composition, and stop and search activity across England, with a focus on Greater London and Merseyside.

## Overview

The dissertation explores how structural inequalities measured through income deprivation and housing inequality, interact with ethnic demographics to influence stop and search patterns. Using spatially disaggregated data at the Lower Layer Super Output Area (LSOA) level, the analysis employs count-based regression models to assess these relationships.

## Repository Structure

- `Code/`: R and Python scripts for data processing, analysis, and visualisation.
- `Data/`: Cleaned and processed datasets used in the analysis.
- `Documents/`: Backups and drafts of the dissertation manuscript.
- `Figures/`: All generated figures and visualisations used in the dissertation.
- `README.md`: This file.

## Key Components

### Data

The analysis draws on publicly available data:

- Stop and Search Data: Downloaded from [data.police.uk](https://data.police.uk/).
- Socioeconomic Indicators: From the UK Government’s Indices of Multiple Deprivation and housing statistics.
- Demographic Data: From the Office for National Statistics (ONS) at the LSOA level.

### Methodology

The study uses Negative Binomial regression models to account for overdispersion in the count data. Interaction terms between ethnic minority population percentages and inequality measures (income deprivation and housing Gini coefficient) test for compounded effects. Model selection is guided by Akaike Information Criterion (AIC) and fit diagnostics.

### Figures and Tables

Figures and tables are created using R and Python and stored in the `Figures/` and `Regression Tables/` directories, respectively.

## Author

**Kofi Barton-Byfield**

- MSc Applied Social Data Science  
- BSc Mathematics  
- [LinkedIn](https://uk.linkedin.com/in/kofi-barton-byfield-b7b83a293)
