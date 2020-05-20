library(data.table)


path = getwd()
houseData <- fread(file.path(path,"household_power_consumption.txt")
                   ,na.strings = "?")
houseData[,Date := as.Date(Date,format = "%d/%m/%Y")]
houseData <- houseData[Date >= "2007-02-01" & Date <= "2007-02-02"]
houseData[,datetime := paste(Date,Time)]
houseData[,datetime := strptime(datetime, format = "%Y-%m-%d %H:%M:%S")]

png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))
plot(houseData$datetime,houseData$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(houseData$datetime,houseData$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(houseData$datetime, houseData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(houseData$datetime, houseData$Sub_metering_2,col="red")
lines(houseData$datetime, houseData$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))
plot(houseData$datetime,houseData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
