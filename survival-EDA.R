actg <- readRDS("data/actg320_clean.rds")

# ------------------------------------------------------------
#  BASIC EXPLORATORY DATA ANALYSIS
# ------------------------------------------------------------

# Age
hist(
  actg$age,
  main = "Distribution of Age",
  xlab = "Age",
  col = "lightblue"
)

# CD4
hist(
  actg$cd4,
  main = "Distribution of Baseline CD4 Count",
  xlab = "CD4 Count",
  col = "lightblue"
)

# Karnofsky score
hist(
  actg$karnof,
  main = "Distribution of Karnofsky Score",
  xlab = "Karnofsky Score",
  col = "lightblue"
)

# Prior ZDV exposure
hist(
  actg$priorzdv,
  main = "Distribution of Prior ZDV Exposure",
  xlab = "Months of Prior ZDV Use",
  col = "lightblue"
)


# ------------------------------------------------------------
#  EVENT DISTRIBUTION BY TREATMENT
# ------------------------------------------------------------

# Counts
table(actg$treatment, actg$censor)

# Row-wise proportions
prop.table(
  table(actg$treatment, actg$censor),
  margin = 1
)

# boxplot

numeric_vars <- c("age", "cd4", "karnof", "priorzdv", "time")

summary(actg[numeric_vars])
par(mfrow = c(2, 3))

for (var in numeric_vars) {
  boxplot(
    actg[[var]],
    main = var,
    ylab = var
  )
}

par(mfrow = c(1, 1))
#

for (var in numeric_vars) {
  
  Q1 <- quantile(actg[[var]], 0.25)
  Q3 <- quantile(actg[[var]], 0.75)
  IQR_value <- IQR(actg[[var]])
  
  lower <- Q1 - 1.5 * IQR_value
  upper <- Q3 + 1.5 * IQR_value
  
  outliers <- actg[[var]][
    actg[[var]] < lower | actg[[var]] > upper
  ]
  
  cat("\nVariable:", var, "\n")
  cat("Lower bound:", lower, "\n")
  cat("Upper bound:", upper, "\n")
  cat("Number of outliers:", length(outliers), "\n")
  cat("Outlier values:\n")
  print(outliers)
}
#IQR-based exploratory screening identified
#extreme observations in age, CD4 count, 
#Karnofsky score, and prior ZDV exposure. 
#These observations were not removed solely on
#the basis of the IQR criterion because extreme 
#values may represent valid clinical characteristics. 
#Potentially influential observations were subsequently
#assessed using Cox-model residual diagnostics
#Note-we should identify the observations corresponding to the large deviance residual (~3.47) and the largest DFBETAs, inspect their age, cd4, karnof, priorzdv, treatment and survival outcome, and then decide whether a sensitivity analysis is needed.
