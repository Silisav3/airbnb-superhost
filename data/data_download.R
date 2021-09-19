# --- Load Libraries --- #
library(googledrive)
library(readr)

# --- Download data --- #
data_id <- "https://drive.google.com/file/d/17FFZX3t8ibGp1X2AaFHMwBg0kMhHGb-g/view?usp=sharing"
out_file <- "Amsterdam.csv" 

drive_download(
    as_id(data_id), 
    path = out_file,
    overwrite = TRUE)

Amsterdam_unclean <- read.csv("Amsterdam.csv")


