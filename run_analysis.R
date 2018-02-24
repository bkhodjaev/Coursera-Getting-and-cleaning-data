setwd("./UCI HAR Dataset/")
## settig working directory
X_test <- read.table("./test/X_test.txt")
## reading data from Test set
str(X_test)
## inspecting the size and class of the data in Test set
y_test <- read.table("./test/y_test.txt")
## reading data from Test labels
str(y_test)
## ispecting the size and class of the data in Test labels
subject_test <- read.table("./test/subject_test.txt")
## reading data from Test subjects
str(subject_test)
## inspecting data from Test subjects
X_train <- read.table("./train/X_train.txt")
## reading data from Train set
str(X_train)
## inspecting the size and class of the data in Train set
y_train <- read.table("./train/y_train.txt")
## reading data from Train labels
str(y_train)
## ispecting the size and class of the data in Train labels
subject_train <- read.table("./train/subject_train.txt")
## reading data from Train subjects
str(subject_train)
## inspecting data from Train subjects
merged_test <- cbind(subject_test, y_test, X_test)
## merging data, labels and subjects from Test set
merged_train <- cbind(subject_train, y_train, X_train)
## merging data, labels and subjects from Train set
mergedData <- rbind(merged_test, merged_train)
## 1. Merged the training and the test sets to create one data set
features <- read.table("./features.txt", colClasses = c("numeric", "character"))
## reading the list of all features 
column_names <- c(features$V2)
## creating a vector for column names for features
colnames(mergedData) <- c("subject_id", "activity_id", column_names)
## 4. Appropriately labeled the data set with descriptive variable names
library(dplyr)
names(mergedData) <- make.unique(names(mergedData))
selectedData <- select(mergedData, subject_id, activity_id, contains("mean"), contains("std"))
## 2. Extracted only the measurements on the mean and standard deviation for each measurement 
selectedData$activity_id <- factor(selectedData$activity_id, levels = activity_labels[,1], labels = activity_labels[,2])
## 3. Applied descriptive activity names to name the activities in the data set
tidyData <- selectedData %>%
  group_by(subject_id, activity_id) %>%
  summarise_all(mean)
## Created a second, independent tidy data set with the average of each variable for each activity and each subject
write.table(tidyData, "tidyData.txt", row.name=FALSE)
## writing tidy data into files