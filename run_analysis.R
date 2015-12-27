## Set working directory  
setwd("C:\\Users\\Alex\\Downloads\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset")

## Load necessary packages
library(data.table)
library(dplyr)

## 0. Load training data set

## Load train set
## A 561-feature vector with time and frequency domain variables
train_data_set <- fread("train\\x_train.txt", header = FALSE)

## Load train labels
y_train <- fread("train\\y_train.txt", header = FALSE,
                 col.names = c("activity"))

## Load train subjects
## Each row identifies the subject who performed the activity 
## for each window sample. Its range is from 1 to 30.
subject_train <- fread("train\\subject_train.txt", header = FALSE, 
                       col.names = c("subject"))

## Merge all in one
train_data_set <- bind_cols(train_data_set, y_train, subject_train)

## Clear parts of data set
rm(y_train, subject_train)

## Load test data set

## Load test set
## A 561-feature vector with time and frequency domain variables
test_data_set <- fread("test\\x_test.txt", header = FALSE)

## Load test labels
y_test <- fread("test\\y_test.txt", header = FALSE,
                col.names = c("activity"))

## Load test subjects
## Each row identifies the subject who performed the activity 
## for each window sample. Its range is from 1 to 30.
subject_test <- fread("test\\subject_test.txt", header = FALSE, 
                      col.names = c("subject"))

## Merge all in one
test_data_set <- bind_cols(test_data_set, y_test, subject_test)

## Clear parts of data set
#rm(x_test, y_test, subject_test)

## 1. Merges the training and the test sets to create one data set.
data_set <- bind_rows(train_data_set, test_data_set)

## Clear unused data
rm(train_data_set, test_data_set)

## 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement.

## Load feature names
features <- fread("features.txt", header = FALSE)

## Get list of fields which contain mean and standard deviation in the name   
used_features <- features[grep("mean\\(|std\\(", features$V2),]

## Extract the measurements on the mean and standard deviation
data_set <- select(data_set, used_features$V1, activity, subject)

## 3. Uses descriptive activity names to name the activities in the data set

## Load activity labels
activity_labels <- fread("activity_labels.txt", header = FALSE,
                         col.names = c("activity", "label"))

## Change activity value to descriptive name
data_set <- mutate(data_set, activity = activity_labels[activity]$label)

## 4. Appropriately labels the data set with descriptive variable names
colnames(data_set)[1:length(used_features$V2)] <- used_features$V2

## 5. Creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject
data_set_average <- data_set %>% group_by(activity, subject) %>% 
  summarise_each(funs(mean), -activity, -subject)


## Write the average
write.table(data_set_average, "data_set_average.txt", row.name = F)


