#Word preduction shiny application - user interface component
##install.packages("shinythemes")
library(shinythemes)
##library(shiny)

fluidPage(theme=shinytheme("cosmo"),
  
  mainPanel(
    h3("Word Prediction Application:"),
    h5("This application predicts the next word for an entered sentence."),
    h5("Enter a text string below and hit the Submit button."),

    wellPanel(
      textInput("Tcir",label=h3("Type your sentence here:")),
    submitButton('Submit'),
    ##),
    h4('Suggested Word:'),
    textOutput("prediction")
    ##verbatimTextOutput("prediction")
    )
  )
  
)