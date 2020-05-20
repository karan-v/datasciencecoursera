library(data.table)


path = getwd()
houseData <- fread(file.path(path,"household_power_consumption.txt")
                   ,na.strings = "?")
houseData[,Date := as.Date(Date,format = "%d/%m/%Y")]
houseData <- houseData[Date >= "2007-02-01" & Date <= "2007-02-02"]
png("plot1.png", width=480, height=480)
hist(houseData$Global_active_power,col = "red",main = "Global Active Power"
     ,xlab = "Global Active Power (kilowatts)",ylab = "Frequency")
dev.off()