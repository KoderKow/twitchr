#' Get Video Information
#'
#' Gets video information by video ID (one or more), user ID (one only), or game ID (one only). The following param description is from the Twitch API docs. Last Updated on 2020-11-22.
#'
#' @param id A string. Required (Read Documentation for more information). ID of the video being queried. Limit: 100. If this is specified, you cannot use any of the optional query parameters below.
#' @param user_id A string. Required (Read Documentation for more information). ID of the user who owns the video. Limit 1.
#' @param game_id A string. Required (Read Documentation for more information). ID of the game the video is of. Limit 1.
#' @param after A string. Optional. Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @param before A string. Optional. Cursor for backward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @param first A string. Optional. Number of values to be returned when getting videos by user or game ID. Limit: 100. Default: 20.
#' @param language A string. Optional. 	Language of the video being queried. Limit: 1.
#' @param period A string. Optional. Period during which the video was created. Valid values: "all", "day", "week", "month". Default: "all".
#' @param sort A string. Optional. Sort order of the videos. Valid values: "time", "trending", "views". Default: "time".
#' @param type A string. Optional. ype of video. Valid values: "all", "upload", "archive", "highlight". Default: "all".
#' @inheritParams get_cheermotes
#'
#' @export
#'
#' @return A tibble data frame of videos data.
#'
#' @family Videos
#' @references https://dev.twitch.tv/docs/api/reference#get-videos
#'
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' # Get a user'rs first 20 videos
#' videos <- get_videos(user_id = 613890167)
#' }
get_videos <- function(
  id = NULL,
  user_id = NULL,
  game_id = NULL,
  after = NULL,
  before = NULL,
  first = NULL,
  language = NULL,
  period = NULL,
  sort = NULL,
  type = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "videos",
    clean_json = clean_json,
    id = id,
    user_id = user_id,
    game_id = game_id,
    after = after,
    before = before,
    first = first,
    language = language,
    period = period,
    sort = sort,
    type = type
  )

  return(d)
}
