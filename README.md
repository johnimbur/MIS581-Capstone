# MIS581-Capstone

# Welcome to the Capstone project for MIS581 for John Imbur in the Colorado State Global MS in Data Analytics.
# The project is a data analysis project for the Unitarian Universalist Association (UUA) that looks at
# the General Social Survey (GSS) from 2018 administered by NORC out of the University of Chicago. The data
# was acquired using the https://gssdataexplorer.norc.org/ and can be found in the files in the repository
# with the naming convention GSS_[yyyy]_raw.csv where [yyyy] is the year in question.
#
# The GSS is a longitudinal social survey that captures demographic data as well as attitudes towards social
# issues every other year in a bi-annual survey that is administered on even years. Each survey roughly 2500
# surveys are administered and captured.
# 
# This project assesses responses based on answers regarding religious strength as well as questions related
# to racial equity and policing with the hope of exploring the possible relationships between these factors
# as well as political and religious affiliation.
#
# The methodology is to "score" different fields using formulas in an Excel spreadsheet modelled after the
# sample found in the GSS_2016_rosetta.xlsx file. The rankings are 1 to 7 with a zero for unknown or misssing
# data. Each field with a non-zero value was then flagged accordingly as containing a value. The values were
# then summed divided by the sum of the flags for a mean score, which was then had one subtracted from it and
# normalized from 0 to 1. This same methodology was used for religiosity strength and racial equity attitudes.
#
# The transformed data was then saved into the GSS_2016.csv file which was used to look at the distribution of
# religious groupings [liberal faith, moderate faith, fundamentalist faith] in categories of 1, 2, and 3
# respectively as well as political persuasion ranging from extremely conservative to extremely liberal, again
# from a scale of 1 to 7. The distribution of the racial equity index that was calculated was observed overall
# as well as each religious category and was seen to be a normal distribution, so in line for linear regression.
# The linear regression matrix was then run for the aggregated totals and it was shown that there was a
# statistically relevant relationship for both the racial equity index as well as the religiosity strength index
# when compared to the political persuasion value. Across all religious categories, the more liberal the higher
# the racial equity index, but the lower the religiosity strength index.
#
# The data analysis was done using SAS and the source code can be found in the capstone.sas file.
#
# The paper can be found in the module_8__CriticalThinking__Option1__john_imbur.doc file.
#
# The presentation can be found in the module_8__CriticalThinking__Option1__john_imbur.ppt file.
