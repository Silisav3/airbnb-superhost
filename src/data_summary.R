# --- Install & load packages --- #

if (!require("pacman")) install.packages("pacman")
pacman::p_load(MatchIt, optmatch, dplyr, gapminder, fixest, forcats, purrr, rlist, RItools, Hmisc, modelsummary, data.table, ggplot2)
search()

# --- Load data and summary --- #

df <- fread("../gen/data-prep/amsterdam.csv")
summary(df)

# --- Some statistics comparing super vs. non-super host --- #

#number of super host/ non-super host
table(df$superhost)

#room type by superhost
df[, .(
    priv_room = sum(private_room),
    apt = sum(entire_home_apt),
    shared = sum(shared_room),
    hotel = sum(hotel_room)
),by = superhost]


# --- Graphs comparing price set by super vs. non-super hosts --- #

#average price set by superhost vs. non-superhost
superhost_price <-
    df[, .(avg_price = mean(price)), by = superhost]
colnames(superhost_price) <-
    c("superhost", "avg_price")

g <- ggplot(df, aes(superhost, price))
g + geom_boxplot(outlier.colour="black", outlier.shape=16,
             outlier.size=2, notch=FALSE)

#average price by room_type (superhost vs. non-superhost)
price_by_roomtype <-
    df[, .(avg_price = mean(price)), by = .(superhost, room_type)]
colnames(price_by_roomtype) <-
    c("superhost", "room_type", "avg_price")
g <-
    ggplot(price_by_roomtype, aes(room_type, avg_price, fill = superhost))
g + geom_bar(stat = "identity",
             width = .5,
             position = 'dodge')

#average price by location (superhost vs. non-superhost)
price_by_location <-
    df[, .(avg_price = mean(price)), by = .(superhost, in_center)]

colnames(price_by_location) <-
    c("superhost", "room_in_center", "avg_price")

g <-
    ggplot(price_by_location, aes(room_in_center, avg_price, fill = superhost))
g + geom_bar(stat = "identity",
             width = .5,
             position = 'dodge')
