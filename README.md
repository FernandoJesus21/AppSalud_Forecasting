# Módulo standalone de AppSalud: herramienta de previsión de series temporales.

Ofrece una previsión de 10 dias a futuro del comportamiento de la COVID-19 en la República Argentina.

![alt text](https://github.com/FernandoJesus21/AppSalud_Forecasting/blob/main/screenshot.png?raw=true)

# Funciones

1) Previsión de 10 dias a futuro.
2) Posibilidad de elegir el rango de fechas para construir el modelo.
3) Elección entre los cuatro modelos disponibles (NAIVE, AVERAGE, ETS y ARIMA).
4) Posibilidad de elegir entre las series de casos confirmados y casos fallecidos.
5) Posibilidad de elegir provincia específica o el total país.
6) Testeado mediante el RMSE calculado a partir de los últimos 30 dias del periodo elegido.
7) Ofrece un reporte con detalles acerca del modelo aplicado.
8) Ofrece la opción de descargar los datos de la serie temporal.

# Detalles

Probado bajo entornos Windows con R 4.3.2 y 4.4.0.

Este proyecto forma parte de la terna de proyectos que dan vida a la aplicación AppSalud.
1. [Repositorio](https://github.com/FernandoJesus21/AppSalud) de la aplicación.
2. [Repositorio](https://github.com/FernandoJesus21/AppSalud_ETL_Framework) del proceso ETL.
