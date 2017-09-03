setwd ("C:\\Users\\Bee\\Documents\\Coursera\\01_Data_Science\\03_Getting_and_Cleaning_Data\\02_Assignments\\01_Data")

# 1. Merges the training and the test sets to create one data set.
#Read Fearures files
x1<- read.table("train/X_train.txt")
x2 <- read.table("test/X_test.txt")

#Read the Subject files
sub1 <- read.table("train/subject_train.txt")
sub2 <- read.table("test/subject_test.txt")

#Read the Activity files
y1 <- read.table("train/y_train.txt")
y2 <- read.table("test/y_test.txt")

#Concatenate the data tables by rows
dataFeatures<- rbind(x1, x2)
dataSubject <- rbind(sub1, sub2)
dataActivity <- rbind(y1, y2)

#set names to variables (original dataset has no column names)
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table("features.txt")
names(dataFeatures)<-dataFeaturesNames$V2

#Merge columns to get the data frame Data for all data
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures,dataCombine)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#Subset Name of Features by measurements on the mean and standard deviation
#i.e taken Names of Features with "mean()" or "std()"
subdataFeaturesNames <-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

#Subset the data frame "Data" by seleted names of Features
selectedNames <-c(as.character(subdataFeaturesNames),"subject","activity")
selectedNames
Data2 <- subset(Data, select = selectedNames)

# 3. Uses descriptive activity names to name the activities in the data set.
#Read descriptive activity names from "activity_labels.txt"
activityLabels <- read.table ("activity_labels.txt")

#facorize Variale activity in the data frame Data using descriptive activity names
Data2$activity <- activityLabels[Data2$activity, 2]

#check
head(Data2$activity,30)

# 4. Appropriately labels the data set with descriptive activity names.
names(Data2)<-gsub("^t", "time", names(Data2))
names(Data2)<-gsub("^f", "frequency", names(Data2))
names(Data2)<-gsub("Acc", "Accelerometer", names(Data2))
names(Data2)<-gsub("Gyro", "Gyroscope", names(Data2))
names(Data2)<-gsub("Mag", "Magnitude", names(Dat2a))
names(Data2)<-gsub("BodyBody", "Body", names(Data2))
#check
names(Data2)

# 5. Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
library(plyr)
Data3 <- aggregate(. ~subject + activity, Data2, mean)
Data3<-Data3[order(Data3$subject,Data3$activity),]
write.table(Data3, file = "tidydata.txt",row.name=FALSE)


https://rstudio-pubs-static.s3.amazonaws.com/37290_8e5a126a3a044b95881ae8df530da583.html