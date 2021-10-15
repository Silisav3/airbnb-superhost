all: data_download data_cleaning data_summary unbalanced_data balanced_data results
data_download: data/Amsterdam.csv
data_cleaning: gen/temp/df_cleaned.csv
data_summary: gen/output/plot1_avg_price_superhost_vs_non.pdf gen/output/plot2_avg_price_room_type.pdf gen/output/plot3_avg_price_location.pdf
unbalanced_data: gen/output/visualizing_unbalanced_data.pdf 
balanced_data: gen/output/visualizing_balanced_data.pdf
results: gen/output/airbnb_results.html
## Sub-builds

data/Amsterdam.csv: src/data-prep/data_download.R
	R --vanilla < src/data-prep/data_download.R
	
gen/temp/df_cleaned.csv: src/data-prep/data_cleaning.R
		R --vanilla < src/data-prep/data_cleaning.R

gen/output/plot1_avg_price_superhost_vs_non.pdf gen/output/plot2_avg_price_room_type.pdf gen/output/plot3_avg_price_location.pdf: src/analysis/data_summary.R
	R --vanilla < src/analysis/data_summary.R

gen/output/visualizing_unbalanced_data.pdf: src/analysis/visualizing_unbalanced_data.R
	R --vanilla < src/analysis/visualizing_unbalanced_data.R
	
gen/output/visualizing_balanced_data.pdf: src/analysis/visualizing_balanced_data.R
	R --vanilla < src/analysis/visualizing_balanced_data.R
	
gen/output/airbnb_results.html: src/analysis/model_comparison.R
	R --vanilla < src/analysis/model_comparison.R