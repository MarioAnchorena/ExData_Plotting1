library(data.table)
library(datasets)

## Read only data required using cmd argument
hpc=fread('findstr -b "Date 1/2/2007 2/2/2007" household_power_consumption.txt')
hpc$Time=strptime(paste(hpc$Date,hpc$Time),"%d/%m/%Y %H:%M:%S") #Convert to POSIXct class
hpc$Date=as.Date(hpc$Date,"%d/%m/%Y") #Convert to Date class


##Open png graphic device
png(file = "plot2.png", width = 480, height = 480)

##Create plot
with(hpc,{
    plot(Time,Global_active_power,type="l",xaxt="n", 
         xlab="",
         ylab="Global Active Power (kilowatts)")
    axis.POSIXct(1,at=seq(min(Date),max(Date)+1,by="day"),format="%a") #X-axis by weekday
})

##Close graphic device
dev.off()

