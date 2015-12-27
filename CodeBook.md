One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

Github repository contains R script called run_analysis.R that does the following:  
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This code book describes the variables, the data, and any transformations or work that I performed to clean up the data. 

## Requirements 
Working directory must contain data downloaded from  [](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The dataset must include the following files:  
- 'activity_labels.txt': Links the class labels with their activity name.  
- 'train/X_train.txt': Training set.  
- 'train/y_train.txt': Training labels.  
- 'test/X_test.txt': Test set.  
- 'test/y_test.txt': Test labels.  
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.   
- 'test/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.   
  
data.table and dplyr packages must be installed and loaded.  

## Data transformation
  
1. Load training data set from file "train\\x_train.txt" which contains a 561-feature vector with time and frequency domain variables to variable train_data_set.

2. Load training labels from file "train\\y_train.txt" to variable y_train.
  
3. Load training subjects from file "train\\subject_train.txt" which contains subject who performed the activity for each window sample to variable subject_train. Subjects' range is from 1 to 30 .   

4. Append y_train and subject_train to train_data_set.

5. Load test data set from file "test\\x_test.txt" which contains a 561-feature vector with time and frequency domain variables to variable test_data_set.

6. Load test labels from file "test\\y_test.txt" to variable y_test.
  
7. Load test subjects from file "test\\subject_test.txt" which contains subject who performed the activity for each window sample to variable subject_test. Subjects' range is from 1 to 30 .   

8. Append y_test and subject_test to test_data_set.

9. Merge the training and the test sets to create one data set and save it to variable data_set.
data_set <- bind_rows(train_data_set, test_data_set)

10. Clean up unused variables.

11. Load feature names from file "features.txt" to variable features.

12. Get list of fields which contains mean and standard deviation in the name and save it to variable used_features.

13. Extract from data_set the measurements on the mean and standard deviation and save it to variable data_set.

14. Load activity labels from file "activity_labels.txt" to variable activity_labels.

15. Replace activity value in data_set by descriptive name from activity_labels.

16. Replace column names in data_set by descriptive variable names from used_features.

17. Group data_set by activity and subject.

18. Calculate the average of each variable for each activity and each subject and save it to variable data_set_average.

19. Save data_set_average to file "data_set_average.txt".



