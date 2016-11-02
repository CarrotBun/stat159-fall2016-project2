
# declare variables
reg = regressions
paper = report/report
script = code/scripts
images = $(wildcard images/*.png)
rmds = $(wildcard report/sections/*.md)
slides = slides/slides
dataset = data/Credit.csv
sdata = data/scaled-credit.csv
session = session-info

# declaring phony targets
.PHONY: all data tests eda ols ridge lasso pcr plsr $(reg) report slides session clean

# all
all: eda $(reg) report

# download data file
data:
	curl -o $(dataset) "http://www-bcf.usc.edu/~gareth/ISL/Credit.csv"

# run all tests through test-that
tests:
	Rscript code/test-that.R

# phony target for eda
eda: data/eda-output.txt

ols: data/OLS-Regression.RData

ridge: data/Ridge-Regression.RData

lasso: data/Lasso-Regression.RData

pcr: data/PCR-Regression.RData

plsr: data/PLS-Regression.RData

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

# OLS Regression Outputs
data/OLS-Regression.RData: $(script)/$(reg)/OLS.R $(script)/Train-Test.R $(sdata)
	Rscript $<

data/ols-results.txt:$(script)/$(reg)/OLS.R $(script)/Train-Test.R $(sdata)
	Rscript $<

# Ridge Regression Outputs
data/Ridge-Regression.RData: $(script)/$(reg)/Ridge.R $(script)/Train-Test.R $(sdata)
	Rscript $<

data/ridge-results.txt:$(script)/$(reg)/Ridge.R $(script)/Train-Test.R $(sdata)
	Rscript $<

# Lasso Regression Ouputs
data/Lasso-Regression.RData: $(script)/$(reg)/Lasso.R $(script)/Train-Test.R $(sdata)
	Rscript $<

data/lasso-results.txt:$(script)/$(reg)/Lasso.R $(script)/Train-Test.R $(sdata)
	Rscript $<

# PCR Regression Ouputs
data/PCR-Regression.RData: $(script)/$(reg)/PCR.R $(script)/Train-Test.R $(sdata)
	Rscript $<

data/pcr-results.txt:$(script)/$(reg)/PCR.R $(script)/Train-Test.R $(sdata)
	Rscript $<

# PLS Regression Ouputs
data/PLS-Regression.RData: $(script)/$(reg)/PLSR.R $(script)/Train-Test.R $(sdata)
	Rscript $<

data/PLS-results.txt:$(script)/$(reg)/PLSR.R $(script)/Train-Test.R $(sdata)
	Rscript $<

$(session).txt: $(script)/$(session)-script.R
	Rscript $<

# remove report
clean:
	rm -f report/*.pdf
	rm -f images/*.png
	rm -f slides/*.html