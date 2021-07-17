#' Get Users
#'
#' Gets information about one or more specified Twitch users. Users are identified by optional user IDs and/or login name. If neither a user ID nor a login name is specified, the user is looked up by Bearer token. *Note: This package does not support the bearer token at this time.*
#'
#' @param id A character. Optional. User ID. Multiple user IDs can be specified. Limit: 100.
#' @param login A character. Optional. User login name. Multiple login names can be specified. Limit: 100.
#' @inheritParams get_cheermotes
#'
#' @export
#'
#' @return A tibble data frame of twitch user data.
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

#' Get Follows
#'
#' @param from_id A character. User ID. The request returns information about users who are being followed by the from_id user.
#' @param to_id A character. User ID. The request returns information about users who are following the to_id user.
#' @param after A character. Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @param first A numeric. Maximum number of objects to return. Maximum: 100. Default: 20.
#' @inheritParams get_cheermotes
#'
#' @export
#'
#' @return A tibble data frame of follower data.
#'
#' @family Users
#' @references https://dev.twitch.tv/docs/api/reference#get-users-follows
#'
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' user <- get_users(login = "TheEatGameLove")
#'
#' followers <- get_follows(to_id = user$id)
#' }
get_follows <- function(
  from_id = NULL,
  to_id = NULL,
  after = NULL,
  first = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "users/follows",
    clean_json = clean_json,
    from_id = from_id,
    to_id = to_id,
    after = after,
    first = first
  )

  return(d)
}

#' Get All Follows
#'
#' @inheritParams get_follows
#'
#' @family Users
#' @export
#'
#' @return A tibble data frame of all follower data.
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-clips
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' user <- get_users(login = "TheEatGameLove")
#'
#' all_followers <- get_all_follows(to_id = user$id)
#' }
get_all_follows <- function(
  from_id = NULL,
  to_id = NULL
) {
  follows <- get_follows(
    from_id = from_id,
    to_id = to_id,
    first = 100
  )

  d <- follows$data

  while (!is.null(follows$pagination)) {
    follows <- get_follows(
      from_id = from_id,
      to_id = to_id,
      first = 100,
      after = follows$pagination
    )

    d <-
      d %>%
      dplyr::bind_rows(follows$data)
  }

  return(d)
}

#' Get A Broadcasters Current Chatters
#'
#' As of 2021-02-28 this endpoint is not documented and does not use any IDs.
#'
#' @param broadcaster A string. The name of the broadcaster.
#'
#' @family Users
#' @export
#'
#' @return A tibble data frame of chatter data.
#'
#' @references https://twitch.uservoice.com/forums/310213-developers/suggestions/39145294-chatters-viewers-helix-api-endpoint
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' chatters <- get_chatters("theeatgamelove")
#' }
get_chatters <- function(broadcaster) {
  chatters_header <- httr::add_headers(
    "Client-ID" = "",
    Authorization = ""
  )

  chatters <-
    glue::glue("https://tmi.twitch.tv/group/user/{broadcaster}/chatters") %>%
    httr::GET(chatters_header) %>%
    httr::content() %>%
    purrr::pluck("chatters") %>%
    flatten_keep_names() %>%
    tibble::enframe("broadcaster_type", "login") %>%
    tidyr::unnest(login) %>%
    dplyr::mutate(broadcaster_type = stringr::str_remove(broadcaster_type, "s\\d+$"))

  return(chatters)
}

#' Get Schedule
#'
#' Gets all scheduled broadcasts or specific scheduled broadcasts from a channel’s [stream schedule](https://help.twitch.tv/s/article/channel-page-setup?language=en_US#Schedule). Scheduled broadcasts are defined as “stream segments” in the API.
#'
#' If a Twitch streamer uses recurring scheduling the pagination will be infinite.
#'
#' @param broadcaster_id A string. User ID of the broadcaster who owns the channel streaming schedule. Provided broadcaster_id must match the user_id in the user OAuth token. Maximum: 1
#' @param id A string. The ID of the stream segment to return. Maximum: 100.
#' @param start_time A string. A timestamp in RFC3339 format to start returning stream segments from. If not specified, the current date and time is used.
#' @param utc_offset A string. A timezone offset for the requester specified in minutes. This is recommended to ensure stream segments are returned for the correct week. For example, a timezone that is +4 hours from GMT would be “240.” If not specified, “0” is used for GMT.
#' @param first A numeric. Maximum number of stream segments to return. Maximum: 25. Default: 20.
#' @param after A string. Cursor for forward pagination: tells the server where to start fetching the next set of results in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @inheritParams get_cheermotes
#'
#' @return A named list. `data` (tibble): the users schedule, NULL if no schudule. `vacation` (tibble): the users vacation dates, NULL if no vacation. `pagination` (character): Pagination value for the `after` parameter to get more data.
#' @export
#'
#' @family Users
#' @references https://dev.twitch.tv/docs/api/reference#get-channel-stream-schedule
#'
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' ## I set my account to be on vacation from "July 16, 2021"
#' ## to "July 16, 2026" for testing. There are also 4 days
#' ## of recurring streams with different values for testing.
#' users <- get_users(login = "KoderKow")
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
  d <- make_request(
    end_point = "schedule",
    clean_json = clean_json,
    broadcaster_id = broadcaster_id,
    id = id,
    start_time = start_time,
    utc_offset = utc_offset,
    first = first,
    after = after
  )

  return(d)
}
