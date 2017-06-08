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
           name = map_chr(node_handle, ~.jcall(obj=bayes_net, returnSig="S", method='getNodeName', .)),
           description = map_chr(node_handle, ~.jcall(obj=bayes_net, returnSig="S", method='getNodeDescription', .)),
           parents = map(node_handle, ~.jcall(obj=bayes_net, returnSig="[I", method='getParents', .)),
           children = map(node_handle, ~.jcall(obj=bayes_net, returnSig="[I", method='getChildren', .))
    )
  nodes
}
