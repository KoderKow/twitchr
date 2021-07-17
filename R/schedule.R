#' Get Schedule
#'
#' Gets all scheduled broadcasts or specific scheduled broadcasts from a channel’s [stream schedule](https://help.twitch.tv/s/article/channel-page-setup?language=en_US#Schedule). Scheduled broadcasts are defined as “stream segments” in the API.
#'
#' @param broadcaster_id A string. User ID of the broadcaster who owns the channel streaming schedule. Provided broadcaster_id must match the user_id in the user OAuth token. Maximum: 1
#' @param id A string. The ID of the stream segment to return. Maximum: 100.
#' @param start_time A string. A timestamp in RFC3339 format to start returning stream segments from. If not specified, the current date and time is used.
#' @param utc_offset A string. A timezone offset for the requester specified in minutes. This is recommended to ensure stream segments are returned for the correct week. For example, a timezone that is +4 hours from GMT would be “240.” If not specified, “0” is used for GMT.
#' @param first A numeric. Maximum number of stream segments to return. Maximum: 25. Default: 20.
#' @param after A string. Cursor for forward pagination: tells the server where to start fetching the next set of results in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @inheritParams get_cheermotes
#'
#' @return A tibble data frame of a user's schedule data.
#' @export
#'
#' @family Schedules
#' @references https://dev.twitch.tv/docs/api/reference#get-channel-stream-schedule
#'
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' users <- get_users(login = "TheEatGameLove")
#'
#' schedule <- get_schedule(users$id)
#' }
get_schedule <- function(
  broadcaster_id = NULL,
  id = NULL,
  start_time = NULL,
  utc_offset = NULL,
  first = NULL,
  after = NULL,
  clean_json = TRUE
) {
  # https://api.twitch.tv/helix/schedule
  d <- make_request(
    end_point = "schedule",
    clean_json = clean_json,
    broadcaster_id = broadcaster_id,
    id = id,
    start_time = start_time,
    utc_offset = utc_offset,
    first = first,
    after = after,
  )

  return(d)
}
