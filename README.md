# Predicting Credit Balance  

## Synopsis  
This project's goal is to predict the average balance that the customer has remaining on their credit card after making their monthly payment. We use methods of regressions such as OLS, Ridge, Lasso, PCR, and PLSR, and cross validation to select the best model of prediction. 

## Motivation  
The motivation for this is to see if factors such as income, credit limit, rating, cards, age, gender, student status, marital status, and ethnicity would affect and predict credit balance. 

## Project Structure

* **code** folder contains all the R scripts (eda, session-info, and regressions), functions, and tests used for running regressions and producing plots.  
* **data** folder contains the raw and processed data ready to be used in the final report and presentation. In addition, it will also contain text files with summaries for the data set and the regressions.   
* **images** contains all the images produced by the R scripts. Images include histograms for data, scatterplots for regressions, validation plots, and prediction plots from the regressions.    
* **report** will contain a Rmd file with the narrative of the final report and a pdf file which is the final report created by knitting the Rmd file. There is also a folder named **sections** where all the narratives are stored.   
* The **Makefile** in this home directory can be used to create and remove all pdf, images, and txt files in this directory.   
* **LICENSE** includes the terms and details on the BSD 2-Clause License, which is the license used for code written in this assignment  
* **.gitignore** lists all files that were ignored by Git.
* **session-info.txt** include all the information about operating system, R version, and R packages used in this assignment.  
* **session.sh** contains the script for compiling software version information used in session-info.txt.  

##Installation  
Access the project by making sure you have the information in session information (software, versions, etc.) and through this repository. 

1. To download data file, run `make data` in command line. The file `Credit.csv` should be downloaded to data folder  
2. The tests used for test-that are located in test-regression.R under code/tests folder. Additional tests could be added there.  
3. To test the functions written in eda-functions and regression-functions. R, run `make tests` in command line  
4. To produce preliminary summary, correlation matrix, and histograms on the dataset, use `make eda`. Outputs/results are located in eda-output.txt and correlation-matrix.RData in data folder. Histograms and boxplots are outputted to images folder.  
5. To run regressions on the data and save relevant objects to RData, run `make regressions`. Note: this command will automatically run all the regressions used in this project(OLS, Ridge, Lasso, PCR, and PLSR)  
6. To run specific regression, use `make (regression name)`. Possible regressions are ols, ridge, lasso, pcr, and plsr. For example, if needed to run OLS regression, run `make ols`. 
7. To generate the final report, given that all previous steps worked and narrative is written in report.Rmd, run `make report`
8. To generate the presentation slides, given that all previous steps worked and narrative is written in slide.Rmd, run `make slides`
9. To see session details, run `make session`. session-info.txt file located in the home directory will be produced, and it will contain information regarding Make version, pandoc version, Git version, R version and all relevant libraries used in this project
8. Given that all scripts and data are located in correct directory, run `make all` will automatically create the final report in pdf, slides in html, and all other relevant graphs and data objects in their respective folders. 
9. To remove the final report file from report folder, use `make clean`


## Contributors  
Name: Lily Li  
Email: lily_li@berkeley.edu  
  
Name: Elly Wang  
Email: ellywjy@berkeley.edu

## License  

![License](https://i.creativecommons.org/l/by-nc/4.0/88x31.png)

All media used in this assignment is licensed under [Attribution-NonCommercial 4.0 International](http://creativecommons.org/licenses/by-nc/4.0/)  

All code used in this assignment is licensed under BSD 2-Clause License. See LICENSE in the home directory for more info. 