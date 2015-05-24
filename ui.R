## ui.R ##
library(shiny)
library(shinydashboard)
library(shinythemes)

ui <- 
  
header <- dashboardHeader(title="Popcorn Methods",
      dropdownMenu(type="messages",icon = icon("question"),
                    messageItem(from="Any questions",
                                  message = a(href="https://github.com/Slardardetenis/popcorn", "Do not forget to check out my code.")
                                )
                  )
  )

sidebar <- dashboardSidebar(
    sidebarMenu(
                  menuItem("dados", tabName = "dados", icon = icon("database")),
                  menuItem("Introdução", tabName = "intro", icon = icon("th")),
                  menuItem("Diagnóstico do Modelo", tabName = "diag", icon = icon("warning")),
                  menuItem("Estatística Descritiva", tabName = "desc", icon = icon("bar-chart")),
                  menuItem("Anova", tabName="anover", icon = icon("line-chart")),
                  menuItem("Comparações Múltiplas", tabName="comp", icon =icon("area-chart")),
                  menuItem("Grupo", tabName="grup", icon = icon("users"))
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
              tabItem(tabName="diag",
                      fluidPage(theme = shinytheme("flatly"),
                                  mainPanel(
                                              h1(strong("Suposições para Anova")),
                                              h2("I) A distribuição em cada grupo deve ser uma normal;"),
                                              h2("II) Erros distribuidos segundo uma normal com média zero e variância constante constante igual em todos os grupos;"),
                                              h2("III) Independência dos erros."),
                                              br(),
                                              h2("Valores ajustados x Resíduos"),
                                              plotOutput("res"),
                                              h3("Apesar de uma parte dos dados ficar distante da outra vemos um padrão de 'cone'.",style="color:red"),
                                              h2("Vamos usar a transformação de box-cox para tentar acabar com essa tendencia nos resíduos."),
                                              plotOutput("boxcox"),
                                              h2("Portando com lambda igual a zero temos uma transformação logarítimica."),
                                              h2("Valores ajustados x Resíduos"),
                                              plotOutput("res1"),
                                              h2("Sendo mais rigoro e usando o teste C de Cochran"),
                                              strong(verbatimTextOutput("coch")),
                                              h2("Portanto os grupos não são homocedásticos.",style="color:red"),
                                              h2("qqnorm dos Resíduos"),
                                              plotOutput("res2"),
                                              h2("Os resíduos parecem ter distribuição normal."),
                                              h2("Usando o teste de Durbin-Watson para verificar se os erros são correlacionados ou não."),
                                              strong(verbatimTextOutput("durbin")),
                                              h2("Vemos que os resíduos são correlacionados."),
                                              h2("Agora vamos ver como ficam cada um dos tratamentos no qqnorm."),
                                              plotOutput("allqq"),
                                              h2(strong("Com as informaçoes acima vemos que nossos dados não cumprem todos presupostos para Anova. Mas você pode clicar na Aba 'Anova' para ver como ficou.",style="color:red"))
                                              
                                            )
                        
                                )
                      ),
            tabItem(tabName="comp",
                      fluidPage(
                                              h1(strong("Teste de Tukey")),
                                              selectInput("selec",h2("Tipo de Dados:"),
                                                            list("Dados Transformados"="dadost",
                                                            "Dados sem transformação"="dadosn")
                                                          ),
                                              strong(verbatimTextOutput("text"),style="color:green"),
                                              plotOutput("compar")
                                            
                                    
                                )
                    ),
            tabItem(tabName="anover",
                      selectInput("sela",h2("Anova"),
                                  list("Dados Transformados"="dadost",
                                       "Dados sem transformação"="dadosn")
                                  ),
                      
                      strong(verbatimTextOutput("anova")),
                      h2(strong("Com os dados transformados ou não o p-valor é muito pequeno, 
                             o que nos faria rejeitar a hipótese nula. Ou seja pelo menos uma média dos tratamentos não é igual à outra."))
                    ),
            tabItem(tabName="grup",
                      h2("Giovani Carrara Rodrigues 7151669"),
                      h2("Juliana Barbosa"),
                      h2("Vitor Bonini"),
                      h2("Marília Coser"),
                      br(),
                      br(),
                      infoBox(icon=icon("beer"),
                                tags$a(href="http://github.com/Slardardetenis/popcorn","Shiny app made by Slardar de tenis")
                              )
                    )
      )
  )

dashboardPage(header, sidebar, body, skin="purple")