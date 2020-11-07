This is a project to analyze the training and test data of the UCI HAR Data set.
The repository includes the following files:

-'README.md' 
Markdown file for the project.

-'run_analysis.R'
The R script used for the project. It first retrieves and combines the training and test data set, then selects the features of interest, in this case, those associated with mean and standard deviation of certain observations. The variables in the data set are then properly labeled to indicate the data related to specific subjects and different activities the subjects were conducting. Finally, the script summarizes the mean values of the variables of interest grouped by subject and activity and outputs the summary table. 

-'average_id&activity.txt'
Summarized data set group by subject and activity from run_analysis.R.

-'Code_book.md'
An updated code book describing the details of the variables, including names and units, as well as the original source of the data set. 