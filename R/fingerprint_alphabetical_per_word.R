#' @title Find fingerprint of string which words are ordered alphabetically
#' @description Fingerprint in order to unify strings like 'Cat Dog' and 'Dog Cat' 
#' @param s chacacter vector
#' @return fingerprint of given vector in a character vector of same size 
#' class <- c("Class A","Class A", "A-CLASS", "A CLASS", "Class B","Class B", "B-CLASS", "B CLASS")
#' fingerprint_alphabetical_per_word(class)
#' @export
fingerprint_alphabetical_per_word <- function(s){
  s <- fingerprint(s)
  s <- sapply(s, 
              function(x) paste0(sort(strsplit(x, split = " ") %>% unlist()), collapse = " "), 
              USE.NAMES = FALSE
              )
  return(s)
}
