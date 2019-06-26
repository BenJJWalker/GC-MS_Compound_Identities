# Gas Chromatography-Mass Spectrometry: Compound Identities

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3257034.svg)](https://doi.org/10.5281/zenodo.3257034)

This repository contains the R code scripts required to allocate and then subset compound identities from GC-MS text files which were converted to `.csv`, in the paper:

**Walker, B.J.J., Letnic, M., Bucknall, M.P., Watson, L., & Jordan, N.R.,** Act your age: Dingo scents code for age and wild dingoes can decipher that signal.

This code can be adapted to any text file that contains data from gas chromatography-mass spectrometry outputs. It compares both the weighted and reverse scores of an identity, and selects those identities with **both scores above 80**; since [Robley et al. (2015)](https://www.researchgate.net/profile/Alan_Robley/publication/290195212_Dingo_Semiochemicals_Towards_a_non-lethal_control_tool_for_the_management_of_dingoes_and_wild_dogs_in_Australia/links/569579c608aeab58a9a4ec2f/Dingo-Semiochemicals-Towards-a-non-lethal-control-tool-for-the-management-of-dingoes-and-wild-dogs-in-Australia.pdf) considered compounds matched <80 as unknowns, whilst those >90 were excellent and likely indicative of a correct structural identification. These scripts produce a full list of chemicals collected by the GC-MS fibre from each sample analysed. Our unsupervised process drastically reduces compound identification time from multiple months to around *30 seconds per sample*. 

Our code has been adapted from:

[Smart, KF, Aggio, RB, Van Houtte, JR & Villas-Bôas, SG 2010](https://www.ncbi.nlm.nih.gov/pubmed/20885382), 'Analytical platform for metabolome analysis of microbial cells using methyl chloroformate derivatization followed by gas chromatography-mass spectrometry', Nature Protocols, vol. 5, no. 10, pp. 1709-29.

Reasoning for using each function in the script is noted next to the function. This script will generate three reports:

    1. Un-altered subset
    2. Duplicate compounds compared to blanks
    3. Unique identifier list -> this is the list you use for PCA+DFA **


## Instructions

All analyses were done in `R`. Convert `.txt` files to `.csv` using the `Save As` function by selecting `"CSV UTF-8 (Comma delimited) (.csv)"` in Microsoft Excel.

To allocate compound identities we use the [`dplyr`](https://github.com/tidyverse/dplyr) and [`plyr`](https://github.com/tidyverse/plyr) packages for `R`, by [Wickham et al. (2017)](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf) and [Wickham (2017)](https://cran.r-project.org/web/packages/plyr/index.html). You can install `dplyr` and `plyr` using:

```r
install.packages("dplyr")
install.packages("plyr")
```

First, you need to subset each blank GC-MS `.csv` file using the code in [`1-BLANK_CODE-Compound_identities`](https://github.com/BenJJWalker/GC-MS_Compound_Identities/blob/master/Scripts/1-BLANK_CODE-Compound_identities.R). We subset four chromatogram-blank `.csv` data files; two vials at the beginning of a gc-ms run, and then the same vials re-sampled at the end of the run. You can do two blanks as a minimum; in which case you would delete redundant code from this script.

You can use the **SHIFT+COMMAND+O** to open the file's option menu for easy navigation around the document.

### Edits required before running code in [`2-SUBSET_CODE-Compound_identities`](https://github.com/BenJJWalker/GC-MS_Compound_Identities/blob/master/Scripts/2-SUBSET_CODE-Compound_identities.R) 
    

**1.** Change each of the folder addresses below to the folder where your blanks and sample are located.

```
report_folder <- "Longevity/1. Excel Files/5. Sixth Run/"
report_folder1 <- "Longevity/1. Excel Files/5. Sixth Run/"
report_folder2 <- "Longevity/1. Excel Files/5. Sixth Run/"
report_folder3 <- "Longevity/1. Excel Files/5. Sixth Run/"
report_folder4 <- "Longevity/1. Excel Files/5. Sixth Run/"
```



**2.** Change each of the file names associated with the locations above.

```
amdis_report <- "SPME_T33_M13_STREZ.csv" 
amdis_report1 <- "SPME_T0_RUN_6_BLANK_1-SUBSET.csv"
amdis_report2 <- "SPME_T0_RUN_6_BLANK_1x-SUBSET.csv"
amdis_report3 <- "SPME_T0_RUN_6_BLANK_2-SUBSET.csv"
amdis_report4 <- "SPME_T0_RUN_6_BLANK_2x-SUBSET.csv"
```



**3.** (If necessary; dependent on your analyses) Change the names of variables which you would like to retain.

```
filenames <- c("RT", "Name", "Weighted", "Reverse")
filenames1 <- c("RT", "Name", "Weighted", "Reverse")
filenames2 <- c("RT", "Name", "Weighted", "Reverse")
filenames3 <- c("RT", "Name", "Weighted", "Reverse")
filenames4 <- c("RT", "Name", "Weighted", "Reverse")
```



**4.** Change the pathway of the `Prelim` object. Ensure the encoding is `"UTF-8"` so you can retain odd symbols.

```
Prelim <- read.csv("Longevity/1. Excel Files/5. Sixth Run/SPME_T33_M13_STREZ.csv", encoding = "UTF-8")
```



**5.** Change the pathways of all `Prelim#` objects. They code for the blank files. Once you have changed this for a run/batch (i.e. all associated blanks), you do not need to do so again until you are analysing another run.

```
Prelim1 <- read.csv("Longevity/1. Excel Files/5. Sixth Run/ SPME_T0_RUN_6_BLANK_1-SUBSET.csv", encoding = "UTF-8")               
Prelim2 <- read.csv("Longevity/1. Excel Files/5. Sixth Run/ SPME_T0_RUN_6_BLANK_1x-SUBSET.csv", encoding = "UTF-8")                   
Prelim3 <- read.csv("Longevity/1. Excel Files/5. Sixth Run/ SPME_T0_RUN_6_BLANK_2-SUBSET.csv", encoding = "UTF-8")     
Prelim4 <- read.csv("Longevity/1. Excel Files/5. Sixth Run/ SPME_T0_RUN_6_BLANK_2x-SUBSET.csv", encoding = "UTF-8")               
```



**6.** Change code which removes unnecessary columns from your `.csv` file. This dependes on what variables you would like to retain, and the type of output text file your mass spec. has produced. Once edited, this does not need to change unless required.

```
removed.RT_Name$Max..Amount <- NULL
removed.RT_Name$Area <- NULL
#etc.
```


## Things to change for specific samples:
- *Demographic Information*: This information forms part of your multivariate analyses later, and can be altered to give you the information attached to each sample that is being subset. Below, the examples correspond to: dingo urine, treatment, the origin of the sample, how old the dingo was, etcetera. *It would be useful to include the name of the sampled individual.*

**7.** Get a new column for demographic information: urine treatment.

```
removed.RT_Name["Treatment"] <- NA 
removed.RT_Name$Treatment <- "t33" # Change This Every Time For The Specific Treatment
```



**8.** Get a new column for demographic information: origin of the urine.

```
removed.RT_Name["UR_Origin"] <- NA 
removed.RT_Name$UR_Origin <- "M13" # Change This Every Time For The Specific Individual
```



**9.** Get a new column for demographic information: age of the dingo.

```
removed.RT_Name["UR_Age"] <- NA 
removed.RT_Name$UR_Age <- "11" # Change This Every Time For The Specific Individual
```



**10.** Etcetera.

```
removed.RT_Name["xxxx"] <- NA 
removed.RT_Name$xxxx <- "xx" # Change This Every Time For The Specific Individual
```


**11.** Change the SUBSET-with-blanks file name.

```
sheet <- "SPME_T33_M13_STREZ-SUBSET.csv"
````



**12.** Change the code binding all datasets. This code only needs to be changed if you do not have four blanks. For instance, you would eliminate `Prelim4` if you only have three blanks.

```
total <- rbind.fill(Prelim1, Prelim2, Prelim3, Prelim4, removed.RT_Name) 
```



**13.** Change the name of the animal which donated the sample. This allows the data extraction to more easily occur as you are subsetting based on the unique name of the animal which is not present in any blanks. 

```
# Change this name every time; extracts based on UR Name
total.Extracted <- subset(total.Extracted, UR_Name == "Sterling") 
```



**14.** Change the name of the final file: the subset sample-minus-blanks.
```
sheet1 <- "SPME_T33_M13_STREZ-SUBSET-BLANKS.csv"
```

## Once all changes are complete:
Use **"OPT+COMMAND+R"** on your keyboard to run the entire script. Repeat the above edits as necessary.


## 

The [`1-BLANK_CODE-Compound_identities`](https://github.com/BenJJWalker/GC-MS_Compound_Identities/blob/master/Scripts/1-BLANK_CODE-Compound_identities.R) follows the exact same principles as this script, except we have included script which repeats (and which can be subset on its own), to cover the correct amount of blanks you may have used. This means that if you have three blanks, say, you would change the three parts of the script related to each, and delete the fourth part, so that after all edits, you only need to run the script once to get all `.csv` files required.

## NOTE*: Ordering and clear management of all files (`.csv, .txt, etc.`) on your operating system is a *must*, and will make this process much easier. 
