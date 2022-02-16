Code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md

The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

Getting and Cleaning Data Course Project
Taylor Lange
February 15, 2022

Create an R script that:
(1) Merges the training and the test sets to create one data set.
(2) Extracts only the measurements on the mean and standard deviation for each measurement. 
(3) Uses descriptive activity names to name the activities in the data set
(4) Appropriately labels the data set with descriptive variable names. 
(5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

LOAD THE REQUIRED PACKAGES
Requires data.table, dplyr, and tidyr packages

SET THE WORKING DIRECTORY AND DOWNLOAD ZIPPED DATA
Dataset downloaded and extracted under the folder called "UCI HAR Dataset""

ASSIGN DATA TO VARIABLES
features <- features.txt 

activities <- activity_labels.txt
List of activities performed when measurements were taken and the codes/labels for each activity

subject_test <- test/subject_test.txt
contains the test data of the volunteer test subjects

x_test <- test/X_test.txt
contains the test data

y_test <- test/y_test.txt
contains the activity code labels for the test data

subject_train <- test/subject_train.txt
contains the training from volunteer subjects 

x_train <- test/X_train.txt 
contains training data

y_train <- test/y_train.txt : 7352 rows, 1 columns
contains the activity code labels for the training data


MERGE THE TRAINING AND TEST DATASETS INTO ONE LARGE DATASET
x created by merging x_train and x_test using rbind() function
y created by merging y_train and y_test using rbind() function
subject created by merging subject_train and subject_test using rbind() function
merged created by merging subject, y and x using cbind() function


EXTRACTS ONLY THE MEAN AND STANDARD DEVIATION FROM THE DATA SET
data is created from the merged dataset by selecting only the following columns: subject, code, mean and the standard deviation (std) for each measurement

USES DESCRIPTIVE ACTIVITY LABELS FOR EACH ACTIVITY
The numbers in the code column of the data is replaced with the appropriate activity label taken from the second column of the activities variable created earlier

LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
code column in data renamed into activity labels
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Grouped the data by subject and activty
finaldata is then created by summarizing data by taking the means of each variable in each activity and  subject


Export finaldata into finaldata.txt file.