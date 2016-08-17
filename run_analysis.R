#file download 
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url,destfile="Dataset.zip",method="curl")
unzip(zipfile = "Dataset.zip")
file_path <- file.path("UCI HAR Dataset")

#activity test & train data 
actTest <- read.table(file.path(file_path, "test", "Y_test.txt"),header=F)
actTrain <- read.table(file.path(file_path, "train", "y_train.txt"), header=F)
actData <- rbind(actTrain, actTest)
names(actData) <- "activity"

#subject test & train data
subTest <- read.table(file.path(file_path, "test", "subject_test.txt"), header=F)
subTrain <- read.table(file.path(file_path, "train", "subject_train.txt"), header=F)
subData <- rbind(subTrain, subTest)
names(subData) <- "subject"

#feature data
featTest <- read.table(file.path(file_path, "test", "X_test.txt"), header=F)
featTrain <- read.table(file.path(file_path, "train", "X_train.txt"), header=F)
featData <- rbind(featTrain, featTest)
names(featData) <- read.table(file.path(file_path, "features.txt"), header=F)[,2]

#merging all data
merged <- cbind(actData, subData, featData)
mergedNoDupe <- merged[, !duplicated(names(merged))]
dataFinal <- select(mergedNoDupe, 1:2, contains("mean()"), contains("std()"))

#labeling
actLabels <- read.table(file.path(file_path, "activity_labels.txt"), header=F)
dataFinal$activity <-factor(dataFinal$activity, levels=actLabels[,1],
                                 labels = actLabels[,2])

#tidy names
names(dataFinal) <- gsub("\\()", "", names(dataFinal))
names(dataFinal) <- gsub("-mean", "_Mean", names(dataFinal))
names(dataFinal) <- gsub("-std", "_Std", names(dataFinal))
names(dataFinal) <- gsub("^t", "time_", names(dataFinal))
names(dataFinal) <- gsub("^f", "freq_", names(dataFinal))
names(dataFinal) <- gsub("-std", "Std", names(dataFinal))









