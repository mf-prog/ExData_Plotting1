dat <- read.table("./household_power_consumption.txt", header = T, sep = ";", 
                  na.strings = "?")
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y") # format the dates
dat$DateTime <- as.POSIXct(paste(dat$Date, dat$Time), format = "%Y-%m-%d %H:%M:%S")

# filter the data for the specified range
dat <- subset(dat, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# make line plot of energy sub metering
png("./plot3.png", width = 480, height = 480)

plot(x=dat$DateTime, y=dat$Sub_metering_1, 
     type = "l", 
     xlab = "",
     xaxt = "n",
     ylab = "Energy sub metering")
lines(x=dat$DateTime, y = dat$Sub_metering_2, col = "red")
lines(x=dat$DateTime, y = dat$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lwd = 1)
axis.POSIXct(1, dat$DateTime, format = "%a", at = seq(min(dat$DateTime), max(dat$DateTime)+(24*60*60), by = "day"))

dev.off()
