###############################################################################
##Mission Description : Plot 2D chart of y=Global_active_power vs x=Time     ##
###############################################################################
## Pre-Load Packages
library(graphics)
library(ggplot2)
library(lattice)
library(grDevices)

#########################################################################
##STEP1 : Download Data and Unzip                                      ##
##1. Check if the data was already downloaded                          ##
##2. If not, download the zip file and unzip all                       ##
#########################################################################
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("EPC.zip")) {
  download.file(url,"EPC.zip")
  unzip("EPC.zip")
}

#########################################################################
##STEP2 : Read only the required file                                  ##
#########################################################################
raw_df<-read.table("household_power_consumption.txt",sep=";",stringsAsFactors = FALSE) %>% tbl_df()
names(raw_df)<-raw_df[1,]
my_df<-raw_df[which(raw_df$Date=="1/2/2007"|raw_df$Date=="2/2/2007"),]
my_df[,3:9]<-as.numeric(unlist(my_df[,3:9]))

#########################################################################
##STEP3 : Process the date format                                      ##
#########################################################################
my_df<-as.data.frame(my_df)
my_df$Time<-strptime(paste(my_df$Date, my_df$Time), format="%d/%m/%Y %H:%M:%S")
my_df$Date<-as.Date(my_df$Date, format="%d/%m/%Y")

#########################################################################
##STEP4 : Plot                                                         ##
#########################################################################
with(my_df,plot(Time,Global_active_power, type="l",ylab="Global Active Power (kilowatts)",cex.lab=0.7,cex.axis=0.7))

#########################################################################
##STEP5 : Output to PNG Device                                         ##
#########################################################################
dev.copy(png,"plot2.png")
dev.off()
  

