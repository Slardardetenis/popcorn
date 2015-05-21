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
                  menuItem("Introdução", tabName = "intro", icon = icon("th")),
                  menuItem("Diagnóstico do Modelo", tabName = "diag", icon = icon("area-chart")),
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
                                         )
#                                 tabPanel("histograma",h2("partiu"))
                            
                              )
                      ),
              tabItem(tabName = "intro",
                        fluidPage(
                            titlePanel(h1(strong("Informações sobre a pesquisa",style="color:black"))),
                            mainPanel(
                                br(),
                                h3("O objetivo da pesquisa é determinar qual método de se fazer pipoca é o mais eficiente. No procedimento vamos levar em conta a quantidade de peruá(milho de pipoca que não estoura) resultante dos seguintes métodos(tratamentos):"),
                                h3("Óleo, Azeite, Margarina e Manteiga.",style="color:blue"),
                                br(),
                                h1(strong("Procedimento",style="color:black")),
                                br(),
                                h2("Óleo e Azeite:",style="color:blue"),
                                h3(span("Quantidade:",style="color:green"), "3 colheres de sopa."),
                                h3(span("tempo de preparo:",style="color:green"), "3 minutos no mínimo, a panela só é retirada do fogo se o intervalo entre um estouro e outro for maior que 5 segundos."),
                                br(),
                                h2("Margarina e Manteiga:",style="color:blue"),
                                h3(span("Quantidade:",style="color:green"), "2 colheres de sopa bem fartas."),
                                h3(span("tempo de preparo:",style="color:green"), "5 minutos no mínimo, a panela só é retirada do fogo se o intervalo entre um estouro e outro for maior que 5 segundos."),
                                br(),
                                h1(strong("Observaçoes:",style="color:black")),
                                br(),
                                h3("A quantidade de pipoca para todas as amostras foi meio copo de requeijão;",style="color:red"),
                                h3("Os procedimentos foram feitos na mesma panela, onde essa éra um pipoqueira;",style="color:red"),
                                h3("Em todas as 20 vezes a manivela era girada sempre em baixa rotação;",style="color:red"),
                                h3("Após cada uso, a panela era lavada e secada;",style="color:red"),
                                h3("Uma milho mal estourado éra considerado um peruá se seu tamanho fosse pequeno e se a cor de peruá fosse mais de 50% do seu corpo.",style="color:red")
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                              )
                          )
                      ),
              tabItem(tabName="diag"
                        
                      )
            )
  )

dashboardPage(header, sidebar, body, skin="purple")