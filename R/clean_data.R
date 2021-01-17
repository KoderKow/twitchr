#' Clean the Response From the Clean Bits Cheermotes Endpoint
#'
#' @param response_content Content from a HTTP Request. This is expecting to take the output from `httr::content()`.
#'
#' @return Clean and tidy tibble.
clean_bits_cheermotes <- function(response_content) {
  data_raw <-
    response_content %>%
    purrr::pluck("data") %>%
    dplyr::bind_rows()

  tiers_clean <-
    data_raw %>%
    dplyr::pull(tiers) %>%
    purrr::map_dfr(flatten_keep_names) %>%
    dplyr::rename_all(~ glue::glue("tiers_{.x}"))

  data_clean <-
    data_raw %>%
    dplyr::select(-tiers) %>%
    dplyr::bind_cols(tiers_clean)

  return(data_clean)
}

#' Clean the Response from the Videos Endpoint
#'
#' @param response_content Content from a HTTP Request. This is expecting to take the output from `httr::content()`.
#'
#' @return Clean and tidy tibble.
clean_videos <- function(response_content) {
  data_clean <-
    response_content %>%
    purrr::pluck("data") %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(
      dplyr::across(
        .cols = c("created_at", "published_at"),
        .fns = lubridate::ymd_hms
      )
    )

  return_list <- list(
    data = data_clean,
    pagination = response_content$pagination$cursor
  )

  return(return_list)
}

#' Clean the Response from Users
#'
#' @inheritParams clean_videos
#'
#' @return Clean and tidy tibble.
clean_users <- function(response_content) {
  data_clean <-
    response_content %>%
    purrr::pluck("data") %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(created_at = lubridate::ymd_hms(created_at))

  return(data_clean)
}

#' Clean the Response from Games
#'
#' @inheritParams clean_videos
#'
#' @return Clean and tidy tibble.
clean_games <- function(response_content) {
  data_clean <-
    response_content %>%
    purrr::pluck("data") %>%
    dplyr::bind_rows()

  return(data_clean)
}
