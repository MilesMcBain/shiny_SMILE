#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Bayesin Network Scenario Interface"),
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "new_scenario_name", label = "Scenario Name", placeholder = "Scenario"),
      shiny::actionButton(inputId = "save", label = "save"),
      shiny::actionButton(inputId = "copy", label = "copy"),
      shiny::actionButton(inputId = "paste", label = "paste"),
      shiny::actionButton(inputId = "delete", label = "delete"),
      shiny::selectInput(inputId = "scenarios", label = "Configured Scenarios", choices = r_scenarios)
    ),
    mainPanel(
      uiOutput("scenario_parameters")
    )
  
  )
  
  
  
  
))
