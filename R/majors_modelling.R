rm(list=ls())
library(tidyverse)

trainTestSplit <- function(df,trainPercent,seed1){
  samp_size <- floor(trainPercent/100 * nrow(df))
  set.seed(seed1)
  idx <- sample(seq_len(nrow(df)), size = samp_size)
  idx
}

Rsquared <- function(lmfit,newdf,y){
  yhat <- predict(lmfit,newdata=newdf)
  RSS <- sum((y - yhat)^2)
  TSS <- sum((y - mean(y))^2)
  rsquared <-1 - (RSS/TSS)
  rsquared
}

data <- read.csv('data/tidy_dataset_wta_2017.csv') 

data %>% filter(is.na(df))

dim(data)
str(data)


unique(data$tourney_name)

majors_data <- data %>% filter(tourney_name %in% c(
  "Australian Open",
  "Roland Garros",
  "Wimbledon",
  "Us Open"
))

dim(majors_data)

# Remove matches with NA minutes
majors_data <- majors_data %>% filter(!is.na(minutes))

filtered_majors_data <- majors_data %>% select(age,rank,ace,df,svpt,S1stIn,S1stIn,S1stWon,S2ndWon,SvGms,bpSaved,bpFaced,Win)

# Count columns with NA
sapply(filtered_majors_data, function(y) sum(is.na(y)))

train_idx <- trainTestSplit(filtered_majors_data, trainPercent = 75, seed=5)
train <- filtered_majors_data[train_idx,]
test <- filtered_majors_data[-train_idx,]


fit <- glm(Win ~ .,family=binomial(link = 'logit'), data = train)
summary(fit)

rsquared = Rsquared(fit, test, test$Win)
sprintf("R-Squared for model 1 is %f", rsquared)

# Reduce to only the significant variables
filtered_majors_data <- filtered_majors_data %>% select(rank,svpt,S1stWon,S2ndWon,bpSaved,bpFaced, Win)
train <- filtered_majors_data[train_idx,]
test <- filtered_majors_data[-train_idx,]

fit <- glm(Win ~ .,family=binomial(link = 'logit'), data = train)
summary(fit)

# Reduce to only the significant variables
filtered_majors_data <- filtered_majors_data %>% select(S1stWon,S2ndWon,bpSaved,bpFaced, Win)
train <- filtered_majors_data[train_idx,]
test <- filtered_majors_data[-train_idx,]

fit <- glm(Win ~ .,family=binomial(link = 'logit'), data = train)
summary(fit)

rsquared = Rsquared(fit, test, test$Win)
sprintf("R-Squared for model 3 is %f", rsquared)

# Reduce to only the significant variables
filtered_majors_data <- filtered_majors_data %>% select(S1stWon,bpSaved,bpFaced, Win)
train <- filtered_majors_data[train_idx,]
test <- filtered_majors_data[-train_idx,]

fit <- glm(Win ~ .,family=binomial(link = 'logit'), data = train)
summary(fit)

rsquared = Rsquared(fit, test, test$Win)
sprintf("R-Squared for model 4 is %f", rsquared)


# Reduce to only the significant variables
filtered_majors_data <- filtered_majors_data %>% select(S1stWon, Win)
train <- filtered_majors_data[train_idx,]
test <- filtered_majors_data[-train_idx,]

fit <- glm(Win ~ .,family=binomial(link = 'logit'), data = train)
summary(fit)

rsquared = Rsquared(fit, test, test$Win)
sprintf("R-Squared for model 5 is %f", rsquared)