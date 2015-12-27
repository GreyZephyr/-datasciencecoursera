setwd('~/Coursera/GetandCleanData/Week1/')

library(xlsx)
library(XML)
library(data.table)

q1fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
q1file <- './data/q1data.csv'
q3fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx "
q3file <- "./data/q3data.xlsx"
q4URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
q4file <-"./data/q4data.xml"
q5URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
q5file <- "./data/q5data.csv"

if(! file.exists("data")) {
  dir.create("data")
}

download.file(q1fileURL,q1file,method = 'curl')
downloadedDate <- date()

data <- read.csv(q1file,header = TRUE)

# Solution
sum(!is.na(data[data$VAL ==24,"VAL"]))

# Question 3
download.file(q3fileURL,q3file,method = "curl")
colIndex = 7:15
rowIndex = 18:23
dat <- read.xlsx(q3file,sheetIndex = 1,header = TRUE,colIndex = colIndex,rowIndex = rowIndex)

sum(dat$Zip*dat$Ext,na.rm=T) 

# Question 4
download.file(q4URL,q4file,method = "curl")
doc <- xmlTreeParse(q4file,useInternal=TRUE)
rootNode <- xmlRoot(doc)
zipcode <- xpathSApply(rootNode,"//zipcode",xmlValue)
sum(zipcode == "21231")

# Question 5
download.file(q5URL,q5file,method = "curl")
DT <- fread(q5file)

#correct answer is DT[,mean(pwgtp15),by=SEX] but not actually fastest on my machine.
