url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "household_power_consumption.txt"
        
if (!file.exists(zip)){
       download.file(url,zip) 
}

dataset <- read.table(unz(zip, file), header = T, sep = ";", na.strings = "?")

subset <- subset(dataset, Date == "1/2/2007" | Date == "2/2/2007")
subset$Date <- (as.Date(subset$Date, format = "%d/%m/%Y"))
subset$Time <- strptime(subset$Time, format = "%H:%M:%S")

png(filename="plot1.png", width = 480, height = 480, units = "px")
hist(subset$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()