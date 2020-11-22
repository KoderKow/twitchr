#' Check Request Status From Twitch
#'
#' @param response A response objct. Generally generated from `httr::GET()` or `httr::POST()`.
#'
#' @return An error message if status code is not 200. Invisible `NULL` if status code is 200.
#' @export
check_status <- function(response) {
  status_code <- httr::status_code(response)

  if (status_code != 200) {
    response_content <- httr::content(response)
    usethis::ui_stop("Bad Request (HTTP {response_content$status}). {stringr::str_to_sentence(response_content$message)}.")
  }

  return(invisible(NULL))
}
