library(dplyr)
if (!exists("dataRaw")) dataRaw <- read.csv("household_power_consumption.csv", header = TRUE, sep = ";")
dataClean <- filter(dataRaw, Date == "1/2/2007" | Date == "2/2/2007")

dataClean$Date <- gsub("1/2/2007", "2007-02-01", dataClean$Date)
dataClean$Date <- gsub("2/2/2007", "2007-02-02", dataClean$Date)
dataClean$DateTime <- as.POSIXct(paste(as.Date(dataClean$Date), dataClean$Time), format="%Y-%m-%d %H:%M:%S")

f <- dataClean$Global_active_power
g <- as.numeric(levels(f))[f]

sm1 <- as.numeric(levels(dataClean$Sub_metering_1))[dataClean$Sub_metering_1]
sm2 <- as.numeric(levels(dataClean$Sub_metering_2))[dataClean$Sub_metering_2]
sm3 <- as.numeric(dataClean$Sub_metering_3)

png(file="plot4.png",width=480,height=480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(sort(dataClean$DateTime), sm1, type="l", col="Black", xlab="", ylab="Energy sub metering")
lines(sort(dataClean$DateTime), sm2, type="l", col="Red")
lines(sort(dataClean$DateTime), sm3, type="l", col="Blue")
legend("topright", lty =1, col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.7)
plot(sort(dataClean$DateTime), dataClean$Voltage, type="l", col="Black", xlab="datetime", ylab="Voltage")
plot(sort(dataClean$DateTime), g, type="l", xlab="", ylab="Global Active Power")
plot(sort(dataClean$DateTime), dataClean$Global_reactive_power, type="l", col="Black", xlab="datetime", ylab="Global Reactive Power")
dev.off()
