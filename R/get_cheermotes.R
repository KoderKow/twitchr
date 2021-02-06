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
  end_point <- "bits/cheermotes"

  d <- make_request(
    end_point = end_point,
    clean_json = clean_json,
    broadcaster_id = broadcaster_id
  )
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
  end_point <- "clips"

  d <- make_request(
    end_point = end_point,
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
  end_point <- "games"

  d <- make_request(
    end_point = end_point,
    clean_json = clean_json,
    id = id,
    name = name
  )
}

## KYLE YOU ARE HERE

get_top_games <- function(
  after = NULL,
  before = NULL,
  first = 20
) {
  end_point <- "games/top"

  d <- make_request(
    end_point = end_point,
    clean_json = TRUE,
    after = after,
    before = before,
    first = first
  )
}
