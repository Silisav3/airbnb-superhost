# --- Install & Load Packages --- #

if (!require("pacman")) install.packages("pacman")
pacman::p_load(MatchIt, optmatch, dplyr, gapminder, fixest, forcats, purrr, rlist, RItools, Hmisc, modelsummary, data.table, ggplot2)

search()

# --- Load Data --- #

amsterdam <- read.csv("gen/temp/df_cleaned.csv")


# Match the sample by optimal matching methodaaa

optimalmatching <-
    matchit(
        amsterdam$superhost ~ amsterdam$in_center + amsterdam$price + amsterdam$minimum_nights + amsterdam$price *
            amsterdam$number_of_reviews + amsterdam$number_of_reviews + amsterdam$listings + amsterdam$reviews_per_month + amsterdam$reviews_per_month *
            amsterdam$price + amsterdam$private_room + amsterdam$entire_home_apt + amsterdam$entire_home_apt *
            amsterdam$price + amsterdam$shared_room + amsterdam$size_house,
        data = amsterdam,
        method = "optimal",
        ratio = 1
    )
amsterdam_matched <- match.data(optimalmatching)

# Chi Square test to see whether our treated and untreated group is balanced in the matched sample "amsterdam_matched"

chisq_after <-
    xBalance(
        amsterdam_matched$superhost ~ amsterdam_matched$in_center + amsterdam_matched$price + amsterdam_matched$minimum_nights + amsterdam_matched$price *
            amsterdam_matched$number_of_reviews + amsterdam_matched$number_of_reviews + amsterdam_matched$listings + amsterdam_matched$reviews_per_month + amsterdam_matched$reviews_per_month *
            amsterdam_matched$price + amsterdam_matched$private_room + amsterdam_matched$entire_home_apt + amsterdam_matched$entire_home_apt *
            amsterdam_matched$price + amsterdam_matched$shared_room + amsterdam_matched$size_house,
        data = amsterdam_matched,
        report = c("chisquare.test")
    )

xBalance(
    amsterdam_matched$superhost ~ amsterdam_matched$in_center + amsterdam_matched$price + amsterdam_matched$minimum_nights + amsterdam_matched$price *
        amsterdam_matched$number_of_reviews + amsterdam_matched$number_of_reviews + amsterdam_matched$listings + amsterdam_matched$reviews_per_month + amsterdam_matched$reviews_per_month *
        amsterdam_matched$price + amsterdam_matched$private_room + amsterdam_matched$entire_home_apt + amsterdam_matched$entire_home_apt *
        amsterdam_matched$price + amsterdam_matched$shared_room + amsterdam_matched$size_house,
    data = amsterdam_matched,
    report = c("chisquare.test")
)

# New propensity score model and prediction based on the matched sample

ps_matched	<-
    glm(
        amsterdam_matched$superhost ~ amsterdam_matched$in_center + amsterdam_matched$price + amsterdam_matched$minimum_nights + amsterdam_matched$price *
            amsterdam_matched$number_of_reviews + amsterdam_matched$number_of_reviews + amsterdam_matched$listings + amsterdam_matched$reviews_per_month + amsterdam_matched$reviews_per_month *
            amsterdam_matched$price + amsterdam_matched$private_room + amsterdam_matched$entire_home_apt + amsterdam_matched$entire_home_apt *
            amsterdam_matched$price + amsterdam_matched$shared_room + amsterdam_matched$size_house,
        data = amsterdam_matched,
        family	= binomial()
    )
summary(ps_matched)

amsterdam_matched$psvalue <- predict(ps_matched,	type = "response")



# Visualization of the balanced data_Graph 2
pdf("gen/output/visualizing_balanced_data.pdf")
histbackback(
    split(amsterdam_matched$psvalue,	amsterdam_matched$superhost),
    main = "Propensity score after matching",
    xlab = c("control", "treatment")
)
dev.off()

write.csv(amsterdam_matched,"gen/temp/amsterdam_matched.csv",row.names = FALSE)
