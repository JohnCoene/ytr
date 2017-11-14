#' List jobs
#'
#' @export
ytr_jobs <- function(token){
  uri <- "https://youtubereporting.googleapis.com/v1/jobs"

  uri <- paste0(uri, )

  response <- httr::GET(uri)

  httr::message_for_status(response)
}
