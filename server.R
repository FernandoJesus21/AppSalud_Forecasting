
shinyServer(function(input, output, session) {
  
  #Elementos en comun
  # estos elementos se usan en varias secciones de la aplicacion
  
  #obtiene el lenguaje seleccionado por el usuario
  selected_language <- reactive({
    input$selected_language
  })
  
  #objeto reactivo que cambia el lenguaje de la app segun el valor de <selected_language>
  i18n <- reactive({
    selected <- selected_language()
    if (length(selected) > 0 && selected %in% translator$get_languages()) {
      translator$set_translation_language(selected)
    }
    translator
  })

  

  ##############################################################################
  # Seccion forecasting (S4)
  ##############################################################################
  
  #funciones de traduccion de las seccion, utilizan el objeto reactivo <i18n()> 
  #para consultar la taduccion que debe mostrar segun el lenguaje activo
  
  output$S4_app_tab_title <- renderText({
    i18n()$t("400")
  })
  
  output$S4_app_title <- renderText({
    i18n()$t("401")
  })
  
  output$S4_range_label <- renderText({
    i18n()$t("32")
  })
  
  output$S4_measure_label <- renderText({
    i18n()$t("33")
  })
  
  output$S4_province_label <- renderText({
    i18n()$t("23")
  })
  
  output$S4_algorithm_label <- renderText({
    i18n()$t("31")
  })
  
  selected_range_S4 <- reactive({
    input$selected_range_S4
  })
  
  #Getters para las dimensiones ubicadas en la cabecera de la seccion
  # el cambio en su valor afecta a varios elementos.

  #medida seleccionada
  # selected_measure_S4 <- reactive({
  #   input$selected_measure_S4
  # })
  #pronvicia seleccionada
  selected_pcia_S4 <- reactive({
    input$selected_pcia_S4
  })
  
  selected_algoritmo_S4 <- reactive({
    input$selected_algoritmo_S4
  })

  
  #Observadores de eventos: se encargan de actualizar las traducciones en los selectores de dimensiones
  # tambien actualizan los elementos disponibles a ser seleccionados segun la seleccion hecha en un selector previo
  
  #observer que realiza las traducciones
  observeEvent(c(input$selected_measure_S4, input$selected_language), {
    sel <- getMetricsChoices(c("C", "CF", "C_AC", "CF_AC"), consts$lista_de_medidas, "measure_label")
    sel <- getTranslationArray(sel, i18n())
    selected_measure <- input$selected_measure_S4
    updateSelectInput(session,
                      "selected_measure_S4",
                      selected = selected_measure,
                      choices = sel
    )
  })
  
  #observer para las provincias
  observeEvent(c(input$selected_pcia_S4, input$selected_language), {
    a <- "[Todas]"
    names(a) <- i18n()$t("14")
    selected_province <- ifelse(input$selected_pcia_S4 %in% consts$listaProvincias2, input$selected_pcia_S4, a)
    updateSelectInput(session,
                      "selected_pcia_S4",
                      selected = selected_province,
                      choices = c(a, consts$listaProvincias2))
  })

  #funciones de llamado para elementos graficos
  # estas funciones invocan a los modulos de la aplicacion, pasando los datos necesarios 
  # para su ejecucion
  
  
  ##############################################################################
  

  m_S4_FORECASTING$init_server("fgraph",
                           df = lista_datasets[["DFP_ST_S1"]],
                           #me = selected_measure_S4,
                           r = selected_range_S4,
                           a = selected_algoritmo_S4,
                           p = selected_pcia_S4,
                           y = selected_year_S4,
                           i18n = i18n
  )
    
  
  
  ##############################################################################
  #FIN
  
})
