#*****Begin Extract data file into data frame*****#

#create temporary directory and placeholder file
td <- tempdir() 
tf <- tempfile(tmpdir=td, fileext=".zip")  

#download file to temporary file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, tf)

#get the name of the zip file and unzip
fname <- unzip(tf, list=TRUE)$Name[1]
unzip(tf, files=fname, exdir=td, overwrite=TRUE)

#get the full path to the extracted file
fpath = file.path(td, fname)

#read file into data frame
power <- read.table(fpath, header=TRUE, sep=".", row.names=NULL)
