#Loading libraries

```{r}
library(data.table)
library(ggplot2)
```

#Loading data and summary

```{r}
df <- setDT(df)
summary(df)

```

#

```{r}
#number of super host/ non-super host
table(df$superhost)
```
```{r}
#room type by superhost
df[, .(
    priv_room = sum(private_room),
    apt = sum(entire_home_apt),
    shared = sum(shared_room),
    hotel = sum(hotel_room)
),by = superhost]
```
```{r}
#average price set by superhost vs. non-superhost
superhost_price <-
    df[, .(avg_price = mean(price)), by = superhost]
colnames(superhost_price) <-
    c("superhost", "avg_price")

superhost_price
```

```{r}
g <- ggplot(df, aes(superhost, price))
g + geom_boxplot(outlier.colour="black", outlier.shape=16,
             outlier.size=2, notch=FALSE)

```

```{r}
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
```

Unexpectedly, avg. prices set by non-superhost are higher for most room types, except for *Entire home*.

```{r}
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
```
However, by room location, we see that superhosts set higher price in both cases.


