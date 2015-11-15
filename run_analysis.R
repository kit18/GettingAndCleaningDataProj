## Script to run 
library(dplyr)

##1. Merges the training and the test sets to create one data set.


  #Function to download and unzip dataset from website
  downloadUCIDataSet<-function(){
    if(!file.exists("dataset.zip")){
      download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip", mode = "wb")
    }
    
    if(!file.exists("UCI HAR Dataset")){
      unzip("dataset.zip")
    }
  }
  
  
  #Function to retrieve header names for measurements
  getMeasurementNames<-function(){
    measureHeader <- read.table("UCI HAR Dataset/features.txt")
    colnames(measureHeader) <- c("Index","MeasuremeantName")
    measureHeader<-gsub("[()]","", measureHeader$MeasuremeantName)
    measureHeader<-gsub(",","-", measureHeader)
    measureHeader
  }
  
  
  #Function to generate merged test dataset
  generateTestMergedSet<-function(measureHeader){
    subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
    colnames(subject_test) <- "SubjectId"
    
    activity_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
    colnames(activity_test) <- "ActivityId"
    
    measurements_test <- read.table("UCI HAR Dataset/test/X_test.txt")
    colnames(measurements_test) <- measureHeader
    
    testfull <- cbind(subject_test, activity_test,measurements_test)
    rm(subject_test)
    rm(activity_test)
    rm(measurements_test)
    
    testfull
  }
  
  #Function to generate merged train dataset
  generateTrainMergedSet<-function(measureHeader){
    subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
    colnames(subject_train) <- "SubjectId"
    
    activity_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
    colnames(activity_train) <- "ActivityId"
    
    measurements_train <- read.table("UCI HAR Dataset/train/X_train.txt")
    colnames(measurements_train) <- measureHeader
    
    trainfull <- cbind(subject_train, activity_train,measurements_train)
    rm(subject_train)
    rm(activity_train)
    rm(measurements_train)
    
    trainfull
  }

  #Function to generate merged ataset
  generetedMergedDataSet<-function(){
    downloadUCIDataSet()
    measureHeader<- getMeasurementNames()
    testfull <- generateTestMergedSet(measureHeader)
    trainfull<-generateTrainMergedSet(measureHeader)
    rm(measureHeader)
    
    mergedDataSet <- rbind(testfull, trainfull)
    
    rm(testfull)
    rm(trainfull)
    
    mergedDataSet
  }
  


##2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  
  #Function to extract mean and std measurements
  extractMeasurements <- function(mergedDataSet){
    #Remove duplicated band energy columns
    mergedDataSet <- mergedDataSet[ , !duplicated(colnames(mergedDataSet))]
    
    #Select required columns together with subjectId and activityID
    mergedDataSet <- mergedDataSet  %>%
      select(SubjectId, ActivityId, contains("mean"), contains("std")) %>%
      arrange(SubjectId, ActivityId)
    
    mergedDataSet
  }
  
  
##3. Uses descriptive activity names to name the activities in the data set
  
  #Function retrieve activity names
  getActivityName <- function(mergedDataSet){
    activities <- read.table("UCI HAR Dataset/activity_labels.txt")
    colnames(activities) <- c("ActivityId", "ActivityName")
    
    mergedDataSet<-merge(x=mergedDataSet, y=activities, by = "ActivityId", all.x = T)
    rm(activities)
    
    mergedDataSet
  }
  
  
##4. Appropriately labels the data set with descriptive variable names. 
  
  #Namees have already been cleaned  as data was loaded.
  
  
##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  #Function retrieve activity names
  getSummerisedDataSet <- function(mergedDataSet){
    summerisedDS <- mergedDataSet %>%
      group_by(SubjectId, ActivityId, ActivityName) %>%
      summarise_each(funs(mean)) %>%
      arrange(SubjectId, ActivityId)
    summerisedDS
  }
  
#Script
mergedDataSet <- generetedMergedDataSet()
mergedDataSet <- extractMeasurements(mergedDataSet)
mergedDataSet <- getActivityName(mergedDataSet)

summerizedDataSet <- getSummerisedDataSet(mergedDataSet)
write.table(summerizedDataSet, row.names = F, file = "SummerizedOutput.txt")