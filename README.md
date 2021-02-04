# Getting-and-Cleaning-Data
Repository for Coursera JHU Getting and Cleaning Data Course Project

# 1 - LOAD packages ----

# 2 - LOAD data ----
## 2.1 - Download the HUCI HAR dataset from url provided, unzip in data folder
## 2.2 - Delete compressed file
## 2.3 - get test data : subjects, labels and dataset from test folder----
## 2.4 - get train data : subjects, labels and dataset from train folder----
## 2.5 - get features list and activity labels data ----

# 3 - CLEAN and PREPARE data ----

## 3.1 - preparing feature data set ----
## 3.1.1 - getting features labels into a vector
## 3.1.2 - applying features labels to test and train datasets
## 3.1.3 - subsetting mean and std features only
# 3.1.3.1 - getting a vector of mean measurements variables - contains only "mean()"
# 3.1.3.2 - getting a vector of standard deviation measurements variables - contains only "std()"
# 3.1.3.3 - Binding mean & std vars in a single vector
## 3.1.4 - keeping only mean and std column on test & train data set

## 3.2 - preparing activity data set ----
## 3.2.1 - adding labels to columns (primary key activity_id)
## 3.2.2 - adding labels to column activity
## 3.2.3 - adding activity names to test & train labels tables
## 3.2.4 - Setting descriptive label for the subject in subject datasets

## 3.3 - binding test & train data sets ----
# 3.3.1 - binding subject, labels and dataset into test data set
# 3.3.2 - binding subject, labels and dataset into train data set

# 4 - VISUALISE tidy data ----

## 4.1 - Tidy data number 1: data set with descriptive variable names ----
### 4.1.1 - Binding test and train datasets
### 4.1.2 - (optional) deleting all the objects in memory except the resulting data set
### 4.1.3 - writing the output file named HAR_set in the output folder

## 4.2 - Tidy data number 2: data set with the average of each variable for each activity and each subject. ----
### 4.2.1 - converting the subjectId colmun to a character class
### 4.2.2 - applying mean to all mean and standard deviation variables and grouping by subject and activity
### 4.2.3 - writing the output file named HAR_gp_avg in the output folder
### 4.2.4 - deleting all objects in memory
   
   