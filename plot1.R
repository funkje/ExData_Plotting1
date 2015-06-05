library(data.table)

# function that returns a transformed dataset
getData <- function(){
    x <- fread("household_power_consumption.txt", na.strings = "?", sep = ";")
    x <- x[Date == "1/2/2007" | Date == "2/2/2007"]
    x$Date <- as.POSIXct(paste(x$Date, x$Time), format = "%d/%m/%Y %H:%M:%S")
    x$Time <- NULL
    x$Global_active_power <- as.numeric(x$Global_active_power)
    x$Global_reactive_power <- as.numeric(x$Global_reactive_power)
    x$Voltage <- as.numeric(x$Voltage)
    x$Global_intensity <- as.numeric(x$Global_intensity)
    x$Sub_metering_1 <- as.integer(x$Sub_metering_1)
    x$Sub_metering_2 <- as.integer(x$Sub_metering_2)
    x$Sub_metering_3 <- as.integer(x$Sub_metering_3)
    x
}

# get our data
hhData <- getData()

# Plot 1
png("plot1.png", width = 480, height = 480, units = "px")
hist(hhData$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()