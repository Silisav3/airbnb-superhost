# --- Install & Load Packages --- #

if (!require("pacman")) install.packages("pacman")
pacman::p_load(googledrive,readr,MatchIt, optmatch, dplyr, gapminder, fixest, forcats, purrr, rlist, RItools, Hmisc, modelsummary, data.table, ggplot2)

search()

# --- Load Data --- #

amsterdam_matched<-read.csv("gen/temp/amsterdam_matched.csv")
amsterdam <- read.csv("gen/temp/df_cleaned.csv")
# Simple OLS

Simple_OLS <-
    lm (
        price  ~  superhost + in_center + minimum_nights + number_of_reviews + listings + reviews_per_month + private_room + entire_home_apt + shared_room + size_house,
        data = amsterdam
    )
summary(Simple_OLS)

# Sample Matching OLS

Matched_OLS <-
    lm (
        price  ~ superhost + in_center + minimum_nights + number_of_reviews + listings + reviews_per_month + private_room + entire_home_apt + shared_room + size_house,
        data = amsterdam_matched
    )
summary(Matched_OLS)


#Comparing two models
models <- list(Simple_OLS, Matched_OLS)
msummary(models, output = 'gen/output/airbnb_results.html')

