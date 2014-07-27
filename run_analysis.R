##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

setwd("C:/Users/bernidunne/Coursera/Getting_Data")
if(!file.exists("data")){
  dir.create("data")
}

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data/project.zip")
list.files("./data")
dateDownloaded <- date()
dateDownloaded

unzip("./data/project.zip", list=T)

#read in training & test data files
training_data <- read.table("./UCI HAR Dataset/train/X_train.txt", sep="")
testing_data <- read.table("./UCI HAR Dataset/test/X_test.txt", sep="")

#join the datasets
all_data <- rbind (training_data,testing_data)



#load test subjects
training_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep="")
testing_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep="")

all_subjects <- rbind (training_sub,testing_sub)
names(all_subjects)[1] <- "subjects"



#read in training & test activity files
training_act <- read.table("./UCI HAR Dataset/train/Y_train.txt", sep="")
testing_act <- read.table("./UCI HAR Dataset/test/Y_test.txt", sep="")

all_activity <- rbind (training_act,testing_act)
names(all_activity)[1] <- "activity"


#Load features.txt, subset to find columns containing only mean and std dev
#
#mean(): Mean value
#std(): Standard deviation
#
features <- read.table("./UCI HAR Dataset/features.txt", sep="")
features_selected <- features[grepl("mean\\(\\)|std\\(\\)",features$V2),]

col_vector <- features_selected[,"V1"]
data_mean_std <- all_data[, col_vector]

col_names <- features_selected[,"V2"]
names(data_mean_std) <- col_names

#join the tables for subjects, activities, and data points
full_file <- cbind(all_subjects,all_activity,data_mean_std)


#load activity labels 
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep="")


full_file$activity <- factor(full_file$activity, levels = activity_labels$V1, labels = activity_labels$V2)



#####################################################
#Average each activity for each person

#tapply(full_file$subject,"full_file$tBodyAcc-mean()-X",mean)

str(full_file)
full_file_ordered <- full_file[order(full_file$subjects,full_file$activity),]


attach(full_file_ordered)
aggdata <-aggregate(full_file_ordered[3:68], by=list(subjects,activity),FUN=mean, na.rm=TRUE)
head(aggdata)
detach(full_file_ordered)


write.table(aggdata, "./AvgValuesBySubject.txt", sep="\t")
