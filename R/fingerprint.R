#' @title Find fingerprint of string
#' @description Extremely simple fingerprint function for takeoff
#' @param s chacacter vector
#' @return fingerprint of given vector in a character vector of same size 
#' @examples
#' school <- c("school","School","school","School","School ","SCHOOL","School")
#' fingerprint(school)
#' @export
fingerprint <- function(s){
  s <- as.character(s)
  if (length(s) == 0) stop("Character vector should be provided")
  # remove accents
  s <- stringi::stri_trans_general(s, "nfd; [:nonspacing mark:] remove; nfc")
  # remove numbers such as post codes, apartment number, arrondissment 
  s <- gsub(pattern = "[0-9]{2,}.?[[:blank:][:punct:]]?", replacement = "", x = s) 
  # remove punctuation such as resulted because of url encodings
  s <- gsub(pattern = "[[:punct:]]",replacement = " ", x = s)
  # remove multiple spaces
  s <- gsub("(?<=[\\s])\\s*|^\\s+$", "", s, perl = TRUE)
  # remove single or two digit  number that is leaded by space or followed by space
  s <- stringi::stri_replace(str = s, replacement = "", regex = "([[:blank:]^][0-9]{1,2})|([0-9]{1,2}[[:blank:]\\Z])")
  # trim string
  s <- stringi::stri_trim(s)
  s <- stringi::stri_trans_tolower(s)
  return(s)
}
