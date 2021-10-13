# --- Install & Load Packages --- #

if (!require("pacman")) install.packages("pacman")
pacman::p_load(MatchIt, optmatch, dplyr, gapminder, fixest, forcats, purrr, rlist, RItools, Hmisc, modelsummary, data.table, ggplot2)

search()

# --- Load Data --- #

amsterdam <- read.csv("gen/data-prep/amsterdam.csv")

# Chi Square test to see whether our treated and untreated group is 


chi_before <- xBalance(amsterdam$superhost~ amsterdam$in_center + amsterdam$price + amsterdam$minimum_nights + amsterdam$number_of_reviews + amsterdam$listings + amsterdam$reviews_per_month + amsterdam$private_room + amsterdam$entire_home_apt + amsterdam$shared_room + amsterdam$size_house, data = amsterdam, report = c("chisquare.test"))
chisqtest_before<- capture.output(print("chi_before"))
writeLines(chisqtest_before, con = file("testoutput_before.txt"))                        
                                  
                             
# Propensity score model and prediction 

ps	<- glm(amsterdam$superhost ~ amsterdam$in_center + amsterdam$price + amsterdam$minimum_nights + amsterdam$price*amsterdam$number_of_reviews + amsterdam$number_of_reviews + amsterdam$listings + amsterdam$reviews_per_month + amsterdam$reviews_per_month*amsterdam$price + amsterdam$private_room + amsterdam$entire_home_apt + amsterdam$entire_home_apt*amsterdam$price + amsterdam$shared_room + amsterdam$size_house,	data=amsterdam,	family	= binomial())
summary(ps)
amsterdam$psvalue<- predict(ps,	type = "response")

# Visualization of the unbalanced data

histbackback(split(amsterdam$psvalue,	amsterdam$superhost),	main= "Propensity score before matching", xlab=c("control",	"treatment"))

# Match the sample by optimal matching method 

optimalmatching <- matchit(amsterdam$superhost ~ amsterdam$in_center + amsterdam$price + amsterdam$minimum_nights + amsterdam$price*amsterdam$number_of_reviews + amsterdam$number_of_reviews + amsterdam$listings + amsterdam$reviews_per_month + amsterdam$reviews_per_month*amsterdam$price + amsterdam$private_room + amsterdam$entire_home_apt + amsterdam$entire_home_apt*amsterdam$price + amsterdam$shared_room + amsterdam$size_house, data = amsterdam, method = "optimal", ratio = 1)
amsterdam_matched <- match.data(optimalmatching)

# Chi Square test to see whether our treated and untreated group is balanced in the matched sample "amsterdam_matched"

<<<<<<< HEAD
chisq <- xBalance(amsterdam_matched$superhost ~ amsterdam_matched$in_center + amsterdam_matched$price + amsterdam_matched$minimum_nights + amsterdam_matched$price*amsterdam_matched$number_of_reviews + amsterdam_matched$number_of_reviews + amsterdam_matched$listings + amsterdam_matched$reviews_per_month + amsterdam_matched$reviews_per_month*amsterdam_matched$price + amsterdam_matched$private_room + amsterdam_matched$entire_home_apt + amsterdam_matched$entire_home_apt*amsterdam_matched$price + amsterdam_matched$shared_room + amsterdam_matched$size_house, data = amsterdam_matched, report = c("chisquare.test"))
=======
xBalance(amsterdam_matched$superhost ~ amsterdam_matched$in_center + amsterdam_matched$price + amsterdam_matched$minimum_nights + amsterdam_matched$price*amsterdam_matched$number_of_reviews + amsterdam_matched$number_of_reviews + amsterdam_matched$listings + amsterdam_matched$reviews_per_month + amsterdam_matched$reviews_per_month*amsterdam_matched$price + amsterdam_matched$private_room + amsterdam_matched$entire_home_apt + amsterdam_matched$entire_home_apt*amsterdam_matched$price + amsterdam_matched$shared_room + amsterdam_matched$size_house, data = amsterdam_matched, report = c("chisquare.test"))
>>>>>>> 7d8c3c50cfacee3d7adb496d281efe92a319065a

# New propensity score model and prediction based on the matched sample

ps_matched	<- glm(amsterdam_matched$superhost ~ amsterdam_matched$in_center + amsterdam_matched$price + amsterdam_matched$minimum_nights + amsterdam_matched$price*amsterdam_matched$number_of_reviews + amsterdam_matched$number_of_reviews + amsterdam_matched$listings + amsterdam_matched$reviews_per_month + amsterdam_matched$reviews_per_month*amsterdam_matched$price + amsterdam_matched$private_room + amsterdam_matched$entire_home_apt + amsterdam_matched$entire_home_apt*amsterdam_matched$price + amsterdam_matched$shared_room + amsterdam_matched$size_house,	data=amsterdam_matched,	family	= binomial())
summary(ps_matched)

amsterdam_matched$psvalue<- predict(ps_matched,	type	= "response")

# Visualization of the balanced data

histbackback(split(amsterdam_matched$psvalue,	amsterdam_matched$superhost),	main= "Propensity score after matching", xlab=c("control", "treatment"))

# Simple OLS

Simple_OLS <- lm (price  ~  superhost + in_center + minimum_nights + number_of_reviews + listings + reviews_per_month + private_room + entire_home_apt + shared_room + size_house, data = amsterdam)
summary(Simple_OLS)  

# Sample Matching OLS

Matched_OLS <- lm (price  ~ superhost + in_center + minimum_nights + number_of_reviews + listings + reviews_per_month + private_room + entire_home_apt + shared_room + size_house, data = amsterdam_matched)
summary(Matched_OLS)

save(optimalmatching, Simple_OLS, Matched_OLS, chisq, file = 'gen/data-prep/all-models.RData')


load('gen/data-prep/all-models.RData')

list.save(optimalmatching, 'gen/data-prep/optimalmatching.Rds')
list.save(Simple_OLS, 'gen/data-prep/reg_models.Rds')
list.save(Matched_OLS, 'gen/data-prep/reg_models_matching.Rds')

models <- list(Simple_OLS, Matched_OLS)
msummary(models)
msummary(models, output = 'my_awesome_results.html')


final_output <- capture.output(msummary(Simple_OLS, Matched_OLS))

writeLines(final_output, con = file("allresult.txt"))                        

