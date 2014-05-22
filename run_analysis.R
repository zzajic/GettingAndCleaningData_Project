run_analysis <- function() {
  
  ## Read data set test and train and merging
  
  activity_labels<- read.table("./data/UCI HAR Dataset/activity_labels.txt")
  
  #train
  X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
  subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
  y_train[y_train == 1] = "WALKING"
  y_train[y_train == 2] = "WALKING_UPSTAIRS "
  y_train[y_train == 3] = "WALKING_DOWNSTAIRS "
  y_train[y_train == 4] = "SITTING"
  y_train[y_train == 5] = "STANDING "
  y_train[y_train == 6] = "LAYING"
  train <- NULL
  train$subject <- subject_train$V1
  train$activity <- y_train$V1
  train$train <- rep(1,nrow(X_train))
  train$data<- X_train
  train<-as.data.frame(train)
  
  #test
  X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
  subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
  y_test[y_test == 1] = "WALKING"
  y_test[y_test == 2] = "WALKING_UPSTAIRS "
  y_test[y_test == 3] = "WALKING_DOWNSTAIRS "
  y_test[y_test == 4] = "SITTING"
  y_test[y_test == 5] = "STANDING "
  y_test[y_test == 6] = "LAYING"
  test <- NULL
  test$subject <- subject_test$V1
  test$activity <- y_test$V1
  test$train <- rep(0,nrow(X_test))
  test$data<- X_test
  test<-as.data.frame(test)
  
  #merge test and train
  all<-merge(train,test,all=TRUE)

  all_mean<-aggregate(all[3:ncol(all)], all[1:2], mean)
  
  write.table(all, "all.txt", sep="\t") 
  write.table(all_mean, "all_mean.txt", sep="\t") 
}
