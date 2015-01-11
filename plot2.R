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
power <- read.table(fpath, header=TRUE, sep=";", row.names=NULL, na.strings="?")

#filter for dates:2-1-2007 and 2-2-2007
power.dates <- power[power$Date=="1/2/2007"|power$Date=="2/2/2007",]

#combine date and time columns into single column with appropriate format
dt.col <- paste(power.dates$Date, power.dates$Time)
dt.format <- "%d/%m/%Y %H:%M:%S"
power.dates$date.time <- strptime(dt.col, dt.format)

#*****End Extract data file into data frame*****#

#*****Begin Plot the graph*****#

#open a png graphic file device
png(filename="plot2.png", width=480, height=480)

#plot a line graph to the png file
plot(y=power.dates$Global_active_power, 
     x=power.dates$date.time, 
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

#close the png graphic file device
dev.off()

#*****End Plot the graph*****#
