==================================================================
Peer-graded Assignment: Getting and Cleaning Data Course Project
Version 1.0
==================================================================
Willy Sebastian
==================================================================

The goal of this project is to prepare tidy data set from UCI HAR 
Dataset that can be used for later analysis.

The script to produce the tidy data set can be found in run_analysis.R.
The script is divided into 3 sections :


1. Library Load Section.
This section is to load required library create a tidy data set. The
library being used in this script is dplyr.


2. Data Reading Section.
This section is to read raw data from UCI HAR Dataset.Each file in the data set 
is loaded into R Variable.

Following are the list of variables with the corresponding source files,

activity_label 	: activity_labels.txt
features 		: features.txt
x_train 		: X_train.txt
y_train 		: y_train.txt
subject_train 	: subject_train.txt
x_test 			: x_test.txt
y_test 			: y_test.txt
subject_test 	: subject_test.txt

The measurement data in x_train and x_test is labeled with descriptive
variable name which are listed in features.txt


3. Data Cleaning Section.
This section consists activity of data cleaning to produce tidy data set :

- Merge the data in y_train & y_test with activity_label to get the activity 
description for each observation

- Extracts only the measurements on the mean and standard deviation for 
each measurement in test and train data

- Merge test data set with subject and activity description

- Merge training data set with subject and activity description

- Merges the training and the test sets to create one wide format tidy data set

- Group the data set by subject and activity

- Creates a second tidy data set with the average of each variable 
for each activity and each subject

- Write the summary tidy data set into text file (UCI_HAR_tidy_data.txt)