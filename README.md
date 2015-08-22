# datacleaning_course_project
This repo contains my course project for the Coursera course "Getting and Cleaning data" of August 2015

Please, in order to run the program run_analysis.R, make sure your working directory is the one containing the downloaded UCI HAR Dataset.

If you want to see my final dataset, change your working directory into the one where you downloaded it and run in R studio:

data <- read.table("final_dataset.txt", header = TRUE) 

and then
View(data)

In the CodeBook.md file there is explained why I chose such names for the tidy dataset and all the procedure I followed to perform the cleaning.
