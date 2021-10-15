# --- Install & Load Packages --- #

if (!require("pacman")) install.packages("pacman")
pacman::p_load(MatchIt, optmatch, dplyr, gapminder, fixest, forcats, purrr, rlist, RItools, Hmisc, modelsummary, data.table, ggplot2)

search()

# --- Load Data --- #

amsterdam <- read.csv("gen/temp/df_cleaned.csv")

# Chi Square test to see whether our treated and untreated group is 


chi_before <- xBalance(amsterdam$superhost~ amsterdam$in_center + amsterdam$price + amsterdam$minimum_nights + amsterdam$number_of_reviews + amsterdam$listings + amsterdam$reviews_per_month + amsterdam$private_room + amsterdam$entire_home_apt + amsterdam$shared_room + amsterdam$size_house, data = amsterdam, report = c("chisquare.test"))


# Propensity score model and prediction 

ps	<- glm(amsterdam$superhost ~ amsterdam$in_center + amsterdam$price + amsterdam$minimum_nights + amsterdam$price*amsterdam$number_of_reviews + amsterdam$number_of_reviews + amsterdam$listings + amsterdam$reviews_per_month + amsterdam$reviews_per_month*amsterdam$price + amsterdam$private_room + amsterdam$entire_home_apt + amsterdam$entire_home_apt*amsterdam$price + amsterdam$shared_room + amsterdam$size_house,	data=amsterdam,	family	= binomial())
summary(ps)
amsterdam$psvalue<- predict(ps,	type = "response")

# Visualization of the unbalanced data - GRAPH 1

pdf("gen/output/visualizing_unbalanced_data.pdf")
histbackback(split(amsterdam$psvalue,	amsterdam$superhost),	main= "Propensity score before matching", xlab=c("control",	"treatment"))
dev.off()
