# Subsetting Script for Four-Blank Protocol - SAMPLES
# CC-By-4.0 Licence
# Use The Command: "OPT + COMMAND + R" to run this script when edits are complete

# Things To Change Each Time You Analyse A GC-MS Text File
####################################################
# 1st line - This field needs to be filled with the folder address where the raw data and the AMDIS report are.

report_folder <- "Longevity/1. Excel Files/5. Sixth Run/"
report_folder1 <- "Longevity/1. Excel Files/5. Sixth Run/"
report_folder2 <- "Longevity/1. Excel Files/5. Sixth Run/"
report_folder3 <- "Longevity/1. Excel Files/5. Sixth Run/"
report_folder4 <- "Longevity/1. Excel Files/5. Sixth Run/"

#####################################################
# 2nd line - This field needs to be filled with the name of the AMDIS report file, including the extension.
amdis_report <- "SPME_T33_M13_STREZ.csv"
amdis_report1 <- "SPME_T0_RUN_6_BLANK_1-SUBSET.csv"
amdis_report2 <- "SPME_T0_RUN_6_BLANK_1x-SUBSET.csv"
amdis_report3 <- "SPME_T0_RUN_6_BLANK_2-SUBSET.csv"
amdis_report4 <- "SPME_T0_RUN_6_BLANK_2x-SUBSET.csv"

#####################################################
# 3rd line - This line needs to be filled with the name of the samples analysed and present in the AMDIS report file. The name needs to be unique to identify each sample.
filenames <- c("RT", "Name", "Weighted", "Reverse")
filenames1 <- c("RT", "Name", "Weighted", "Reverse")
filenames2 <- c("RT", "Name", "Weighted", "Reverse")
filenames3 <- c("RT", "Name", "Weighted", "Reverse")
filenames4 <- c("RT", "Name", "Weighted", "Reverse")

# What To Read In ###########################################
library(dplyr)

Prelim <- read.csv("Longevity/1. Excel Files/5. Sixth Run/SPME_T33_M13_STREZ.csv", encoding = "UTF-8")

str(Prelim)
names(Prelim)

Prelim1 <- read.csv("Longevity/1. Excel Files/5. Sixth Run/ SPME_T0_RUN_6_BLANK_1-SUBSET.csv", encoding = "UTF-8")        
Prelim2 <- read.csv("Longevity/1. Excel Files/5. Sixth Run/ SPME_T0_RUN_6_BLANK_1x-SUBSET.csv", encoding = "UTF-8")       
Prelim3 <- read.csv("Longevity/1. Excel Files/5. Sixth Run/ SPME_T0_RUN_6_BLANK_2-SUBSET.csv", encoding = "UTF-8")     
Prelim4 <- read.csv("Longevity/1. Excel Files/5. Sixth Run/ SPME_T0_RUN_6_BLANK_2x-SUBSET.csv", encoding = "UTF-8")               

prelim.sub1 <- subset(Prelim, Weighted > 79 & Reverse > 79) # Actual Subset Function

duplicated(prelim.sub1$RT)
removed.RT <- prelim.sub1[!duplicated(prelim.sub1$RT), ] # This removes the lower valued duplicate Retention Times

removed.RT_Name <- removed.RT[!duplicated(removed.RT$Name), ] # This removes the duplicated names, so it doesn’t matter what the match is, as long as it's >79 for the Weighted, and >1 for the Reverse. I.e. the first name occurrence is preserved.

removed.RT_Name

#####################################################
# ?paste # both prelim subset and the blanks (together in the one dataframe)

# Then run duplicated()
# Then do removed version 2 ######################################

# i.e. remove compounds that occur twice, and then paste the remaining list of unique compounds into a nice new file
# subset again based on where the compound is from: i.e. the compounds from dingo urine stay, the ones not dingo go
# remember, this is subsetting based on Retention Time; may get complex if all RT are different

# This means you will have 3 reports generated:
# 1. unaltered subset
# 2. duplicate compounds compared to blanks
# 3. unique identifier list -> this is the list you use for PCA+DFA **

#How to make new data file ###########################################

# These four lines get a subset, unedited data sheet (.csv.csv)
# 1. first report
extension <- ".csv"
location <- c(report_folder, amdis_report, extension)
location <- paste(location, collapse = "")
write.csv(removed.RT_Name, file=location, fileEncoding = "UTF-8")


# Remove unnecessary columns ##########################
removed.RT_Name$Max..Amount <- NULL
removed.RT_Name$Area <- NULL
removed.RT_Name$Intgr.Signal <- NULL
removed.RT_Name$Max..Area <- NULL
removed.RT_Name$Extra.Width <- NULL
# removed.RT_Name$Models <- NULL # -> for m/z
removed.RT_Name$Frac..Good <- NULL
removed.RT_Name$Expec..RT <- NULL
removed.RT_Name$RI.RI.lib. <- NULL
removed.RT_Name$Net <- NULL
removed.RT_Name$Simple <- NULL
removed.RT_Name$Corrections <- NULL
removed.RT_Name$X.m.z. <- NULL
removed.RT_Name$S.N..m.z. <- NULL
removed.RT_Name$Area....m.z. <- NULL
removed.RT_Name$Conc. <- NULL
removed.RT_Name$RT.RT.lib. <- NULL
removed.RT_Name$extension <- NULL

# Getting new column to delineate Treatment
removed.RT_Name["Treatment"] <- NA 
removed.RT_Name$Treatment <- "t33" # Change This Every Time For The Specific Treatment

# Getting new column to delineate Urine Origin (Identity)
removed.RT_Name["UR_Origin"] <- NA 
removed.RT_Name$UR_Origin <- "M13" # Change This Every Time For The Specific Individual

# Getting new column to delineate Urine Age
removed.RT_Name["UR_Age"] <- NA 
removed.RT_Name$UR_Age <- "11" # Change This Every Time For The Specific Individual

# Getting new column to delineate Urine Subspecies
removed.RT_Name["UR_Subspecies"] <- NA 
removed.RT_Name$UR_Subspecies <- "Alpine" # Change This Every Time For The Specific Individual

# Getting new column to delineate Urine Subspecies
removed.RT_Name["UR_Name"] <- NA 
removed.RT_Name$UR_Name <- "Sterling" # Change This Every Time For The Specific Individual

# Getting new column to delineate Urine Subspecies
removed.RT_Name["UR_Sex"] <- NA 
removed.RT_Name$UR_Sex <- "Male" # Change This Every Time For The Specific Individual

## Calculation Variables ###############################################
# GETTING new column of % TIC to all raw abundances
removed.RT_Name["PC.TIC"] <- NA 
# Create total of all base peaks
removed.RT_Name$PC.TIC <- (removed.RT_Name$Base.Peak)/sum(as.numeric(removed.RT_Name$Base.Peak))*100

# GETTING new column to delineate Sample Number
removed.RT_Name["Longevity.Sample"] <- NA 
removed.RT_Name$Longevity.Sample <- "9" # Change This Every time For The Specific Treatment

# pasting 2nd report ##################################################

confirmation <- paste("File", removed.RT_Name, "done!", sep=" ") 
print(confirmation) 
names(removed.RT_Name)

#Create new file
sheet <- "SPME_T33_M13_STREZ-SUBSET.csv"
store <- paste(report_folder, sheet)
write.csv(removed.RT_Name, file=store, fileEncoding = "UTF-8")
#### Creating New Dataframe Of All Blanks And Sample ####

# binds the datasets
library(plyr)
total <- rbind.fill(Prelim1, Prelim2, Prelim3, Prelim4, removed.RT_Name) 

total.Extracted <- total[!duplicated(total$Name), ] # Removes duplicate rows

# Change this name every time; extracts based on UR Name
total.Extracted <- subset(total.Extracted, UR_Name == "Sterling") 
total.Extracted

# pasting 3rd report ##############################################

confirmation1 <- paste("File", total.Extracted, "done!", sep=" ")
print(confirmation1)
names(total.Extracted)

#Create new file
sheet1 <- "SPME_T33_M13_STREZ-SUBSET-BLANKS.csv"
store <- paste(report_folder, sheet1)
write.csv(total.Extracted, file=store, fileEncoding = "UTF-8")                                         
# END ***************************************************************************
