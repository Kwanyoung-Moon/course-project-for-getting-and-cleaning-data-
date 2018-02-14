# W4 Course Project

# load data
setwd("C:/°ü¿µ/coursera/course3/data/UCI HAR Dataset")
getwd()

labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
subtest <- read.table("./test/subject_test.txt")
xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/y_test.txt")


baccxtest <- read.table("./test/Inertial_Signals/body_acc_x_test.txt")
baccytest <- read.table("./test/Inertial_Signals/body_acc_y_test.txt")
baccztest <- read.table("./test/Inertial_Signals/body_acc_z_test.txt")
gyroxtest <- read.table("./test/Inertial_Signals/body_gyro_x_test.txt")
gyroytest <- read.table("./test/Inertial_Signals/body_gyro_y_test.txt")
gyroztest <- read.table("./test/Inertial_Signals/body_gyro_z_test.txt")
taccxtest <- read.table("./test/Inertial_Signals/total_acc_x_test.txt")
taccytest <- read.table("./test/Inertial_Signals/total_acc_y_test.txt")
taccztest <- read.table("./test/Inertial_Signals/total_acc_z_test.txt")

subtrain <- read.table("./train/subject_train.txt")
xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/y_train.txt")


baccxtrain <- read.table("./train/Inertial_Signals/body_acc_x_train.txt")
baccytrain <- read.table("./train/Inertial_Signals/body_acc_y_train.txt")
baccztrain <- read.table("./train/Inertial_Signals/body_acc_z_train.txt")
gyroxtrain <- read.table("./train/Inertial_Signals/body_gyro_x_train.txt")
gyroytrain <- read.table("./train/Inertial_Signals/body_gyro_y_train.txt")
gyroztrain <- read.table("./train/Inertial_Signals/body_gyro_z_train.txt")
taccxtrain <- read.table("./train/Inertial_Signals/total_acc_x_train.txt")
taccytrain <- read.table("./train/Inertial_Signals/total_acc_y_train.txt")
taccztrain <- read.table("./train/Inertial_Signals/total_acc_z_train.txt")

#1. merge the training and the test sets to create one data set
#3. uses descriptive activity names to name the activities in the data set
#4. appropriately labels the data set with descriptive variable names
names(xtrain) <- features[,2]
names(xtest) <- features[,2]
colnames(subtrain) <- "subject_ID"
colnames(subtest) <- "subject_ID"
colnames(ytrain) <- "activity_label"
colnames(ytest) <- "activity_label"

ytrain[,1] <- labels[,2][ytrain[,1]]
ytest[,1] <- labels[,2][ytest[,1]]

totaltrain <- cbind(subtrain, xtrain, ytrain)
totaltest <- cbind(subtest, xtest, ytest)
total <- rbind(totaltrain, totaltest)

#2. extract only the measurements on the mean and standard deviation fore each measurement
feat2 <- as.character(features[,2][grep("mean|std", features[,2])])
measurements2 <- total[, feat2]

measurements3 <- cbind(total[,1],measurements2, total[,563])
colnames(measurements3)[c(1,81)] <- c("subject_ID", 'activity_label')

#5. create a second, independent tidy data set with the average of each variable for each activity and each subject
#library(reshape2)
measurements4 <- melt(measurements3, id = c("subject_ID", "activity_label"))
tidy <- dcast(measurements4, subject_ID + activity_label ~ variable, mean)
write.table(tidy, "tidy.txt")