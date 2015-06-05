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

# Plot 3
png("plot3.png", width = 480, height = 480, units = "px")
with(hhData, plot(Date, Sub_metering_1, type = "l", xlab = "",
                  ylab = "Energy sub metering"))
with(hhData, lines(Date, Sub_metering_2, col = "red"))
with(hhData, lines(Date, Sub_metering_3, col = "blue"))
with(hhData, legend("topright", 
                    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                    col = c("black", "red", "blue"),
                    lty = 1))
dev.off()