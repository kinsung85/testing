################## Load the data to the r file and only select those date that will be analysed ###
# Select those for the dates 2007-02-01 and 2007-02-02
data <- read.table("household_power_consumption.txt",skip=66637,nrows=2880, sep = ';')
data <- data.frame(data)

# > liness[66638]
# [1] "1/2/2007;00:00:00;0.326;0.128;243.150;1.400;0.000;0.000;0.000"

# > liness[66638+2879],
# [1] "2/2/2007;23:59:00;3.680;0.224;240.370;15.200;0.000;2.000;18.000"

################### Load the column names ########################
names_data <- read.table("household_power_consumption.txt",skip=0,nrows=1, sep = ';')
names_data2 <- matrix(0,1,9)

# small trick to get the column names and put the names(data) as the column names
for (i in 1:9){
  
  names_data2[i] <- as.character(names_data[i][1,1])
  
}

names(data) <- names_data2

tail(data)

################## converting the date and time to system date and time ###### 

date_time_combine <- paste(data$Date,data$Time,sep=",")
head(date_time_combine)
date_time_sys <- strptime(date_time_combine,format="%d/%m/%Y,%H:%M:%S")

################### Plot the Graph ################################
png("plot4.png", width = 5, height = 7, units = 'in', res = 600)

par(mfrow = c(2, 2))
plot_colors <- c("black", "red", "blue")

with(data, {
  plot(date_time_sys,data$Global_active_power,type = "l" , xlab = " ", ylab = "Global Active Power")
  plot(date_time_sys,data$Voltage,type="l",xlab = "datetime",ylab = "Voltage")
  plot(date_time_sys,data$Sub_metering_1, type="l",xlab = " " ,ylab = "Energy sub metering",col=plot_colors[1])
  lines(date_time_sys,data$Sub_metering_2, type="l", col=plot_colors[2])
  lines(date_time_sys,data$Sub_metering_3, type="l", col=plot_colors[3])
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"), lty = c(1,1,1), bty="n", cex=0.7)
  plot(date_time_sys,data$Global_reactive_power,type="l",xlab = "datetime",ylab = "Global_reactive_power")
  
})

################### Save the Graph ################################
dev.off()
