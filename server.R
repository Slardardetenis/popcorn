## app.R ##
library(shiny)
library(datasets)
library(agricolae)
library(multcomp)
library(MASS)
library(lmtest)
library(GAD)

dataset <- read.table("pipocabitch.txt",h=T)

dataset1 <- cbind(dataset,log(dataset$perua))

names(dataset1) = c("Tratamentos","Peruá","log(Peruá)")

dataset$fator <- as.factor(dataset$fator)

fat1 <- factor(fator,labels = c("óleo","azeite","margarina","manteiga"))

model1 <- aov(dataset$perua~as.factor(dataset$fator),data=dataset)

model2 <- aov(log(dataset$perua)~as.factor(dataset$fator),data=dataset)

newdata <- c

server <- function(input,output){
  
  output$dados <- renderDataTable({dataset1})
  
  output$bp <- renderPlot({
    boxplot(dataset$perua~fat1,
              data=dataset,outline = input$outliers,
              col="skyblue",xlab="Tratamentos"
            )
  })
  
  output$res <- renderPlot({
    plot(fitted(model1),residuals(model1),data=dataset)
  })
  
  output$boxcox <- renderPlot({
    boxcox(model1,lambda=seq(-0.2,0.2,0.1))
  })
  
  output$res1 <- renderPlot({
    plot(fitted(model2),residuals(model2),data=dataset)
  })
  
  output$coch <- renderPrint({
    C.test(model2)
  })
  
  output$res2 <- renderPlot({
    qqnorm(residuals(model2))
    qqline(residuals(model2),col="red")
  })
  
  output$durbin <- renderPrint({
    dwtest(model2)
  })
  
  
}