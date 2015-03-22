## create one R script called run_analysis.R that does the following
> ## merges the training and test sets to create one data set
  > ## extracts only the measurements on the mean and standard deviation for each measurement
  > ## uses descriptive activity names to name the activities in the data set
  > ## appropriately label the data set with descriptive variable names
  > ## from the data set in step 4, creates a second, independently tidy data set with the average of each variable for each activity and each subject
  > ## write.table(), using row.name=FALSE
  library(dplyr)
library (data.table)
## load test data
test1<-read.table(file = "test/X_test.txt", header = FALSE)
## label columns with data from gyroscope
namestest <- read.table( file = "features.txt")
names(test1) <- namestest$V2
## add a column for the subjets
subj_test <- read.table(file ="test/subject_test.txt", header = FALSE)
data_subj_test <- cbind(subj_test, test1)
names(data_subj_test)[1] <- "subject"
#add activity information for test
activity <-read.table(file = "test/y_test.txt")
testdata <- cbind(activity, data_subj_test)
## repeat all of above steps for training data
train1 <- read.table(file = "train/X_train.txt", header = FALSE)
namestest2 <- read.table ( file = "features.txt")
names(train1) <- namestest2$V2
subj_train <- read.table(file = "train/subject_train.txt", header = FALSE)
data_subj_train <- cbind(subj_train, train1)
names(data_subj_train)[1] <- "subject"
activity2 <-read.table(file = "train/y_train.txt")
traindata <- cbind(activity2, data_subj_train)
## combine data for  training and testing into one data table
binddata <- rbind(testdata, traindata)
## remove invalid characters from names
names(binddata) <- make.names(names(binddata), unique = TRUE)
## select out data for mean and standard deviation only
bind_mn <- select(binddata, V1, subject, contains ("mean"), contains("std"))
## start labeling activity
## load in activity labels
activitylabel <- read.table(file = "activity_labels.txt")
merge2 <- merge(bind_mn, activitylabel)
## label activty in data frame
merged2 <- rename( merge2,ActCat=V1, Activity= V2)
merged3 <- select(merged2, -ActCat)
## arrange data so that the data is grouped by subject and then activity, with the 
## data arranged in either a measurement of value column
mergegroup <-gather(merged3, measurement, value, -subject, -Activity)
sortmerge <- arrange(mergegroup, subject, Activity, measurement)
groupmerge <- group_by(sortmerge, subject, Activity, measurement)
## Lastly, the data was summarised resulting in a mean value for all the measurments 
## called avg.  This results in a narrow data table (4 variables with 15,480 obs)
sumgroup <- summarise (groupmerge, avg=mean(value))
## convert to text file using write.table
sumgrouptxt <- write.table(sumgroup, file = "sumgrouptxt", row.name=FALSE)
