library(shiny)
library(stringr)
require(XML)

readposts <- 
		function(){
			posts <- xmlParse("10-26-teens_706posts.xml",  ,useInternalNodes = TRUE)
		}

posts <- readposts()

filteredclasses <-
		function(){
			classes <- as.data.frame(xpathSApply(doc = posts, path = "/*/Posts/Post/@class"))
			print(sprintf("There are %d classes",length(unlist(classes))))
}

filteredmessagesandclasses <-
		function(){
			classframe <- filteredclasses()
			messages <- xpathSApply(doc = posts, path = "//Post//text()",xmlValue)
			print(sprintf("There are %d messages",length(messages)))
			messageframe <- as.data.frame(messages)
			messagesandclasses <- merge(messageframe,classframe)
			messagesandclasses <-  messagesandclasses[ -which( messagesandclasses$messages==""), ]
			print(sprintf("Merged frame has %d messages",length(messagesandclasses)))
			print(colnames(messagesandclasses))
			#messageframe$messages <- str_trim(messageframe$messages) 
			#print( messagesandclasses )
}



function(input, output) {

  filteredmessagesandclasses()
  output$text1 <- renderText({ 
			  "class"
		  })
}


