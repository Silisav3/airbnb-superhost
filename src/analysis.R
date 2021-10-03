# --- Load Libraries --- #

library(MatchIt)
library(optmatch)
library(dplyr)
library(gapminder)
library(fixest)
library(forcats)
library(purrr)
library(rlist)
library(RItools)


# --- Load Data --- #

amsterdam <- read.csv("gen/data-prep/amsterdam.csv")

# Chi Square test to see whether our treated and untreated group is balanced

xBalance(amsterdam$superhost~ amsterdam$in_center + amsterdam$price + amsterdam$minimum_nights + amsterdam$number_of_reviews + amsterdam$listings + amsterdam$reviews_per_month + amsterdam$private_room + amsterdam$entire_home_apt + amsterdam$shared_room + amsterdam$size_house, data = amsterdam, report = c("chisquare.test"))

optimalmatching <- matchit(amsterdam$superhost ~ amsterdam$in_center + amsterdam$price + amsterdam$minimum_nights + amsterdam$price*amsterdam$number_of_reviews + amsterdam$number_of_reviews + amsterdam$listings + amsterdam$reviews_per_month + amsterdam$reviews_per_month*amsterdam$price + amsterdam$private_room + amsterdam$entire_home_apt + amsterdam$entire_home_apt*amsterdam$price + amsterdam$shared_room + amsterdam$size_house, data = amsterdam, method = "optimal", ratio = 1)
amsterdam_matched <- match.data(optimalmatching)

# Chi Square test to see whether our treated and untreated group is balanced in the matched sample

xBalance(amsterdam_matched$superhost~ amsterdam_matched$in_center + amsterdam_matched$price + amsterdam_matched$minimum_nights + amsterdam_matched$number_of_reviews + amsterdam_matched$listings + amsterdam_matched$reviews_per_month + amsterdam_matched$private_room + amsterdam_matched$entire_home_apt + amsterdam_matched$shared_room + amsterdam_matched$size_house, data = amsterdam_matched, report = c("chisquare.test"))
