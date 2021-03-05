#' Make a Twitch API Request
#'
#' @param end_point A character. The endpoint to make a request to.
#' @param ... Named elements that will serve as parameters that will be used during the `httr::GET()` request.
#' @param clean_json A logical. If `TRUE`, clean and tidy the data. If `FALSE`, return the result of `httr::content`.
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

  if (length(response_content$data) == 0) {
    usethis::ui_warn("The request is successful, however, there is no data in the response.")

    return(NULL)
  }

  if (clean_json == TRUE) {
    ## bits/cheermotes ----
    if (end_point == "bits/cheermotes") {
      result <- clean_bits_cheermotes(response_content)
    }

    ## videos ----
    if (end_point == "videos") {
      result <- clean_videos(response_content)
    }

    ## users ----
    if (end_point == "users") {
      result <- clean_users(response_content)
    }

    ## games ----
    if (end_point == "games") {
      result <- clean_games(response_content)
    }

    ## top/games ----
    if (end_point == "games/top") {
      result <- clean_top_games(response_content)
    }

    ## clips ----
    if (end_point == "clips") {
      result <- clean_clips(response_content)
    }

    ## Search Channels ----
    if (end_point == "search/channels") {
      result <- clean_search_channels(response_content)
    }

    if (end_point == "tags/streams") {
      result <- clean_get_all_stream_tags(response_content)
    }

    if (end_point == "streams/tags") {
      result <- clean_stream_tags(response_content, language)
    }

    if (end_point == "search/categories") {
      result <- clean_search_categories(response_content)
    }

    if (end_point == "users/follows") {
      result <- clean_get_follows(response_content)
    }

  } else {
    result <- response_content
  }

  return(result)
}

#' Check Request Status From Twitch
#'
#' @param response A response objct. Generally generated from `httr::GET()` or `httr::POST()`.
#'
#' @return An error message if status code is not 200. Invisible `NULL` if status code is 200.
check_status <- function(response) {
  status_code <- httr::status_code(response)

  if (status_code != 200) {
    response_content <- httr::content(response)
    usethis::ui_stop("Bad Request (HTTP {response_content$status}). {stringr::str_to_sentence(response_content$message)}.")
  }

  return(invisible())
}

#' Format Parameters
#'
#' @param ... Named elements that are wanted parameters to an end point.
#'
#' @return A character string in URL ready format.
format_parameters <- function(...) {
  parameters <- list(...) %>%
    purrr::compact()

  if (length(parameters) == 0) {
    return("")
  }

  formatted_parameters <-
    parameters %>%
    purrr::imap_chr(~ {
      glue::glue_collapse(glue::glue("{.y}={.x}"), sep = "&")
    }) %>%
    glue::glue_collapse(sep = "&") %>%
    paste0("?", .) %>%
    URLencode()

  return(formatted_parameters)
}

#' Keep names while flattening a named list
#'
#' Source taken from the package rlist's list.flatten. Didn't want to load dependency. Added a step to clean the names to snake case.
#'
#' @param x list
#' @param use.names	logical. Should the names of x be kept?
#' @param classes	A character vector of class names, or "ANY" to match any class.
flatten_keep_names <- function (x, use.names = TRUE, classes = "ANY") {
  len <- sum(rapply(x, function(x) 1L, classes = classes))
  y <- vector("list", len)
  i <- 0L
  items <- rapply(x, function(x) {
    i <<- i + 1L
    y[[i]] <<- x
    TRUE
  }, classes = classes)
  if (use.names && !is.null(nm <- names(items)))
    names(y) <- stringr::str_replace_all(nm, "\\.", "_")
  y
}

#' @title Silence the Haters
#'
#' @description For situations when you want to mute **known** warnings or messages in a {dplyr} chain.
#'
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#'
#' @rdname quiet_pipe
#' @export
`%shh%` <- function(lhs, rhs) {
  w <- options()$warn
  on.exit(options(warn = w))
  options(warn = -1)
  lhs_quo = rlang::quo_name(rlang::enquo(lhs))
  rhs_quo = rlang::quo_name(rlang::enquo(rhs))
  pipe = paste(lhs_quo, "%>%", rhs_quo)
  return(suppressMessages(rlang::eval_tidy(rlang::parse_quo(pipe, env = rlang::caller_env()))))
}

#' Wrapper for Formatting Date Times
#'
#' @param .data A tibble. Data to be formatted.
date_formatter <- function(.data) {
  d <-
    .data %>%
    dplyr::mutate(
      dplyr::across(
        .cols = c(
          dplyr::matches("created_at"),
          dplyr::matches("published_at"),
          dplyr::matches("last_updated"),
          dplyr::matches("followed_at")
        ),
        .fns = lubridate::ymd_hms
      )
    )

  return(d)
}
