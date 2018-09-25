# Subsetting Script for Four-Blank Protocol - BLANKS
# CC-By-4.0 Licence
# Use The Command: "OPT + COMMAND + R" to run this script when edits are complete

# THINGS TO CHANGE EACH TIME YOU ANALYSE A FILE
#####################################################
# 1st line - This field has to be filled with the folder address where the raw data and the AMDIS report are.

report_folder <- "Longevity/1. Excel Files/5. Sixth Run/"

######################### BLANK 1 ############################
# 2nd line - This field has to be filled with the name of the AMDIS report file, including the extension.
amdis_report <- "SPME_T0_RUN_6_BLANK_1.csv"

#####################################################
# 3rd line - This line has to be filled with the name of the samples analyzed and present in the AMDIS report file. The name has to be unique to identify each sample.
filenames <- c("RT", "Name", "Weighted", "Reverse")

# What To Read In ###########################################
library(dplyr)

Prelim <- read.csv("Longevity/1. Excel Files/5. Sixth Run/SPME_T0_RUN_6_BLANK_1.csv", encoding = "UTF-8")

str(Prelim)
names(Prelim)

prelim.sub1 <- subset(Prelim, Weighted > 79 & Reverse > 79) 

duplicated(prelim.sub1$RT)
removed.RT <- prelim.sub1[!duplicated(prelim.sub1$RT), ] # This removes the lower valued duplicate Retention Times. 

removed.RT_Name <- removed.RT[!duplicated(removed.RT$Name), ] # This removes the duplicated names, so it doesnt matter what the match is, as long as it's >79 for the Weighted, and >1 for the Reverse. I.e. the first name occurrence is preserved.

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

# GETTING new column to delineate Treatment
removed.RT_Name["Treatment"] <- NA 
removed.RT_Name$Treatment <- "None" # CHANGE THIS EVERYTIME FOR THE SPECIFIC TREATMENT

# GETTING new column to delineate Urine Origin (Identity)
removed.RT_Name["UR_Origin"] <- NA 
removed.RT_Name$UR_Origin <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Age
removed.RT_Name["UR_Age"] <- NA 
removed.RT_Name$UR_Age <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Subspecies"] <- NA 
removed.RT_Name$UR_Subspecies <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Name"] <- NA 
removed.RT_Name$UR_Name <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Sex"] <- NA 
removed.RT_Name$UR_Sex <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

## Calculation Variables ###############################################
# GETTING new column of % TIC to all raw abundances
removed.RT_Name["PC.TIC"] <- NA 
# Create total of all base peaks
removed.RT_Name$PC.TIC <- (removed.RT_Name$Base.Peak)/sum(as.numeric(removed.RT_Name$Base.Peak))*100

# GETTING new column to delineate  Sample Number
removed.RT_Name["Longevity.Sample"] <- NA 
removed.RT_Name$Longevity.Sample <- "None" # CHANGE THIS EVERYTIME FOR THE SPECIFIC TREATMENT

# pasting 2nd report ##################################################

confirmation <- paste("File", removed.RT_Name, "done!", sep=" ")
print(confirmation)
names(removed.RT_Name)
                                                          
#Create new file
sheet <- "SPME_T0_RUN_6_BLANK_1-SUBSET.csv"
store <- paste(report_folder, sheet)
write.csv(removed.RT_Name, file=store, fileEncoding = "UTF-8")
# NEED to manually delete the repeated CAS number ones that have no number, impossible to delete all "Zero" ones that aren't CAS identified **********************************************************************************************



# do all blanks on one script, repeated 4 times***



######################### BLANK 2 ############################
# 2nd line - This field has to be filled with the name of the AMDIS report file, including the extension.
amdis_report <- "SPME_T0_RUN_6_BLANK_1x.csv"

#####################################################
# 3th line - This line has to be filled with the name of the samples analyzed and present in the AMDIS report file. The name has to be unique to identify each sample.
filenames <- c("RT", "Name", "Weighted", "Reverse")

# What To Read In ###########################################
library(dplyr)

Prelim <- read.csv("Longevity/1. Excel Files/5. Sixth Run/SPME_T0_RUN_6_BLANK_1x.csv", encoding = "UTF-8")

str(Prelim)
names(Prelim)

prelim.sub1 <- subset(Prelim, Weighted > 79 & Reverse > 79)

duplicated(prelim.sub1$RT)
removed.RT <- prelim.sub1[!duplicated(prelim.sub1$RT), ] # This removes the lower valued duplicate Retention Times.

removed.RT_Name <- removed.RT[!duplicated(removed.RT$Name), ] # This removes the duplicated names, so it doesnt matter what the match is, as long as it's >79 for the Weighted, and >1 for the Reverse. I.e. the first name occurrence is preserved.

removed.RT_Name

#How to make new data file ###########################################
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

# GETTING new column to delineate Treatment
removed.RT_Name["Treatment"] <- NA 
removed.RT_Name$Treatment <- "None" # CHANGE THIS EVERYTIME FOR THE SPECIFIC TREATMENT

# GETTING new column to delineate Urine Origin (Identity)
removed.RT_Name["UR_Origin"] <- NA 
removed.RT_Name$UR_Origin <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Age
removed.RT_Name["UR_Age"] <- NA 
removed.RT_Name$UR_Age <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Subspecies"] <- NA 
removed.RT_Name$UR_Subspecies <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Name"] <- NA 
removed.RT_Name$UR_Name <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Sex"] <- NA 
removed.RT_Name$UR_Sex <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

## Calculation Variables ###############################################
# GETTING new column of % TIC to all raw abundances
removed.RT_Name["PC.TIC"] <- NA 

# Create total of all base peaks
removed.RT_Name$PC.TIC <- (removed.RT_Name$Base.Peak)/sum(as.numeric(removed.RT_Name$Base.Peak))*100

# GETTING new column to delineate  Sample Number
removed.RT_Name["Longevity.Sample"] <- NA 
removed.RT_Name$Longevity.Sample <- "None" # CHANGE THIS EVERYTIME FOR THE SPECIFIC TREATMENT

# pasting 2nd report ##################################################

confirmation <- paste("File", removed.RT_Name, "done!", sep=" ")
print(confirmation)
names(removed.RT_Name)

#Create new file
sheet <- "SPME_T0_RUN_6_BLANK_1x-SUBSET.csv"
store <- paste(report_folder, sheet)
write.csv(removed.RT_Name, file=store, fileEncoding = "UTF-8")
# NEED to manually delete the repeated CAS number ones that have no number, impossible to delete all "Zero" ones that aren't CAS identified **********************************************************************************************





######################### BLANK 3 ############################
# 2nd line - This field has to be filled with the name of the AMDIS report file, including the extension.
amdis_report <- "SPME_T0_RUN_6_BLANK_2.csv"

#####################################################
# 3rd line - This line has to be filled with the name of the samples analyzed and present in the AMDIS report file. The name has to be unique to identify each sample.
filenames <- c("RT", "Name", "Weighted", "Reverse")

# What To Read In ###########################################
library(dplyr)

Prelim <- read.csv("Longevity/1. Excel Files/5. Sixth Run/SPME_T0_RUN_6_BLANK_2.csv", encoding = "UTF-8")

str(Prelim)
names(Prelim)

prelim.sub1 <- subset(Prelim, Weighted > 79 & Reverse > 79)

duplicated(prelim.sub1$RT)
removed.RT <- prelim.sub1[!duplicated(prelim.sub1$RT), ] # This removes the lower valued duplicate Retention Times.

removed.RT_Name <- removed.RT[!duplicated(removed.RT$Name), ] # This removes the duplicated names, so it doesnt matter what the match is, as long as it's >79 for the Weighted, and >1 for the Reverse. I.e. the first name occurrence is preserved.

removed.RT_Name

#How to make new data file ###########################################
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

# GETTING new column to delineate Treatment
removed.RT_Name["Treatment"] <- NA 
removed.RT_Name$Treatment <- "None" # CHANGE THIS EVERYTIME FOR THE SPECIFIC TREATMENT

# GETTING new column to delineate Urine Origin (Identity)
removed.RT_Name["UR_Origin"] <- NA 
removed.RT_Name$UR_Origin <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Age
removed.RT_Name["UR_Age"] <- NA 
removed.RT_Name$UR_Age <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Subspecies"] <- NA 
removed.RT_Name$UR_Subspecies <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Name"] <- NA 
removed.RT_Name$UR_Name <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Sex"] <- NA 
removed.RT_Name$UR_Sex <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

## Calculation Variables ###############################################
# GETTING new column of % TIC to all raw abundances
removed.RT_Name["PC.TIC"] <- NA 

# Create total of all base peaks
removed.RT_Name$PC.TIC <- (removed.RT_Name$Base.Peak)/sum(as.numeric(removed.RT_Name$Base.Peak))*100

# GETTING new column to delineate  Sample Number
removed.RT_Name["Longevity.Sample"] <- NA 
removed.RT_Name$Longevity.Sample <- "None" # CHANGE THIS EVERYTIME FOR THE SPECIFIC TREATMENT

# pasting 2nd report ##################################################

confirmation <- paste("File", removed.RT_Name, "done!", sep=" ")
print(confirmation)
names(removed.RT_Name)

#Create new file
sheet <- "SPME_T0_RUN_6_BLANK_2-SUBSET.csv"
store <- paste(report_folder, sheet)
write.csv(removed.RT_Name, file=store, fileEncoding = "UTF-8")
# NEED to manually delete the repeated CAS number ones that have no number, impossible to delete all "Zero" ones that aren't CAS identified **********************************************************************************************





######################### BLANK 4 ############################
# 2nd line - This field has to be filled with the name of the AMDIS report file, including the extension.
amdis_report <- "SPME_T0_RUN_6_BLANK_2x.csv"

#####################################################
# 3rd line - This line has to be filled with the name of the samples analyzed and present in the AMDIS report file. The name has to be unique to identify each sample.
filenames <- c("RT", "Name", "Weighted", "Reverse")

# What To Read In ###########################################
library(dplyr)

Prelim <- read.csv("Longevity/1. Excel Files/5. Sixth Run/SPME_T0_RUN_6_BLANK_2x.csv", encoding = "UTF-8")

str(Prelim)
names(Prelim)

prelim.sub1 <- subset(Prelim, Weighted > 79 & Reverse > 79) 

duplicated(prelim.sub1$RT)
removed.RT <- prelim.sub1[!duplicated(prelim.sub1$RT), ] # This removes the lower valued duplicate Retention Times.

removed.RT_Name <- removed.RT[!duplicated(removed.RT$Name), ] # This removes the duplicated names, so it doesnt matter what the match is, as long as it's >79 for the Weighted, and >1 for the Reverse. I.e. the first name occurrence is preserved.

removed.RT_Name

#How to make new data file ###########################################
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

# GETTING new column to delineate Treatment
removed.RT_Name["Treatment"] <- NA 
removed.RT_Name$Treatment <- "None" # CHANGE THIS EVERYTIME FOR THE SPECIFIC TREATMENT

# GETTING new column to delineate Urine Origin (Identity)
removed.RT_Name["UR_Origin"] <- NA 
removed.RT_Name$UR_Origin <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Age
removed.RT_Name["UR_Age"] <- NA 
removed.RT_Name$UR_Age <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Subspecies"] <- NA 
removed.RT_Name$UR_Subspecies <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Name"] <- NA 
removed.RT_Name$UR_Name <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

# GETTING new column to delineate Urine Subspecies
removed.RT_Name["UR_Sex"] <- NA 
removed.RT_Name$UR_Sex <- "Control" # CHANGE THIS EVERYTIME FOR THE SPECIFIC INDIVIDUAL

## Calculation Variables ###############################################
# GETTING new column of % TIC to all raw abundances
removed.RT_Name["PC.TIC"] <- NA 

# Create total of all base peaks
removed.RT_Name$PC.TIC <- (removed.RT_Name$Base.Peak)/sum(as.numeric(removed.RT_Name$Base.Peak))*100

# GETTING new column to delineate  Sample Number
removed.RT_Name["Longevity.Sample"] <- NA 
removed.RT_Name$Longevity.Sample <- "None" # CHANGE THIS EVERYTIME FOR THE SPECIFIC TREATMENT

# pasting 2nd report ##################################################

confirmation <- paste("File", removed.RT_Name, "done!", sep=" ")
print(confirmation)
names(removed.RT_Name)

#Create new file
sheet <- "SPME_T0_RUN_6_BLANK_2x-SUBSET.csv"
store <- paste(report_folder, sheet)
write.csv(removed.RT_Name, file=store, fileEncoding = "UTF-8")
# NEED to manually delete the repeated CAS number ones that have no number, impossible to delete all "Zero" ones that aren't CAS identified **********************************************************************************************

# END ***************************************************************************                                                          