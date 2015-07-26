Code book for Getting and Cleaning Data - Assignment week 3 (24th July 2015)
===========================================================

The source data is a zipped file located here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The file was downloaded and unzipped to create the resulting folder "UCI HAR Dataset" containing serveral text files (.txt) and further folders.

Only the following files were used:
- activity_labels: reference for activities undertaken (1 = WALKING, 2 = WALING_UPSTAIRS...)
- features: full list of variables (561 in total)
- subject_test and subject_train: reference id for each of the 30 subjects
- X_test and X_train: variable measurements for each subject performing each activity
- y_test and y_train: activities for each subject

To create the "tidy" dataset, the following activities were undertaken:

1. the files above were loaded into data frames "al", "features", "subject", "Xvalues" and "yvalues" respectively, merging "..._test" and "..._train" as appropriate

2. "features" was used to identify which variables were means or standard deviations, and arrays of the names and locations of these variables were created ("msd" and "msdi" respectively)

3. a new data frame "Xmsd" was created as a duplicate of "Xvalues" but containing only the variables identified as means or standard deviations; the column names were updated accordingly

4. a new data frame "newSet" was then created as a duplicate of "Xmsd" but additionally included the subject id and activity name

5. the average of each variable for each activity and each subject was calculated and the results were output to a text file "tidy"