#' Get Clips
#'
#' Gets clip information by clip ID (one or more), broadcaster ID (one only), or game ID (one only). Note: The clips service returns a maximum of 1000 clips. For a query to be valid, `id` (one or more), `broadcaster_id`, or `game_id` must be specified. You may specify only one of these parameters.
#'
#' @param broadcaster_id A character. ID of the broadcaster for whom clips are returned. The number of clips returned is determined by the first query-string parameter (default: 20). Results are ordered by view count.
#' @param game_id A character. ID of the game for which clips are returned. The number of clips returned is determined by the first query-string parameter (default: 20). Results are ordered by view count.
#' @param id A character. ID of the clip being queried. Limit: 100.
#' @param after A character. Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. This applies only to queries specifying broadcaster_id or game_id. The cursor value specified here is from the pagination response field of a prior query.
#' @param before A character. Cursor for backward pagination: tells the server where to start fetching the next set of results, in a multi-page response. This applies only to queries specifying broadcaster_id or game_id. The cursor value specified here is from the pagination response field of a prior query.
#' @param ended_at A character. Ending date/time for returned clips, in RFC3339 format. (Note that the seconds value is ignored.) If this is specified, started_at also must be specified; otherwise, the time period is ignored.
#' @param first A numeric. Maximum number of objects to return. Maximum: 100. Default: 20.
#' @param started_at A character. Starting date/time for returned clips, in RFC3339 format. (The seconds value is ignored.) If this is specified, ended_at also should be specified; otherwise, the ended_at date/time will be 1 week after the started_at value.
#' @inheritParams get_cheermotes
#'
#' @family Clips
#' @export
#'
#' @return A tibble data frame of clip data.
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-clips
#' @examples
#' \dontrun{
#' twitch_auth()
#'
#' user <- get_users(login = "KowAndToilet")
#'
#' clips <- get_clips(broadcaster_id = user$id)
#' }
get_clips <- function(
  broadcaster_id = NULL,
  game_id = NULL,
  id = NULL,
  after = NULL,
  before = NULL,
  ended_at = NULL,
  first = NULL,
  started_at = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "clips",
    clean_json = clean_json,
    broadcaster_id = broadcaster_id,
    game_id = game_id,
    id = id,
    after = after,
    before = before,
    ended_at = ended_at,
    first = first,
    started_at = started_at
  )

  return(d)
}

#' Get All Clips
#'
#' Gets clip information by broadcaster ID (one only), or game ID (one only). This function will handle pagination with `get_clips` automatically. Using at least one of the following parameters is required; `broadcaster_id` or `game_id`.
#'
#' @inheritParams get_clips
#'
#' @family Clips
#' @export
#'
#' @return A tibble data frame of clip data.
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-clips
#' @examples
#' \dontrun{
#' twitch_auth()
#'
#' user <- get_users(login = "KowAndToilet")
#'
#' all_clips <- get_all_clips(broadcaster_id = user$id)
#' }
get_all_clips <- function(
  broadcaster_id = NULL,
  game_id = NULL,
  ended_at = NULL,
  started_at = NULL
) {
  clips <- get_clips(
    broadcaster_id = broadcaster_id,
    game_id = game_id,
    first = 100,
    ended_at = ended_at,
    started_at = started_at
  )

  d <- clips$data

  while (!is.null(clips$pagination)) {
    clips <- get_clips(
      broadcaster_id = broadcaster_id,
      game_id = game_id,
      first = 100,
      ended_at = ended_at,
      started_at = started_at,
      after = clips$pagination
    )

    d <-
      d %>%
      dplyr::bind_rows(clips$data)
  }

  return(d)
}
