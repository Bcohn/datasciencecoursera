
testData <- read.table("/Users/brent/datasciencecoursera/getAndClean/test/X_test.txt")
testSubjects <- read.table("/Users/brent/datasciencecoursera/getAndClean/test/y_test.txt")
completeTest <- cbind(testSubjects,testData)


trainData <- read.table("/Users/brent/datasciencecoursera/getAndClean/train/X_train.txt")
trainSubjects <- read.table("/Users/brent/datasciencecoursera/getAndClean/train/y_train.txt")
completeTrain <- cbind(trainSubjects,trainData)


Labels <- read.table("/Users/brent/datasciencecoursera/getAndClean/features.txt")

colnames(testData) <- testLabels$V2
colnames(trainData) <- testLabels$V2

names(completeTest)[1] <- "activity"
names(completeTrain)[1] <- "activity"

grep("mean",names(completeTrain), value=T)==grep("mean",names(completeTest))

meanVars <- grep("mean",names(completeTrain), value=T)
stdVars <- grep("std",names(completeTrain), value=T)
varsToKeep <- c(meanVars,stdVars, "activity")

keepTrain <- completeTrain[,varsToKeep]
keepTest <- completeTest[,varsToKeep]
length(varsToKeep)==dim(keepTrain)[2]
length(varsToKeep)==dim(keepTest)[2]

almostTidyData <- rbind(keepTrain,keepTest)

activityLabel <- read.table("/Users/brent/datasciencecoursera/getAndClean/activity_labels.txt")
names(activityLabel) <- c("activity","activityName")
 
tidyData <- merge(x=almostTidyData,y=activityLabel,by="activity")

tidyData <- tidyData[-1]
