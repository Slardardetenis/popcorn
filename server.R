## app.R ##
library(shiny)
library(datasets)
library(agricolae)
library(multcomp)
library(MASS)
library(lmtest)

dataset <- read.table("pipocabitch.txt",h=T)

dataset$fator <- as.factor(dataset$fator)

fat1 <- factor(fator,labels = c("óleo","azeite","margarina","manteiga"))


server <- function(input,output){
  
  output$dados <- renderDataTable({dataset})
  
  output$bp <- renderPlot({
    boxplot(dataset$pirua~fat1,
              data=dataset,outline = input$outliers,
              col="skyblue",xlab="Tratamentos"
            )
  })
  
}