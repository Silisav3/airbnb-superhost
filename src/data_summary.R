library(data.table)
library(ggplot2)

ams <- setDT(readRDS("gen/data-prep/amsterdam.rds"))
str(ams)

head(ams)
nrow(ams)
table(ams$host_is_superhost)

#should delete the room_type variable and one of the separate types
ams[, c("room_type",
        "private_room",
        "entire_home_apt",
        "shared_room",
        "hotel_room")]

#something wrong when transforming Hotel_room variable (because in the new data,
#Hotel_room is all 0 while in the old data, there are 110 Hotel_room)

ams[, .(
    priv_room = sum(private_room),
    apt = sum(entire_home_apt),
    shared = sum(shared_room),
    hotel = sum(hotel_room)
),
by = host_is_superhost]

#   host_is_superhost priv_room   apt shared hotel
#1:              TRUE       926  1064      1     0
#2:             FALSE      2569 11765     43     0

table(ams$host_is_superhost, ams$room_type)
#       entire home/apt hotel room private room shared room
#FALSE           11765         64         2569          43
#TRUE             1064         46          926           1

table(ams$hotel_room == 1)
#FALSE
#16368

#average price by room_type (superhost vs. non-superhost)
superhost_price <-
    ams[, .(avg_price = mean(price)), by = .(host_is_superhost, room_type)]
colnames(superhost_price) <-
    c("superhost", "room_type", "avg_price")

g <-
    ggplot(superhost_price, aes(room_type, avg_price, fill = superhost))
g + geom_bar(stat = "identity",
             width = .5,
             position = 'dodge')
#avr price for non-superhost is higher in most case.
