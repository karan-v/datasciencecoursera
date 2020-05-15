The run_analysis.R script performs the data preparation and then followed by the 4 steps required as described in the course project’s definition.

1. Downloading the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset.

2. Assigning the to variables
a.features <- features.txt : 561 rows, 2 columns
  The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
b.labels <- activity_labels.txt : 6 rows, 2 columns
  List of activities performed when the corresponding measurements were taken and its codes (labels)
c.sub_test <- test/subject_test.txt : 2947 rows, 1 column
  contains test data of 9/30 volunteer test subjects being observed
d.test <- test/X_test.txt : 2947 rows, 66 columns
  contains recorded features test data. selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement
e.labels_test <- test/y_test.txt : 2947 rows, 1 columns
  contains test data of activities’code labels
f.sub_train <- test/subject_train.txt : 7352 rows, 1 column
  contains train data of 21/30 volunteer subjects being observed
g.train <- test/X_train.txt : 7352 rows, 66 columns
  contains recorded features train data. selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement
h.labels_train <- test/y_train.txt : 7352 rows, 1 columns
  contains train data of activities’code labels.

3. Merging training and the test sets to create one data set
a.train (7352 rows, 68 column) is created by binding train, sub_train and labels_train thorugh the cbind() function. 
b.test (2947 rows, 68 column) is created by binding test, sub_test and labels_test thorugh the cbind() function.
c.Merged_Data (10299 rows, 68 column) is created by merging train and test using rbind() function

4. creates a second, independent tidy data set with the average of each variable for each activity and each subject
  merged (180 rows, 68 columns) is modified by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
  Export FinalData into TidyData.txt file.
