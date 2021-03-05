#' Get Games
#'
#' Gets game information by game ID or name. For a query to be valid, `name` and/or `id` must be specified.
#'
#' @param id A character. Game ID. At most 100 id values can be specified.
#' @param name A character. Game name. The name must be an exact match. For example, “Pokemon” will not return a list of Pokemon games; instead, query any specific Pokemon games in which you are interested. At most 100 name values can be specified.
#' @inheritParams get_cheermotes
#'
#' @family Games
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-games
#'
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' games <- get_games(name = c("Battletoads", "Stardew Valley"))
#' }
get_games <- function(
  id = NULL,
  name = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "games",
    clean_json = clean_json,
    id = id,
    name = name
  )

  return(d)
}

#' Get Top Games
#'
#' Gets games sorted by number of current viewers on Twitch, most popular first.
#'
#' @param after A character. Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @param before A character. Cursor for backward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @param first A numeric. Maximum number of objects to return. Maximum: 100. Default: 20.
#' @inheritParams get_cheermotes
#'
#' @family Games
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-top-games
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' top_games <- get_top_games()
#' }
get_top_games <- function(
  after = NULL,
  before = NULL,
  first = 20,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "games/top",
    clean_json = clean_json,
    after = after,
    before = before,
    first = first
  )

  return(d)
}
