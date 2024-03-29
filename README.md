
<!-- README.md is generated from README.Rmd. Please edit that file -->

# twitchr

<!-- badges: start -->

[![R-CMD-check](https://github.com/KoderKow/twitchr/workflows/R-CMD-check/badge.svg)](https://github.com/KoderKow/twitchr/actions)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->

R wrapper for the Twitch API.

## Installation

### From Github

``` r
# install.packages("devtools")
devtools::install_github("koderkow/twitch")
```

## Setup

### Steps

1.  Go to <https://dev.twitch.tv/login>
2.  Login with Twitch
3.  Click *Register Your Application*
4.  Fill out the App information
    -   Name: Name of the app. Something to label it for the own
        personal use
    -   OAuth Redirect URLs: Fill this in if one if you have one. If not
        put `http://localhost`
    -   Category: Pick related category such as *Analytics Tool*
5.  Click Create
6.  On the new app, click *Manage*
7.  This page will have the Client ID and Client Secret
8.  Open the `.Renviron` to add these values
    -   Run `usethis::edit_r_environ()` in the RStudio R console
9.  Enter the two key values into this file with the following key names
    -   `TWITCH_CLIENT_ID=YOUR CLIENT ID`
    -   `TWITCH_SECRET=YOUR SECRET`
10. Restart the RStudio session

### More Information

Read about getting authorization tokens
[here](https://dev.twitch.tv/docs/authentication/).

## Examples

``` r
library(twitchr)
```

### Authorize

Get auth token by using `twitch_auth()`. This will be appended to future
API calls

``` r
twitch_auth()
```

### Get user information

Look up a user by their display name to get user information. This is
userful to obtain `broadcaster_id` for other functions

``` r
user <- get_users(login = "KowAndToilet")

user
#> # A tibble: 1 x 10
#>   id        login        display~1 type  broad~2 descr~3 profi~4 offli~5 view_~6
#>   <chr>     <chr>        <chr>     <chr> <chr>   <chr>   <chr>   <chr>     <int>
#> 1 613890167 kowandtoilet kowandto~ ""    affili~ Kyle a~ https:~ https:~    4989
#> # ... with 1 more variable: created_at <dttm>, and abbreviated variable names
#> #   1: display_name, 2: broadcaster_type, 3: description, 4: profile_image_url,
#> #   5: offline_image_url, 6: view_count
#> # i Use `colnames()` to see all variable names
```

### Get Videos

Obtain a users recent videos

``` r
videos <- get_videos(user_id = user$id)
```

### Get Followers

Display the followers of a channel

``` r
followers <- get_follows(to_id = user$id)
```

### Get chatters

Display who is currently in a broadcasters chat

``` r
chatters <- get_chatters("KowAndToilet")
```

### Other functions

I have covered most of the Twitch API endpoints which can be viewed
[here](https://koderkow.github.io/twitchr/reference/index.html). If
there are any you would like added please create an issue! :)

## Thanks to

-   [Freguglia](https://github.com/Freguglia/rTwitchAPI/) for getting me
    started on the oauth code
