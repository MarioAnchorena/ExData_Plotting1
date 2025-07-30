library(data.table)
library(datasets)

## Read only data required using cmd argument
hpc=fread('findstr -b "Date 1/2/2007 2/2/2007" household_power_consumption.txt')
hpc$Time=strptime(paste(hpc$Date,hpc$Time),"%d/%m/%Y %H:%M:%S") #Convert to POSIXct class
hpc$Date=as.Date(hpc$Date,"%d/%m/%Y") #Convert to Date class


##Open png graphic device
png(file = "plot4.png", width = 480, height = 480)
par(mfcol=c(2,2)) #parameters for 4 plots

##Create plot
with(hpc,{
    #Plot1
    plot(Time,Global_active_power,type="l",xaxt="n", 
         xlab="",
         ylab="Global Active Power (kilowatts)")
    axis.POSIXct(1,at=seq(min(Date),max(Date)+1,by="day"),format="%a")
    
    #Plot2
    plot(Time,Sub_metering_1,type="l",xaxt="n",
         xlab="",
         ylab="Energy sub metering")
    points(Time,Sub_metering_2, col = "red", type = "l")
    points(Time,Sub_metering_3, col = "blue", type = "l")
    legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           lty=1,col=c("black","red","blue"),bty ="n")
    axis.POSIXct(1,at=seq(min(Date),max(Date)+1,by="day"),format="%a")
    
    #Plot3
    plot(Time,Voltage,type="l",xaxt="n",xlab="datetime")
    axis.POSIXct(1,at=seq(min(Date),max(Date)+1,by="day"),format="%a")
    
    #Plot4
    plot(Time,Global_reactive_power,type="l",xaxt="n",xlab="datetime")
    axis.POSIXct(1,at=seq(min(Date),max(Date)+1,by="day"),format="%a")
})

##Close graphic device
dev.off()    
    
