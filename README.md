# datacleaning_course_project
This repo contains my course project for the Coursera course "Getting and Cleaning data" of August 2015

Please, in order to run the program, make sure your working directory is the one containing UCI HAR Dataset.
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
