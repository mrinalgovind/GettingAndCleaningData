## The below script does the following
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.




## 0. Download, Extract and Read the data from the files for analysis

# Download and Extract the data in the workspace

DOWNLOADED_FILE_NAME = "projdataset.zip"

if( ! file.exists(DOWNLOADED_FILE_NAME)){
  
  dataurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  download.file(dataurl, DOWNLOADED_FILE_NAME)
  
  unzip(DOWNLOADED_FILE_NAME, exdir="./proj_data", junkpaths = TRUE) #will put all the files in 1 folder "proj_data"
  
}else{
  
  # It is assumed that data zip file has been downloaded.
  # It has been extracted into the current workspace
  # and all files reside under the folder "proj_data"
  
}

# Test data set related files
subject_test <- read.table("proj_data/subject_test.txt")
X_test <- read.table("proj_data/X_test.txt")
Y_test <- read.table("proj_data/Y_test.txt")


# Train data set related files
subject_train <- read.table("proj_data/subject_train.txt")
X_train <- read.table("proj_data/X_train.txt")
Y_train <- read.table("proj_data/Y_train.txt")


## 1. Merges the training and the test sets to create one data set.
#
#
# To merge all the trianing and test set data the script will do the following:
#
# 1. It will merge the Subject, Y and X data for both training and test set individually.
# 2. Will finally combine the 2 data sets produced in step 1 to create the combined dataset

## Load libraries to be used

library(dplyr)

# Merge the test dataset files
subject_test <- tbl_df(subject_test)
X_test <- tbl_df(X_test)
Y_test <- tbl_df(Y_test)

test_data <- X_test %>% 
  mutate(subject = as.numeric(subject_test$V1), activity = as.numeric(Y_test$V1), set = "test") %>% 
  select(subject, activity, set, V1:V561)

# Merge the train dataset files
subject_train <- tbl_df(subject_train)
X_train <- tbl_df(X_train)
Y_train <- tbl_df(Y_train)

train_data <- X_train %>% 
  mutate(subject = as.numeric(subject_train$V1), activity = as.numeric(Y_train$V1), set = "train") %>% 
  select(subject, activity, set, V1:V561)

# Combined data set
combined_data <- bind_rows(test_data, train_data)
print("1. Merged training and the test sets: ")
cat("\n")
print(combined_data)
cat("\n")
print("*********************************")
cat("\n\n\n")

# free up memory
rm("subject_test", "X_test", "Y_test", "subject_train", "X_train", "Y_train", "test_data", "train_data")

## End of 1.



## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#
#
# To achieve the above, script will do the following:
#
# 1, Rename all the coloumns of the combined dataset "combined_data" with actual names from "features.txt"
# 2. Select on the coloumns which have in their name "means()" and "std()"

# Read data from "features.txt"
features <- read.table("proj_data/features.txt")

features <- tbl_df(features)

# mutating to make sure duplicate coloumn names don't create any issue
features <- features %>% 
  mutate(cnames = paste(as.character(V1),as.character(V2),sep = "_"), V1 = NULL, V2 = NULL)

col_name_vector <- c("subject", "activity", "set", as.character(features$cnames))

#renaming the combined dataset
colnames(combined_data) <- col_name_vector

# subsetting only the measurements on the mean and standard deviation for each measurement
combined_data <- combined_data %>% 
  select(1:3, contains("mean()"), contains("std()"))
  
print("2. Extracted only the measurements on the mean and standard deviation for each measurement")
cat("\n")
print(combined_data)
cat("\n")
print("*********************************")
cat("\n\n\n")

# free up memory
rm("features", "col_name_vector")


## End of 2. 


## 3. Uses descriptive activity names to name the activities in the data set
#
#
# To achieve the above, script will do the following:
#
# 1. Read descriptive activity names from "activity_labels.txt"
# 2. Mutate the the combined data set's activity coloumn with values from activity_labels.txt

# Read the "activity_labels.txt"
activity_ds <- read.table("proj_data/activity_labels.txt")

combined_data <- combined_data %>% 
  mutate(activity = as.character(activity_ds$V2[as.numeric(activity)]))

print("3. Uses descriptive activity names to name the activities in the data set")
cat("\n")
print(combined_data)
cat("\n")
print("*********************************")
cat("\n\n\n")

# free up memory
rm("activity_ds")


## End of 3.



## 4. Appropriately labels the data set with descriptive variable names.
#
#
# To achieve the above, script will use the "stringr" package to rename the variables.
#
# Variables names like like "350_fBodyAccJerk-std()-Z" to "freqDomainSignal_BodyAccJerk_standardDeviation_Z_axis"
# and column names like "201_tBodyAccMag-mean()" to "time_BodyAccMag_mean" to make it more readable

library(stringr)

# vector of column names 
cnames <- names(combined_data)


# rename column names like "350_fBodyAccJerk-std()-Z" to "frequency_BodyAccJerk_standardDeviation_Z_axis"
# and column names like "201_tBodyAccMag-mean()" to "time_BodyAccMag_mean"
pattern <- "(\\d{1,3})_(t|f)(\\w+)(-)(\\w+)(\\(\\))-?(X|Y|Z)?"

cnames <- str_replace_all(cnames, pattern, "\\2_\\3_\\5_\\7")
cnames <- str_replace_all(cnames, "(.*)(_$)", "\\1")
cnames <- str_replace_all(cnames, "(.*_)([X|Y|Z])", "\\1\\2_axis")
cnames <- str_replace_all(cnames, "^(t)(_.*)$", "time\\2")
cnames <- str_replace_all(cnames, "^(f)(_.*)$", "frequency\\2")
cnames <- str_replace_all(cnames, "^(.*_)(std)(.*)?$", "\\1standardDeviation\\3")
cnames <- str_replace_all(cnames, "(.*)(BodyBody)(.*)", "\\1Body\\3")
cnames <- str_replace_all(cnames, "(.*)(Acc)(.*)", "\\1Acceleration\\3")
cnames <- str_replace_all(cnames, "(.*)(Gyro)(.*)", "\\1Gyroscope\\3")
cnames <- str_replace_all(cnames, "(.*)(Mag)(.*)", "\\1Magnitude\\3")


cnames <- str_replace(cnames, "subject", "subject_id")
cnames <- str_replace(cnames, "activity", "activity_name")
cnames <- str_replace(cnames, "set", "data_set_name")

#renaming the columns of combined dataset with only mean and standard deviation measures 
colnames(combined_data) <- cnames

print("4. Appropriately labels the data set with descriptive variable names.")
cat("\n")
print(combined_data)
cat("\n")
print("*********************************")
cat("\n\n\n")

# free up memory
rm("cnames")

## End of 4



## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#     for each activity and each subject.
#
#
# To achieve the above, script will ... .
#
# 

tidy <- combined_data

tidy <- tidy %>% 
  group_by(subject_id,activity_name,data_set_name) %>%
  summarise_each(funs(mean))

# create txt file of table data.
write.table(tidy, file="tidy_data.txt", row.names = FALSE) 

print("5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.")
cat("\n")
print(tidy)
cat("\n")
print("*********************************")
cat("\n\n\n")

# free up memory


## End of 5