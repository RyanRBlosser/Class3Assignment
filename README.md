# Class 3 Assignment Readme
Class 3 Assignment Readme

There is only one .R file, run_analysis.R, which if run, combines files from the working directory and eventually outputs a text file of the second data set.

How the data set was constructed:
1) Take the test files (subject_test, y_test, x_test) as combine them "vertically" (cbind)
and append to them (rbind) the train files (suject_train, y_train, x_train)...this results in a large, wide data frame

2) Import the features.txt file as a separate data frame

3) Create a new column in the data frame from step 2 that increments the numeric column by 2.  

4) Create another column in this same data frame that strips out the parentheses and dashes from the alpha column 

5) Filter this data frame with a regular expression (look for all rows in the original character column that have "mean()" or "std()" in them)

6) Turn these two newly created columns in steps 3 and 4 into vectors by appending c(1,2) to the numeric column and c("subject", "activity") to the other
These two vectors are used to both filter the original data frame and rename its columns.
The reason for adding 2 in an earlier step and putting the vector c(1,2) at the beginning is that the very first two column in the data frame are from the "skinny" text files, one column
for subject (in the subject text file) and one column for activity number (in the Y text file).  Then, the main data file starts at column 3, which means that we need to offset the "position" in the features file by 2.
This is the same reason for adding the c("subject", "activity") at the start.  Again, the features file dictates the metadata starting at column 3.

7) "Filter" the main data frame with the numeric vector created above in step 6.

8) Rename the newly created data frame with the character vector created above in step 6.

9) Import the activity_labels.txt file as a new data frame.  This is going to be used to change the activity column in the main data frame 
to a factor variable with the levels being the second column of this data frame.

10) Create a vector with the second column of this new data frame.

11) Change the "activity" column in the data frame to a factor column with the data frame created by the activity_labels file.

12) Create a new data frame from the main data frame using ddply with three arguments: the data frame, the two columns at the left of the data frame (subject and activity) and using numcolwise(mean).
numcolwise will perform the computation (in this case the mean) on each individual column in the data frame not included in the second argument.  This is how to get the mean from every column on a per subject, per activity basis.

13) Write data table to file

