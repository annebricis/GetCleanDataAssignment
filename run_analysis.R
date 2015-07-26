## Getting and cleaning data - Assignment week 3
## =============================================
## Assumes the following dataset has been downloaded and unzipped:
##      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Merge the training and the test sets to create one data set
## -----------------------------------------------------------
subject<-rbind(read.table("UCI HAR Dataset\\test\\subject_test.txt"), read.table("UCI HAR Dataset\\train\\subject_train.txt"))
Xvalues<-rbind(read.table("UCI HAR Dataset\\test\\X_test.txt"), read.table("UCI HAR Dataset\\train\\X_train.txt"))
yvalues<-rbind(read.table("UCI HAR Dataset\\test\\y_test.txt"), read.table("UCI HAR Dataset\\train\\y_train.txt"))


## Extract only the measurements on the mean and standard deviation for each measurement. 
features<-read.table("UCI HAR Dataset\\features.txt")
msdi<-c(grep("mean", features$V2), grep("std", features$V2))
Xmsd<-Xvalues[,msdi]


## Use descriptive activity names to name the activities in the data set
al<-read.table("UCI HAR Dataset\\activity_labels.txt")
yvalues$terms<-al$V2[yvalues$V1]


## Appropriately label the data set with descriptive variable names. 
msd<-c(grep("mean", features$V2, value=TRUE), grep("std", features$V2, value=TRUE))
names(Xmsd)<-msd


## combine the dataset into one data frame
newSet<-data.frame("subject"=subject$V1, "activities"=yvalues$terms, Xmsd)


## From the data set in step 4, creates a second, independent tidy data set with the average of 
##      each variable for each activity and each subject.
library(plyr)
tidy<-ddply(newSet[,3:ncol(newSet)], .(newSet$subject, newSet$activities), colMeans)
write.table(tidy, file="tidy.txt", row.name=FALSE)
