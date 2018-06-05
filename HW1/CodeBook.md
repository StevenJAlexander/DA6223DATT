I set up directories on my computer as follows:
"DATT" (Data Analytics Tools and Techniques" under pre-existing directory "UTSA".
"DATT HW1" (DATT Home Work 1) under "DATT"
"UCI HAR Dataset" under "DATT HW1" with the contents of the zip file downloaded from Blackboard.
"test" and "train" under "UCI HAR Dataset" as created by extracting files from the zip file.

I wrote an R script that did the following:

Read the 561 feature/column/variable names for the X data from "features.txt" into "colnames_df".

Read training and test X variables from "X_train.txt" and "X_test.txt" in "trainx_df" and
"testx_df".  Assigned column names from "colnames_df".

Read training and test subject ID numbers (1 - 30) from "subject_train.txt" and "subject_test.txt"
into "trainsub_df" and "testsub_df".

Read activity code numbers (1 - 6) from "Y_train.txt" and "Y_test.txt" into "trainy_df" and "testy_df".

Used the rbind() function to combine training and test data for "X" variables into "x_df",
the subject ID variable into "subject_df", and activity code variable into "y_df".

Copied "X" variables with column names containing "mean()" into a separate data frame, "mean_df".

Copied "X" variables with column names containing "std()" into a separate data frame, "std_df".

Recoded activity codes (1 - 6) to activity descriptions (e.g. WALKING, SITTING).

Used the cbind() function to combine mean_df, std_df, subject_db, and y_df.

Used the remove() function to eliminate variables, vectors, and data frames that were no longer needed.

Used the aggregate() function to calculate the mean of each column of the "HAR_df" data frame, grouping
rows by subject (person) and activity and storing the results in the "HAR_mean_df" data frame.

Used the write.table() function to write the HAR_mean_df data frame to a text file.
