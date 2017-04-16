library(dplyr)

# 1. Merges the training and the test sets to create one data set.

# - prepare train set by reading subject_train.txt, y_train.txt, x_train.txt and combine by columns
subject_train <- read.table("train/subject_train.txt", header = FALSE, col.names = "subject")
y_train <- read.table("train/y_train.txt", header = FALSE, col.names = "activity")
x_train <- read.table("train/x_train.txt", header = FALSE)
train <- cbind(subject_train, y_train, x_train)

# - prepare test set by reading subject_test.txt, y_test.txt, x_test.txt and combine by columns
subject_test <- read.table("test/subject_test.txt", header = FALSE, col.names = "subject")
y_test <- read.table("test/y_test.txt", header = FALSE, col.names = "activity")
x_test <- read.table("test/X_test.txt", header = FALSE)
test <- cbind(subject_test, y_test, x_test)

# - combind by rows the train and test sets
ds <- rbind(train, test)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# - read list of all features
features <- read.table("features.txt", header = FALSE)

# - subset features' index for the measurements on the mean and standard deviation
mean_std_measurements <- features[grepl("mean()", features$V2, fixed = TRUE) | grepl("std()", features$V2, fixed = TRUE), 1]

# - select the features columns (V1 - V561) which match the indexes subseted above
mean_std_ds <- ds %>%
        select(subject:activity, num_range("V", mean_std_measurements)) 


# 3. Uses descriptive activity names to name the activities in the data set

# - read the class labels with their activity name
activity_labels <- read.table("activity_labels.txt", header = FALSE)

# - replace labels with their activity name
mean_std_activity_ds <- mutate(mean_std_ds, activity = activity_labels$V2[match(activity, activity_labels$V1)]) 


# 4. Appropriately labels the data set with descriptive variable names.

# - subset the feature variable names for the measurements on the mean and standard deviation. Change them to lowercase, remove '()' and replace '-' with '.'
feature_names <- tolower(
                features[grepl("mean()", features$V2, fixed = TRUE) | grepl("std()", features$V2, fixed = TRUE), 2])

feature_names <- gsub("()", "", feature_names, fixed = TRUE)
feature_names <- gsub("-", ".", feature_names, fixed = TRUE)

# - Replace V1, V2, and etc. with the feature names.
names(mean_std_activity_ds) <- c(c("subject", "activity"), feature_names)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# - group the data set by activity and subject
by_activity_subject <- group_by(mean_std_activity_ds, activity, subject)

# - compute the mean for each variables 
average_by_activity_subject <- summarise_all(by_activity_subject, mean)


write.table(average_by_activity_subject, "average_by_activity_subject.txt", row.name=FALSE)

data <- read.table("average_by_activity_subject.txt", header = TRUE) 
View(data)
