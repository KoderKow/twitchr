#' Make a Twitch API Request
#'
#' @param end_point A character. The endpoint to make a request to.
#' @param ... Named elements that will serve as parameters that will be used during the `httr::GET()` request.
#' @param clean_json A logical. If `TRUE`, clean and tidy the data. If `FALSE`, return the result of `httr::content`.
#'
#' @export
make_request <- function(
  end_point,
  ...,
  clean_json = TRUE
) {
  ## Clean params, if any
  formatted_params <- format_parameters(...)

  ## Establish URLs
  base_url <- "https://api.twitch.tv/helix/"
  url_end_point <- glue::glue("{base_url}{end_point}{formatted_params}")

  response <- httr::GET(url = url_end_point)

  check_status(response)

  response_content <- httr::content(response)

  if (clean_json == TRUE) {
    ## bits/cheermotes ----
    if (end_point == "bits/cheermotes") {
      result <- clean_bits_cheermotes(response_content)
    }

    ## videos ----
    if (end_point == "videos") {
      result <- clean_videos(response_content)
    }

  } else {
    result <- response_content
  }

  return(result)
}
