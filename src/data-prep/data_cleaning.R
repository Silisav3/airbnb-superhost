rm(list = ls())
# --- Install & Load Packages --- #

if (!require("pacman")) install.packages("pacman")
pacman::p_load(MatchIt, optmatch, dplyr, gapminder, fixest, forcats, purrr, rlist, RItools, Hmisc, modelsummary, data.table, ggplot2)

search()

# --- Select columns --- #
df_unclean <- read.csv("data/Amsterdam.csv")

df <- df_unclean %>% select(
    host_id,
    host_is_superhost,
    neighbourhood_cleansed,
    property_type ,
    room_type ,
    accommodates,
    bedrooms,
    beds,
    amenities,
    price,
    minimum_nights,
    number_of_reviews,
    calculated_host_listings_count,
    reviews_per_month
)


#--- Convert data ---#

df$host_id <- as.numeric(df$host_id)

df$host_is_superhost <- as.factor(df$host_is_superhost)
df$host_is_superhost <- df$host_is_superhost == "t"

df$neighbourhood_cleansed <-
    replace(df$neighbourhood_cleansed,
            df$neighbourhood_cleansed == "Centrum-West",
            "Centrum")
df$neighbourhood_cleansed <-
    replace(df$neighbourhood_cleansed,
            df$neighbourhood_cleansed == "Centrum-Oost",
            "Centrum")
df$neighbourhood_cleansed <-
    ifelse(df$neighbourhood_cleansed == "Centrum", 1, 0)

df$accommodates <- as.numeric(df$accommodates)
df$beds <- as.numeric(df$beds)
df$bedrooms <- as.numeric(df$bedrooms)

df$property_type <- ifelse(df$property_type == "Entire rental unit", 1, 0)
df$private_room <- ifelse(df$room_type == "Private room", 1, 0)
df$entire_home_apt <- ifelse(df$room_type == "Entire home/apt", 1, 0)
df$shared_room <- ifelse(df$room_type == "Shared room", 1, 0)
df$hotel_room <- ifelse(df$room_type == "Hotel room", 1, 0)

df$size_house <-
    rowMeans(df[, colnames(df) %in% c('accommodates', 'bedrooms', 'beds')])
# use more comments!
df = subset(df, select = -c(accommodates, beds, bedrooms))

df$price <- as.numeric(as.factor(df$price))
df <-na.omit(df)

setnames(df, old = c("host_is_superhost","neighbourhood_cleansed", "calculated_host_listings_count"), 
            new = c("superhost", "in_center", "listings"))

df$superhost[df$superhost =="TRUE"] <- 1

#--- Save final dataset ---#

write.csv(df, "gen/temp/df_cleaned.csv",row.names = FALSE)


