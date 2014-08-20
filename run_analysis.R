## first we get the test data
setwd("~")
setwd("desktop/UCI HAR Dataset")
features <- read.table("features.txt")
featureNames <- as.character(features[,2])
matchMean <- grep("mean", featureNames)
matchStd <- grep("std", featureNames)
data_t <- read.table("test/X_test.txt")
names(data_t) <- featureNames
test <- data_t[, c(matchMean, matchStd)]
subject_t <- read.table("test/subject_test.txt")
names(subject_t) <- "identity"
labels_t <- read.table("test/Y_test.txt")
names(labels_t) <- "activity"
testData <- cbind(test, subject_t, labels_t)
## then we do the same to training data
data_tr <- read.table("train/X_train.txt")
names(data_tr) <- featureNames
train <- data_tr[, c(matchMean, matchStd)]
subject_tr <- read.table("train/subject_train.txt")
names(subject_tr) <- "identity"
labels_tr <- read.table("train/Y_train.txt")
names(labels_tr) <- "activity"
trainData <- cbind(train, subject_tr, labels_tr)
bindData <- rbind(testData, trainData)
activityLabels <- read.table("activity_labels.txt", col.names = c("activity", "activityNames"))
mergeData <- merge(bindData, activityLabels, by = "activity")
## now create a second dataset
summaryData <- aggregate(mergeData[,2:80], by = list(Activity = mergeData$activityNames, Subject = mergeData$identity), FUN = mean)
## export the data to text files
write.table(mergeData, "mergeData.txt", row.names = FALSE)
write.table(summaryData, "summaryData.txt", row.names = FALSE)