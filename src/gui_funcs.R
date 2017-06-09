nodes_to_rhandsontable_input <- function(nodes_df){
  nodes_df %>% 
    filter(type %in% c("Cpt","List")) %>%
    select(id, outcomes) %>%
    spread(key = id, value = outcomes) %>%
    unnest() %>%
    #head(1) %>% #prototype input. Factor levels.
    as.data.frame() %>%
    rhandsontable()
    
}