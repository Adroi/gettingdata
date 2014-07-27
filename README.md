gettingdata
===========

Project for Data Science part 3


################################

The code in run_analysis.R downloads the raw data from the online archive.

The data are in three main parts:
1)The number of the subject performing the test (1-30)
2)The activity undertaken, eg walking. Values are encoded 1-6
3)A series of measurements for each combination of the above, consisting of 561 columns of data

Additional datasets provide the names for the activity values, and for the column headings in the main dataset.

The datasets for the training and test data are combined, and then subsetted to retain those columns which relate to means and standard deviations

From this output dataset, the means are calculated for each subject and activity combination, resulting in 180 rows of data.

The output txt file is tab delimited (\t)