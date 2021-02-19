#' Get Users
#'
#' Gets information about one or more specified Twitch users. Users are identified by optional user IDs and/or login name. If neither a user ID nor a login name is specified, the user is looked up by Bearer token.
#'
#' @param id A character. Optional. User ID. Multiple user IDs can be specified. Limit: 100.
#' @param login A character. Optional. User login name. Multiple login names can be specified. Limit: 100.
#' @inheritParams get_cheermotes
#'
#' @export
#'
#' @family Users
#' @references https://dev.twitch.tv/docs/api/reference#get-users
#'
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' users <- get_users(login = "TheEatGameLove")
#' }
get_users <- function(
  id = NULL,
  login = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "users",
    clean_json = clean_json,
    id = id,
    login = login
  )

  return(d)
}
