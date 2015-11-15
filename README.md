# Read Me

##Running the script
1. Place the `run_analysis.R` file in your project working directory
2. Use the command line `source("run_analysis.R")` in R
 
##Result
- Two datasets will be created in the global environment. 
- `mergedDataSet` is the cleaned dataset (not summerised)
- `summerizedDataSet` is the cleaned and summerised by getting mean for all measurements grouped by subject and activity
 
##Functions
- `downloadUCIDataSet` downloads the zip and unzips the base data files if it has not been downloaded or unzipped
- `getMeasurementNames` gets the meansurement names from the `features.txt` file
- `generateTestMergedSet` merges the subject_test.txt, Y_test.txt, X_test.txt in to a single dataset with the relevant labels.
- `generateTrainMergedSet` merges the subject_train.txt, Y_train.txt, X_train.txt in to a single dataset with the relevant labels.
- `generetedMergedDataSet` runs `downloadUCIDataSet`, `getMeasurementNames`, `generateTestMergedSet`, `generateTrainMergedSet` in that order before merging the resulting test and train dataset set into a single dataset.
- `extractMeasurements` extracts the only the mean and standard deviation measurements
- `getActivityName` add an `ActivityName` column with the corresponding activity anme
- `cleanColumnNam` cleans the column by remove all `(` and `)` from the column name
- `getSummerisedDataSet` create a table by taking the mean of all measurements group by subject and activity
