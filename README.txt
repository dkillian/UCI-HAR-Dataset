This describes my approach to the anaylsis of the data collect on a group of 30 volunteers who wore an activity sensing cell phone to determine their activity.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
The dataset is called UCI-HAR-Dataset and it includes the following files:
The CodeBook text includes a description of  the variables

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

My initial approach was to read the testing data into R
  Then I labeled all the data columns
  And added a new column to identify the individual subjects and called with data_subj_test
  Once the subject information was included I then added information on the activity usby adding a column that describes the activity (sittin, standing etc)
  This data was called activity and the combined data set was called testdata
  I repeated all of these steps; read the files, add the subject and activity information to the training data set 
  and this is called traindata
  These two sets were combined into one large data frame using rbind with the training data going below the testing data
  To facilitate further analysis I removed invalid characters from the column names specifically the (), using the make.names function
  I further modified the data set to select out only the data that was expressed as a mean or standard deviation (std)
  I accomplished this by first arranging the data into measurement, value, subject and activity
  using the gather function
  Then I arranged and grouped the data based upon the subject and activity 
  This data set was called groupmerge (a grouping of merged data)
  The final step was to summarise the data by obtaining the average of the measurements (mean) using the summarize function
  This data is called sumgroup and represents a summary of the data that is grouped by subject and activity
  I then converted this data to a text file using the write.table function
  The resulting file is called sumgrouptxt
  
