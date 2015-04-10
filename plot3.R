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

png(filename="plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
with(dataset, plot(Time, Sub_metering_1, type="n",
                   xlab=NA,
                   ylab = "Energy sub metering"))
lines(dataset$Time, dataset$Sub_metering_1, col = "black")
lines(dataset$Time, dataset$Sub_metering_2, col = "red")
lines(dataset$Time, dataset$Sub_metering_3, col = "blue")
legend("topright",
       lwd=1,
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

dev.off()
cat("Graph saved in working dir as \"plot3.png\"")