# --- Install & Load Packages --- #

if (!require("pacman")) install.packages("pacman")
pacman::p_load(MatchIt, optmatch, dplyr, gapminder, fixest, forcats, purrr, rlist, RItools, Hmisc, modelsummary, data.table, ggplot2)

search()


#Loading data and summary

df <- fread("gen/temp/df_cleaned.csv")
summary(df)

#number of super host/ non-super host
table(df$superhost)


#room type by superhost
df[, .(
    priv_room = sum(private_room),
    apt = sum(entire_home_apt),
    shared = sum(shared_room),
    hotel = sum(hotel_room)
),by = superhost]

#average price set by superhost vs. non-superhost
superhost_price <-
    df[, .(avg_price = mean(price)), by = superhost]
colnames(superhost_price) <-
    c("superhost", "avg_price")

superhost_price
pdf("gen/output/plot1_avg_price_superhost_vs_non.pdf")
g <- ggplot(df, aes(as.factor(superhost), price))
g + geom_boxplot(outlier.colour="black", outlier.shape=16,
             outlier.size=2, notch=FALSE)
dev.off()
#average price by room_type (superhost vs. non-superhost)
price_by_roomtype <-
    df[, .(avg_price = mean(price)), by = .(as.factor(superhost), room_type)]
colnames(price_by_roomtype) <-
    c("superhost", "room_type", "avg_price")
pdf("gen/output/plot2_avg_price_room_type.pdf")
g <-ggplot(price_by_roomtype, aes(room_type, avg_price, fill = as.factor(superhost)))
g + geom_bar(stat = "identity",
             width = .5,
             position = 'dodge')

dev.off()
#average price by location (superhost vs. non-superhost)
price_by_location <-
    df[, .(avg_price = mean(price)), by = .(as.factor(superhost), in_center)]

colnames(price_by_location) <-
    c("superhost", "room_in_center", "avg_price")
pdf("gen/output/plot3_avg_price_location.pdf")
g <-
    ggplot(price_by_location, aes(room_in_center, avg_price, fill = as.factor(superhost)))
g + geom_bar(stat = "identity",
             width = .5,
             position = 'dodge')
dev.off()



