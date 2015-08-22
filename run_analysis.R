## 1st task: Merging the training and the test sets to create one data set.
##plus 4th task: Appropriately labels the data set with descriptive variable names.

train<-read.table("UCI HAR Dataset/train/X_train.txt")
#dim(train)
#gives: 7352  561
test<-read.table("UCI HAR Dataset/test/X_test.txt")
## dim(test)
##gives: 2947  561

##extraction of the subjects, both of train set and test set
subtrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
subtest<-read.table("UCI HAR Dataset/test/subject_test.txt")

## extraction of the correspondent activities per measurement, 
##both of train set and test set
acttrain<-read.table("UCI HAR Dataset/train/y_train.txt")
acttest<-read.table("UCI HAR Dataset/test/y_test.txt")

##attachment of correspondent subjects' ids and activity labels 
datatrain<-cbind(subtrain,acttrain, train)
datatest<-cbind(subtest,acttest, test)

##read name of variables and transform them into a character vector.
varnames<-read.table("UCI HAR Dataset/features.txt")
names<-as.character(varnames[,"V2"]) 

##assign the character vector just read above to the columns 3rd-563rd, 
##while first two columns will be Subject and Activity.
colnames(datatrain)<-c("Subject", "Activity", names)
colnames(datatest)<-c("Subject", "Activity", names)

##Merging of dataset regarding the test subjects, called datatest, 
##and the dataset regarding the train subjects, called datatrain.
exper<-rbind(datatest,datatrain)


##2nd task: Extract only the measurements on the mean and standard 
##deviation for each measurement. 

##First I find the position of variables that regard mean and std, 
##using the function grep, that will look for the word mean, regardless the case, 
##throughout the vector names.
namerelvar<-grep("mean", names, ignore.case = TRUE)
stdrelvar<-grep("std", names, ignore.case = TRUE)

meanvar<-names[namerelvar]
stdvar<-names[stdrelvar]

##variables names we're interested in, regarding mean and std
interpos<-c(namerelvar, stdrelvar) ##their position
internames<-c(meanvar, stdvar)   ##the actual character vector with variable
##names regarding mean and std plus subject ids and activity labels.

##the following dataset, called experim, is an extraction of the previous, exper, 
##with only the variables regarding mean and standard deviation.
experim=exper[,internames]
experim=cbind(exper[,c(1,2)], experim)  
##3rd task: Use descriptive activity names to name the activities in the data set
actlabels<-read.table("activity_labels.txt") #read the activity labels file
actnames<-factor(actlabels[,2], levels=c("WALKING", 
      "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
#I create a factor with the second column of the dataframe actlabels above created, giving
##as labels the order in which they are given in the actlabels dataframe.

colactlab=experim[,2] #the column of experim I want to substitute
##I create the substitute column, made of character
subcol=as.character(actnames[colactlab])

experim=mutate(experim, Activity=subcol)

 
##5th task:From the data set in step 4, 
##create a second, independent tidy data set with the 
##average of each variable for each activity and each subject.

means3<-tapply(experim[,3], list(experim$Subject, experim$Activity), mean)
means3=data.frame(means3)
means3=mutate(means3, Subject=1:30, Measure=rep(internames[1], 30))
means=means3
means=rename(means, MEAN_WHILE_LAYING=LAYING, MEAN_WHILE_SITTING=SITTING, 
             MEAN_WHILE_STANDING=STANDING, MEAN_WHILE_WALKING_DOWNSTAIRS=WALKING_DOWNSTAIRS, 
             MEAN_WHILE_WALKING=WALKING, MEAN_WHILE_WALKING_UPSTAIRS=WALKING_UPSTAIRS)
##for each measure regarding the mean or the standard deviation I use tapply, subdividing
##considering the Subject and the Activity.
for(j in 4:88){
newmeans<-tapply(experim[,j], list(experim$Subject, experim$Activity), mean)
newmeans=data.frame(newmeans)
newmeans=mutate(newmeans, Subject=1:30, Measure=rep(internames[(j-2)], 30))
##change names of columns to specify I am not giving a single measurament during an activity, 
##but the mean of many measurements during that activity.
newmeans=rename(newmeans, MEAN_WHILE_LAYING=LAYING, MEAN_WHILE_SITTING=SITTING, 
               MEAN_WHILE_STANDING=STANDING, MEAN_WHILE_WALKING_DOWNSTAIRS=WALKING_DOWNSTAIRS, 
               MEAN_WHILE_WALKING=WALKING, MEAN_WHILE_WALKING_UPSTAIRS=WALKING_UPSTAIRS)
means<-rbind(means, newmeans)

##reorder the all matrix so that the 
##same subject has all the means related to him close.
means=arrange(means, Subject)
}

##this is the final tidy dataset.
means<-means[,c(7,8,1:6)]
