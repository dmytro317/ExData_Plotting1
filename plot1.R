fullData <- read.table('household_power_consumption.txt', header=T, sep=';', na.strings="?")

fullData <- transform(
  fullData,
  datetime = do.call(
    function(Date, Time) {
      strptime(paste(Date, Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
    },
    fullData[c("Date", "Time")]
  )
);

feb2day <- subset(fullData, datetime >= '2007-02-01 00:00:00' & datetime < '2007-02-03 00:00:00')
rm(fullData)

png(filename="plot1.png", width=480, height=480)
hist(feb2day$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
