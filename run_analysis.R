
# 1 - LOAD packages ----

library(dplyr)

# 2 - LOAD data ----

## 2.1 - Download the dataset from url, unzip in /data/ rep
zip_ds <- "data.zip"

if (!file.exists(zip_ds)){
            fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
            download.file(fileURL, zip_ds, method="curl")
}  
if (!file.exists("data")) { 
            unzip(zipfile = zip_ds, exdir = "./data/") 
}


## 2.2 - Delete compressed file
if (file.exists(zip_ds)) {
            file.remove(zip_ds)
}


## 2.3 - get test data ----
test_subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test_set <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

## 2.4 - get train data ----
train_subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
train_set <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

## 2.5 - get features list and activity labels data ----
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

# 3 - CLEAN and PREPARE data ----

## 3.1 - preparing feature data set ----

## getting features labels 
features_labels <- as.vector(features$V2)

## applying features labels to data sets 
names(test_set) = features_labels
names(train_set) = features_labels

## subsetting mean and std features only

# getting a vector of mean measurements variables - contains only "mean()"
mean_feat <- print(grep("mean\\(\\)", features$V2, value = TRUE))

# getting a vector of standard deviation measurements variables - contains only "std()"
std_feat <- print(grep("std\\(\\)", features$V2, value = TRUE))

# combine mean & std vars in a single vector
vars_features <- c(mean_feat, std_feat)

## keeping only mean and std column on test & train data set (using dplyr)
test_set <- test_set %>%
            select(all_of(vars_features))
train_set <- train_set %>%
            select(all_of(vars_features))

## 3.2 - preparing activity data set ----

## adding labels to columns (primary key activity_id)
names(activity_labels)[names(activity_labels) == "V1"] = "activityId"
names(test_labels)[names(test_labels) == "V1"] = "activityId"
names(train_labels)[names(train_labels) == "V1"] = "activityId"

## adding labels to column activity
names(activity_labels)[names(activity_labels) == "V2"] = "activity"

## merge activity names with test & train labels tables
test_labels <- inner_join(test_labels, activity_labels)
train_labels <- inner_join(train_labels, activity_labels)

## preparing subject data set
names(test_subject)[names(test_subject) =="V1"] = "subjectId"
names(train_subject)[names(train_subject) =="V1"] = "subjectId"

## 3.3 - binding test & train data sets ----

# binding columns for test data set
test <- cbind(test_subject, test_labels, test_set)

# binding columns for train data set
train <- cbind(train_subject, train_labels, train_set)

# 4 - VISUALISE tidy data ----

## 4.1 - Tidy data #1: data set with descriptive variable names ----
HAR_set <- rbind(train, test)
HAR_set <- HAR_set[,-2]

# deleting all the objects in memory except the resulting data set
## rm(list=(ls()[ls()!="HAR_set"]))

# writing the output in a file for answer 1
write.table(HAR_set,"./output/HAR_set.txt", row.names = FALSE)


## 4.2 - Tidy data #2: data set with the average of each variable for each activity and each subject. ----

HAR_set$subjectId <- as.character(HAR_set$subjectId)

HAR_gp_avg <- aggregate(HAR_set[,3:ncol(HAR_set)], 
                        by=list("Subject" = HAR_set$subjectId, "Activity" = HAR_set$activity), FUN= mean)

# writing the output in a file for answer 2
write.table(HAR_gp_avg,"./output/HAR_gp_avg.txt", row.names = FALSE)

# deleting all objects in memory
# rm(list=ls())
   
   