#################################################################################
# Library Load Section.
# This section is to load required library create a tidy data set.
# Library being used : dplyr
#################################################################################
require(dplyr)



#################################################################################
# Data Reading Section.
# This section is to read raw data of UCI HAR Dataset.
# Each file in the data set is loaded into R Variable.
#################################################################################

#Read activity_labels.txt
activity_label <- read.fwf("UCI HAR Dataset/activity_labels.txt", 
                           width = c(1,20), 
                           col.names = c("activity_id", "activity"))


#Read features.txt
features <- read.fwf("UCI HAR Dataset/features.txt", 
                     width = 40, 
                     sep = " ", 
                     col.names = c("feature_id", "feature_name"))


#Read X_train.txt and label the data with the list of 
#measurement name from features.txt
x_train <- read.fwf("UCI HAR Dataset/train/X_train.txt", 
                    width = rep(16, 561))
names(x_train) <- features$feature_name


#Read y_train.txt
y_train <- read.fwf("UCI HAR Dataset/train/y_train.txt", 
                    width = 1, 
                    col.names = "activity_id")


#Read subject_train.txt
subject_train <- read.fwf("UCI HAR Dataset/train/subject_train.txt", 
                          width = 2, 
                          col.names = "subject")


#Read X_train.txt and label the data with the list of 
#measurement name from features.txt
x_test <- read.fwf("UCI HAR Dataset/test/x_test.txt", 
                   width = rep(16, 561))
names(x_test) <- features$feature_name


#Read y_test.txt
y_test <- read.fwf("UCI HAR Dataset/test/y_test.txt", 
                   width = 1, 
                   col.names = "activity_id")

#Read subject_test.txt
subject_test <- read.fwf("UCI HAR Dataset/test/subject_test.txt", 
                         width = 2, 
                         col.names = "subject")


#################################################################################
# Data Cleaning Section.
# This section consists activity of data cleaning to produce tidy data set.
#################################################################################

#Merge the data in y_train & y_test with activity_label to get the activity 
#description for each observation
y_train_label <- inner_join(y_train, activity_label, by="activity_id")
y_test_label <- inner_join(y_test, activity_label, by="activity_id")


#Extracts only the measurements on the mean and standard deviation for 
#each measurement in test and train data
col_mean_std <- grep("mean[^Freq]|std", features$feature_name, value = TRUE)
x_test <- x_test[,col_mean_std]
x_train <- x_train[,col_mean_std]


#Merge test data set with subject and activity description
x_test_set <- cbind(subject_test, y_test_label$activity, x_test)
names(x_test_set)[2] <- "activity"


#Merge training data set with subject and activity description
x_train_set <- cbind(subject_train, y_train_label$activity, x_train)
names(x_train_set)[2] <- "activity"


#Merges the training and the test sets to create one data set
data_set <- as_tibble(rbind(x_test_set, x_train_set))


#Group the data set by subject and activity
data_set <- data_set %>%
            arrange(subject) %>%
            group_by(subject,activity)


#Creates a second tidy data set with the average of each variable 
#for each activity and each subject.
data_set_summary <- summarise_all(data_set, mean)


#Write the summary tidy data set into text file
write.table(data_set_summary, 
            file = "UCI_HAR_tidy_data.txt", 
            row.name=FALSE, 
            sep = " ")


