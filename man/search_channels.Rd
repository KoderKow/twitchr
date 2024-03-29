% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/search.R
\name{search_channels}
\alias{search_channels}
\title{Search channels}
\usage{
search_channels(
  query = NULL,
  first = FALSE,
  after = NULL,
  live_only = NULL,
  clean_json = TRUE
)
}
\arguments{
\item{query}{A character. URl encoded search query.}

\item{first}{A numeric. Maximum number of objects to return. Maximum: 100 Default: 20}

\item{after}{A character. Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.}

\item{live_only}{A logical. Filter results for live streams only. Default: false}

\item{clean_json}{A logical. If \code{TRUE}, clean and tidy the data. If \code{FALSE}, return the result of \code{httr::content}.}
}
\value{
A tibble data frame of search channel data.
}
\description{
Returns a list of channels (users who have streamed within the past 6 months) that match the query via channel name or description either entirely or partially. Results include both live and offline channels. Online channels will have additional metadata (e.g. started_at, tag_ids).
}
\examples{
\dontrun{
library(twitchr)

twitch_auth()

search_results <- search_channels("KowAndToilet")
}
}
\references{
\url{https://dev.twitch.tv/docs/api/reference#search-channels}
}
\seealso{
Other Search: 
\code{\link{search_categories}()}
}
\concept{Search}
