# Getting and Cleaning Data


The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. This data is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Unzip the zip file into the folder and place the R script run_analysis.R into the same folder. Load the R script.


The R script does the following steps:

1. Merges the training and the test sets to create one data set.

The training and test sets comprise of 
- the identifier of subject who carried out the experiment (subject_train.txt and subject_test.txt), 
- the activity performed (y_train.txt and y_test.txt), and
- the 561-feature vector with time and frequency domain variables (X_train.txt and X_test.txt)
Combine those vectors to produce respective data set. Training set comprises of 7352 observations and test set has 2947 observations.
Then, merge training and test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

The data set produced in step 1 has subject, activity and 561 feature columns (V1 - V561). By interpreting the column names, columns with measurements on the mean and standard deviation can be identified. features.txt contains list of variables of each feature with index column. Subset the index column of the feature names containing mean() and std(). Then, use the value of the index column to select only the columns with the mean and standard deviation for each measurement.  


3. Uses descriptive activity names to name the activities in the data set.

Actitivites in the data set is labeled using number. activity_labels.txt file contains the numbers and corresponding descriptive activity names. 
Read the activity numbers and corresponding names into a data table. Then, replace the activity numbers in the data set with the matching activity names. 


4. Appropriately labels the data set with descriptive variable names.

At this point, the variable name for features are V1, V2 and etc. Replace the variable names with descriptive variable names and remove "()" characters and replace "-" with ".".

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Finally, create a tidy data set by grouping it by activity and subject, and apply mean function to all columns. 


The tidy data is stored in file named average_by_activity_subject.txt. 

The following R script can be executed in R Studio to read in and view the tidy data set. 
 
```
address <- "https://s3.amazonaws.com/coursera-uploads/user-longmysteriouscode/asst-3/massivelongcode.txt"
address <- sub("^https", "http", address)
data <- read.table(url(address), header = TRUE) 
View(data)
```

See the codebook.txt file which contains the codebook for the tidy data set.





