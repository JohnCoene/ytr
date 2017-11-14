#' Authenticate
#'
#' @param client.id Your \code{client.id}. See details below.
#' @param client.secret Your \code{client.secret}. See details below.
#' @param scope Scope of token. See details below.
#'
#' @details
#' To get your client.id and client.secret please follow the instructions
#' \href{https://developers.google.com/youtube/registering_an_application}{here}
#' Also set the redirect Authorized redirect URIs to your \code{httr::oauth_callback()} URL,
#' generally your localhost.
#'
#' Valid scopes:
#' \itemize{
#'   \item{\code{yt-analytics-monetary.readonly}}
#'   \item{\code{yt-analytics.readonly}}
#' }
#'
#' See \href{https://developers.google.com/youtube/reporting/guides/authorization/client-side-web-apps}{official documentation}
#' for more information on the scopes.
#'
#' @examples
#' \dontrun{
#' token <- ytr_oauth("something.apps.googleusercontent.com",
#'   "xxXx0X0x0X0xXX0")
#' }
#'
#' @export
ytr_oauth <- function(client.id, client.secret,
                      scope = "yt-analytics.readonly"){

  if (missing(client.id) || missing(client.secret)) {
    stop("Missing client id or secret", call. = FALSE)
  }

  youtube <- httr::oauth_endpoints("google")

  # build app
  you.app <- httr::oauth_app("youtube", client.id, client.secret)

  # set scope
  if(!scope %in% valid_scopes()){

    stop("Invalid scope. See @details.", call. = FALSE)

  } else {

    scope <- paste0("https://www.googleapis.com/auth/", scope)

  }

  # OAuth
  token <- httr::oauth2.0_token(youtube, you.app,
                                scope = scope,
                                cache = FALSE)

  return(token)
}
