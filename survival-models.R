actg <- readRDS("data/actg320_clean.rds") 
str(actg)

#------------------------------------------------------------
#INSTALL / LOAD REQUIRED PACKAGES
# ------------------------------------------------------------
install.packages("survival")
install.packages("survminer")

library(survival)
library(survminer)

#------------------------------------------------------------
# CREATE SURVIVAL OBJECT
# ------------------------------------------------------------
# time   = follow-up time
# censor = event indicator

surv_object <- Surv(
  time = actg$time,
  event = actg$censor
)

surv_object


# ------------------------------------------------------------
# KAPLAN-MEIER ESTIMATION
# ------------------------------------------------------------

# Overall Kaplan-Meier estimate
km_fit <- survfit(
  Surv(time, censor) ~ 1,
  data = actg
)

summary(km_fit)

# Plot overall Kaplan-Meier curve
plot(
  km_fit,
  xlab = "Time (days)",
  ylab = "Survival Probability",
  main = "Kaplan-Meier Survival Curve",
  conf.int = TRUE
)


# ------------------------------------------------------------
# KAPLAN-MEIER BY TREATMENT
# ------------------------------------------------------------

km_treatment <- survfit(
  Surv(time, censor) ~ treatment,
  data = actg
)

summary(km_treatment)

# Plot treatment-specific curves
plot(
  km_treatment,
  col = c("blue", "red"),
  lwd = 2,
  xlab = "Time (days)",
  ylab = "Survival Probability",
  main = "Kaplan-Meier Curves by Treatment"
)

legend(
  "bottomleft",
  legend = levels(actg$treatment),
  col = c("blue", "red"),
  lwd = 2
)

# Optional nicer plot using survminer
ggsurvplot(
  km_treatment,
  data = actg,
  conf.int = TRUE,
  risk.table = TRUE,
  pval = FALSE,
  xlab = "Time (days)",
  ylab = "Survival Probability",
  title = "Kaplan-Meier Survival Curves by Treatment"
)


# ------------------------------------------------------------
# LOG-RANK TEST
# ------------------------------------------------------------

# Null hypothesis:
# H0: Survival distributions are the same between treatment groups

logrank_test <- survdiff(
  Surv(time, censor) ~ treatment,
  data = actg
)

logrank_test

# Calculate p-value
p_value_logrank <- 1 - pchisq(
  logrank_test$chisq,
  df = length(logrank_test$n) - 1
)

p_value_logrank


# ------------------------------------------------------------
# COX PH MODEL - TREATMENT ONLY
# ------------------------------------------------------------

cox_treatment <- coxph(
  Surv(time, censor) ~ treatment,
  data = actg
)

summary(cox_treatment)

# Hazard ratio
exp(coef(cox_treatment))

# 95% CI for hazard ratio
exp(confint(cox_treatment))


# ------------------------------------------------------------
# FULL COX PH MODEL
# ------------------------------------------------------------

# NOTE:
# treatment_group is NOT included together with treatment here
# because treatment_group represents the specific treatment arm
# and is closely related to treatment.

cox_full <- coxph(
  Surv(time, censor) ~
    treatment +
    strat2 +
    sex +
    raceth +
    ivdrug +
    hemophil +
    karnof +
    cd4 +
    priorzdv +
    age,
  data = actg
)

summary(cox_full)


# ------------------------------------------------------------
# HAZARD RATIOS
# ------------------------------------------------------------

hazard_ratios <- exp(coef(cox_full))

hazard_ratios


# ------------------------------------------------------------
# 95% CONFIDENCE INTERVALS FOR HAZARD RATIOS
# ------------------------------------------------------------

hr_ci <- exp(
  cbind(
    HR = coef(cox_full),
    confint(cox_full)
  )
)

hr_ci


# ------------------------------------------------------------
# COX MODEL COEFFICIENTS + HR + CI + P-VALUE
# ------------------------------------------------------------

cox_summary <- summary(cox_full)

cox_results <- data.frame(
  Variable = rownames(cox_summary$coefficients),
  Coefficient = cox_summary$coefficients[, "coef"],
  HR = cox_summary$coefficients[, "exp(coef)"],
  SE = cox_summary$coefficients[, "se(coef)"],
  Z = cox_summary$coefficients[, "z"],
  P_value = cox_summary$coefficients[, "Pr(>|z|)"],
  HR_Lower_95 = exp(confint(cox_full))[, 1],
  HR_Upper_95 = exp(confint(cox_full))[, 2],
  row.names = NULL
)

cox_results


# ------------------------------------------------------------
# PROPORTIONAL HAZARDS ASSUMPTION
# ------------------------------------------------------------

# Schoenfeld residual test
ph_test <- cox.zph(cox_full)

ph_test

# Plot Schoenfeld residuals
plot(ph_test)


# ------------------------------------------------------------
# COX-SNEL / MARTINGALE-RELATED DIAGNOSTICS
# ------------------------------------------------------------

# Martingale residuals
martingale_resid <- residuals(
  cox_full,
  type = "martingale"
)

summary(martingale_resid)

# Deviance residuals
deviance_resid <- residuals(
  cox_full,
  type = "deviance"
)

summary(deviance_resid)


# ------------------------------------------------------------
# INFLUENTIAL OBSERVATIONS
# ------------------------------------------------------------

# dfbeta residuals
dfbeta_resid <- residuals(
  cox_full,
  type = "dfbeta"
)

head(dfbeta_resid)


# ------------------------------------------------------------
# COX MODEL DIAGNOSTIC PLOTS USING SURVMINER
# ------------------------------------------------------------

# Martingale residual diagnostic
ggcoxdiagnostics(
  cox_full,
  type = "martingale",
  linear.predictions = FALSE
)

# Deviance residual diagnostic
ggcoxdiagnostics(
  cox_full,
  type = "deviance",
  linear.predictions = FALSE
)

# DFBETA diagnostic
ggcoxdiagnostics(
  cox_full,
  type = "dfbeta",
  linear.predictions = FALSE
)


# ------------------------------------------------------------
# MODEL SUMMARY
# ------------------------------------------------------------

summary(cox_full)

# Concordance index from Cox model
cox_summary$concordance


