# data load ---------------------------------------------------------------

# download data set
actg320_colnames <- c('id','time','censor','time_d','censor_d','treatment','treatment_group',
                      'strat2','sex','raceth','ivdrug','hemophil','karnof','cd4','priorzdv','age')
actg320 <- read.table('https://raw.githubusercontent.com/WinVector/QSurvival/master/vignettes/AIDSdata/actg320.dat', col.names = actg320_colnames)
dim(actg320)
actg320

# we're removing time_d and censor_2 as it has a rarer outcome balance
actg <- actg320[,c('time', 'censor', 'treatment','treatment_group',
                      'strat2','sex','raceth','ivdrug','hemophil','karnof','cd4','priorzdv','age')]
# Number of rows and columns
dim(actg)

# Variable names
names(actg)

# Structure
str(actg)

# ------------------------------------------------------------
# CHECK DATA QUALITY
# ------------------------------------------------------------

# Missing values in each column
colSums(is.na(actg))

# Total number of missing values
sum(is.na(actg))

# Check duplicate patient IDs
sum(duplicated(actg$id))

# Summary of all variables
summary(actg)
# ------------------------------------------------------------
# CHECK SURVIVAL VARIABLES
# ------------------------------------------------------------

# time   = time to AIDS-defining diagnosis/death endpoint
# censor = event indicator

table(actg$censor)

summary(actg$time)

range(actg$time)

# ------------------------------------------------------------
# CHECK CATEGORICAL VARIABLES
# ------------------------------------------------------------

table(actg$treatment)
prop.table(table(actg$treatment))

table(actg$treatment_group)
prop.table(table(actg$treatment_group))

table(actg$strat2)
table(actg$sex)
table(actg$raceth)
table(actg$ivdrug)
table(actg$hemophil)
# ------------------------------------------------------------
#  CHECK NUMERICAL VARIABLES
# ------------------------------------------------------------

summary(actg$karnof)
summary(actg$cd4)
summary(actg$priorzdv)
summary(actg$age)


# ------------------------------------------------------------
#  CONVERT CATEGORICAL VARIABLES TO FACTORS
# ------------------------------------------------------------

actg$sex <- factor(actg$sex)
actg$raceth <- factor(actg$raceth)
actg$ivdrug <- factor(actg$ivdrug)
actg$hemophil <- factor(actg$hemophil)
actg$strat2 <- factor(actg$strat2)

actg$treatment <- factor(actg$treatment)
actg$treatment_group <- factor(actg$treatment_group)

# Check structure again
str(actg)

# ------------------------------------------------------------
#  Save cleaned Dataset
# ------------------------------------------------------------

# Convert categorical variables to factors
actg$sex <- factor(actg$sex)
actg$raceth <- factor(actg$raceth)
actg$ivdrug <- factor(actg$ivdrug)
actg$hemophil <- factor(actg$hemophil)
actg$strat2 <- factor(actg$strat2)
actg$treatment <- factor(actg$treatment)
actg$treatment_group <- factor(actg$treatment_group)

# Check
str(actg)
dir.create("data", showWarnings = FALSE)
saveRDS(
  actg,
  "data/actg320_clean.rds"
)

write.csv(
  actg,
  "data/actg320_clean.csv",
  row.names = FALSE
)
getwd()


file.exists("data/actg320_clean.rds")
file.exists("data/actg320_clean.csv")

