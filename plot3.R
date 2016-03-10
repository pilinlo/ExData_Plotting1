###############################################################################
##Mission Description : Plot 2D chart of y=sub_metering(1:3) vs x=Time       ##
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
with(my_df,plot(Time,Sub_metering_1, type="l",ylab="Energy sub metering",cex.lab=0.7,cex.axis=0.7))
with(my_df,points(Time,Sub_metering_2, type="l",col="red"))
with(my_df,points(Time,Sub_metering_3, type="l",col="blue"))

legend("topright",col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),cex=0.6, lty=1, lwd=1)

#########################################################################
##STEP5 : Output to PNG Device                                         ##
#########################################################################
dev.copy(png,"plot3.png")
dev.off()
  

