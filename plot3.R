#To execute the code from a Lunux command line just type
# R CMD BATCH plot1.R

library(datasets) #Charge datasets library

temp <- tempfile() # create a temporal file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp) #download the zip file and store it in temp file
housepowerconsump <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", head=TRUE) # create a dataset with semicolon as separator and a header
unlink(temp) #remove the temp file from memory

head(housepowerconsump) #show the first values of the dataset

housepowerconsump[housepowerconsump == "?"]<-NA # replace questionmarks by NA
housepowerconsump$Time <- strptime(paste(housepowerconsump$Date, housepowerconsump$Time, sep=" "), "%d/%m/%Y %H:%M:%S")# generate a continuous time with concatenated date

housepowerconsump$Date <-  as.Date(housepowerconsump$Date, "%d/%m/%Y") # change text Date to proper date 

subpowerconsump =subset(housepowerconsump, Date >= "2007-02-01" & Date <= "2007-02-02") # generate a subdate only with requested dates


png(filename = "plot3.png", width = 480, height = 480)
with(subpowerconsump, plot(Time,Sub_metering_1, type="l", ylab="Energy sub metering", xlab =""))
with(subpowerconsump, lines(Time,Sub_metering_2,col="red"))
with(subpowerconsump, lines(Time,Sub_metering_3,col="blue"))# Bad values shown, not able to discover why it plots "14" vals
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off() # close the PNG device
