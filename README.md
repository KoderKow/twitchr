
<!-- README.md is generated from README.Rmd. Please edit that file -->

# twitchr

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![R build
status](https://github.com/KoderKow/twitchr/workflows/R-CMD-check/badge.svg)](https://github.com/KoderKow/twitchr/actions)
<!-- badges: end -->

R wrapper for the Twitch API.

## Installation

### From Github

``` r
if (!requireNamespace("remotes")){install.packages("remotes")}
remotes::install_github("koderkow/twitchr")
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
[here](https://dev.twitch.tv/docs/authentication).

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
user <- get_users(login = "theeatgamelove")

user
#> # A tibble: 1 x 10
#>   id    login display_name type  broadcaster_type description profile_image_u~
#>   <chr> <chr> <chr>        <chr> <chr>            <chr>       <chr>           
#> 1 6138~ thee~ TheEatGameL~ ""    affiliate        Hello frie~ https://static-~
#> # ... with 3 more variables: offline_image_url <chr>, view_count <int>,
#> #   created_at <dttm>
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
chatters <- get_chatters("theeatgamelove")
```

### Other functions

I have covered most of the Twitch API endpoints which can be viewed
[here](https://koderkow.github.io/twitchr/reference/index.html). If
there are any you would like added please create an issue! :)

## Thanks to

-   [Freguglia](https://github.com/Freguglia/rTwitchAPI) for getting me
    started on the oauth code
