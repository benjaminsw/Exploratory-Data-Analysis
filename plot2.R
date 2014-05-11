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


## making plot 2 ##
new_elect$Global_active_power =  as.numeric(as.character(new_elect$Global_active_power))

#open png devide
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA,  type = "cairo")
plot(new_elect$Time, new_elect$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
#close png device
dev.off()
 
