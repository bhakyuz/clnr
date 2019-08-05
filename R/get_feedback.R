#' @title Get feedback from user whether to replace a value
#' @description Get feedback from user whether to replace provided one lengt character
#' @param x One-lengt charachter 
#' @param replacement One-lengt charachter proposed as a replacement to x
#' @param ask_user Logical value in order to ask or accept right away replacement value
#' @return Final value that will be used instead of x 
#' @examples
#' get_feedback(x = "School ", replacement = "school", ask_user = FALSE)
#' \dontrun{
#' get_feedback(x = "school", replacement = "house")
#' }
#' @export
get_feedback <- function(x = "NoT CleAn ", replacement = "Clean", ask_user = T){
  
  if(is.logical(ask_user) & ask_user) {
    input <- readline(prompt = paste0("Wanna replace '", x, "' with '", replacement,  "': y/n or the value desired: "))
  } else input <- "y"
  
  if(tolower(input) == "y")
  {
    res <- replacement
    attributes(res) <- list(to_replace = T)
  } else {
    if(tolower(input) == "n")
    {
      res <- x
      attributes(res) <- list(to_replace = F)
    } else {
      res <- input
      attributes(res) <- list(to_replace = NULL)
    }
  }
  
  return(res)
}