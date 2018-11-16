### STEP 1 ###
Install R (https://www.r-project.org/)


### STEP 2 ###
Download the script and files you need. 

In your home directory, create a folder called "Data". 

Download the analysis script from https://github.com/rlesurf/23andme/blob/master/identify_pathogenic_variants.R and then move it into your Data folder.

Download your raw 23andme variants. On the 23andme.com website, top right corner, click on your name, then click "Browse Raw Data" and follow those instructions. Unzip the file they give you so that it has a .txt extension, and then move it into your Data folder.

Download the ClinVar database (which describes known pathogenic variants) from ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/tab_delimited/archive/ and then move it into your Data folder. The file should be named something like "variant_summary_...". Just get the most recent one. You don't have to unzip this if it has a .gz extension.


### STEP 3 ###
Point the analysis script to the 23andme and ClinVar files. To do this, open up identify_pathogenic_variants.R and modify the two early lines that start with "VARIANTS.23ANDME = " and "VARIANTS.CLINVAR = ".

If you can't figure out how to do that, alternatively just rename your files as follows:
Your 23andme file becomes -> genome_Robert_Lesurf_v3_Full_20181115153353.txt
The ClinVar file becomes -> variant_summary_2018-11.txt.gz


### STEP 4 ###
Run your analysis!

Open up the terminal on your mac and type:
cd ~/Data
Rscript identify_pathogenic_variants.R

Voila! Your results should appear as a new tab-delimited file that ends with "..._pathogenic.txt"
You can easily view this file by opening it in Excel or a similar program.
Interpreting the results will require a little effort. ClinVar lists the disease affected under the column "PhenotypeList". You'll have to Google either the "rsid" or some of the "PhenotypeIDS" to learn more about them. Nearly everyone will have some pathogenic variants in their genome, so you probably don't need to be too concerned. But if you're having a baby, they could be something to discuss with your doctor or geneticist.
