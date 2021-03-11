#' Get All Stream Tags
#'
#' @param after A character. Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
#' @param first A numeric. Maximum number of objects to return. Maximum: 100. Default: 20.
#' @param tag_id A character. ID of a tag. Multiple IDs can be specified, separated by ampersands. If provided, only the specified tag(s) is(are) returned. Maximum of 100.
#' @param language A character. Default `en-us` (English US). Options include: bg-bg, cs-cz, da-dk, de-de, el-gr, en-us, es-es, es-mx, fi-fi, fr-fr, hu-hu, it-it, ja-jp, ko-kr, nl-nl, no-no, pl-pl, pt-br, pt-pt, ro-ro, ru-ru, sk-sk, sv-se, th-th, tr-tr, vi-vn, zh-cn, zh-tw, bg-bg, cs-cz, da-dk, de-de, el-gr, en-us, es-es, es-mx, fi-fi, fr-fr, hu-hu, it-it, ja-jp, ko-kr, nl-nl, no-no, pl-pl, pt-br, pt-pt, ro-ro, ru-ru, sk-sk, sv-se, th-th, tr-tr, vi-vn, zh-cn, zh-tw, bg-bg, cs-cz, da-dk, de-de, el-gr, en-us, es-es, es-mx, fi-fi, fr-fr, hu-hu, it-it, ja-jp, ko-kr, nl-nl, no-no, pl-pl, pt-br, pt-pt, ro-ro, ru-ru, sk-sk, sv-se, th-th, tr-tr, vi-vn, zh-cn, zh-tw.
#' @inheritParams get_cheermotes
#'
#' @family Tags
#' @export
#'
#' @return A tibble data frame of stream tag data.
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-all-stream-tags
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' tags <- get_all_stream_tags(first = 3)
#' }
get_all_stream_tags <- function(
  after = NULL,
  first = NULL,
  tag_id = NULL,
  language = "en-us",
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "tags/streams",
    clean_json = clean_json,
    after = after,
    first = first,
    tag_id = tag_id,
    language = language
  )

  d$data <-
    d$data %>%
    dplyr::rename(l = language) %>%
    dplyr::filter(l == language) %>%
    dplyr::rename(language = l)

  return(d)
}

#' Get Stream Tags
#'
#' Gets the list of tags for a specified stream (channel).
#'
#' @param broadcaster_id A character. ID of the stream thats tags are going to be fetched.
#' @inheritParams get_cheermotes
#' @inheritParams get_all_stream_tags
#'
#' @family Tags
#' @export
#'
#' @return A tibble data frame of stream tag data.
#'
#' @references https://dev.twitch.tv/docs/api/reference#get-stream-tags
#' @examples
#' \dontrun{
#' library(twitchr)
#'
#' twitch_auth()
#'
#' user <- get_users(login = "TheEatGameLove")
#'
#' tags <- get_stream_tags(broadcaster_id = user$id)
#' }
get_stream_tags <- function(
  broadcaster_id = NULL,
  language = "en-us",
  clean_json = TRUE
) {
  d <- make_request(
    end_point = "streams/tags",
    clean_json = clean_json,
    broadcaster_id = broadcaster_id
  )

  d <-
    d %>%
    dplyr::rename(l = language) %>%
    dplyr::filter(l == language) %>%
    dplyr::rename(language = l)

  return(d)
}
