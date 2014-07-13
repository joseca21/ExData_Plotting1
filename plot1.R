# read only required data subset from default directory
Power_Subset <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=F, sep=';')

# read headers from default directory and and assign them as names for dataset
names(Power_Subset) <- names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))

# add extra column with a concatenated date and time in the right format
dateTime <- strptime( paste(Power_Subset$Date,Power_Subset$Time), format="%d/%m/%Y %H:%M:%S")
Power_Subset1 <- cbind(Power_Subset,dateTime)

#plot graph and save it as png file
png(filename="plot1.png", width=480, height=480)
hist(Power_Subset1$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off() # closes graphics device