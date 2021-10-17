# Becoming AirBnB superhost: Is it worth it? 

__How becoming a superhost pays off on Airbnb: Do superhosts charge higher than their non-accredited counterparts?__

![Becoming a superhost is a huge investment in time and effort](https://raw.githubusercontent.com/thtbui/group-9-investigating-airbnb/main/data/how%20to%20become%20a%20superhost.png)

## Motivation

Peer-to-peer accommodation services such as Airbnb have become a game-changer in the rental market and the tourism accommodation sector. Literature has investigated a different price determinants of Airbnb listings such as: listing attributes, host attributes, rental policies, listing reputation, and listing location (see more at [More Resources](#more-resources))

This project addresses the following research questions: 
+ Do superhosts charge higher than non-superhosts for listings with same characteristics? 

Answering this question benefits Airbnb users (i.e, hosts and guests) in different ways:
+ For Airbnb hosts: Becoming a superhost requires huge time and effort investments. The results from this study can help answer the question: Is it worth it to become a superhost? 
+ For Airbnb guests: This helps travelers u nderstand the price listing bias which in turns helps them make better decision when comparing and choosing accomodations on Airbnb.  

## Data overview

The data consists of 13,421 observations of which each represents an AirBnB listing. After removing unnecessary columns, the final dataset includes 16 variables related to both hosts and the listings.

+ There are 1835 superhosts (13.7%) and 11586 (86.3%) non-superhost-owned listings
+ We can observe some differences in price set by superhost vs. non-superhost in general:

1. Of all listings in the dataset, average prices set by superhosts are higher than that of non-superhosts:

![avr. price by superhost vs. non-superhost ](https://raw.githubusercontent.com/thtbui/group-9-investigating-airbnb/main/data/avg_price_superhost_nonsuperhost.png)

2. Examinizing prices for each room type, we see the same pattern: Except for Entire homes where prices of superhosts are a bit higher, non-superhosts establish higher prices for all other property types.

![avr. price by room type - superhost vs. non-superhost ](https://raw.githubusercontent.com/thtbui/group-9-investigating-airbnb/main/data/avg_price_by_roomtype_superhost_vs_nonsuperhost.png)

3. Lastly, considering property location, superhosts seem to set higher price for both in center and not-center rooms

![avr. price by room location - superhost vs. non-superhost ](https://raw.githubusercontent.com/thtbui/group-9-investigating-airbnb/main/data/avg_price_by_loc_superhost_vs_nonsuperhost.png)

## Method and results

We use OLS estimation to analyze the effect of being a superhost compared to non-accredited hosts on the listing's price. In the regression model, we include some control variables such as property type, number of reviews, total number of listings of the host house size and etc.

However, omitted variables are one of the major problems in nonexperimental studies because if we do not take them into account, they will create a biased estimate of the effect. For instance, it might be possible that a listing on the day of a national holiday have a higher price than the other dates and the total number of listings of a host might be higher in a national than in an ordinary period. In this case, the omitted variable both affects the dependent variable "price" and the independent variable "total listings". In such a case, the effect pf total listings would be over-estimated, because our model could not capture the effect of holidays. 

To overcome this endogeneity problem, we use propensity score matching method. To be more specific, we match the treated (superhosts) and untreated (non-accredited hosts) groups based on the covariates included in the model ike a real lab experiment, both conditions are approximately the same except the difference in the type of host (superhost vs non-accredited)

## Repository overview

Our repository has the following structure:
```
   |───gen
   |   ├───input
   |   ├───output
   |   |──temp
   |
   |───paper
   |  
   └───src
        ├───analysis
        └───data-prep
```
## Running instructions

For this project, we made use of GNU make. In order to run the whole project type in your terminal the command make.If you would like to learn more about GNU make, we advice you to visit the following [site](https://tilburgsciencehub.com/building-blocks/automate-and-execute-your-work/automate-your-workflow/what-are-makefiles/).

Before running the makefile, please make sure you have the following packages installed :
```
        install.packages("pacman")
        install.packages("googledrive")
        install.packages("readr")
        install.packages("MatchIt")
        install.packages("optmatch")
        install.packages("gapminder")
        install.packages("dplyr")
        install.packages(fixest)
        install.packages("forcats")
        install.packages("purrr")
        install.packages("rlist")
        install.packages("RItools")
        install.packages("Hmisc")
        install.packages("modelsummary")
        install.packages("data.table")
        install.packages("ggplot2")
```
## More resources

Perez-Sanchez VR, Serrano-Estrada L, Marti P, Mora-Garcia R-T. The What, Where, and Why of Airbnb Price Determinants. Sustainability. 2018; 10(12):4596. [https://doi.org/10.3390/su10124596]

## About

This group project is part of the course Data Preparation & Workflow Management at Tilburg University. The following authors have created and contributed to this repository:
+ Iliana Chlimintza <i.d.chlimintza@tilburguniversity.edu>
+ Tolga Depecik <t.depecik@tilburguniversity.edu>
+ Trang Bui <t.h.t.bui@tilburguniversity.com> 
+ Vasileios Syrpas <v.syrpas@tilburguniversity.edu>
+ Janick Boekhorst <j.boekhorst@tilburguniversity.edu>

