% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/games.R
\name{get_top_games}
\alias{get_top_games}
\title{Get top games}
\usage{
get_top_games(after = NULL, before = NULL, first = 20, clean_json = TRUE)
}
\arguments{
\item{after}{A character. Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.}

\item{before}{A character. Cursor for backward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.}

\item{first}{A numeric. Maximum number of objects to return. Maximum: 100. Default: 20.}

\item{clean_json}{A logical. If \code{TRUE}, clean and tidy the data. If \code{FALSE}, return the result of \code{httr::content}.}
}
\value{
A tibble data frame of top game data.
}
\description{
Gets games sorted by number of current viewers on Twitch, most popular first.
}
\examples{
\dontrun{
library(twitchr)

twitch_auth()

top_games <- get_top_games()
}
}
\references{
\url{https://dev.twitch.tv/docs/api/reference#get-top-games}
}
\seealso{
Other Games: 
\code{\link{get_games}()}
}
\concept{Games}
