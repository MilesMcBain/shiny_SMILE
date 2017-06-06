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