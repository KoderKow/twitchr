get_games <- function(
  id = NULL,
  name = NULL,
  clean_json = TRUE
) {
  end_point <- "games"

  d <- make_request(
    end_point = end_point,
    clean_json = clean_json,
    id = id,
    name = name
  )
}
