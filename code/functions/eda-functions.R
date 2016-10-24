# getSummary returns the stats needed for eda
getSummary <- function(data){
	vec <- c(summary(data),
		round(IQR(data),2),
		round(range(data)[2]-range(data)[1],2), 
		round(sd(data),2))

	names(vec) <- c( "Min.","1st Qu.","Median", 
		"Mean","3rd Qu.","Max.", "IQR", "Range","SD")

	vec
}

getFreq <- function(data){
	freqList <- apply(data, 2, table)
	organize_freq(freqList, nrow(data))
	
}

# Helper function for output
organize_freq <- function(freqList, total){
	for (i in 1:length(freqList)){
		cat(names(freqList)[i], "\n")
		tb <- rbind(freqList[[i]], freqList[[i]]/total)
		rownames(tb)<- c("Count", "Relative Frequency")
		print(tb)
		cat("\n")
	}

}