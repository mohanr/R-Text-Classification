library(shiny)


fluidPage(

  # Application title
  titlePanel("Text Classification"),


  sidebarLayout(
    sidebarPanel(
			textInput("caption", "Text", "Type Text"),
			verbatimTextOutput("value")
    ),


    mainPanel(
			textOutput("text1")
    )
  )
)
