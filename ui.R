


# carga de constantes
consts <- use("constants.R")

# carga de funciones de utilidad
source("utilities/getMetricsChoices.R")
source("utilities/getTimeFilterChoices.R")
source("utilities/getProvinceChoices.R")
source("utilities/getTranslationArray.R")


#translator$set_translation_language('es')

## ui.R ##


ui <- fixedPage(
  #usei18n(translator),
  #useShinyjs(),
  #includeScript(consts$script_animar_botones), #carga de script (js)
  tags$div(
      id = "lang",
      pickerInput(inputId = "selected_language",
                  label = "",
                  choices = consts$flags$val,
                  choicesOpt = list(content = consts$flags$img)),
      
      ),
    

    div(
      class = "tabset-general",

      tabsetPanel(
        type = "tabs",

    
        ##############################################################################
        # Seccion forecasting (S4)
        ##############################################################################
        
        tabPanel(
          #"Forecasting",
          textOutput("S4_app_tab_title"),
          icon = icon("gauge"),
          htmlTemplate(
            "www/forecasting.html",
            appTitle = textOutput("S4_app_title"),
            appVersion = consts$app_version,
            dashboardLogo = consts$shinyLogo,
            provincia = selectInput(
              "selected_pcia_S4",
              #"Provincia",
              label = textOutput("S4_province_label"),
              choices = c("[Todas]", consts$listaProvincias2),
              selected = "[Todas]",
              selectize = TRUE
            ),
            fechas = dateRangeInput(
              "selected_range_S4",
              label = textOutput("S4_range_label"),
              start  = "2020-03-01",
              end    = reload_date-days(1),
              min    = "2020-03-01",
              max    = reload_date-days(1),
              format = "yy/mm/dd",
              separator = " - ",
              language = "es",
              autoclose = T,
              width = "245px"
            ),
            algoritmo = selectInput(
              "selected_algoritmo_S4",
              #"Algoritmo",
              label = textOutput("S4_algorithm_label"),
              choices = c("NAIVE", "AVERAGE", "ETS", "ARIMA"),
              selected = "ARIMA",
              selectize = TRUE
            ),
            fgraph = m_S4_FORECASTING$ui("fgraph"),
            texto_footer = consts$texto_footer
          )

        )
        
      )
    )
)
