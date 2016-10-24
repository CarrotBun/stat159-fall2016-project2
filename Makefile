
# declare variables
reg = regressions
paper = report/report
script = code/scripts
images = $(wildcard images/*.png)
rmds = $(wildcard report/sections/*.md)
slides = slides/slides
dataset = data/Credit.csv
sdata = data/scaled-credit.csv

# declaring phony targets
.PHONY: all data tests eda ols ridge lasso pcr plsr $(reg) report slides session clean

# all
all: eda $(reg) report

# download data file
data:
	curl -o $(dataset) "http://www-bcf.usc.edu/~gareth/ISL/Credit.csv"

# run all tests through test-that
tests:
	#Rscript code/test-that.R

# phony target for eda
eda: data/eda-output.txt

ols: 

ridge: data/Ridge-Regression.RData

lasso:

pcr: data/PCR-Regression.RData

plsr:

# phony target for regression
$(reg): 
	make ols
	make ridge
	make lasso
	make pcr
	make plsr

# phony target for report
report: $(paper).pdf

# phony target for slides
slides: $(slides).html

#phony target for session-info doc
session: $(session).txt


$(paper).Rmd: $(rmds)
	cat $(rmds) > $(paper).Rmd

# generate pdf by running Rmd
$(paper).pdf: $(paper).Rmd data/$(reg).RData $(images)
	Rscript -e "library(rmarkdown); render('$(paper).Rmd','pdf_document')"

# generate summary txt file from Rscript
data/eda-output.txt: $(script)/eda-script.R $(dataset)
	Rscript $<

data/correlation-matrix.RData: $(script)/eda-script.R $(dataset)
	Rscript $<


data/Ridge-Regression.RData: $(script)/$(reg)/Ridge.R $(script)/Train-Test.R $(sdata)
	Rscript $<

data/ridge-results.txt:$(script)/$(reg)/Ridge.R $(script)/Train-Test.R $(sdata)
	Rscript $<

data/PCR-Regression.RData: $(script)/$(reg)/PCR.R $(script)/Train-Test.R $(sdata)
	Rscript $<

data/pcr-results.txt:$(script)/$(reg)/PCR.R $(script)/Train-Test.R $(sdata)
	Rscript $<


# remove report
clean:
	rm -f report/*.pdf
	rm -f slides/*.html