Sys.setlocale("LC_TIME", "English")

loadData <- function(){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        zip <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
        file <- "household_power_consumption.txt"
        
        if (!file.exists(zip)){
                cat("downloading file from url ...\n")
                download.file(url,zip) 
        }
        
        cat("loading dataset ...\n")
        unzip (zip,files=file)
        dataset <- read.table(file, header = T, sep = ";", na.strings = "?")
        
        cat("subsetting and cleaning dataset ...\n")
        subset <- subset(dataset, Date == "1/2/2007" | Date == "2/2/2007")
        subset$Time <- paste(subset$Date,subset$Time, sep = " ") 
        subset$Time <- strptime(subset$Time, format = "%d/%m/%Y %H:%M:%S")
        subset$Date <- (as.Date(subset$Date, format = "%d/%m/%Y"))
        
        subset
}
dataset <- loadData()

png(filename="plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfcol = c(2,2))

# graph 1 #
cat("calculating graph 1 ... \n")
with(dataset, plot(Time, Global_active_power, type="n",
                   xlab=NA,
                   ylab = "Global Active Power"))
lines(dataset$Time, dataset$Global_active_power)

# graph 2 #
cat("calculating graph 2 ... \n")
with(dataset, plot(Time, Sub_metering_1, type="n",
                   xlab=NA,
                   ylab = "Energy sub metering"))
lines(dataset$Time, dataset$Sub_metering_1, col = "black")
lines(dataset$Time, dataset$Sub_metering_2, col = "red")
lines(dataset$Time, dataset$Sub_metering_3, col = "blue")
legend("topright",
       lwd=1,
       bty = "n",
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

# graph 3 #
cat("calculating graph 3 ... \n")
with(dataset, plot(Time, Voltage, type="n",
                   xlab="datetime",
                   ylab = "Voltage"))
lines(dataset$Time, dataset$Voltage)

# graph 4 #
cat("calculating graph 4 ... \n")
with(dataset, plot(Time, Global_reactive_power, type="n",
                   xlab="datetime"))
lines(dataset$Time, dataset$Global_reactive_power)


dev.off()
cat("Graph saved in working dir as \"plot4.png\"")