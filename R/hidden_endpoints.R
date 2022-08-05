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
