#' Get All Stream Tags
#'
#' @param after A character. Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @param first A numeric. Maximum number of objects to return. Maximum: 100. Default: 20.
#' @param tag_id A character. ID of a tag. Multiple IDs can be specified, separated by ampersands. If provided, only the specified tag(s) is(are) returned. Maximum of 100.
#' @inheritParams get_cheermotes
#'
#' @family Tags
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-all-stream-tags
get_all_stream_tags <- function(
  after = NULL,
  first = NULL,
  tag_id = NULL,
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "tags/streams",
    clean_json = clean_json,
    after = after,
    first = first,
    tag_id = tag_id
  )

  return(d)
}

#' Get Stream Tags
#'
#' Gets the list of tags for a specified stream (channel).
#'
#' @param broadcaster_id A character. ID of the stream thats tags are going to be fetched.
#' @param language A character. Wanted language. Need to list languages here...
#' @inheritParams get_cheermotes
#'
#' @family Tags
#' @export
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-stream-tags
get_stream_tags <- function(
  broadcaster_id = NULL,
  language = "en-us",
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "streams/tags",
    language = "en-us",
    clean_json = clean_json,
    broadcaster_id = broadcaster_id
  )

  return(d)
}
