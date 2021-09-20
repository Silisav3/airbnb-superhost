# --- Select columns --- #
library(dplyr)

Amsterdam_columns<-Amsterdam_unclean %>% select(host_id,host_is_superhost,
                                                neighbourhood_cleansed,property_type ,
                                                room_type ,accommodates,bedrooms,beds,amenities,price,
                                                minimum_nights, number_of_reviews,calculated_host_listings_count,
                                                reviews_per_month)


#--- Convert data ---# 

Amsterdam_columns$host_id <- as.numeric(Amsterdam_columns$host_id)

Amsterdam_columns$host_is_superhost <-as.factor(Amsterdam_columns$host_is_superhost)
Amsterdam_columns$host_is_superhost<- Amsterdam_columns$host_is_superhost == "t"


Amsterdam_columns$neighbourhood_cleansed<-replace(Amsterdam_columns$neighbourhood_cleansed,Amsterdam_columns$neighbourhood_cleansed== "Centrum-West","Centrum")
Amsterdam_columns$neighbourhood_cleansed<-replace(Amsterdam_columns$neighbourhood_cleansed,Amsterdam_columns$neighbourhood_cleansed== "Centrum-Oost","Centrum")
Amsterdam_columns$neighbourhood_cleansed<- ifelse(Amsterdam_columns$neighbourhood_cleansed=="Centrum",1,0)


Amsterdam_columns$accommodates <- as.numeric(Amsterdam_columns$accommodates)
Amsterdam_columns$beds <- as.numeric(Amsterdam_columns$beds)
Amsterdam_columns$bedrooms <- as.numeric(Amsterdam_columns$bedrooms)


Private_room <- ifelse(Amsterdam_columns$room_type=="Private room",1,0)
Entire_home_apt <- ifelse(Amsterdam_columns$room_type=="Entire home/apt",1,0)
Shared_room<-ifelse(Amsterdam_columns$room_type=="Shared room",1,0)
Hotel_room<-ifelse(Amsterdam_columns$room_type=="Hotel room",1,0)
Amsterdam_columns<-cbind(Amsterdam_columns,Private_room,Entire_home_apt,Shared_room,Hotel_room)


Amsterdam_columns$accommodates <- as.numeric(Amsterdam_columns$accommodates)
Amsterdam_columns$beds <- as.numeric(Amsterdam_columns$beds)
Amsterdam_columns$bedrooms <- as.numeric(Amsterdam_columns$bedrooms)

size_house<-rowMeans(Amsterdam_columns[,6:8])
Amsterdam_columns<-cbind(Amsterdam_columns,size_house)
Amsterdam_columns = subset(Amsterdam_columns, select = -c(accommodates,beds,bedrooms))


Amsterdam_columns$minimum_nights <- as.numeric(Amsterdam_columns$minimum_nights)
Amsterdam_columns$number_of_reviews <- as.numeric(Amsterdam_columns$number_of_reviews)      
Amsterdam_columns$calculated_host_listings_count <- as.numeric(Amsterdam_columns$calculated_host_listings_count) 
Amsterdam_columns$reviews_per_month <- as.numeric(Amsterdam_columns$reviews_per_month)

Amsterdam_columns$price<-as.numeric(as.factor(Amsterdam_columns$price))

Amsterdam<- Amsterdam_columns

#--- Save final dataset ---#

write_rds(Amsterdam,"Amsterdam.rds")
