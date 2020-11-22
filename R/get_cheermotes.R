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
