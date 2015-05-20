## ui.R ##
library(shiny)
library(shinydashboard)

ui <-
  
header <- dashboardHeader(title="Popcorn Methods",
      dropdownMenu(type="messages",icon = icon("question"),
                    messageItem(from="Any questions",
                                  message = a(href="https://github.com/Slardardetenis/dashshiny", "Do not forget to check out my code.")
                                )
                  )
  )

sidebar <- dashboardSidebar(
    sidebarMenu(
                  menuItem("dados", tabName = "dados", icon = icon("database")),
                  menuItem("Introdução", tabName = "dados", icon = icon("th")),
                  menuItem("Diagnóstico do Modelo", tabName = "ana", icon = icon("area-chart")),
                  menuItem("Estatística Descritiva", tabName = "desc", icon = icon("bar-chart"))                           
                )  
  )

body <- dashboardBody(
    tabItems(
  
              tabItem(tabName = "dados",
                        dataTableOutput("dados")
                      ),
              tabItem(tabName = "desc",
                        tabBox(side = "right", selected = "Box-Plot", height = "800px", width="1000px",
                                tabPanel("Box-Plot",
                                          h2("Box-Plot"),
                                          checkboxInput("outliers", "Mostrar Outliers", FALSE),
                                          plotOutput("bp")
                                         ),
                                tabPanel("histograma",h2("partiu"))
                            
                              )
                      )
            )
  )

dashboardPage(header, sidebar, body, skin="purple")