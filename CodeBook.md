Please, in order to run the program, make sure your working directory is the one containing UCI HAR Dataset.

Here is my procedure:
First of all I extracted the file named X_train and X_test, respectively in the directories train and test, creating two separate datasets.
Then I extracted the names of the subjects for each measurement, both of train set and test set, form the .txt files subject_train.txt and subject_test.txt .
Afterwards I extracted the correspondent activities per measurement, both of train set and test set, stored in the files y_train.txt and y_test.txt.
I then attached the correspondent subjects' ids and activity labels on the two datasets separately with the command cbind().

In the features.txt file I read the names of the variables and transformed them into a character vector, called names. 

(already step 4) I assigned the character vector just read above to the columns 3rd-563rd, 
while first two columns were named Subject and Activity.

(step 1) I could then merge the two datasets in a dataset called exper.

(step 2): In order to extract only the measurements on the mean and standard deviation for each measurement, first I found the position of variables that regard mean and std, using the function grep, that will look for the word mean, regardless the case, throughout the vector names.
I did so because I wanted to include even those measurement that computed the angle over mean quantities, such as "angle(X,gravityMean)" and "meanFreq()" measurements. The variables found were 86.
Then it sufficed to restrict the vector names to the positions found with grep.

Then I created another dataset experim, extracting from the previous, exper, with as columns only the variables regarding mean and standard deviation, apart from the subject ids and the activity labels.

(step 3) In order to have descriptive activity names to name the activities in the data set, I read the labels 
of the activities from the file activity_labels.txt and then created a factor, called actnames, with levels ordered as the activities' labels.
I then mutate the dataset experim with, instead of the activity labels' column, the factor actnames computed on the labels' column and then made character.

 
(step 5) From the data set in step 4, to create a second, independent tidy data set with the 
average of each variable for each activity and each subject, I used the function tapply iteratively (for cycle) in the columns from 3rd to 88th (i.e. on the measures' columns) with as function mean and as index both the Subject and the Activity columns.
On the resulting matrix, that I transformed into a data frame, I attached a column with the measure name repeated as many time as the subjects (30). That column was called Measure.
Then I changed the names of the columns so that it was clear I was referring to mean values and not to single measurements.
At the end of each iteration the resulting data frame was attached to the one made previously and then the all data frame was rearranged according to the Subject ids.

As I had Subject and Measure as last column, I preferred to put them as first and second. 

Measures included:
"tBodyAcc-mean()-X"                    "tBodyAcc-mean()-Y"                   
"tBodyAcc-mean()-Z"                    "tGravityAcc-mean()-X"                
"tGravityAcc-mean()-Y"                 "tGravityAcc-mean()-Z"                
"tBodyAccJerk-mean()-X"                "tBodyAccJerk-mean()-Y"               
"tBodyAccJerk-mean()-Z"                "tBodyGyro-mean()-X"                  
"tBodyGyro-mean()-Y"                   "tBodyGyro-mean()-Z"                  
"tBodyGyroJerk-mean()-X"               "tBodyGyroJerk-mean()-Y"              
"tBodyGyroJerk-mean()-Z"               "tBodyAccMag-mean()"                  
"tGravityAccMag-mean()"                "tBodyAccJerkMag-mean()"              
"tBodyGyroMag-mean()"                  "tBodyGyroJerkMag-mean()"             
"fBodyAcc-mean()-X"                    "fBodyAcc-mean()-Y"                   
"fBodyAcc-mean()-Z"                    "fBodyAcc-meanFreq()-X"               
"fBodyAcc-meanFreq()-Y"                "fBodyAcc-meanFreq()-Z"               
"fBodyAccJerk-mean()-X"                "fBodyAccJerk-mean()-Y"               
"fBodyAccJerk-mean()-Z"                "fBodyAccJerk-meanFreq()-X"           
"fBodyAccJerk-meanFreq()-Y"            "fBodyAccJerk-meanFreq()-Z"           
"fBodyGyro-mean()-X"                   "fBodyGyro-mean()-Y"                  
"fBodyGyro-mean()-Z"                   "fBodyGyro-meanFreq()-X"              
"fBodyGyro-meanFreq()-Y"               "fBodyGyro-meanFreq()-Z"              
"fBodyAccMag-mean()"                   "fBodyAccMag-meanFreq()"              
"fBodyBodyAccJerkMag-mean()"           "fBodyBodyAccJerkMag-meanFreq()"      
"fBodyBodyGyroMag-mean()"              "fBodyBodyGyroMag-meanFreq()"         
"fBodyBodyGyroJerkMag-mean()"          "fBodyBodyGyroJerkMag-meanFreq()"     
"angle(tBodyAccMean,gravity)"          "angle(tBodyAccJerkMean),gravityMean)"
"angle(tBodyGyroMean,gravityMean)"     "angle(tBodyGyroJerkMean,gravityMean)"
"angle(X,gravityMean)"                 "angle(Y,gravityMean)"                
"angle(Z,gravityMean)"                 "tBodyAcc-std()-X"                    
"tBodyAcc-std()-Y"                     "tBodyAcc-std()-Z"                    
"tGravityAcc-std()-X"                  "tGravityAcc-std()-Y"                 
"tGravityAcc-std()-Z"                  "tBodyAccJerk-std()-X"                
"tBodyAccJerk-std()-Y"                 "tBodyAccJerk-std()-Z"                
"tBodyGyro-std()-X"                    "tBodyGyro-std()-Y"                   
"tBodyGyro-std()-Z"                    "tBodyGyroJerk-std()-X"               
"tBodyGyroJerk-std()-Y"                "tBodyGyroJerk-std()-Z"               
"tBodyAccMag-std()"                    "tGravityAccMag-std()"                
"tBodyAccJerkMag-std()"                "tBodyGyroMag-std()"                  
"tBodyGyroJerkMag-std()"               "fBodyAcc-std()-X"                    
"fBodyAcc-std()-Y"                     "fBodyAcc-std()-Z"                    
"fBodyAccJerk-std()-X"                 "fBodyAccJerk-std()-Y"               
"fBodyAccJerk-std()-Z"                 "fBodyGyro-std()-X"                   
"fBodyGyro-std()-Y"                    "fBodyGyro-std()-Z"                   
 "fBodyAccMag-std()"                    "fBodyBodyAccJerkMag-std()"           
"fBodyBodyGyroMag-std()"               "fBodyBodyGyroJerkMag-std()" 

Their mean per subject per activity were then called:
MEAN_WHILE_LAYING"             
"MEAN_WHILE_SITTING"           
"MEAN_WHILE_STANDING"           
"MEAN_WHILE_WALKING"           
"MEAN_WHILE_WALKING_DOWNSTAIRS" 
"MEAN_WHILE_WALKING_UPSTAIRS"  