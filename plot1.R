#To execute the code from a Lunux command line just type
# R CMD BATCH plot1.R

library(datasets) #Charge datasets library

temp <- tempfile() # create a temporal file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp) #download the zip file and store it in temp file
housepowerconsump <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", head=TRUE) # create a dataset with semicolon as separator and a header
unlink(temp) #remove the temp file from memory

head(housepowerconsump) #show the first values of the dataset

housepowerconsump[housepowerconsump == "?"]<-NA # replace questionmarks by NA
housepowerconsump$Date <-  as.Date(housepowerconsump$Date, "%d/%m/%Y") # change text Date to proper date 

subpowerconsump =subset(housepowerconsump, Date >= "2007-02-01" & Date <= "2007-02-02") # generate a subdate only with requested dates

plotpng = hist(as.numeric(subpowerconsump$Global_active_power)/1000,breaks=13, xlab="Global Active Power (kilowats)", col="red", main="Global Active Power") # generate the histogram with the requested format, legends, title, breaks, color and in kilowats

png(filename = "plot1.png", width = 480, height = 480)
plot(plotpng , xlab="Global Active Power (kilowats)", col="red", main="Global Active Power")
dev.off() # close the PNG device
