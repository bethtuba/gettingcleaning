##Load needed packages, dplyr and reshape2
if("dplyr" %in% installed.packages()) {
    library(dplyr)
} else {
  install.packages("dplyr")
  library(dplyr)
}
if("reshape2" %in% installed.packages()) {
  library(reshape2)
} else {
  install.packages("reshape2")
  library(reshape2)
}

##Create a folder for this script called "gettingcleaningproject"
if(!dir.exists("./gettingcleaningproject")) {
  dir.create("./gettingcleaningproject")
}
setwd("./gettingcleaningproject")

###Download the data & extract it
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./rawdata.zip")
unzip("rawdata.zip")
###Data extracts into folder "./UCI HAR Dataset"
setwd("./UCI HAR Dataset")


##Step 1: Merge test & train data sets
testData <- read.table("./test/X_test.txt")
trainData <- read.table("./train/X_train.txt")
allData <- rbind(testData, trainData)

###assign column names to the data (NOTE: THIS IS STEP 4 OF THE ASSIGNMENT)
headers <- read.table("./features.txt", stringsAsFactors = F)
colnames(allData) <- headers[, 2]

###read in activity labels
labels <- rbind(read.table("./test/Y_test.txt"), read.table("./train/Y_train.txt"))
colnames(labels) <- "activityNum"


##Step 2: Extracts only the mean and standard deviation for each measurement
neededCols <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)
myData <- allData[, neededCols]


##Step 3: Uses descriptive activity names to name the activities in the data set
###add the activity labels to myData
myData <- cbind(labels, myData)

###read in activity descriptions
activities <- read.table("./activity_labels.txt")

###create tbl_df & assign activity descriptions to each row using the activity #
myData2 <- tbl_df(myData)
myData2 <- mutate(myData2, Activity = activities[activityNum, 2])
###rearrange columns (remove activityNum, move Activity to position 1)
myData2 <- select(myData2, Activity, 2:67)
tidyData <- myData2


##Step 4: Appropriately label the data set with descriptive variable names.
###This was done already in the "assign column names to the data" section of Step 1

##Step 5 of assignment (not part of the tidy data creation): Create a second, independent tidy data set with the average of each variable for each activity and each subject.
myData2Melt <- melt(myData2, id=("Activity"), measure.vars=2:67)
averagesData <- dcast(myData2Melt, Activity ~ variable, mean)

##Clean up the environment
rm(activities)
rm(allData)
rm(headers)
rm(labels)
rm(myData)
rm(myData2)
rm(myData2Melt)
rm(testData)
rm(trainData)
rm(neededCols)