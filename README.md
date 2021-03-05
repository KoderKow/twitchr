
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

``` r
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
    -   TWITCH\_CLIENT\_ID=YOUR CLIENT ID
    -   TWITCH\_SECRET=YOUR SECRET
10. Restart the RStudio session

### More Information

Read about getting authorization tokens
[here](https://dev.twitch.tv/docs/authentication).

## Examples

``` r
library(twitchr)
```

``` r
twitch_auth()
```

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

``` r
videos <- get_videos(user_id = user$id)

videos
#> $data
#> # A tibble: 20 x 15
#>    id    user_id user_login user_name title description created_at         
#>    <chr> <chr>   <chr>      <chr>     <chr> <chr>       <dttm>             
#>  1 9360~ 613890~ theeatgam~ TheEatGa~ "Sec~ ""          2021-03-03 23:57:37
#>  2 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#>  3 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#>  4 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#>  5 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#>  6 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#>  7 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#>  8 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#>  9 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> 10 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> 11 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> 12 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> 13 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> 14 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> 15 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> 16 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> 17 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> 18 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> 19 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> 20 9346~ 613890~ theeatgam~ TheEatGa~ "[20~ ""          2021-03-02 21:56:22
#> # ... with 8 more variables: published_at <dttm>, url <chr>,
#> #   thumbnail_url <chr>, viewable <chr>, view_count <int>, language <chr>,
#> #   type <chr>, duration <chr>
#> 
#> $pagination
#> [1] "eyJiIjpudWxsLCJhIjp7Ik9mZnNldCI6MjB9fQ"
```

## Thanks to

-   [Freguglia](https://github.com/Freguglia/rTwitchAPI) for getting me
    started on the oauth code
