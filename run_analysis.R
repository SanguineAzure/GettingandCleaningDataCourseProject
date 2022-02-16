# Getting and Cleaning Data Course Project
# Taylor Lange
# February 15, 2022

#Create an R script that:
# (1) Merges the training and the test sets to create one data set.
# (2) Extracts only the measurements on the mean and standard deviation 
#     for each measurement. 
# (3) Uses descriptive activity names to name the activities in the data set
# (4) Appropriately labels the data set with descriptive variable names. 
# (5) From the data set in step 4, creates a second, independent tidy data set 
#     with the average of each variable for each activity and each subject.

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# load required packages
  require("data.table")
  require("dplyr")
  require("tidyr")

# Set the working directory
  setwd("C:/Users/Taylor/Documents/R/GettingandCleaningDataCourseProject/")

# Load features and activity labels
  features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
  activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
  
# Load test data and training data
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
  
# (1) Combine the training data with the test data, combine the training labels with test 
# labels
  x <- rbind(x_train, x_test)
  y <- rbind(y_train, y_test)
  subject <- rbind(subject_train, subject_test)
  merged <- cbind(subject, y, x)
  
# (2) Extract mean and standard deviation only
  data <- merged %>% select(subject, code, contains("mean"), contains("std"))
  
# (3) Assign the activity labels
  data$code <- activities[data$code, 2]
  
# (4) Assign descriptive variable names
  names(data)[2] = "activity"
  names(data) <- gsub("Acc", "Accelerometer", names(data))
  names(data) <- gsub("Gyro", "Gyroscope", names(data))
  names(data) <- gsub("BodyBody", "Body", names(data))
  names(data) <- gsub("Mag", "Magnitude", names(data))
  names(data) <- gsub("^t", "Time", names(data))
  names(data) <- gsub("^f", "Frequency", names(data))
  names(data )<- gsub("tBody", "TimeBody", names(data))
  names(data) <- gsub("-mean()", "Mean", names(data), ignore.case = TRUE)
  names(data) <- gsub("-std()", "STD", names(data), ignore.case = TRUE)
  names(data) <- gsub("-freq()", "Frequency", names(data), ignore.case = TRUE)
  names(data) <- gsub("angle", "Angle", names(data))
  names(data) <- gsub("gravity", "Gravity", names(data))
  
# (5) Make a final tidy dataset with the average of each variable for each activity 
# and each subject
  finaldata <- data %>%
    group_by (subject, activity) %>%
    summarise_all (funs(mean))
  
# Create and save the grouped final tidy dataset into a txt file!
  write.table (finaldata, "finaldata.txt", row.name=FALSE)