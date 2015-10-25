Code name run_analysis.R


This script was developped only to perform a specific action.  You can just submit the script to get the final result
of a tidy dataset/file which will have the aggregated mean and std variables group by test/training subject and the activities.

You can select the whole content from your windows system and execute together.

Below is the proces flow.

1. It will create an executing directory in your working directory with name GETDATA033
2. the latest content would be downloaded and unzipped in the executing directory.
3. Final datasets are calculated and finally two files are created.
4. The final output would there is the location "/GETDATA033/UCI HAR Dataset/" with name getdata-033.txt
5. Also there is one additional file as getdata-033_All_mean_std.txt , which contains the raw data marged together for any further analysis.


Once done with work delete the folder "/GETDATA033/" and clear the temp content rm(list = ls()) for zero foot print.