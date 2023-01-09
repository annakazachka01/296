# Enrollment Data Function

# Function for url zip file downloading 
cms_files_url <- 'https://www.cms.gov/files/zip/'
cms_data_download <- function(cms_zip_file_name){
  temp <- tempfile()
  
  download.file(url = paste0(cms_files_url, 
                             cms_zip_file_name), 
                temp, 
                method = 'curl')
  
  unzipped_file_paths <- unzip(temp)
  
  unlink(temp)
  
  return(unzipped_file_paths)
}

# Change the directory to download the enrollement data
setwd("/Users/annakazachka/PSTAT296/Data/Enrollment")

# Input of Time
# Enrollment Data (example: "september-2022")

# Enrollment Data Download Function
dlEnrollData <- function(...) {
  x <- list(...)
  for (month_year in x){
    MA_enrollement_unzipped_paths <- cms_data_download(paste0('ma-enrollment-statecountycontract-',month_year,'-full-version.zip'))
    contracts_enrollement_unzipped_paths <- cms_data_download(paste0('monthly-enrollment-cpsc-',month_year,'.zip'))
    penetration_unzipped_paths <- cms_data_download(paste0('ma-statecounty-penetration-',month_year,'.zip'))}
}


# Change the directory to download the enrollement data
setwd("/Users/annakazachka/PSTAT296/Data/Enrollment")
dlEnrollData("january-2021","february-2021","march-2021","april-2021","may-2021", "june-2021", "july-2021", "august-2021", "september-2021", "october-2021", "november-2021", "december-2021")
# Change the directory to download the performance data
setwd("/Users/annakazachka/PSTAT296/Data/Performance")
# Performance Data Download
performance_data_unzipped_paths <- cms_data_download('2022-star-ratings-data-table-oct-06-2021.zip')
# Change the directory to download the benefits data
setwd("/Users/annakazachka/PSTAT296/Data/Benefits")
# Benefits Data Download
benefits_unzipped_paths <- cms_data_download('pbp-benefits-2021-updated-07012021.zip')
