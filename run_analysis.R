#packages plyr and dplyr are required. 


#read datasets into R. The UCI HAR Dataset folder needs to be already loaded
#into the working directory 

test_set<-read.table("./UCI HAR Dataset/test/X_test.txt")
test_labels<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
training_set<-read.table("./UCI HAR Dataset/train/x_train.txt")
training_labels<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
features<-read.table("./UCI HAR Dataset/features.txt")

#Step 1. 
#merge test and training sets to create on data set
dataset<-rbind(test_set, training_set)
#rename the column names using list of features. 
colnames(dataset)<-as.character(features[[2]])

#Step 2. 
#extract the measurements on the mean for each measurement
subset_mean<-dataset[,grep("-mean()",colnames(dataset),fixed=TRUE)]
#extract the measurements on standard deviation for each measurement
subset_std<-dataset[,grep("-std()",colnames(dataset),fixed=TRUE)]
# combine the two subsets and add subjects and activity lables. 
subjects<-rbind(subject_test,subject_train)
colnames(subjects)<-"subject"
activity<-rbind(test_labels,training_labels)
colnames(activity)<-"activity"
subset<-cbind(subjects,activity,subset_mean,subset_std) 

# Step 3. 
#Uses descriptive activity names to name the activities in the data set
subset$activity<-factor(subset$activity,level=1:6,labels=activity_labels[[2]])

#Step 4. 
#Appropriately labels the data set with descriptive variable names
#t means time domain
colnames(susbset)<-gsub("^t","SignalFromTimeDomain",colnames(subset))
colnames(subset)<-gsub("^f","SignalFromFrequencyDomain",colnames(subset))
colnames(subset)<-gsub("Acc","Accelerometer",colnames(subset))
colnames(subset)<-gsub("Gyro","Gyroscope",colnames(subset))
colnames(subset)<-gsub("Mag","Magnitude",colnames(subset))
colnames(subset)<-gsub("std","standard deviation",colnames(subset))
colnames(subset)<-gsub("mean","mean value",colnames(subset))
colnames(subset)<-gsub("-X","-in X direction",colnames(subset),fixed=TRUE)
colnames(subset)<-gsub("-Y","-in Y direction",colnames(subset),fixed=TRUE)
colnames(subset)<-gsub("-Z","-in Z direction",colnames(subset),fixed=TRUE)

#Step 5
#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.
library(plyr)
library(dplyr)
subset2<-summarise_each(group_by(subset, subject, activity),funs(mean))
View(subset2)
