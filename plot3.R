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

png(filename="plot3.png", width=480, height=480)
with(
  feb2day, {
  plot(datetime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", col="black")
  lines(datetime, Sub_metering_2, type="l", col="red")
  lines(datetime, Sub_metering_3, type="l", col="blue")
});

legend("topright", lwd=1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
