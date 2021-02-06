#' Search for Games or Categories
#'
#' Returns a list of games or categories that match the query via name either entirely or partially.
#'
#' @param query A character. 	URl encoded search query.
#' @param first A numeric. Maximum number of objects to return. Maximum: 100. Default: 20.
#' @param after Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @param clean_json A logical. If `TRUE`, clean and tidy the data. If `FALSE`, return the result of `httr::content`.
#'
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#search-categories
search_categories <- function(
  query = NULL,
  first = NULL,
  after = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "search/categories",
    clean_json = clean_json,
    query = query,
    first = first,
    after = after
  )

  return(d)
}
