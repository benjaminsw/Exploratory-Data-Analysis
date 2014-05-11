#prep data
#show current work directory. make sure that file you want to read exist in this sub directory
getwd()

# read data in
elect = read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#het dimension of data just reag in. of course, 9 variable with 2,075,259 rows
dim(elect)

#to show first 6 rows of the data set and to make sure that data is read in successfully
head(elect)

#bind date and time and make it to timestamp and change time form string to timestamp and tring date to date
elect$Time = strptime(paste(elect$Date, elect$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
elect$Date = as.Date(elect$Date, "%d/%m/%Y")


#in this exercise we use only data from the dates 2007-02-01 and 2007-02-02
#so, i'll subset data in between this dates
new_elect = subset(elect,  elect$Date == as.Date("01/02/2007", "%d/%m/%Y") | elect$Date == as.Date("02/02/2007", "%d/%m/%Y"))


## making plot 3 ##
new_elect$Sub_metering_1 =  as.numeric(as.character(new_elect$Sub_metering_1))
new_elect$Sub_metering_2 =  as.numeric(as.character(new_elect$Sub_metering_2))
new_elect$Sub_metering_3 =  as.numeric(as.character(new_elect$Sub_metering_3))

#open png devide
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA,  type = "cairo")
plot(new_elect$Time, new_elect$Sub_metering_1, type="l", col="black",
     ylab="Energy sub metering", xlab="")
lines(new_elect$Time, new_elect$Sub_metering_2, col="red")
lines(new_elect$Time, new_elect$Sub_metering_3, col="blue")
legend("topright",cex=0.7, lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#close png device
dev.off()