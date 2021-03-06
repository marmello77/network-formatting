# network-formatting

How to format a matrix in R to be used in different network programs.

Ecological Synthesis Lab (SintECO): https://marcomellolab.wordpress.com.

Author: Gabriel Félix.
E-mail: gabriel.felixf@hotmail.com.

How to cite: Félix G.M. 2016. How to format a matrix in R to be used in different network programs. Ecological Synthesis Lab of the University of São Paulo, Brazil.

Published on April 25th, 2017 (English version).

Run in R 3.3.3 (2017-03-06) -- "Another Canoe".

Disclaimer: You may use this script freely for non-comercial purposes at your own risk. We assume no responsibility or liability for the use of this software, convey no license or title under any patent, copyright, or mask work right to the product. We reserve the right to make changes in the software without notification. We also make no representation or warranty that such application will be suitable for the specified use without further testing or modification. If this script helps you produce any academic work (paper, book, chapter, dissertation etc.), please acknowledge the authors and cite the source, using the DOI provided and the URL to this GitHub repository.


----------------------------------------------------------------------------------------


(A) How to run the script:

1. Your network must be formatted as in the examples provided, saved as a TXT or XLSX file. Even the column names should match the examples.

1. After downloading these files, copy them to a separate folder in which to run the analysis.

2. Open RStudio. Load the "reshape2" and "xlsx" packages. If you do not already have them, install them:

Library (reshape2)
Library (xlsx)

3. Create a new script window (CMD + SHFT + N).

4. Define the working directory. Enter the path of the folder where the files in this script are:

Setwd ("write the complete folder path here")

5. Call the script file R, which is formatted as a function, using the source command:

Source ("network formatting.R")

6. Use the "inputs" function to run the network formatting script. Include the full path of the folder and the file type where you created the list of interactions; Can be ".txt" or "xlsx":

Inputs ("write the complete folder path here", files_type = ".txt")

7. Ready! Subfolders have been created in your working directory, with your network formatted for multiple programs.


----------------------------------------------------------------------------------------


(B) Details about this script for advanced users:

This script has only one function: "inputs". This function has two arguments: "dir" and "files_type"

Dir: defines where the interaction lists are to be transformed into the input files
Files_type: defines which format the lists are in, ".txt" or ".xlsx". Default is ".txt"

The required packages are: "reshape2" and "xlsx". Be sure to install them!


----------------------------------------------------------------------------------------


(C) Advanced Instructions:

Interaction lists should follow the examples ("example.txt" and "example.xlsx"), both in terms of formatting and column names. Column names in the interaction lists should be: PARTNER_1, PARTNER_2, and WEIGHT. If the lists are in TXT format, be sure to save them as a "tab-delimited" file.

This script will run for all spreadsheets, in XLSX or TXT format, depending on what is defined in "files_type" inside the folder indicated in "dir". So be sure to (i) put in this folder only the files you want to use, and (ii) structure all files as in the examples.
Only files saved in recent versions of Excel will be read.

The "xlsx" package needs newer versions of Java to run, and any Java-related error when running this script is probably caused by Java version. If you can not rotate in this format, choose to save the lists of interactions in tab-delimited format (TXT) and use files_type = ".txt".
