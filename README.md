# Tidy-data-from-Human-Activity-Recognition-Using-Smartphones-Dataset

## Project Overview
This project cleans and processes the Human Activity Recognition Using Smartphones Dataset.
The goal is to produce a tidy dataset with average values of all mean and standard deviation measurements grouped by subject and activity.

## Data Source
Original dataset: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Workflow
1. Merge the training dataset and test dataset into one complete dataset.
2. Extract only measurements of mean() and std() from all features.
3. Replace numeric activity codes with descriptive activity names.
4. Rename all variables with clear and descriptive names.
5. Create a second independent tidy dataset containing the average value of each variable for each subject and each activity.

## Output Result
The final output file is "tidy_data.txt".

### Final tidy dataset features
- Total rows: 180 rows (30 subjects × 6 activities)
- Total columns: 68 columns
- Each row represents one unique combination of one subject and one activity
- All numeric values are averaged values of the original sensor measurements

## How to run
1. Install package "dplyr"
2. Run "run_analysis.R"
3. The output file "tidy_data.txt" will be generated automatically
