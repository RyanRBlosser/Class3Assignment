library("plyr")

# Step 1 from the CODEBOOK file
data_frame <- rbind(
  cbind(read.table("subject_test.txt", sep = "" , header = F),
         read.table("y_test.txt", sep = "" , header = F),
         read.table("X_test.txt", sep = "" , header = F)),
   cbind(read.table("subject_train.txt", sep = "" , header = F),
         read.table("y_train.txt", sep = "" , header = F),
         read.table("X_train.txt", sep = "" , header = F)))
		 
# Step 2
column_names <- read.table("features.txt", sep = "" , header = F)

# Step 3
column_names$rowplus2 <- column_names$V1 + 2

# Step 4
column_names$newnames <- gsub("\\(", "", gsub("\\)", "", gsub("-", "_", column_names$V2)))

# Step 5
column_names_filtered <- column_names[with(column_names, grepl("mean\\(\\)|std\\(\\)", V2)),]

# Step 6
colnumvector <- c(c(1, 2), as.vector(column_names_filtered$rowplus2))
colnamevector <- c(c("subject", "activity"), as.vector(column_names_filtered$newnames))

# Step 7
data_frame <- data_frame[,colnumvector]

# Step 8
colnames(data_frame) <- colnamevector

# Step 9
activity_names <- read.table("activity_labels.txt", sep = "" , header = F)

# Step 10
activityvector <- as.vector(activity_names$V2)

# Step 11
data_frame$activity <- factor(data_frame$activity)
levels(data_frame$activity) <- activityvector

# Step 12
data_frame2 <- ddply(data_frame, .(subject, activity), numcolwise(mean))

# Step 13
