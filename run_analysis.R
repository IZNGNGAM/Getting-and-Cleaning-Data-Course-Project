# Step 1 Merges the training and the test sets to create one data set

# Extract the training and test data sets separately as subject, X and y

subject_train <- read.table('../UCI HAR Dataset/train/subject_train.txt')
X_train <- read.table('../UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('../UCI HAR Dataset/train/y_train.txt')

subject_test <- read.table('../UCI HAR Dataset/test/subject_test.txt')
X_test <- read.table('../UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('../UCI HAR Dataset/test/y_test.txt')

# Merge the training and test sets

subject <- rbind(subject_train, subject_test)
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)

# Step 2 Extracts only the measurements 
# on the mean and standard deviation for each measurement

# find the features associated with the mean and standard deviation
# the features related to meanFreq() are excluded

features <- read.table('../UCI HAR Dataset/features.txt')
# columns to keep
desired_cols <- grep('mean\\(\\)|std\\(\\)', features[,2]) 
# respective feature names, parse to remove () and -
desired_features <- grep('mean\\(\\)|std\\(\\)', features[,2], value = T) 
desired_features <- gsub('\\(\\)','',desired_features)
desired_features <- gsub('-','_',desired_features)
# select these columns from X
X <- X[,desired_cols]

# Step 3 Uses descriptive activity names to name the activities in the data set

activities <- read.table('../UCI HAR Dataset/activity_labels.txt')
# map the label in y to the activity
y <- sapply(y, function (x){x <- tolower(activities[as.integer(x),2])})
colnames(y) <- 'activity'

# Step 4 Appropriately labels the data set with descriptive variable names

# label subject
colnames(subject) <- 'subject_id'
# label features, use the features names retrieved
colnames(X) <- desired_features
# ready to combine subject, X and y
full_dataset <- cbind(subject, X, y)

# Step 5 From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

library(dplyr)

# group by id and activity, then calculate the mean for every variable
grouped_mean <- full_dataset %>% 
    group_by(subject_id, activity) %>% 
    summarize_all(mean)

# write to an external file to save the summarized data set

write.table(grouped_mean, file = 'average_id&activity.txt', row.names = F)
