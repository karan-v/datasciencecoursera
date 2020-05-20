library(data.table)


path = getwd()
houseData <- fread(file.path(path,"household_power_consumption.txt")
                   ,na.strings = "?")
houseData[,Date := as.Date(Date,format = "%d/%m/%Y")]
houseData <- houseData[Date >= "2007-02-01" & Date <= "2007-02-02"]
houseData[,datetime := paste(Date,Time)]
houseData[,datetime := strptime(datetime, format = "%Y-%m-%d %H:%M:%S")]

png("plot2.png", width=480, height=480)
plot(houseData$datetime,houseData$Global_active_power, type="l", xlab="", ylab="Global Active Power (Kilowatts)")
dev.off()
