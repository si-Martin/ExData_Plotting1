library(dplyr)
if (!exists("dataRaw")) dataRaw <- read.csv("household_power_consumption.csv", header = TRUE, sep = ";")
dataClean <- filter(dataRaw, Date == "1/2/2007" | Date == "2/2/2007")

dataClean$Date <- gsub("1/2/2007", "2007-02-01", dataClean$Date)
dataClean$Date <- gsub("2/2/2007", "2007-02-02", dataClean$Date)
dataClean$DateTime <- as.POSIXct(paste(as.Date(dataClean$Date), dataClean$Time), format="%Y-%m-%d %H:%M:%S")

sm1 <- as.numeric(levels(dataClean$Sub_metering_1))[dataClean$Sub_metering_1]
sm2 <- as.numeric(levels(dataClean$Sub_metering_2))[dataClean$Sub_metering_2]
sm3 <- as.numeric(dataClean$Sub_metering_3)

png(file="plot3.png",width=480,height=480)
plot(sort(dataClean$DateTime), sm1, type="l", col="Black", xlab="", ylab="Energy sub metering")
lines(sort(dataClean$DateTime), sm2, type="l", col="Red")
lines(sort(dataClean$DateTime), sm3, type="l", col="Blue")
legend("topright", lty =1, col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
