

options(scipen = 12)


library(shiny)
library(lubridate)
library(readr)
library(dplyr)
library(modules)
library(sass)
library(dygraphs)
library(shinyWidgets)
library(shinyjs)
library(scales)
library(shinycssloaders)
library(leaflet)
library(fst)
library(xts)
library(forecast)
library(gfonts)
library(stats)
library(shiny.i18n)
library(data.table)
library(writexl)

translator <- Translator$new(translation_json_path='lang/translation.json')

#CFG <- read_csv("config.csv", col_types = cols(value = col_character()))

#custom font (only works in shinyapps.io)
dir.create('~/.fonts')
file.copy("www/fonts/RobotoCondensed-Regular.ttf", "~/.fonts")
system('fc-cache -f ~/.fonts')


#lista de dataframes
lista_datasets <- list()

source("utilities/getExternalLink.R")


#Function compiling sass files to one css file
sass(
  sass_file("styles/main.scss"),
  output = "www/main.css",
  options = sass_options(output_style = "compressed"),
  cache = NULL
)

#Lectura de datos


#DFP series temporales de la S1
lista_datasets[["DFP_ST_S1"]] <-
  read.fst("www/data/fst/DFP_ST_S1.fst", as.data.table = T)



# Constantes
consts <- use("constants.R")

# Carga de modulos:


#m_S4_TIME_SERIES <- use("./modules/m_S4_TIME_SERIES.R")
m_S4_FORECASTING <- use("./modules/m_S4_FORECASTING.R")


# Indice de los DFPs
indice_datasets <- names(lista_datasets)

#fecha de recarga de datos
df_reload <- read.fst("www/data/fst/reload_date.fst")
reload_date <- df_reload$V_data_last_update

#fecha de la version de la aplicacion
version_date <- df_reload$etl_date












