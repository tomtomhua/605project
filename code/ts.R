rm(list=ls())
args=commandArgs(T)
if(length(args) != 1){
  cat("usage: Rscript ts.R <data directory>\n", file=stderr())
  stop()
}
Data <- read.csv(paste0("mr_1_loc_",args[1],".csv"),header = F)

#test <- ts(data$X0.3926357626914978,start = as.Date(2013-01-24 01:30))
library(forecast)
Data$V17=as.Date(Data$V17)

newdata=tapply(Data$V1, Data$V17, mean)

# V1 <- ts(newdata,start = as.Data(rownames(newdata)[1]),)
# 
# tsdisplay( ,xlab="year",ylab="Retail index")
# 
# data_d1D1=diff(newdata,30) 
# tsdisplay(data_d1D1,xlab="year",ylab="Retail index")
# 
# data_d1D1=diff(data_d1D1) 
# tsdisplay(data_d1D1,xlab="year",ylab="Retail index")

# plot(newdata[1:730],type="l")
# 
# lapply(date, function)
# 
# terr_num=ts(data$X0.3926357626914978)
# terr_num=terr_num[1:2000]
# 
# plot(terr_num,type="l")
# acf(terr_num)
# par(opar)
# 
# p_d_q=auto.arima(terr_num)

ts_data=ts(newdata,start = c(2010,1))
ts_data_train <- ts_data[1:(length(ts_data)-365)]

# arima_1<-auto.arima(ts_data_train,)
# 
# predict_result <- predict(arima_1,365,level=0.9)
# plot(predict_result$pred)


y <- msts(ts_data_train, seasonal.periods=c(7,365.25)) 
model = auto.arima(y,D=1,trace=F) 
for_model = forecast(model,365) 

#plot(for_model$mean) 
#plot(ts_data[(length(ts_data)-364):length(ts_data)],type="l")
pred=as.vector(for_model$mean)
real=ts_data[(length(ts_data)-364):length(ts_data)]
result=data.frame(time=names(real), realdata=real,predictdata=pred,row.names = NULL)

save(result,file = paste0(args[1],".Rdata"))

#library(ggplot2)
#png(paste0(args[1],".png"),,width = 5000,height = 3000,res = 580)
#print(ggplot(result) + 
#        geom_line(aes(x=time,y=realdata,group=1,color="cyan")) +
#        geom_line(aes(x=time,y=predictdata,group=1,color="red")) +
#        labs(title="Comparison of real data and predicted data in time series",x='time',y='temperature')+
#        theme(plot.title = element_text(hjust = 0.5)))
#dev.off()
