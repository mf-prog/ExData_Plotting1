# Load in the data
z_file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!dir.exists("./Electric power consumption")){
  download.file(z_file, "./Electric power consumption.zip", method = "curl")
  unzip("./Electric power consumption.zip", exdir = "./")
}

dat <- read.table("./household_power_consumption.txt", header = T, sep = ";", 
                  na.strings = "?")
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y") # format the dates

# filter the data for the specified range
dat <- subset(dat, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# make histogram of global active power
png("./plot1.png", width = 480, height = 480)

hist(dat$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     col = "red", 
     main = "Global Active Power")

dev.off()
