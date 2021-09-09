# --- Load Libraries --- #
library(googledrive)
library(readr)

data_id <- "https://drive.google.com/file/d/17FFZX3t8ibGp1X2AaFHMwBg0kMhHGb-g/view?usp=sharing"
out_file <- "Hong_Kong.csv" 

drive_download(
    as_id(data_id), 
    path = out_file,
    overwrite = TRUE)

    