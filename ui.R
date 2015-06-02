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
                                h3("O problema proposto na disciplina Planejamento de experimentos I, ministrada pelo",span("professor Dr. Marinho",style="color:blue"), "foi determinar qual tratamento seria o mais eficiente na questão de aproveitamento de milhos estourados nos tratamentos."),
#                                 h3("Óleo, Azeite, Margarina e Manteiga.",style="color:blue"),
                                br(),
                                h1(strong("Procedimento",style="color:black")),
                                br(),
                                h2("Em uma panela própria para pipoca (pipoqueira),selecionamos 20 amostras de milhos de 100 gramas, 600 grãos de milhos, utilizando 5 amostras para cada tratamento sendo:", span("azeite, óleo, margarina e manteiga",style="color:red"), ",com 2 colheres de sopa de cada ingrediente nos respectivos tratamentos. Após cada coleta de amostra a panela era lavada, secada e resfriada, sendo mexida durante todo o tempo. Este tempo foi determinado por uma amostra piloto, onde se obteve o tempo de 4 minutos de permanencia no fogo alto.")
                              )
                          )
                      ),
              tabItem(tabName="diag",
                      fluidPage(theme = shinytheme("flatly"),
                                  mainPanel(
                                              h1(strong("Suposições para Anova")),
                                              h2("Para utilizarmos a análise de variância temos antes que verificar se os dados possuem os requisitos necessários. As suposições para o uso desta, são:"),
                                              h2("I) A distribuição em cada grupo deve ser uma normal;"),
                                              h2("II) Erros distribuídos segundo uma normal com média zero e variância constante igual em todos os grupos;"),
                                              h2("III) Independência dos erros."),
                                              br(),
                                              h2("Valores ajustados x Resíduos"),
                                              plotOutput("res"),
                                              h3("Apesar de uma parte dos dados ficar distante da outra vemos um padrão de 'cone'.",style="color:red"),
                                              h2("Vamos usar a transformação de box-cox para tentar acabar com essa tendencia nos resíduos."),
                                              plotOutput("boxcox"),
                                              h2("Portando com lambda igual a zero temos uma transformação logarítmica."),
                                              h2("Valores ajustados x Resíduos"),
                                              plotOutput("res1"),
                                              h2("Sendo mais rigoro e usando o teste C de Cochran"),
                                              strong(verbatimTextOutput("coch")),
                                              h2("Portanto os grupos 'são' homocedásticos.",style="color:blue"),
                                              h2("qqnorm dos Resíduos"),
                                              plotOutput("res2"),
                                              h2("Os resíduos parecem ter distribuição normal."),
                                              h2("Usando o teste de Durbin-Watson para verificar se os erros são correlacionados ou não."),
                                              strong(verbatimTextOutput("durbin")),
                                              h2("Vemos que os resíduos são 'não correlacionados.'",style="color:blue"),
                                              h2("Agora vamos ver como ficam cada um dos tratamentos no qqnorm."),
                                              plotOutput("allqq"),
                                              h2(strong("Com as informações acima vemos que nossos dados cumprem todos pressupostos para Anova. Clique no menu 'ANOVA' para ver os resultados.",style="color:blue"))
                                              
                                            )
                        
                                )
                      ),
            tabItem(tabName="comp",
                      fluidPage(
                                              h1(strong("Teste de Tukey")),
                                              selectInput("selec",h2("Tipo de Dados:"),selected="Dados sem transformação",
                                                            list("Dados Transformados"="dadost",
                                                            "Dados sem transformação"="dadosn")
                                                          ),
                                              strong(verbatimTextOutput("text"),style="color:green"),
                                              plotOutput("compar"),
#                                               h2(strong("Uma importante observação, é lembrarmos que mesmo transformando os dados não conseguimos comprir os presupostos para a anova,
#                                                         Observando os intervalos de confiança acima('essas linhas em negrito') as médias dos tratamentos podem ser consideradas iguais,
#                                                         se o intervalo tiver o 'zero' dentro dele. Por exemplo nos dados não transformados podemos dizer que as médias dos tratamentos"))
                                                h3(strong("Se o intervalo de confiança(linha em negrito) contém o zero, dizemos que os tratamentos possuem médias iguais.")),
                                                h2("Repare que com os", span("dados sem transformação",style="color:green"), "podemos dizer que", span("'há diferença' entre as médias de azeite-manteiga e margarina-manteiga.",style="color:green")),
                                                h2("Já nos",span("dados tranformados, todas médias de tramentos são diferentes exceto por azeite-margarina que podem ser consideradas iguais.",style="color:blue")),
                                                br(),
                                                h2("Através dos resultados acima podemos ver o perigo que nos submetemos ao fazer testes sem se preocupar com seus pressupostos.",style="color:red")
                                            
                                    
                                )
                    ),
            tabItem(tabName="anover",
                      selectInput("sela",h2("Anova"),selected = "Dados sem transformação",
                                  list("Dados Transformados"="dadost",
                                       "Dados sem transformação"="dadosn")
                                  ),
                      
                      strong(verbatimTextOutput("anova")),
                      h2(strong("Com os dados transformados ou não o p-valor é muito pequeno, 
                             o que nos faria rejeitar a hipótese nula. Ou seja pelo menos uma média dos tratamentos não é igual à outra."))
                    ),
            tabItem(tabName="grup",
                      h2("Giovani Carrara Rodrigues 7151669"),
                      h2("Juliana Barbosa 7986142"),
                      h2("Vitor Bonini 8065859"),
                      h2("Marília Coser 8065797"),
                      br(),
                      br(),
                      infoBox(icon=icon("beer"),
                                tags$a(href="http://github.com/Slardardetenis/popcorn","Shiny app made by Slardar de tenis")
                              )
                    )
      )
  )

dashboardPage(header, sidebar, body, skin="purple")