# Getting and Cleaning Data Course Project

This course project repository contains the following files.

* run_analysis.R : This is the main script for the project
* README.md : Provides details about the project objectives and how it was achieved
* CodeBook.md : Describes the variables, the data, and any transformations or work that was performed to clean up the data 

## Objective

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



## Solution

The analysis is done in following steps:

1. Download data and read it
2. Divide the analysis in 5 parts as per the objective. Each step is described in detail as we progress forward.

## Download Data and Read

 ####Download, Extract and Read the data from the files for analysis.
 
 ####Downloaded data is in the "<workspace>/proj_data" folder created in the workspace.
 
<pre><code>
 DOWNLOADED_FILE_NAME = "projdataset.zip"

if( ! file.exists(DOWNLOADED_FILE_NAME)){
  
  dataurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  download.file(dataurl, DOWNLOADED_FILE_NAME)
  
  # put all the files in 1 folder "proj_data"
  unzip(DOWNLOADED_FILE_NAME, exdir="./proj_data", junkpaths = TRUE) 
  
}else{
  
  # It is assumed that data zip file has been downloaded.
  # It has been extracted into the current workspace
  # and all files reside under the folder "proj_data"
  
}
</code></pre>

####Read relevant files

<pre> <code>

# Test data set related files
subject_test <- read.table("proj_data/subject_test.txt")
X_test <- read.table("proj_data/X_test.txt")
Y_test <- read.table("proj_data/Y_test.txt")


# Train data set related files
subject_train <- read.table("proj_data/subject_train.txt")
X_train <- read.table("proj_data/X_train.txt")
Y_train <- read.table("proj_data/Y_train.txt")

</code> </pre>





## Part 1
### Merges the training and the test sets to create one data set.

 To merge all the training and test set data the script will do the following:

 1. It will merge the Subject, Y and X data for both training and test set individually.
 2. Will finally combine the 2 data sets produced in step 1 to create the combined dataset

#### Load libraries to be used

<pre><code>
library(dplyr)
</code></pre>


#### Merge the test dataset files
<pre><code>
subject_test <- tbl_df(subject_test)
X_test <- tbl_df(X_test)
Y_test <- tbl_df(Y_test)

test_data <- X_test %>% 
  mutate(subject = as.numeric(subject_test$V1), activity = as.numeric(Y_test$V1), set = "test") %>% 
  select(subject, activity, set, V1:V561)
</code></pre>
  
#### Merge the train dataset files
<pre><code>
subject_train <- tbl_df(subject_train)
X_train <- tbl_df(X_train)
Y_train <- tbl_df(Y_train)

train_data <- X_train %>% 
  mutate(subject = as.numeric(subject_train$V1), activity = as.numeric(Y_train$V1), set = "train") %>% 
  select(subject, activity, set, V1:V561)
</code></pre>
  
#### Combine the data set
<pre><code>
combined_data <- bind_rows(test_data, train_data)
</code></pre>


## Part 2
### Extracts only the measurements on the mean and standard deviation for each measurement. 


 To achieve the above, script will do the following:

 1. Rename all the columns of the combined dataset "combined_data" with actual names from "features.txt"
 2. Select on the columns which have in their name "means()" and "std()"

#### Read data from "features.txt"

<pre><code>
features <- read.table("proj_data/features.txt")

features <- tbl_df(features)
</code></pre>

#### Mutating to make sure duplicate column names don't create any issue

<pre><code>

features <- features %>% 
  mutate(cnames = paste(as.character(V1),as.character(V2),sep = "_"), V1 = NULL, V2 = NULL)

col_name_vector <- c("subject", "activity", "set", as.character(features$cnames))

#renaming the combined dataset
colnames(combined_data) <- col_name_vector

</code></pre>

#### Sub-setting only the measurements on the mean and standard deviation for each measurement

<pre><code>
combined_data <- combined_data %>% 
  select(1:3, contains("mean()"), contains("std()"))
</code></pre>



 

  ## Part 3


  ### Uses descriptive activity names to name the activities in the data set


  To achieve the above, script will do the following:
  
  1. Read descriptive activity names from "activity_labels.txt"
  2. Mutate the the combined data set's activity coloumn with values from activity_labels.txt


  #### Read the "activity_labels.txt" to fetch the descriptive names.
  
  <pre><code>
  activity_ds <- read.table("proj_data/activity_labels.txt")
  </code></pre>
  
  #### Replace the activity ids with the actual names.
  
  <pre><code>
  combined_data <- combined_data %>% 
  mutate(activity = as.character(activity_ds$V2[as.numeric(activity)]))
  </code></pre>

  
  
  
  
  ## Part 4
  
  ### Appropriately labels the data set with descriptive variable names.
  
  To achieve the above script will do the following

  1. Script will use the "stringr" package to rename the variables.
  2. Variables names like "350_fBodyAccJerk-std()-Z" will be renamed to "freqDomainSignal_BodyAccJerk_standardDeviation_Z_axis".
  3. Column names like "201_tBodyAccMag-mean()" will be renamed to "time_BodyAccMag_mean" to make it more readable.
  4. Certain terms in column names will be expanded to be more descriptive.
  
  
  
  #### load the 'stringr' package
  <pre><code>
  library(stringr)
  </code></pre>
  
  #### extract the vector of current column names 
  <pre><code>
  cnames <- names(combined_data)
  </code></pre>
  
  #### Use RegEx to transform column names.
  The script will use regex to match the column names and transform them
  
  * rename column names like "350_fBodyAccJerk-std()-Z" to "f_BodyAccJerk_standardDeviation_Z_axis" 
  * and column names like "201_tBodyAccMag-mean()" to "t_BodyAccMag_mean"
  
  <pre><code>
  pattern <- "(\\d{1,3})_(t|f)(\\w+)(-)(\\w+)(\\(\\))-?(X|Y|Z)?"
  
  cnames <- str_replace_all(cnames, pattern, "\\2_\\3_\\5_\\7")
  cnames <- str_replace_all(cnames, "(.*)(_$)", "\\1")
  cnames <- str_replace_all(cnames, "(.*_)([X|Y|Z])", "\\1\\2_axis")
  
  </code></pre>
  
  ##### Expand certain parts of the column name to be more descriptive.
  * prefix 't' to be replaced with 'time'
  * prefix 'f' to be replaced with 'frequency'
  * suffix 'std' to be replaced with 'standardDeviation'
  <pre><code>
  cnames <- str_replace_all(cnames, "^(t)(_.*)$", "time\\2")
  cnames <- str_replace_all(cnames, "^(f)(_.*)$", "frequency\\2")
  cnames <- str_replace_all(cnames, "^(.*_)(std)(.*)?$", "\\1standardDeviation\\3")
  </code></pre>
  
  * 'BodyBody' to be replaced with 'Body'
  * 'Acc' to be replaced with 'Acceleration'
  * 'Gyro' to be replaced with 'Gyroscope'
  * 'Mag' to be replaced with 'Magnitude'
  <pre><code>
  cnames <- str_replace_all(cnames, "(.*)(BodyBody)(.*)", "\\1Body\\3")
  cnames <- str_replace_all(cnames, "(.*)(Acc)(.*)", "\\1Acceleration\\3")
  cnames <- str_replace_all(cnames, "(.*)(Gyro)(.*)", "\\1Gyroscope\\3")
  cnames <- str_replace_all(cnames, "(.*)(Mag)(.*)", "\\1Magnitude\\3")
  </code></pre>
  
  * 'subject' to be replaced with 'subject_id'
  * 'activity' to be replaced with 'activity_name'
  * 'set' to be replaced with 'data_set_name'
  <pre><code>
  cnames <- str_replace(cnames, "subject", "subject_id")
  cnames <- str_replace(cnames, "activity", "activity_name")
  cnames <- str_replace(cnames, "set", "data_set_name")
  </code></pre>
  
  
  
  #### renaming the columns of combined dataset with only mean and standard deviation measures 
  <pre><code>
  colnames(combined_data) <- cnames
  </code></pre>
  
  
  
  
  
  
  
  ## Part 5
  
  ### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  To achieve the above, script will do the following
  
  1. group the data by subject, activity and data set (train/test)
  2. summarise each group with the mean calculation
  
  
  
  #####The following code performs the above steps 1 & 2 
  <pre><code>
  tidy <- combined_data
  
  tidy <- tidy %>% 
  group_by(subject_id,activity_name,data_set_name) %>%
  summarise_each(funs(mean))
  </code></pre>

