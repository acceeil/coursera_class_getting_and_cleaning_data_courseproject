Coursera Class #2: Course Project 
==================================

The packages **plyr** and **dplyr** are required for this script. It is assumed that the 
 UCI HAR Dataset folder has already been downloaded to the working directory. 
 
 Step 0. The script is started with reading all necessary files into R:
 ================
 
- 'features.txt': List of all features.--stored as *features*

- 'activity_labels.txt': Links the class labels with their activity name.--
     stored as *activity_labels*

- 'train/X_train.txt': Training set.--stored as *training_set*

- 'train/y_train.txt': Training labels.--stored as *training_labels*

- 'test/X_test.txt': Test set.--stored as *test_set*

- 'test/y_test.txt': Test labels.--stored as *test_labels*

- 'subject_train.txt':Each row identifies the subject who performed the activity 
   for each window sample. Its range is from 1 to 30--stored as *subject_test*
   
- 'subject_test.txt':Each row identifies the subject who performed the activity 
   for each window sample. Its range is from 1 to 30--stored as *subject_test*
  
Step 1. Merge test and training sets to create on data set
===================================================================
- used the rbind fouction to combine the test and training datasets and stored it
  as dataset--stored as *dataset*
  
- Subset the variable names(column names) from *features* dataset and rename the
  column names of the *dataset*

Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
=============================================================================
- Using **grep** function to extract the measurements on the mean for each
   measurement first and stored as-*subset_mean*. Using -mean() as the pattern to
   be matched. fixed= FALSE, so only the mean variable measurments are extracted. 
   Varibales with meanFreq() are not extracted. Based on feature_info.txt, it's
   another varible not the mean variable. 
   
- Using **grep** function to extract the measurements on the mean for each
   measurement first and stored as-*subset_std*. Using -std() as the pattern to
   be matched. fixed= FALSE, so only the std variable measurments are extracted. 
  
- Using **cbind** function, combine *subset_mean* and *subset_std*, and at the 
  same time add subjects and activity columns to the dataset. Stored as *subset*
  
Step 3. Uses descriptive activity names to name the activities in the data set
==========
- Using **factor** and *acitivty_lables* dataset to change the index number in activity column to descriptive
  activity names. 
  
Step 4. Appropriately labels the data set with descriptive variable names
===
After reading the feature.info document, following changes are made to the variable 
names. function **gsub**are used. 
- change t to Signal from Time Domain
- change f to signal from Frequency Domain
- change Acc to Accelerometer
- change Gyn to Gynoscope
- change Mag to Magnitude
- change std to standard deviation
- change mean to mean value
- cange -X, -Y, -Z to in X/Y/Z direction

Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
===========================================================================

- Used package plyr and dply and function **group_by**and **summarise_each** and 
and stored as *subset2*

