#' Get Auth Token
#'
#' Get started with the Twitch API [here](https://dev.twitch.tv/docs/api/). `TWITCH_CLIENT_ID` and `TWITCH_SECRET` need to be set in the *.Renviron* file. Set these values in *.Renviron* with `usethis::edit_r_environ()`; ex: `TWITCH_CLIENT_ID=abc123`.
#'
#' @param client_id A character. Twitch App ID.
#' @param client_secret A character. Twitch App Secret.
#'
#' @return Invisible authorization data.
#' @export
twitch_auth <- function(
  client_id = Sys.getenv("TWITCH_CLIENT_ID"),
  client_secret = Sys.getenv("TWITCH_SECRET")
) {

  if (assertthat::are_equal(client_id, "") | assertthat::are_equal(client_secret, "") | assertthat::are_equal(client_id, NULL) | assertthat::are_equal(client_secret, NULL)) {
    usethis::ui_stop("{usethis::ui_value('client_id')} and {usethis::ui_value('client_secret')} need to set.")
  }

  query_list <- list(
    client_id = client_id,
    client_secret = client_secret,
    grant_type = "client_credentials"
  )

  response <-
    httr::POST(
      url = "https://id.twitch.tv/oauth2/token",
      query = query_list
    )

  check_status(response)

  response_content <- httr::content(response)

  httr::add_headers(
    'Client-ID' = client_id,
    Authorization = paste0("Bearer ", response_content$access_token)
  ) %>%
    httr::set_config()

  return(invisible(response_content))
}
