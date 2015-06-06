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

################### Plot the Graph ################################
hist(data$Global_active_power,xlab = "Global Active Power (kilowatts)",main = "Global Active Power",col = "red")

################### Save the Graph ################################
dev.copy(png,'plot1.png')
dev.off()
