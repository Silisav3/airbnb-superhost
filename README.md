# Accreditation as price determinant: How becoming a superhost pays off on Airbnb

__Do superhosts charge higher than their non-accredited counterparts?__

## Motivation

Peer-to-peer accommodation services such as Airbnb have become a game-changer in the rental market and the tourism accommodation sector. Literature has investigated a different price determinants of Airbnb listings such as: listing attributes, host attributes, rental policies, listing reputation, and listing location (see more at [More Resources](##more-resources))

This project addresses the following research questions: 
+ Do superhosts charge higher than non-superhosts for listings with same characteristics? 
+ Does superhosts' estimated monthly income differ from that of non-accredited hosts? 

Answering these questions benefits Airbnb users (i.e, hosts and guests) in different ways:
+ For Airbnb hosts: Becoming a superhost requires huge time and effort investments. The results from this study can help answer the question: Is it worth it to become a superhost? 
+ For Airbnb guests: This helps travelers u nderstand the price listing bias which in turns helps them make better decision when comparing and choosing accomodations on Airbnb.  

## Method and results

We use OLS estimation to analyze the effect of being a superhost compared to non-accredited hosts on the listing's price. In the regression model, we include some control variables such as property type, number of reviews, total number of listings of the host house size and etc.

However, omitted variables are one of the major problems in nonexperimental studies because if we do not take them into account, they will create a biased estimate of the effect. For instance, it might be possible that a listing on the day of a national holiday have a higher price than the other dates and the total number of listings of a host might be higher in a national than in an ordinary period. In this case, the omitted variable both affects the dependent variable "price" and the independent variable "total listings". In such a case, the effect pf total listings would be over-estimated, because our model could not capture the effect of holidays. 

To overcome this endogeneity problem, we use propensity score matching method. To be more specific, we match the treated (superhosts) and untreated (non-accredited hosts) groups based on the covariates included in the modelL ike a real lab experiment, both conditions are approximately the same except the difference in the type of host (superhost vs non-accredited)

*First, introduce and motivate your chosen method, and explain how it contributes to solving the research question/business problem.

Second, summarize your results concisely. Make use of subheaders where appropriate.*

## Repository overview

Provide an overview of the directory structure and files.

## Running instructions

Explain to potential users how to run/replicate your workflow. Touch upon, if necessary, the required input data, which (secret) credentials are required (and how to obtain them), which software tools are needed to run the workflow (including links to the installation instructions), and how to run the workflow. Make use of subheaders where appropriate.

## More resources

Perez-Sanchez VR, Serrano-Estrada L, Marti P, Mora-Garcia R-T. The What, Where, and Why of Airbnb Price Determinants. Sustainability. 2018; 10(12):4596. [https://doi.org/10.3390/su10124596]

## About

This group project is part of the course Data Preparation & Workflow Management at Tilburg University. The following authors have created and contributed to this repository:
+ Iliana Chlimintza <i.d.chlimintza@tilburguniversity.edu>
+ Tolga Depecik <t.depecik@tilburguniversity.edu>
+ Trang Bui <t.h.t.bui@tilburguniversity.com> 
+ Vasileios Syrpas <v.syrpas@tilburguniversity.edu>
+ Janick Boekhorst <j.boekhorst@tilburguniversity.edu>

