# Initialisation and Setup Functions


#' Title
#'
#' @param networks_path a directory to search for bayesian network definitions 
#'
#' @return the file to load the bayesian network from.
#' @export
#'
select_local_networks <- function(networks_path){
  network_files <- list.files(networks_path)
  if(length(network_files) > 1){
    message(sprintf("Multiple network defintions found in %s, please make a selection:", networks_path))
    network_definition <- rChoiceDialogs::rchoose.files(default = networks_path)
  }
  else network_definition <- network_files[[1]]
  network_definition
}

#' Title
#'
#' @param bayes_net an initialsed Bayesian Netowrk Java Object 
#'
#' @return A nested tibble containing network nodes
#' @export 
#'
get_network_nodes <- function(bayes_net){
  node_handles <-.jcall(obj=bayes_net, returnSig="[I", method='getAllNodes')
  nodes <- 
    data_frame(node_handle = node_handles) %>%
    mutate(id = map_chr(node_handle, ~.jcall(obj=bayes_net, returnSig="S", method='getNodeId', .)),
           type = map_chr(node_handle, ~get_node_type(bayes_net, .)),
           name = map_chr(node_handle, ~.jcall(obj=bayes_net, returnSig="S", method='getNodeName', .)),
           description = map_chr(node_handle, ~.jcall(obj=bayes_net, returnSig="S", method='getNodeDescription', .)),
           outcomes = map(node_handle, ~get_node_outcomes(bayes_net, .)),
           parents = map(node_handle, ~.jcall(obj=bayes_net, returnSig="[I", method='getParents', .)),
           children = map(node_handle, ~.jcall(obj=bayes_net, returnSig="[I", method='getChildren', .))
    )
  nodes
}

get_node_type <- function(bayes_net, node_handle){
  node_type_int <- .jcall(obj=bayes_net, returnSig="I", method='getNodeType', node_handle)
  type <- switch(as.character(node_type_int),
                 "18" = "Cpt",
                 "20" = "TruthTable",
                 "17" = "List",
                 "8"  = "Table",
                 "520"= "Mau",
                 "146"= "NoisyMax",
                 "274"= "NoisyAdder",
                 "4"  = "Equation",
                 "82" = "DeMorgan",
                 "NF"
                 )
  type
}

get_node_outcomes <- function(bayes_net, node_handle){
  num_outcomes <- .jcall(obj=bayes_net, returnSig="I", method='getOutcomeCount', node_handle)
  if(get_node_type(bayes_net, node_handle) %in% c("Cpt", "List")){
    outcomes_inorder <- map_chr(as.integer((1:num_outcomes)-1), 
                                  ~.jcall(obj=bayes_net, returnSig="S", method='getOutcomeId', node_handle, .)) %>%
                        forcats::as_factor() #makes states a factor with levels in the order they appear.
  }else{
    outcomes_inorder <- NA
  }
  outcomes_inorder
    
}
