# --- Install & Load Packages --- #

if (!require("pacman")) install.packages("pacman")
pacman::p_load(googledrive,readr,MatchIt, optmatch, dplyr, gapminder, fixest, forcats, purrr, rlist, RItools, Hmisc, modelsummary, data.table, ggplot2)

search()

# Create folders 
dir.create('./data')
dir.create('./gen/input')
dir.create('./gen/temp')
dir.create('./gen/output')


# --- Download data --- #
data_id <- "https://drive.google.com/file/d/17FFZX3t8ibGp1X2AaFHMwBg0kMhHGb-g/view?usp=sharing"
out_file <- "data/Amsterdam.csv" 

drive_download(
    as_id(data_id), 
    path = out_file,
    overwrite = TRUE)

