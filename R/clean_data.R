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
    date_formatter()

  return_list <- list(
    data = data_clean,
    pagination = response_content$pagination$cursor
  )

  return(return_list)
}

#' Clean the Response From the Clips Endpoint
#'
#' @inheritParams clean_videos
#'
#' @return Clean and tidy tibble.
clean_clips <- function(response_content) {
  data_clean <-
    response_content %>%
    purrr::pluck("data") %>%
    dplyr::bind_rows() %>%
    date_formatter()

  return_list <- list(
    data = data_clean,
    pagination = response_content$pagination$cursor
  )

  return(return_list)
}

#' Clean the Response From the Clean Bits Cheermotes Endpoint
#'
#' @inheritParams clean_videos
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

#' Clean the Response From Games
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

#' Clean the Response From Top Games
#'
#' @inheritParams clean_videos
#'
#' @return A named list containing: data, a Clean and tidy tibble. pagination, cursor for pagination.
clean_top_games <- function(response_content) {
  data_clean <-
    response_content %>%
    purrr::pluck("data") %>%
    dplyr::bind_rows()

  return_list <- list(
    data = data_clean,
    pagination = response_content$pagination$cursor
  )

  return(return_list)
}

#' Clean the Response From Search Channels
#'
#' @inheritParams clean_videos
#'
#' @return A named list containing: data, a Clean and tidy tibble. tags, character vector of current live streamer tags. pagination, cursor for pagination.
clean_search_channels <- function(response_content) {
  ## Need to iterate after the pluck and remove tag_ids possibly
  data_raw <-
    response_content %>%
    purrr::pluck("data")

  ## Need to get tag names!
  tag_ids <-
    data_raw %>%
    purrr::map(tag_cleaner)

  data_clean <-
    data_raw %>%
    ## Remove tag IDs
    purrr::map_dfr(purrr::discard, is.list)

  return_list <- list(
    data = data_clean,
    tags = tag_ids,
    pagination = response_content$pagination$cursor
  )

  return(return_list)
}

#' Extract and Clean Search Channel Tags
#'
#' @param data_raw_element An element from data_raw/response_content
#'
#' @return A list of tags per searched channel
tag_cleaner <- function(data_raw_element) {
  clean_tags <-
    data_raw_element %>%
    purrr::keep(is.list) %>%
    unlist(use.names = FALSE)

  return(clean_tags)
}

#' Clean the Response From Search Channels
#'
#' @inheritParams clean_videos
#'
#' @return A named list containing: data, a Clean and tidy tibble. pagination, cursor for pagination.
clean_get_all_stream_tags <- function(response_content) {

  data_clean <-
    response_content %>%
    purrr::pluck("data") %>%
    purrr::map_dfr(get_all_tags_response_cleaner)

  return_list <- list(
    data = data_clean,
    pagination = response_content$pagination$cursor
  )

  return(return_list)
}

get_all_tags_response_cleaner <- function(data_raw_element) {
  d <-
    dplyr::tibble(
      tag_id = data_raw_element$tag_id,
      is_auto = data_raw_element$is_auto,
      langage = names(data_raw_element$localization_names),
      localization_names = unlist(data_raw_element$localization_names, use.names = FALSE),
      localization_descriptions = unlist(data_raw_element$localization_descriptions, use.names = FALSE)
    )

  return(d)
}

#' Clean the Response From Search Categories
#'
#' @inheritParams clean_videos
#'
#' @return A named list containing: data, a Clean and tidy tibble. pagination, cursor for pagination.
clean_search_categories <- function(response_content) {
  data_clean <-
    response_content %>%
    purrr::pluck("data") %>%
    dplyr::bind_rows()

  return_list <- list(
    data = data_clean,
    pagination = response_content$pagination$cursor
  )

  return(return_list)
}
