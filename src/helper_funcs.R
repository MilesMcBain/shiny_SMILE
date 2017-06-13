#Paste0, Parse, Eval  
P0PE <- function(...){
  eval.parent(parse(text = paste0(...)))
}