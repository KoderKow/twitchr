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

  while(!is.null(follows$pagination)) {
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
    'Client-ID' = "",
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
