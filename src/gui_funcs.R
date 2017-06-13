get_input_nodes <- function(nodes_df){
  nodes_df %>% 
    filter(type %in% c("Cpt","List"))
}

nodes_to_input_proto <- function(nodes_df){
  input_proto <- 
    nodes_df %>% 
    get_input_nodes() %>%
    select(node_handle,id,name,description,outcomes) %>%
    mutate(outcomes = map(outcomes, levels))
 input_proto
}

generate_node_input_UI <- function(output, nodes_df){
  # Generate node evidence input
  list_of_node_inputs <- 
    nodes_df %>%
    nodes_to_input_proto() %>%
    pmap(.f = function(id, name, description, outcomes, ...){
      wellPanel(    
        fluidRow(
          shiny::column(width = 6,
                        h3(name),
                        shiny::textOutput(outputId = paste0(id,"_descr"))),
          shiny::column(width = 6,
                        shiny::selectInput(inputId = id, label = "Evidence", choices = c(".",outcomes), selected = "."),
                        shiny::textInput(inputId = paste0(id,"_virtual"), 
                                         label = "Virtual Evidence", 
                                         placeholder = "Pr(S1), Pr(S2), ... Pr(Sn)"))
        )
      )
    })
  
  output$scenario_parameters <-   renderUI({ tagList(list_of_node_inputs) })

  # Set the description text
  pwalk(nodes_df, function(id, description, ...){
     P0PE("output$",id,"_descr <- renderText(description)")
  })
}

validate_node_input <- function(input, input_node_list){
  input_evidence <-
    tibble(
      evidence = map_chr(input_node_list, ~eval(parse(text = paste0("input$",.)))),
      virtual_evidence = map(id, ~P0PE("input$",.,"_virtual"))
    )
  print(input_evidence)
  View(input_evidence)
}


save_node_input <- function(){
  
}
