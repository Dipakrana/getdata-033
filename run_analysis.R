
##Create the working directory
dir.exists("GETDATA033")
{
print("Good to see that you already have GETDATA033 folder")
}
else 
{
  print("Please don't mind. I am creating one directory GETDATA033. ")
  dir.create("GETDATA033")
}

#getwd()
#setwd("..")


print("Files are downloaded and unzipped ")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "./GETDATA033/getdata_projectfiles_UCI_HAR_Dataset.zip")

unzip("./GETDATA033/getdata_projectfiles_UCI_HAR_Dataset.zip",exdir = "./GETDATA033")


#read all the file into separate dataframes

#list.files("./GETDATA033/UCI HAR Dataset/test")
#list.files("./GETDATA033/UCI HAR Dataset/train")
#list.files("./GETDATA033/UCI HAR Dataset")

features<-read.table("./GETDATA033/UCI HAR Dataset/features.txt")
activity_labels<-read.table("./GETDATA033/UCI HAR Dataset/activity_labels.txt")

##Test
X_test<- read.table("./GETDATA033/UCI HAR Dataset/test/X_test.txt",fill=TRUE)
subject_test<-read.table("./GETDATA033/UCI HAR Dataset/test/subject_test.txt")
y_test<-read.table("./GETDATA033/UCI HAR Dataset/test/y_test.txt")

#Uses descriptive activity names to name the activities in the data set.
y_test_final<-merge(y_test,activity_labels,by="V1")

#Variable names are set as per available details in the features file.
colnames(X_test)<-as.vector(features$V2)
colnames(y_test_final) <- c("activity_ID","activity_labels")
colnames(subject_test)<-c("subject_test")

X_test_final<-cbind(subject_test,y_test_final,X_test)

#head(X_train_final[,1:10])

#str(y_test)
#str(subject_test)
#str(X_train)


##Train
X_train<- read.table("./GETDATA033/UCI HAR Dataset/train/X_train.txt",fill=TRUE)
subject_train<-read.table("./GETDATA033/UCI HAR Dataset/train/subject_train.txt")
y_train<-read.table("./GETDATA033/UCI HAR Dataset/train/y_train.txt")

#Uses descriptive activity names to name the activities in the data set.
y_train_final<-merge(y_train,activity_labels,by="V1")

#Variable names are set as per available details in the features file.
colnames(X_train)<-as.vector(features$V2)
colnames(y_train_final) <- c("activity_ID","activity_labels")
colnames(subject_train)<-c("subject_test")

X_train_final<-cbind(subject_train,y_train_final,X_train)

#head(X_train_final[,564])


##Merge Test and Trainning data.
X_Final<-rbind(X_train_final,X_test_final)

#colnames(head(X_Final[,564]))
#features$V2

## Fetch the final list of columns for meand and STD.
Final_Col_list<-grep("subject_test|activity_labels|mean\\(|std\\(",colnames(X_Final))

All_mean_std_<-X_Final[,Final_Col_list]


##Aggregate teh data to get the mean for each variables by Subject and activity
aggdata <-aggregate(All_mean_std_, by=list(All_mean_std_$subject_test,All_mean_std_$activity_labels), 
                    FUN=mean, na.rm=TRUE)

aggdata<-aggdata[ ,-c(3:4)]

colnames(aggdata)[1]<-c("Subject")
colnames(aggdata)[2]<-c("Activity")


##Orderng teh data to make it good looking.
aggdata <- aggdata [order(aggdata$Subject,aggdata$Activity),]

#Final out put file
write.table(aggdata,file ="./GETDATA033/UCI HAR Dataset/getdata-033.txt" , row.name=FALSE )

#Raw data for any future analysis.
write.table(All_mean_std_,file ="./GETDATA033/UCI HAR Dataset/getdata-033_All_mean_std.txt" , sep = " " , row.name=FALSE )


##Done








