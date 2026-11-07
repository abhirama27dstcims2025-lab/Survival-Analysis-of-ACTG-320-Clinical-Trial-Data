# Survival Analysis of ACTG 320 Clinical Trial Data

## Project Overview

This project focuses on applying statistical survival analysis techniques to clinical trial data from the ACTG 320 study.

The objective is to investigate time-to-event outcomes, understand survival patterns, evaluate treatment effects, and identify factors associated with event risk.

The analysis is primarily conducted using **R programming** and statistical survival modelling techniques.

## Objectives

- Perform exploratory data analysis on clinical trial data.
- Estimate survival probabilities using the Kaplan-Meier method.
- Compare survival distributions using the Log-Rank test.
- Develop a Cox Proportional Hazards regression model.
- Interpret hazard ratios and confidence intervals.
- Assess the proportional hazards assumption.
- Evaluate model diagnostics and influential observations.

## Dataset

**Dataset:** ACTG 320 Clinical Trial Dataset

The dataset contains clinical and demographic information about participants in a clinical trial.

Important variables include:

- `time`: Follow-up time
- `censor`: Event/censoring indicator
- `treatment`: Treatment information
- `sex`: Participant sex
- `age`: Participant age
- `cd4`: CD4 cell count
- `karnof`: Karnofsky performance score
- `ivdrug`: Intravenous drug use history
- `priorzdv`: Previous ZDV treatment

## Statistical Methodology

### 1. Exploratory Data Analysis
- Data cleaning and preprocessing
- Missing-value assessment
- Descriptive statistics
- Event and censoring distribution

### 2. Kaplan-Meier Estimation
- Estimation of survival probabilities
- Kaplan-Meier survival curves
- Comparison of survival patterns across treatment groups

### 3. Log-Rank Test
- Comparison of survival distributions between treatment groups
- Hypothesis testing for differences in survival experiences

### 4. Cox Proportional Hazards Model
- Multivariable survival regression
- Hazard ratio estimation
- Confidence interval interpretation
- Statistical significance assessment

### 5. Model Diagnostics
- Proportional hazards assumption testing
- Schoenfeld residual analysis
- Martingale residual analysis
- Deviance residual analysis
- DFBETA residual analysis for influential observations

## Technologies Used

- R Programming
- RStudio
- Survival Analysis
- Statistical Modelling
- Data Visualization

## Project Structure

```text
ACTG320-Survival-Analysis/
│
├── data/
│   └── actg320_clean.csv
│
├── R/
│   ├── 01_data_preprocessing.R
│   ├── 02_exploratory_analysis.R
│   ├── 03_kaplan_meier.R
│   ├── 04_log_rank_test.R
│   ├── 05_cox_model.R
│   └── 06_model_diagnostics.R
│
├── results/
│
├── plots/
│
└── README.md
```

*Folder structure can be adjusted to match the actual uploaded files.*

## Expected Outcomes

- Understand survival patterns among clinical trial participants.
- Evaluate differences in survival between treatment groups.
- Identify important predictors associated with event risk.
- Assess the reliability and assumptions of the Cox regression model.
- Develop practical experience in clinical and pharmaceutical survival analysis.

## Future Scope

- Random Survival Forest
- Machine Learning-based survival prediction
- XGBoost Survival Analysis
- Comparison of statistical and machine learning survival models

## Conclusion

This project demonstrates the application of statistical survival analysis techniques to clinical trial data, combining survival estimation, hypothesis testing, regression modelling, and diagnostic methods to understand time-to-event outcomes.
