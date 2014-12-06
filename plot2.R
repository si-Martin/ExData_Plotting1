#library(dplyr)
if (!exists("dataRaw")) dataRaw <- read.csv("household_power_consumption.csv", header = TRUE, sep = ";")
dataClean <- filter(dataRaw, Date == "1/2/2007" | Date == "2/2/2007")
DataF <- read.table(text = "",  colClasses = c("numeric", "numeric"),  col.names = c("Class", "Frequency"))

dataClean$Date <- gsub("1/2/2007", "2007-02-01", dataClean$Date)
dataClean$Date <- gsub("2/2/2007", "2007-02-02", dataClean$Date)
dataClean$DateTime <- as.POSIXct(paste(as.Date(dataClean$Date), dataClean$Time), format="%Y-%m-%d %H:%M:%S")

print (DataF$day)
f <- dataClean$Global_active_power
g <- as.numeric(levels(f))[f]

png(file="plot2.png",width=480,height=480)
plot(sort(dataClean$DateTime), g, type="l", xlab="", ylab="Global Active Power (in kilowatts")
dev.off()