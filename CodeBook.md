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

The header of the file contains the name of the variables.

### Variables description

* subject_id    :   Integer ID of the test subject whose movements were measured. 

* activity_name :   Name of the activity the test subject was performing at the time of measurement. Can take any of the following 6 values.
    * Walking
    * Walking Upstairs
    * Walking Downstairs
    * Sitting
    * Standing
    * Laying
    
* data_set_name :   Name of the original Data Set from which this Subject's data was merged. Can take values as 'test' or 'train'.


All variables below are mean of a measurement for each subject and activity.
All values are floating point numbers between -1 to 1. 

* time_BodyAcceleration_mean_X_axis : Raw Time domain body acceleration mean in X dimension
* time_BodyAcceleration_mean_Y_axis : Raw Time domain body acceleration mean in Y dimension
* time_BodyAcceleration_mean_Z_axis : Raw Time domain body acceleration mean in Z dimension

* time_GravityAcceleration_mean_X_axis : Raw Time domain Gravity acceleration mean in X dimension
* time_GravityAcceleration_mean_Y_axis : Raw Time domain Gravity acceleration mean in Y dimension
* time_GravityAcceleration_mean_Z_axis : Raw Time domain Gravity acceleration mean in Z dimension

* time_BodyAccelerationJerk_mean_X_axis : Body linear acceleration mean to obtain jerk signal in X dimension
* time_BodyAccelerationJerk_mean_Y_axis : Body linear acceleration mean to obtain jerk signal in Y dimension
* time_BodyAccelerationJerk_mean_Z_axis : Body linear acceleration mean to obtain jerk signal in Z dimension

* time_BodyGyroscope_mean_X_axis : Raw Time domain body gyroscope mean in X dimension
* time_BodyGyroscope_mean_Y_axis : Raw Time domain body gyroscope mean in Y dimension
* time_BodyGyroscope_mean_Z_axis : Raw Time domain body gyroscope mean in Z dimension

* time_BodyGyroscopeJerk_mean_X_axis : Body Angular Velocity mean to obtain jerk signal in X dimension
* time_BodyGyroscopeJerk_mean_Y_axis : Body Angular Velocity mean to obtain jerk signal in Y dimension
* time_BodyGyroscopeJerk_mean_Z_axis : Body Angular Velocity mean to obtain jerk signal in Z dimension

* time_BodyAccelerationMagnitude_mean : Raw Time domain body acceleration Magnitude mean
* time_GravityAccelerationMagnitude_mean : Raw Time domain Gravity acceleration Magnitude mean
* time_BodyAccelerationJerkMagnitude_mean : Body linear acceleration Magnitude mean to obtain jerk signal
* time_BodyGyroscopeMagnitude_mean : Raw Time domain body gyroscope Magnitude mean
* time_BodyGyroscopeJerkMagnitude_mean : Body Angular Velocity Magnitude mean to obtain jerk signal

* frequency_BodyAcceleration_mean_X_axis : Fast Fourier Transform of Raw Time domain body acceleration mean in X dimension
* frequency_BodyAcceleration_mean_Y_axis : Fast Fourier Transform of Raw Time domain body acceleration mean in Y dimension
* frequency_BodyAcceleration_mean_Z_axis : Fast Fourier Transform of Raw Time domain body acceleration mean in Z dimension

* frequency_BodyAccelerationJerk_mean_X_axis : Fast Fourier Transform of Body linear acceleration mean to obtain jerk signal in X dimension
* frequency_BodyAccelerationJerk_mean_Y_axis : Fast Fourier Transform of Body linear acceleration mean to obtain jerk signal in Y dimension
* frequency_BodyAccelerationJerk_mean_Z_axis : Fast Fourier Transform of Body linear acceleration mean to obtain jerk signal in Z dimension

* frequency_BodyGyroscope_mean_X_axis : Fast Fourier Transform of Raw Time domain body gyroscope mean in X dimension
* frequency_BodyGyroscope_mean_Y_axis : Fast Fourier Transform of Raw Time domain body gyroscope mean in Y dimension
* frequency_BodyGyroscope_mean_Z_axis : Fast Fourier Transform of Raw Time domain body gyroscope mean in Z dimension

* frequency_BodyAccelerationMagnitude_mean : Fast Fourier Transform of Raw Time domain body acceleration Magnitude mean
* frequency_BodyAccelerationJerkMagnitude_mean : Fast Fourier Transform of Body linear acceleration Magnitude mean to obtain jerk signal
* frequency_BodyGyroscopeMagnitude_mean : Fast Fourier Transform of Raw Time domain body gyroscope Magnitude mean
* frequency_BodyGyroscopeJerkMagnitude_mean : Fast Fourier Transform of Body Angular Velocity Magnitude mean to obtain jerk signal

* time_BodyAcceleration_standardDeviation_X_axis : Raw Time domain body acceleration standard deviation in X dimension
* time_BodyAcceleration_standardDeviation_Y_axis : Raw Time domain body acceleration standard deviation in Y dimension
* time_BodyAcceleration_standardDeviation_Z_axis : Raw Time domain body acceleration standard deviation in Z dimension

* time_GravityAcceleration_standardDeviation_X_axis : Raw Time domain Gravity acceleration standard deviation in X dimension
* time_GravityAcceleration_standardDeviation_Y_axis : Raw Time domain Gravity acceleration standard deviation in Y dimension
* time_GravityAcceleration_standardDeviation_Z_axis : Raw Time domain Gravity acceleration standard deviation in Z dimension

* time_BodyAccelerationJerk_standardDeviation_X_axis : Body linear acceleration standard deviation to obtain jerk signal in X dimension
* time_BodyAccelerationJerk_standardDeviation_Y_axis : Body linear acceleration standard deviation to obtain jerk signal in Y dimension
* time_BodyAccelerationJerk_standardDeviation_Z_axis : Body linear acceleration standard deviation to obtain jerk signal in Z dimension

* time_BodyGyroscope_standardDeviation_X_axis : Raw Time domain body gyroscope standard deviation in X dimension
* time_BodyGyroscope_standardDeviation_Y_axis : Raw Time domain body gyroscope standard deviation in Y dimension
* time_BodyGyroscope_standardDeviation_Z_axis : Raw Time domain body gyroscope standard deviation in Z dimension

* time_BodyGyroscopeJerk_standardDeviation_X_axis : Body Angular Velocity standard deviation to obtain jerk signal in X dimension
* time_BodyGyroscopeJerk_standardDeviation_Y_axis : Body Angular Velocity standard deviation to obtain jerk signal in Y dimension
* time_BodyGyroscopeJerk_standardDeviation_Z_axis : Body Angular Velocity standard deviation to obtain jerk signal in Z dimension

* time_BodyAccelerationMagnitude_standardDeviation : Raw Time domain body acceleration Magnitude standard deviation
* time_GravityAccelerationMagnitude_standardDeviation : Raw Time domain Gravity acceleration Magnitude standard deviation
* time_BodyAccelerationJerkMagnitude_standardDeviation : Body linear acceleration Magnitude standard deviation to obtain jerk signal 
* time_BodyGyroscopeMagnitude_standardDeviation : Raw Time domain body gyroscope Magnitude standard deviation 
* time_BodyGyroscopeJerkMagnitude_standardDeviation : Body Angular Velocity Magnitude standard deviation to obtain jerk signal

* frequency_BodyAcceleration_standardDeviation_X_axis : Fast Fourier Transform of Raw Time domain body acceleration standard deviation in X dimension
* frequency_BodyAcceleration_standardDeviation_Y_axis : Fast Fourier Transform of Raw Time domain body acceleration standard deviation in Y dimension
* frequency_BodyAcceleration_standardDeviation_Z_axis : Fast Fourier Transform of Raw Time domain body acceleration standard deviation in Z dimension

* frequency_BodyAccelerationJerk_standardDeviation_X_axis : Fast Fourier Transform of Body linear acceleration standard deviation to obtain jerk signal in X dimension
* frequency_BodyAccelerationJerk_standardDeviation_Y_axis : Fast Fourier Transform of Body linear acceleration standard deviation to obtain jerk signal in Y dimension
* frequency_BodyAccelerationJerk_standardDeviation_Z_axis : Fast Fourier Transform of Body linear acceleration standard deviation to obtain jerk signal in Z dimension

* frequency_BodyGyroscope_standardDeviation_X_axis : Fast Fourier Transform of Raw Time domain body gyroscope standard deviation in X dimension
* frequency_BodyGyroscope_standardDeviation_Y_axis : Fast Fourier Transform of Raw Time domain body gyroscope standard deviation in Y dimension
* frequency_BodyGyroscope_standardDeviation_Z_axis : Fast Fourier Transform of Raw Time domain body gyroscope standard deviation in Z dimension

* frequency_BodyAccelerationMagnitude_standardDeviation : Fast Fourier Transform of Raw Time domain body acceleration Magnitude standard deviation
* frequency_BodyAccelerationJerkMagnitude_standardDeviation : Fast Fourier Transform of Body linear acceleration Magnitude standard deviation to obtain jerk signal 
* frequency_BodyGyroscopeMagnitude_standardDeviation : Fast Fourier Transform of Raw Time domain body gyroscope Magnitude standard deviation
* frequency_BodyGyroscopeJerkMagnitude_standardDeviation : Fast Fourier Transform of Body Angular Velocity Magnitude standard deviation to obtain jerk signal

