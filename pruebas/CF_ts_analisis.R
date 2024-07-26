
#carga de bibliotecas y definicion de parametros
library(dplyr)
library(xts)
library(forecast)
library(data.table)
library(dygraphs)
library(tseries)
library(ggplot2)
library(fst)
library(lubridate)
library(urca)
last_selected_date <- as.Date("2023-12-10")

#carga de datos y armado de la serie temporal

data <- read.fst("www/data/fst/DFP_ST_S1.fst", as.data.table = T)
data <- filter(data, c1 == "CF") %>%
  filter(provincia == "[Todas]") %>%
  select(date, valor) %>%
  filter(date <= last_selected_date) %>%
  setnames(old = "valor", new = "real")

train <- data[1:(nrow(data)-30),]
test <- data[(nrow(data)-29):nrow(data),]

st_train <- xts(train$real, order.by = train$date)
st_test <- xts(test$real, order.by = test$date)
st_data <- xts(data$real, order.by = data$date)

#########################################################################
#analisis de la serie temporal

#grafico de linea
plot(st_train)
#gráfico ACF
acf(st_train, lag.max=60, xaxt="n", xlab="Lag")
#gráfico PACF
pacf(st_train, lag.max=60, xaxt="n", xlab="Lag")
#alternativa que muestra los tres gráficos a la vez
#ggtsdisplay(st_train)

#test Ljung-Box
Box.test(st_train, type = "Ljung-Box")

#test ADF
summary(ur.df(st_train))
#test KPSS
summary(ur.kpss(st_train))

#cantidad de diferenciaciones recomendadas para convertir la serie en estacionaria
ndiffs(st_train)
#cantidad de diferenciaciones recomendadas para convertir la serie en estacionaria (respecto a la estacionalidad)
nsdiffs(st_train) #si hay error no se encuentra patrones estacionales en la serie


######################################################################

model <- auto.arima(st_train, lambda = "auto", stationary = F)

checkresiduals(model)




