# Getting And Cleaning Data Project CodeBook

## Introduction
The base dataset is obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The description to the base dataset can be obtained at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

After the running run_analysis.R, two cleaned data sets will be created in the global environment. 
- The mergedDataSet contains the cleaned merged data set.
- The summerisedDataSet contains the mean of the mergedDataSet group by the suject and the activity

## MergedDataSet

###Transformation
The following transformation has been applied to obtain this dataset
1. The fieldnames taken from the "features.txt" is cleaned (remove "(" and ")") and applied to the dataset.
2. The training and test dataset have been merged to indicate both the SubjectId and ActivityId.
3. The resulting training and test dataset are then merged to a single dataset.
4. Only SubjectId, ActivityId and columns that contains either a mean or a standard deviation are kept.
5. The resulting dataset is then merged with the data from "activity_labels.txt" to obtain the activity names.

###Variables

####Subject
- SubjectId (Subject labelled 1-30)

####Activity
- ActivityId (Activity lablled 1-6)
- ActivityName (Corresponding activity name)

####Measurements
- Measurements are labelled in a fixed format "(measurement type)-(mean/std)-(Axis if applicable)"
- For example "tBodyAcc-std-Z", indicates that the measurement is of a standardDeviation of the tBodyAcc in the Z axis.

## SummerisedDataSet

###Transformation
The following transformation has been applied to the mergedDataSet to obtain this dataset
1. Group by SubjectId, ActivityId and ActivityName.
2. Summerise the table by taking the mean for each grouping of SubjectId, ActivityId and ActivityName.
3. Order the data by SubjectId and ActivityId.
 
###Variables

####Subject
- SubjectId (Subject labelled 1-30)

####Activity
- ActivityId (Activity lablled 1-6)
- ActivityName (Corresponding activity name)

####Measurements
- Measures are all means of the labelled measurements grouped by the subject and activity.
- Measurements are labelled in a fixed format "(measurement type)-(mean/std)-(Axis if applicable)"
- For example "tBodyAcc-std-Z", indicates that the measurement is of a mean of the standardDeviation of the tBodyAcc in the Z axis for a given subject and actitvity.
