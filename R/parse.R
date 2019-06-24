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

  data <- lapply(ytr$rows, as.data.frame)

  nm <- function(x){names(x) <- columns;return(x)}

  suppressWarnings({
    data <- lapply(data, nm) %>%
      purrr::map_df(dplyr::bind_rows)
  })

  tibble::as.tibble(data)
}
