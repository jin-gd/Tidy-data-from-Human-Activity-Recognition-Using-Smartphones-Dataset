# run_analysis.R
library(dplyr)

# Download and unzip the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip", mode = "wb")
unzip("data.zip")

# Read metadata: feature names and activity labels
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

# Read training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# 1. Merge the training and the test sets to create one data set
test_data <- cbind(subject_test, y_test, x_test)
train_data <- cbind(subject_train, y_train, x_train)
merged_data <- rbind(train_data, test_data)

# 2. Extract only the measurements on the mean and standard deviation for each measurement
selected_cols <- grep("mean\\(\\)|std\\(\\)", features$V2)
keep_columns <- c(1, 2, selected_cols + 2)
tidy_data <- merged_data[, keep_columns]

# 3. Use descriptive activity names to name the activities in the data set
tidy_data <- merge(tidy_data, activity_labels, by = "code", all.x = TRUE)
tidy_data <- select(tidy_data, -code)

# 4. Appropriately label the data set with descriptive variable names
colnames(tidy_data)[3:(ncol(tidy_data)-1)] <- features$V2[selected_cols]
names(tidy_data) <- gsub("^t", "time", names(tidy_data))
names(tidy_data) <- gsub("^f", "frequency", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
final_tidy <- tidy_data %>%
        group_by(subject, activity) %>%
        summarise(across(everything(), mean))

# Export the final tidy data
write.table(final_tidy, "tidy_data.txt", row.name = FALSE)
