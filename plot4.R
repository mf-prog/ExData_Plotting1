dat <- read.table("./household_power_consumption.txt", header = T, sep = ";", 
                  na.strings = "?")
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y") # format the dates
dat$DateTime <- as.POSIXct(paste(dat$Date, dat$Time), format = "%Y-%m-%d %H:%M:%S")

# filter the data for the specified range
dat <- subset(dat, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# make a 4 panel plot
png("./plot4.png", width = 480, height = 480)

par(mfrow = c(2,2), mar = c(4,4,2,2))

#plot top left
plot(x=dat$DateTime, y=dat$Global_active_power, 
     type = "l", 
     xlab = "",
     xaxt = "n",
     ylab = "Global Active Power")
axis.POSIXct(1, dat$DateTime, format = "%a", at = seq(min(dat$DateTime), max(dat$DateTime)+(24*60*60), by = "day"))

# plot top right
plot(x=dat$DateTime, y=dat$Voltage, 
     type = "l", 
     xaxt = "n",
     ylab = "Voltage",
     xlab = "datetime")
axis.POSIXct(1, dat$DateTime, format = "%a", at = seq(min(dat$DateTime), max(dat$DateTime)+(24*60*60), by = "day"))

#plot bottom left
plot(x=dat$DateTime, y=dat$Sub_metering_1, 
     type = "l", 
     xlab = "",
     xaxt = "n",
     ylab = "Energy sub metering")
lines(x=dat$DateTime, y = dat$Sub_metering_2, col = "red")
lines(x=dat$DateTime, y = dat$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lwd = 1, 
       bty = "n")
axis.POSIXct(1, dat$DateTime, format = "%a", at = seq(min(dat$DateTime), max(dat$DateTime)+(24*60*60), by = "day"))

# plot bottom right
plot(x=dat$DateTime, y=dat$Global_reactive_power, 
     type = "l", 
     xaxt = "n",
     xlab = "datetime",
     ylab = "Global_reactive_power")
axis.POSIXct(1, dat$DateTime, format = "%a", at = seq(min(dat$DateTime), max(dat$DateTime)+(24*60*60), by = "day"))

dev.off()
