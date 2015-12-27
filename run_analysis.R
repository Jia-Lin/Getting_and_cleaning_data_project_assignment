## Getting and Cleaning Data - Course Project
## The below script assumes data file has already been downloaded, exactracted,
##   and eworking directory is UCI HAR Dataset
## Otherwise the data file can be downloaded from: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## 1. Merges the training and the test sets to create one data set.
## 		data_set_step_1 contains the answer for this step.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
##
##
## 1. Merges the training and the test sets to create one data set.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## data_set_step_1 contains the answer for above steps.
options(warn = -1)
## Step 1 - Merges the training and the test sets to create one data set.
## Step 1.1 - Determine column names from features.txt file
features <- read.table("features.txt", stringsAsFactors=FALSE)
## Step 1.2 - Read training data
df1 <- read.table("train/X_train.txt")
names(df1) <- features$V2
## step 1.3 Read and merge subjects
subjects <- read.table("train/subject_train.txt")
names(subjects) <- c("subject")
df1 <- cbind(subjects, df1)
## Step 1.4 - read and merge activity
act <- read.table("train/y_train.txt")
names(act) <- c("actID")
act_label <- read.table("activity_labels.txt")
names(act_label) <- c("actID", "activity")
act <- merge(act, act_label, by.x="actID", by.y="actID")
## Step 1.5 - merge activity with data file
df1 <- cbind(act, df1)
##
## Step 2 - Read test data and merge with training data
## Step 2.1 - Read test data
df2 <- read.table("test/X_test.txt")
names(df2) <- features$V2
## step 2.2 Read and merge subjects
subjects <- read.table("test/subject_test.txt")
names(subjects) <- c("subject")
df2 <- cbind(subjects, df2)
## Step 2.3 - read and merge activity
act <- read.table("test/y_test.txt")
names(act) <- c("actID")
##act_label <- read.table("activity_labels.txt")
##names(act_label) <- c("actID", "activity")
act <- merge(act, act_label, by.x="actID", by.y="actID")
## Step 2.4 - merge activity with data file
df2 <- cbind(act, df2)
## Step 2.5 - merge test and train data, data_set_step_1 is the merged data set.
data_set_step_1 <- rbind(df1, df2)
print("Please use data_set_step_1 for the data set in the step 1 of the instruction.")
##
##
##
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 		data_set_step_2 is the required data subset for this step.
step_2_measurements <- features$V2[grep("mean|std", features$V2)]
data_set_step_2 <- data_set_step_1[c("subject", "activity", step_2_measurements)]
##
##
##
##
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library("plyr")
groupColumns <- c("subject", "activity")
dataColumns <- features$V2
data_set_step_5 <- ddply(data_set_step_1, groupColumns, function(x) colMeans(x[dataColumns]))


