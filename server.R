#Loading the required libraries for graphing and mapping functions.
require(shiny)
require(ggplot2)
require(dplyr)
require(leaflet)

#Loading the data from the csv file
coral_data = read.csv('Coral_Data.csv')
#Converting the Bleaching values from % to numbers.
coral_data[,6] <- as.numeric(gsub("%", "",coral_data[,6]))/100
coral_data[,6] = coral_data[,6] * 100
#Defining the server side of shiny application.
shinyServer(function(input, output){
  #Receiving the inputs from the side panel in shiny application.
  smoother_input <- reactive(input$Smoother_Type)
  coral_input <- reactive(input$Coral_Type)
  #Graphing the data based on the input given.
  output$Bleaching_datas <- renderPlot({
    coral_filter = coral_data %>% filter(coral_data$coralType == coral_input())
    #Ordering the data by latitude.
    coral_filter = coral_filter[order(coral_filter$latitude),]
    coral_filter$location = factor(coral_filter$location, levels = unique(coral_filter$location))
    ggplot(coral_filter,aes(year,value)) + facet_grid(coralType~location) + geom_smooth(method = smoother_input(), color = 'red')
  })
  #Creating a map using leaflet and plotting the corresponding locations onto the map.
  output$mapout <- renderLeaflet({
    coral_filter = coral_data %>% filter(coral_data$coralType == coral_input())
    leaf_print = leaflet(data = coral_filter) %>% addTiles() %>% addMarkers(~longitude, ~latitude, popup = ~as.character(location))
    print(leaf_print)
  })
})
