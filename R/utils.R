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
      # glue::glue("{.y}={.x}")
    }) %>%
    glue::glue_collapse(sep = "&") %>%
    paste0("?", .)

  return(formatted_parameters)
}

#' Keep names while flattening a named list
#'
#' Source taken from `rlist::list.flatten`. Didn't want to load dependency. Added a step to clean the names to snake case.
#'
#' @inheritParams rlist::list.flatten
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

