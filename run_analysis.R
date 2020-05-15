library(data.table)
library(reshape2)
path = getwd()
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = "./dataset.zip",method = "curl")
unzip(zipfile = "./dataset.zip")

labels <- fread(file.path(path,"UCI HAR Dataset/activity_labels.txt")
                ,col.names = c("labels","class"))
features <- fread(file.path(path,"UCI HAR Dataset/features.txt")
                  ,col.names = c("index","fname"))

featreq <- grep("(mean|std)\\(\\)",features$fname)
renamefeat <- features[featreq,fname]

#reading the training data
train <- fread(file.path(path,"UCI HAR Dataset/train/X_train.txt"))[,featreq,with = FALSE]
names(train) <- renamefeat
labels_train <- fread(file.path(path,"UCI HAR Dataset/train/y_train.txt"),
                      col.names = c("class"))
sub_train <- fread(file.path(path,"UCI HAR Dataset/train/subject_train.txt"),
                   col.names = c("subname"))
train <- cbind(train,labels_train,sub_train)

#reading the test data
test <- fread(file.path(path,"UCI HAR Dataset/test/X_test.txt"))[,featreq,with = FALSE]
names(test) <- renamefeat
labels_test <- fread(file.path(path,"UCI HAR Dataset/test/y_test.txt"),
                     col.names = c("class"))
sub_test <- fread(file.path(path,"UCI HAR Dataset/test/subject_test.txt"),
                  col.names = c("subname"))
test <- cbind(test,labels_test,sub_test)

#merging test and train data together
merged <- rbind(train,test)

merged[["class"]] <- factor(merged[, class], levels = labels[["labels"]], labels = labels[["class"]])
merged[["subname"]] <- as.factor(merged[ ,subname])

merged <- reshape2::melt(merged,id = c("class","subname"))
merged <- reshape2::dcast(merged,class+subname~variable,mean)
names(merged)[names(merged) == "class"] <- "activity"
names(merged)[names(merged) == "subname"] <- "subject"

write.table(merged, "TidyData.txt", row.name=FALSE)