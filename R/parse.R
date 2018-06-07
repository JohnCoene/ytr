#' Parse results
#'
#' Build data frame from results
#'
#' @param ytr An object as returned by an API call.
#'
#' @return \code{tibble}
#'
#' @export
ytr_parse <- function(ytr){
  columns <- ytr$columnHeaders %>%
    purrr::map("name") %>%
    unlist()

  data <- as.data.frame(ytr$rows)
  names(data) <- columns

  tibble::as.tibble(data)
}
