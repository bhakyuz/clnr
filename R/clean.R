#' @title Clean character vector
#' @description Clean character vector automatically with user feedback
#' @param s chacacter vector
#' @param ask_user Logical value in order to ask user her opinoin or automatically clean
#' @param fingerprint_fun name of function to be used for identifying string keys 
#' This should receive a char vector and returns same char vector of same lengt 
#' @return chacacter vector of clean/unified strings
#' @importFrom magrittr "%>%"
#' @examples
#' not_clean <- c("school","School","school","School","School ","SCHOOL","School", "Class A","Class A", "A-CLASS", "A CLASS")
#' clean(s = not_clean, ask_user = FALSE)
#' @export
clean <- function(s, ask_user = TRUE, fingerprint_fun = fingerprint){
  
  df <- data.frame(s = s, 
                   fingerprint = fingerprint_fun(s), 
                   stringsAsFactors = FALSE)
  
  df <- 
    df %>% 
    dplyr::mutate(length = nchar(s)) %>%
    dplyr::group_by(s) %>%
    dplyr::mutate(count = dplyr::n()) %>%
    dplyr::group_by(fingerprint, s) %>%
    dplyr::mutate(count_combination = dplyr::n()) %>%
    dplyr::group_by(fingerprint) %>% 
    dplyr::mutate(value_to_keep = dplyr::last(s, order_by = count, )) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(will_be_updated = !value_to_keep == s) 
  
  to_update <- 
    df %>%
    dplyr::filter(will_be_updated) %>%
    dplyr::mutate(
      prio_to_update = (count + count_combination * .01 + length * .001) / nrow(df),
      final_value_to_keep = as.character(NA)
    ) %>%
    dplyr::arrange(
      dplyr::desc(prio_to_update), 
      dplyr::desc(count), dplyr::desc(count_combination), length) %>%
    dplyr::distinct()
  
  if(!ask_user) {
    to_update$final_value_to_keep <- to_update$value_to_keep
  } else {
    for (i in 1:nrow(to_update)) {
      to_update$final_value_to_keep[i] <- get_feedback(
        x = to_update$s[i], 
        replacement = to_update$value_to_keep[i], ask_user)
    }
  }
  
  df_final <- dplyr::left_join(
    df, 
    dplyr::select(to_update, s, final_value_to_keep),
    by = "s")
  
  logs <- to_update %>%
    dplyr::select(s, fingerprint, final_value_to_keep)
  cat(crayon::yellow("Main modifications are as following:\n"))
  print(logs)
  res <- dplyr::coalesce(df_final$final_value_to_keep, df_final$s)
  return(res)
  # TODO check and present results
  # a <- clnr::clean(clnr::candyhierarchy_localities, ask_user = F)
}
