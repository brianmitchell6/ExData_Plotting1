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
png(filename="plot4.png", width=480, height=480)

#set plotting parameter for 2x2 plot
par(mfrow = c(2, 2))


#**Plot the first graph to upper left position**#
plot(y=power.dates$Global_active_power, 
     x=power.dates$date.time, 
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")


#**Plot the second graph to upper right position**#
plot(y=power.dates$Voltage,
     x=power.dates$date.time,
     type="l",
     xlab="datetime",
     ylab="Voltage")


#**Plot the third graph to lower left position**#
#plot Sub_metering_1 data
plot(x=power.dates$date.time,
     y=power.dates$Sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")

#plot Sub_metering_2 data
lines(x=power.dates$date.time,
      y=power.dates$Sub_metering_2, 
      col="red")

#plot Sub_metering_3 data
lines(x=power.dates$date.time,
      y=power.dates$Sub_metering_3, 
      col="blue")

#plot legend
legend("topright", 
       lty=c(1,1,1), 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n")


#**Plot the fourth graph to the lower right position**#
plot(y=power.dates$Global_reactive_power,
     x=power.dates$date.time,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")


#close the png graphic device
dev.off()

#*****End Plot the graph*****#