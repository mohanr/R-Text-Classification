library(shiny)
library(stringr)
require(XML)

readposts <- 
		function(){
			posts <- xmlParse("10-26-teens_706posts.xml",  ,useInternalNodes = TRUE)
		}

posts <- readposts()

df <- data.frame(
				x1=character(),
				stringsAsFactors=FALSE)


filteredclasses <-
		function(){
			classes <- xpathSApply(doc = posts, path = "/*/Posts/Post/@class")
			for (i in 1:length(classes)) {
				df <- rbind(df, data.frame(x = classes[[i]]))
			}			
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



