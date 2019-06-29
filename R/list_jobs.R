#' List jobs
#'
#' @param token your token as returned by \code{\link{ytr_oauth}}.
#' @param start,end Start and end date of class \code{Date}.
#' @param ids Ids of chennels or users data to return.
#' @param metrics Metrics to return, see\href{https://developers.google.com/youtube/analytics/metrics}{docs}.
#' @param dimensions A \code{list} or \code{vector} of YouTube Analytics dimensions, such as \code{video} or \code{ageGroup}, see\href{https://developers.google.com/youtube/reporting/}{docs}.
#' @param ... Any other parameter to pass to query.
#'
#' @examples
#' \dontrun{
#' token <- ytr_oauth(
#'   "something.apps.googleusercontent.com",
#'   "xxXx0X0x0X0xXX0")
#'
#' ytr <- ytr_reports(token) %>%
#'   ytr_parse()
#' }
#'
#' @importFrom magrittr %>%
#'
#' @seealso \href{https://developers.google.com/youtube/analytics/}{official documentation}
#'
#' @export
ytr_reports <- function(token, start = Sys.Date() - 3, end = Sys.Date(),
                        ids = "channel==MINE", metrics = c("views","likes"), 
                        dimensions = NULL, ...){
  uri <- "https://youtubeanalytics.googleapis.com/v2/reports"

  if(!is.null(dimensions))
    dimensions <- paste0(dimensions, collapse = ",")

  uri <- httr::parse_url(uri)
  uri$query <- list(
    metrics = paste0(metrics, collapse = ","),
    ids = ids,
    startDate = as.character(start),
    endDate = as.character(end),
    dimensions = dimensions,
    ...
  )

  uri <- httr::build_url(uri)

  response <- httr::GET(uri, httr::config(token = token))

  httr::stop_for_status(response, httr::content(response)$error$message)

  content <- httr::content(response)

  content
}
