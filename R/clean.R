#' @title Clean character vector
#' @description Clean character vector automatically with user feedback
#' @param s chacacter vector
#' @param ask_user Logical value in order to ask user her opinoin or automatically clean
#' @return chacacter vector of clean/unified strings
#' @importFrom magrittr "%>%"
#' @export
clean <- function(s, ask_user = T){
  df <- data.frame(s = s, fingerprint = fingerprint(s), stringsAsFactors = F)
  
  df <- 
    df %>% 
    dplyr::mutate(l = nchar(s)) %>%
    dplyr::group_by(s) %>%
    dplyr::mutate(count = dplyr::n()) %>%
    dplyr::group_by(fingerprint, s) %>%
    dplyr::mutate(count_combination = dplyr::n()) %>%
    dplyr::group_by(fingerprint) %>% 
    # value_to_keep is based on the original data for now but this 
    # ideally this might be provided by user 
    # so it is more reproducible
    dplyr::mutate(value_to_keep = dplyr::last(s, order_by = count, )) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(will_be_updated = !value_to_keep == s) 
  
  # paste(df$s[!df$change], df$u[!df$change], sep = ">", collapse = " ")
  
  to_update <- 
    df %>%
    dplyr::filter(will_be_updated) %>%
    dplyr::mutate(
      prio_to_update = (count + count_combination * .01 + l * .001) / nrow(df),
      final_value_to_keep = as.character(NA)
    ) %>%
    dplyr::arrange(dplyr::desc(prio_to_update), dplyr::desc(count), dplyr::desc(count_combination), l) %>%
    #   dplyr::select(s, fingerprint, value_to_keep) %>% 
    dplyr::distinct()
  
  for (i in 1:nrow(to_update)) {
    to_update$final_value_to_keep[i] <- get_feedback(
      x = to_update$s[i], 
      replacement = to_update$value_to_keep[i], ask_user)
  }
  
  df2 <- dplyr::left_join(
    df, 
    dplyr::select(to_update, s, final_value_to_keep),
    by = "s")
  
  res <- dplyr::coalesce(df2$final_value_to_keep, df2$s)
  return(res)
}
