# datacleaning_course_project
This repo contains my course project for the Coursera course "Getting and Cleaning data" of August 2015

Please, in order to run the program run_analysis.R, make sure your working directory is the one containing the downloaded UCI HAR Dataset.
The run_analysis.R file extracts the file from UCI HAR Dataset, creates two data frames, one for the train set and the other for the test train. It already assigns both the column names using the variables given in the features.txt. The through rbind() command it merges the two data frames.
For extracting only the variables regarding mean and standard deviation, the function grep was used.
Then a second data frame was created with only those "interesting variables" and of course Subject ids and Activity labels.
Then, to substitute the activity labels with proper names describing the activity, I created a factor that had as levels the values in the file "activity_labels.txt" in the same order. With the function mutate it was then possible to substitute the activity labels' column with an actual activity names' column.
At the end, to have a tidy data frame with the means per subject per activity, I used in a cycle for on the 86 interesting variables the function tapply with indexes both Subject and Activity.


If you want to see my final dataset, change your working directory into the one where you downloaded it and run in R studio:

data <- read.table("final_dataset.txt", header = TRUE) 

and then
View(data)

In the CodeBook.md file there is explained why I chose such names for the tidy dataset and all the procedure in detail I followed to perform the cleaning.
