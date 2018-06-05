library(car)

# Reading files in the working directory without a path did not work
path = paste0(getwd(), "/")
widths_x = rep.int(x = 16, times = 561)

# Read the variable names
colnames_filename = paste0(path, "features.txt")
colnames_df = read.delim(file = colnames_filename, header = FALSE, sep = " ")

# Read the training and test X data, using the variable names in the data frame
trainx_filename = paste0(path, "train/X_train.txt")
trainx_df = read.fwf(file = trainx_filename, widths = widths_x,
                     col.names = colnames_df[,2])

testx_filename  = paste0(path, "test/X_test.txt")
testx_df = read.fwf(file = testx_filename, widths = widths_x,
                    col.names = colnames_df[,2])

# Read the training and test subject (person) ID, and name the variable
trainsub_filename = paste0(path, "train/subject_train.txt")
trainsub_df = read.fwf(file = trainsub_filename, widths = c(2),
                       col.names = c("Subject"))

testsub_filename = paste0(path, "test/subject_test.txt")
testsub_df = read.fwf(file = testsub_filename, widths = c(2),
                      col.names = c("Subject"))

# Read the training and test Y data, and name the variable
trainy_filename = paste0(path, "train/Y_train.txt")
trainy_df = read.fwf(file = trainy_filename, widths = c(1),
                     col.names = c("Activity"))

testy_filename  = paste0(path, "test/Y_test.txt")
testy_df = read.fwf(file = testy_filename, widths = c(1),
                    col.names = c("Activity"))

# Merge the training and the test sets to create datasets for X, subject ID, and Y
x_df = rbind(trainx_df, testx_df)
subject_df = rbind(trainsub_df, testsub_df)
y_df = rbind(trainy_df, testy_df)

# Extract only the measurements on the mean and standard deviation for each measurement
mean_df = x_df[,grepl("mean()", names(x_df))]
std_df = x_df[,grepl("std()", names(x_df))]

# Use descriptive activity names to name the activities in the data set
y_df$Activity = recode(y_df$Activity, 
                       paste0("1='WALKING';2='WALKING_UPSTAIRS';3='WALKING_DOWNSTAIRS';",
                              "4='SITTING';5='STANDING';6='LAYING';else=NA"))

# Appropriately label the data set with descriptive variable names
# (Done in read.fwf by referring to colnames_df from "features.txt")

# Merge the selected X variables, subject ID, and recoded Y variable to create one dataset
HAR_df = cbind(mean_df, std_df, subject_df, y_df)

# Remove temporary objects
remove(colnames_df, colnames_filename, mean_df, std_df, subject_df)
remove(testsub_df, testsub_filename, trainsub_df, trainsub_filename)
remove(testx_df, testx_filename, testy_df, testy_filename)
remove(trainx_df, trainx_filename, trainy_df, trainy_filename)
remove(widths_x, x_df, y_df)

# Create a second, independent tidy data set with the average
# of each variable for each activity and each subject
HAR_mean_df = aggregate(HAR_df[,c(1:79)], by = list(HAR_df$Subject, HAR_df$Activity), 
                        FUN = mean, na.rm = TRUE)
colnames(HAR_mean_df)[c(1:2)] = c("Subject","Activity")

# Write table
write.table(x = HAR_mean_df, file = paste0(path, "HumanActivityRecognitionMeans.txt"), 
            quote = FALSE, row.names = FALSE)

