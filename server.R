#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
 
  # Setup the node input UI based on the network definition.
  generate_node_input_UI(output, nodes_df)
  
  #Get a list of input nodes
  input_nodes <- get_input_nodes(nodes_df)
  
observe({
    input$save
    if(input$save > 0){
      validate_node_input(input, input_nodes$id)
      save_node_input()
    }
    })
})
