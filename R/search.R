#' Search Channels
#'
#' Returns a list of channels (users who have streamed within the past 6 months) that match the query via channel name or description either entirely or partially. Results include both live and offline channels. Online channels will have additional metadata (e.g. started_at, tag_ids).
#'
#' @param query A character. URl encoded search query.
#' @param first A numeric. Maximum number of objects to return. Maximum: 100 Default: 20
#' @param after A character. Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @param live_only A logical. Filter results for live streams only. Default: false
#' @inheritParams get_cheermotes
#'
#' @family Search
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#search-channels
search_channels <- function(
  query = NULL,
  first = FALSE,
  after = NULL,
  live_only = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "search/channels",
    clean_json = clean_json,
    query = query
  )

  return(d)
}

#' Search for Games or Categories
#'
#' Returns a list of games or categories that match the query via name either entirely or partially.
#'
#' @param query A character. 	URl encoded search query.
#' @param first A numeric. Maximum number of objects to return. Maximum: 100. Default: 20.
#' @param after Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @inheritParams get_cheermotes
#'
#' @export
#'
#' @family Search
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
