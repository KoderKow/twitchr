#' Retrieves the list of available Cheermotes
#'
#' Retrieves the list of available Cheermotes, animated emotes to which viewers can assign Bits, to cheer in chat. Cheermotes returned are available throughout Twitch, in all Bits-enabled channels.
#'
#' @param broadcaster_id A numeric. Optional. ID for the broadcaster who might own specialized Cheermotes.
#' @param clean_json A logical. If `TRUE`, clean and tidy the data. If `FALSE`, return the result of `httr::content`.
#'
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-cheermotes
get_cheermotes <- function(broadcaster_id = NULL, clean_json = TRUE) {
  d <- make_request(
    end_point = "bits/cheermotes",
    clean_json = clean_json,
    broadcaster_id = broadcaster_id
  )

  return(d)
}

#' Get Clips
#'
#' Gets clip information by clip ID (one or more), broadcaster ID (one only), or game ID (one only). Note: The clips service returns a maximum of 1000 clips.
#'
#' @param broadcaster_id A character. ID of the broadcaster for whom clips are returned. The number of clips returned is determined by the first query-string parameter (default: 20). Results are ordered by view count.
#' @param game_id A character. ID of the game for which clips are returned. The number of clips returned is determined by the first query-string parameter (default: 20). Results are ordered by view count.
#' @param id A character. ID of the clip being queried. Limit: 100.
#' @inheritParams get_cheermotes
#'
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-clips
get_clips <- function(
  broadcaster_id = NULL,
  game_id = NULL,
  id = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "clips",
    clean_json = clean_json,
    broadcaster_id = broadcaster_id,
    game_id = game_id,
    id = id
  )

  return(d)
}

#' Get Games
#'
#' Gets game information by game ID or name.
#'
#' @param id A character. Game ID. At most 100 id values can be specified.
#' @param name A character. Game name. The name must be an exact match. For example, “Pokemon” will not return a list of Pokemon games; instead, query any specific Pokemon games in which you are interested. At most 100 name values can be specified.
#' @inheritParams get_cheermotes
#'
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-games
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
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-top-games
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

#' Search Channels
#'
#' Returns a list of channels (users who have streamed within the past 6 months) that match the query via channel name or description either entirely or partially. Results include both live and offline channels. Online channels will have additional metadata (e.g. started_at, tag_ids).
#'
#' @param query A character. URl encoded search query.
#' @param first A numeric. Maximum number of objects to return. Maximum: 100 Default: 20
#' @param after A character. Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @param live_only A logical. Filter results for live streams only. Default: false
#' @inheritParams get_cheermotes
#'
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#search-channels
search_channels <- function(
  query = NULL,
  first = FALSE,
  after = NULL,
  live_only = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "search/channels",
    clean_json = clean_json,
    query = query
  )

  return(d)
}

#' Get All Stream Tags
#'
#' @param after A character. Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @param first A numeric. Maximum number of objects to return. Maximum: 100. Default: 20.
#' @param tag_id A character. ID of a tag. Multiple IDs can be specified, separated by ampersands. If provided, only the specified tag(s) is(are) returned. Maximum of 100.
#' @inheritParams get_cheermotes
#'
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-all-stream-tags
get_all_stream_tags <- function(
  after = NULL,
  first = NULL,
  tag_id = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "tags/streams",
    clean_json = clean_json,
    after = after,
    first = first,
    tag_id = tag_id
  )

  return(d)
}

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

#' Search for Games or Categories
#'
#' Returns a list of games or categories that match the query via name either entirely or partially.
#'
#' @param query A character. 	URl encoded search query.
#' @param first A numeric. Maximum number of objects to return. Maximum: 100. Default: 20.
#' @param after Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @inheritParams get_cheermotes
#'
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#search-categories
search_categories <- function(
  query = NULL,
  first = NULL,
  after = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "search/categories",
    clean_json = clean_json,
    query = query,
    first = first,
    after = after
  )

  return(d)
}
