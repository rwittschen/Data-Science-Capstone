#Word prediction shiny application

library(shiny)
library(NLP)
library(tm)
library(RWeka)
source("predict.R")

shinyServer(
  
  function(input, output) {
    
    output$inputValue <- renderPrint({input$Tcir})
    
    ##output$prediction <- renderPrint({word.entry(input$Tcir)})
    output$prediction <- renderText({word.entry(input$Tcir)})
  }
  
)