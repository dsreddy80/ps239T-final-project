## Imports unstructured data from the Annenberg/Pew Archive, 
## reshapes into tabular format and cleans (further cleaning 
## still to be performed), and exports to annenberg_pew_data.csv.


# Load packages for importing and tidying data

library(readr)
library(tidyr)
library(reshape2)
library(lubridate)

# Import text file of all data from Annenberg/
# Pew Archive of Presidential Campaign Discourse 
# (text file created by copying and pasting all 12 doc files 
# provided by library into one 
# file, and saving file in .txt format -- NOTE: one manual edit made
# to file -- "Genre" tag was missing for what becomes observation 
# 1611 (Description: McGovern is inconsistent), so typed it in)

speeches <- read_file("./PresidentsAnalysis/Data.txt")

# Replace Variables with @s to indicate columns

speeches <- gsub("Year:", "@", speeches)
speeches <- gsub("Candidate:", "@", speeches)
speeches <- gsub("\r\nParty:", "@", speeches)
speeches <- gsub("Length:", "@", speeches)
speeches <- gsub("Text:", "@", speeches)

# Remove all existing line breaks

speeches <- gsub("[\r\n]", "", speeches)

# Remove all #

speeches <- gsub("#", "", speeches)

# Remove all ""
speeches <- gsub("\"", "", speeches)

# Replace "Genre" with line break to indicate row demarcations 

speeches <- gsub("Genre:", "\r\n", speeches, ignore.case = TRUE)

# Writing to file for debugging

fileConn <- file("./PresidentsAnalysis/Output")
writeLines(speeches, fileConn)
close(fileConn)

# Create rough dataframe based on row and column demaracations above

speeches.df <- read.csv(text=speeches, header=FALSE, 
                        sep="@", stringsAsFactors = FALSE, 
                        col.names = c("Genre", "Year", "Candidate", 
                                      "Party", "Length", "Text"), 
                        strip.white = TRUE, comment.char="")


# Separate columns containing multiple variables

speeches.df <- separate(speeches.df, Length, 
                        into = c("Length", "Subjects"), 
                        sep = "WORDS", extra = "merge")


speeches.df <- separate(speeches.df, Year, 
                        into = c("Year", "Date"), sep = 4, 
                        extra = "merge")

speeches.df <- separate(speeches.df, Party, 
                        into = c("Party", "City"), 
                        sep = "City: ", extra = "merge")

speeches.df <- separate(speeches.df, City, 
                        into = c("City", "State"), 
                        sep = "State: ", 
                        extra = "merge")

speeches.df <- separate(speeches.df, State, 
                        into = c("State", "Description"), 
                        sep = "Description: ", extra = "merge")

speeches.df <- separate(speeches.df, Description, 
                        into = c("Description", "Type"), 
                        sep = "Type: ", extra = "merge")

# Spot Cleaning 

speeches.df$Length <- gsub(",", "", speeches.df$Length)

speeches.df$Length <- gsub(" WORD ", "", speeches.df$Length)

speeches.df$Length <- as.numeric(speeches.df$Length)

speeches.df$Date <- gsub("Date: ", "", speeches.df$Date)

speeches.df$Subjects <- gsub("Subjects: ", "", speeches.df$Subjects)

# ISSUES FOR FURTHER CLEANING:
# Tried to remove trailing (R) and (D) for candidates, and got stuck
# Among other things, used: 
# speeches.df$Candidate <- gsub("[(D)]", "", speeches.df$Candidate) --
# removed all parentheses, leaving just lone Rs for Repubs, which 
# below code would not address
# speeches.df$Candidate <- gsub("(R)", "", speeches.df$Candidate).
# Have left issue alone for now.

# Note that after processing above, certain variables remained 
# spread across multiple columns (because of varying order in raw
# data).  The below code seems to separate and classify all jumbled 
# columns accurately --
# BUT because of issue with "separate" simply acting like paste(), 
# code leaves a bunch of character NAs that don't work like 
# regular NAs...and trying to remove all "NA" destroys text, e.g.
# Arizona becomes Arizo --
# to address later!


# Further separates differently ordered variables into duplicative 
# columns, re-unites as appropriate, then removes some of resulting
# character NAs

speeches.df <- separate(speeches.df, State, 
                        into = c("State", "Type2"), 
                        sep = "Type: ", extra = "merge")

speeches.df <- unite(speeches.df, Type, c("Type", "Type2"))

speeches.df$Type <-  gsub("NA_", "", speeches.df$Type)
speeches.df$Type <-  gsub("_NA", "", speeches.df$Type)

speeches.df <- separate(speeches.df, Party, 
                        into = c("Party", "Type2"), 
                        sep = "Type: ", extra = "merge")

speeches.df <- separate(speeches.df, Party, 
                        into = c("Party", "Descript2"), 
                        sep = "Description: ", extra = "merge")

speeches.df <- separate(speeches.df, Party, 
                        into = c("Party", "State2"), 
                        sep = "State: ", extra = "merge")

speeches.df <- unite(speeches.df, Type, c("Type", "Type2"))
speeches.df <- unite(speeches.df, State, c("State", "State2"))
speeches.df <- unite(speeches.df, Description, 
                     c("Description", "Descript2"))

speeches.df$Description <-  gsub("NA_", "", speeches.df$Description)
speeches.df$Description <-  gsub("_NA", "", speeches.df$Description)


speeches.df$State <-  gsub("NA_", "", speeches.df$State)
speeches.df$State <-  gsub("_NA", "", speeches.df$State)

speeches.df$Type <-  gsub("NA_", "", speeches.df$Type)
speeches.df$Type <-  gsub("_NA", "", speeches.df$Type)

# Removes all NAs in Type, because this does not harm data given
# existing permutations of "Type."  Does not work for State and
# Description, though, because "na" is in text.

speeches.df$Type <-  gsub("NA", "", speeches.df$Type)

# Writes reshaped and cleaned (still a work in progress!)
# tabular data to file

write.csv(speeches.df, file = "annenberg_pew_data.csv")

# Attempted work-around, given earlier problems
# with separating multiple varaiables within "Party" column
# -- created new binary columns for Party ID -- may no longer be
# needed, so leaving in comments for now)

# speeches.df$Republican <- grepl("Republican", speeches.df$Party)
# speeches.df$Democrat <- grepl("Democrat", speeches.df$Party)
# speeches.df$Independent <- grepl("Independent", speeches.df$Party)