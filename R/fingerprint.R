#' @title Find fingerprint of string
#' @description Extremely simple fingerprint function for takeoff
#' @param s chacacter vector
#' @return fingerprint of given vector in a character vector of same size 
#' @examples
#' school <- c("school","School","school","School","School ","SCHOOL","School")
#' fingerprint(school)
#' @export
fingerprint <- function(s) tolower(trimws(s))