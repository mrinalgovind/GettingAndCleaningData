# CodeBook

This document describes the variables, the data, and any transformations or work that you performed to clean up the data

## Input Data

This data is from "Human Activity Recognition Using Smartphones Data Set". 
The data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Transformations performed

Following transformations are performed:

1. *subject_test.txt* is read to *subject_test*
2. *X_test.txt* is read to *X_test*
3. *Y_test.txt* is read to *Y_test*
4. *subject_train.txt* is read to *subject_train*
5. *X_train.txt* is read to *X_train*
6. *Y_train.txt* is read to *Y_train*
7. All the above data is merged into a common data structure *combined_data*
8. Variables containing only the 'mean' and 'standard deviation' readings are retained in the *combined_data*
9. In *combined_data* 'activity' is replaced with descriptive names from the *activity_labels.txt*
10. Variables are given descriptive names
    * Rename column names like "350_fBodyAccJerk-std()-Z" to "f_BodyAccJerk_standardDeviation_Z_axis" 
    * Rename column names like "201_tBodyAccMag-mean()" to "t_BodyAccMag_mean"
    * prefix 't' to be replaced with 'time'
    * prefix 'f' to be replaced with 'frequency'
    * suffix 'std' to be replaced with 'standardDeviation'
    * 'BodyBody' to be replaced with 'Body'
    * 'Acc' to be replaced with 'Acceleration'
    * 'Gyro' to be replaced with 'Gyroscope'
    * 'Mag' to be replaced with 'Magnitude'
    * 'subject' to be replaced with 'subject_id'
    * 'activity' to be replaced with 'activity_name'
    * 'set' to be replaced with 'data_set_name'
11. *tidy* is created from *combined_data* and the data is grouped by suject and activity
12. *tidy* is summarized on each variable by calculating the mean of each variable for each activity and each subject.
13. *tidy* is written to *tidy_data.txt*

## Output tidy data (tidy_data.txt)
The output is a file named *tidy_data.txt*.

The header of the file contains the name of the variables, which are pretty descriptive and easily understanddable. 


