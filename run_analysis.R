
#load test data
testData <- read.table("/Users/brent/datasciencecoursera/getAndClean/test/X_test.txt")
testActivity <- read.table("/Users/brent/datasciencecoursera/getAndClean/test/y_test.txt")
#merge test data
completeTest <- cbind(testActivity,testData)

#load training data
trainData <- read.table("/Users/brent/datasciencecoursera/getAndClean/train/X_train.txt")
trainActivity <- read.table("/Users/brent/datasciencecoursera/getAndClean/train/y_train.txt")
#merge training data
completeTrain <- cbind(trainActivity,trainData)

#load labels
Labels <- read.table("/Users/brent/datasciencecoursera/getAndClean/features.txt")

#label data
colnames(testData) <- testLabels$V2
colnames(trainData) <- testLabels$V2

#label activities
names(completeTest)[1] <- "activity"
names(completeTrain)[1] <- "activity"

#test tomake sure variable names are equivalent in training & test for
#the variablse we care about
grep("mean",names(completeTrain), value=T)==grep("mean",names(completeTest))

#pull out mean and standard deviation variables
meanVars <- grep("mean",names(completeTrain), value=T)
stdVars <- grep("std",names(completeTrain), value=T)
#merge mean and standard deviation variables
varsToKeep <- c(meanVars,stdVars, "activity")

#filter data for only mean, std dev, and activity name variables
keepTrain <- completeTrain[,varsToKeep]
keepTest <- completeTest[,varsToKeep]
length(varsToKeep)==dim(keepTrain)[2]
length(varsToKeep)==dim(keepTest)[2]

almostTidyData <- rbind(keepTrain,keepTest)

#label activities
activityLabel <- read.table("/Users/brent/datasciencecoursera/getAndClean/activity_labels.txt")
names(activityLabel) <- c("activity","activityName")

#label activities
tidyData <- merge(x=almostTidyData,y=activityLabel,by="activity")
#drop numeric activity column
tidyData <- tidyData[-1]

write.table(tidyData,file="tidyData.txt")
