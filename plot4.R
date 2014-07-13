# read only required data subset from default directory
Power_Subset <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=F, sep=';')

# read headers from default directory and and assign them as names for dataset
names(Power_Subset) <- names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))

# add extra column with a concatenated date and time in the right format
dateTime <- strptime( paste(Power_Subset$Date,Power_Subset$Time), format="%d/%m/%Y %H:%M:%S")
Power_Subset1 <- cbind(Power_Subset,dateTime)

#plot graph and save it as png file
png(filename="plot4.png", width=480, height=480)

## sets up multiple charts in one page
plot4.par <- par(mfrow=c(2,2))

## plots top left chart
plot(Power_Subset1$dateTime, Power_Subset1$Global_active_power, type="l", ylab = "Global Active Power", xlab = "")

## plots top right chart
plot(Power_Subset1$dateTime, Power_Subset1$Voltage, type="l", ylab = "Voltage", xlab ="datetime")

## plots bottom left chart
plot(Power_Subset1$dateTime, Power_Subset1$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
points(Power_Subset1$dateTime, Power_Subset1$Sub_metering_2, type="l", ylab = "Energy sub metering", xlab = "", col="red")
points(Power_Subset1$dateTime, Power_Subset1$Sub_metering_3, type="l", ylab = "Energy sub metering", xlab = "", col="blue")
legend("topright", # places a legend at the appropriate place
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # puts text in the legend
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5),col=c("black","red","blue"), # gives the legend lines the correct color and width
       bty = "n", # removes border line
       cex=0.9) # asjust size of legend

## plots bottom right chart
plot(Power_Subset1$dateTime, Power_Subset1$Global_reactive_power, type="l", ylab= "Global_reactive_power", xlab ="datetime")

## closes graphics device
dev.off()

## needs to resets par so subsequent charts are not plotted in 2x2 grid
par(plot4.par)



