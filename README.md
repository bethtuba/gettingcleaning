# Course project for Getting &amp; Cleaning Data (July 2015)

##Introduction
Using the run_analysis.R script, you can convert the raw Samsung data into a tidy data set of means and standard deviations for each measurement.
This script requires the dplyr and reshape2 changes. The script will automatically install and load them if they are not on your machine.

##Setup
1. Download the raw data from this url to your working directory: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Name the *.zip file "rawdata.zip".
3. Run the script, "run_analysis.R".

##Results
After executing, you will have two new data.frames in your environment:
* tidyData
** The tidy data set described in the introduction.
**Please note that this data.frame is also a tbl_df object (see dplyr for more information)
* averagesData
** The means of each measurement by the activity performed.

##Code Book
Please see "features_info.txt" for information about the materials.
