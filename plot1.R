library(dplyr)
if (!exists("dataRaw")) dataRaw <- read.csv("household_power_consumption.csv", header = TRUE, sep = ";")
dataClean <- filter(dataRaw, Date == "1/2/2007" | Date == "2/2/2007")

f <- dataClean$Global_active_power
g <- as.numeric(levels(f))[f]

png(file="plot1.png",width=480,height=480)
hist(g, col='Red', xlab="Global Active Power (in kilowatts)", main ="Global Active Power")
dev.off()