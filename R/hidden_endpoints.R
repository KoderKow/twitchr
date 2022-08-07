#' Get a broadcasters current chatters
#'
#' **This uses undocumented API endpoints. This may change or break at anytime. Use at your own risk!**.
#'
#' @param broadcaster A character. The name of the broadcaster.
#'
#' @family Hidden Endpoints
#' @export
#'
#' @return A tibble data frame of chatter data.
#'
#' @references <https://thomassen.sh/twitch-api-endpoints/#tmi.twitch.tv/group/user/{USERNAME}/chatters>
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' chatters <- get_chatters("KowAndToilet")
#' }
get_chatters <- function(broadcaster) {
  chatters_header <- httr::add_headers(
    "Client-ID" = "",
    Authorization = ""
  )

  broadcaster_lower <- stringr::str_to_lower(broadcaster)

  chatters <-
    glue("https://tmi.twitch.tv/group/user/{broadcaster_lower}/chatters") %>%
    httr::GET(chatters_header) %>%
    httr::content() %>%
    purrr::pluck("chatters") %>%
    flatten_keep_names() %>%
    tibble::enframe("broadcaster_type", "login") %>%
    tidyr::unnest(login) %>%
    dplyr::mutate(broadcaster_type = stringr::str_remove(broadcaster_type, "s\\d+$"))

  return(chatters)
}

#' Get video comments
#'
#' **This uses undocumented API endpoints. This may change or break at anytime. Use at your own risk!**. Given a `video_id`, return the comments/chat related to that video.
#'
#' @param video_id A numeric. Video ID for the comments to extract.
#'
#' @family Hidden Endpoints
#' @export
#'
#' @return A list of comments related to the requested `video_id`. `NULL` is returned if the `video_id` does not exist.
#'
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' video_comments <- get_video_comments(822494395)
#' }
get_video_comments <- function(video_id) {
  comment_header <- httr::add_headers(
    `Client-ID` = httr2::secret_decrypt(tw, k),
    Accept = "application/vnd.twitchtv.v5+json; charset=UTF-8"
  )

  resp <-
    glue("https://api.twitch.tv/v5/videos/{video_id}/comments") %>%
    httr::GET(comment_header) %>%
    httr::content()

  d <-
    resp |>
    purrr::pluck("comments") |>
    purrr::map(~ {
      .x$message$user_badges <- .x$message$user_badges |>
        purrr::simplify() |>
        purrr::map(purrr::pluck, "_id") |>
        unlist() |>
        stringr::str_c(collapse = ", ")

      .x$message$fragments <- NULL
      .x$message$emoticons <- NULL

      return(.x)
    }) |>
    purrr::map_dfr(flatten_keep_names)

  while (!is.null(resp$`_next`)) {
    print(resp$`_next`)
    resp <-
      glue("https://api.twitch.tv/v5/videos/{video_id}/comments?cursor={resp$`_next`}") %>%
      httr::GET(comment_header) %>%
      httr::content()

    d_next <-
      resp |>
      purrr::pluck("comments") |>
      purrr::map(~ {
        .x$message$user_badges <- .x$message$user_badges |>
          purrr::simplify() |>
          purrr::map(purrr::pluck, "_id") |>
          unlist() |>
          stringr::str_c(collapse = ", ")

        .x$message$fragments <- NULL
        .x$message$emoticons <- NULL

        return(.x)
      }) |>
      purrr::map_dfr(flatten_keep_names)

    d <-
      d %>%
      dplyr::bind_rows(d_next)
  }

  return(d)
}
