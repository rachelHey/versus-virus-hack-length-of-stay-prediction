# Import data:

# Useful packages
library(jsonlite)
library(tidyverse)
library(here)
library(survival)
library(lubridate)

path_to_csv_data <- "/home/rachel/Desktop/hackathon/synthea/output/csv/"

patients <- read.csv(file = paste0(path_to_csv_data, "patients.csv"))

n_sample <- nrow(patients)

set.seed(123)
# let's assume our n_sample patients were all in 1 hospital, and this hospital 
# has 22 ICU beds:
randomly_allocate_a_bed <- sample(1:22, size = n_sample, 
                                  replace = TRUE)

# let's assume a patient is in an ICU bed an average of 7 days
avg_nb_days <- 7
randomly_allocate_a_length_of_stay <- rpois(n = n_sample,
                                            lambda = avg_nb_days)

patients <- cbind(randomly_allocate_a_bed, 
                  randomly_allocate_a_length_of_stay, 
                  patients)

# I also need a status at discharge of the bed: 
patients$discharge_status <- ifelse(patients$DEATHDATE == "",
                                    "alive", "dead")

patients <- patients %>% 
  mutate(BIRTHDATE = ymd(as.character(BIRTHDATE)),
         age = (ymd("2020-04-01") - BIRTHDATE)/365)


# Split into train and test
train_patients <- patients$
# We can predict at admission, how long the patient stays in the bed:
stupid_regression <- glm(randomly_allocate_a_length_of_stay ~ 1,
                         family = "poisson",data = patients)
stupid_regression_covariates <- glm(randomly_allocate_a_length_of_stay ~ GENDER + age,
                         family = "poisson",data = patients)

predict(stupid_regression_covariates)

km_fit <- survfit(Surv(randomly_allocate_a_length_of_stay,
                       discharge_status == "dead") ~ 1, data=patients)

km_fit <- survfit(Surv(randomly_allocate_a_length_of_stay, rep(1, 112)) ~ 1, data=patients)
summary(km_fit)
plot(km_fit)

km_fit <- survfit(Surv(randomly_allocate_a_length_of_stay,
                       discharge_status == "dead") ~ 1, data=patients)
summary(km_fit)
plot(km_fit)
