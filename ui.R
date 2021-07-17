fluidPage(
  fluidRow(
    column(4, wellPanel(
      #Creating the input choices for smoother types one can select from in the main panel.
      selectInput("Smoother_Type","Please select the type of smoother",
                  choices = c("auto","lm","glm","loess")),
      #Creating the input choices for coral types one can select from in the main panel.
      selectInput("Coral_Type","Please select the Coral Type",
                  choices = c("blue corals","hard corals","sea fans","sea pens","soft corals")))),
    #Plotting both the graph of the data and the map onto the main panel.
    column(8,
           h4("Coral Bleaching from 2010 to 2017"),
           plotOutput("Bleaching_datas"),
           h4("Location of Sites"),
           leafletOutput("mapout")
    )
  )
)