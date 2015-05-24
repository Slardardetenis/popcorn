## app.R ##
library(shiny)
library(datasets)
library(agricolae)
library(multcomp)
library(MASS)
library(lmtest)
library(GAD)
library(rCharts)

datatrad <- read.table("pipocatrad.txt",h=T)
attach(datatrad)

dataset <- read.table("pipocabitch.txt",h=T)

dataset1 <- cbind(dataset,log(dataset$perua))

contr <- rbind("1 - 2" = c(1, -1, 0, 0),
               "1 - 3" = c(1, 0, -1, 0), 
               "1 - 4" = c(1, 0, 0, -1),
               "2 - 3" = c(0, 1, -1, 0),
               "2 - 4" = c(0, 1, 0, -1),
               "3 - 4" = c(0, 0, 1, -1))

names(dataset1) = c("Tratamentos","Peruá","log(Peruá)")

dataset$fator <- as.factor(dataset$fator)

fat1 <- factor(fator,labels = c("óleo","azeite","margarina","manteiga"))

model1 <- aov(dataset$perua~as.factor(dataset$fator),data=dataset)

model2 <- aov(log(dataset$perua)~as.factor(dataset$fator),data=dataset)

newdata <- c

tuu <- glht(model1,linfct=contr)

tuk <- glht(model2,linfct=contr)

server <- function(input,output){
  
  output$dados <- renderDataTable({dataset1}, options =list(orderClasses=TRUE))
  
  output$bp <- renderPlot({
    boxplot(dataset$perua~fat1,
              data=dataset,outline = input$outliers,
              col="skyblue",xlab="Tratamentos"
            )
  })
  
  output$res <- renderPlot({
    plot(fitted(model1),residuals(model1),data=dataset,pch=16,col="blue")
  })
  
  output$boxcox <- renderPlot({
    boxcox(model1,lambda=seq(-0.2,0.2,0.1))
  })
  
  output$res1 <- renderPlot({
    plot(fitted(model2),residuals(model2),data=dataset,pch=16,col="blue")
  })
  
  output$coch <- renderPrint({
    C.test(model2)
  })
  
  output$res2 <- renderPlot({
    qqnorm(residuals(model2),pch=16,col="blue")
    qqline(residuals(model2),col="red")
  })
  
  output$durbin <- renderPrint({
    dwtest(model2)
  })
  
  output$allqq <- renderPlot({
    par(mfrow=c(2,2))
    qqnorm(oleo,pch=15,col="blue",main="Óleo")
    qqline(oleo,col="red")
    
    qqnorm(azeite,pch=13,col="blue",main="Azeite")
    qqline(azeite,col="orange")
    
    qqnorm(marg,pch=17,col="blue",main="Margarina")
    qqline(marg,col="purple")
    
    qqnorm(mant,pch=12,col="blue",main="Manteiga")
    qqline(mant,col="green")
  })
  
  cond <- reactive({
    paste(input$selec)
  })
  
  cond2 <- reactive({
    paste(input$sela)
  })
  
  output$text <- renderPrint({
    if(cond()=="dadost"){
      summary(tuk)
    }
    else if(cond()=="dadosn"){
      summary(tuu)
    }
    
  })
  
  output$compar <- renderPlot({
    if(cond()=="dadost"){
      plot(confint(tuk,level=0.95),col="black",main="1:Óleo,2:Azeite,3:Margarina,4:Manteiga")
    }
    else if(cond()=="dadosn"){
      plot(confint(tuu,level=0.95),col="black",main="1:Óleo,2:Azeite,3:Margarina,4:Manteiga")
    }
  })
  
  output$anova <- renderPrint({
    if(cond2()=="dadost"){
      summary(model1)
    }
    else if(cond2()=="dadosn"){
      summary(model2)
    }
  })
    
  
  
}