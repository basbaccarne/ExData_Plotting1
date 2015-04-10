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

png(filename="plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(dataset$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
cat("Graph saved in working dir as \"plot1.png\"")