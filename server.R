library(shiny)
library(stringr)
require(XML)

readposts <- 
		function(){
			posts <- xmlParse("10-26-teens_706posts.xml",  ,useInternalNodes = TRUE)
		}

posts <- readposts()

classdf <- data.frame(
		classes=character(),
				stringsAsFactors=FALSE)

messagedf <- data.frame(
				messages=character(),
				stringsAsFactors=FALSE)
		

filteredclasses <-
		function(){
			classes <- xpathSApply(doc = posts, path = "/*/Posts/Post/@class")
			classdf <- rbind(classdf, data.frame(classes = classes))
		}

filteredmessages <-
		function(){
			messages <- trimws(xpathSApply(doc = posts, path = "//Post//text()",xmlValue))
			messagedf <- rbind(classdf, data.frame(messages = messages))
			cleanmessages <- messagedf[-which(messagedf$messages == ""), ]
			messageframe <- rbind(classdf, data.frame(messages = cleanmessages))
		}

filteredmessagesandclasses <-
		function(){
			messageframe <- filteredmessages()
			classesframe <- filteredclasses()	
			mergedframe <-  data.frame(messageframe,classesframe)
			print(sprintf("There are %d rows",nrow(mergedframe)))
			
		}



function(input, output) {

  filteredmessagesandclasses()
  output$text1 <- renderText({ 
			  "class"
		  })
}



