library(shiny)
library(stringr)
require(XML)


function(input, output) {

  posts <- xmlParse("10-26-teens_706posts.xml",  ,useInternalNodes = TRUE)
  messages <- xpathSApply(doc = posts, path = "//Post//text()",xmlValue)
  messageframe <- as.data.frame(messages)
  messageframe$messages <- str_trim(messageframe$messages) 
  print( messageframe )
  output$text1 <- renderText({ 
			  "class"
		  })
}

