
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

## Examples

``` r
library(twitchr)
```

``` r
twitch_auth()
```

``` r
cheermotes <- get_cheermotes(broadcaster_id = 41245072)

cheermotes
#> # A tibble: 180 x 30
#>    prefix type  order last_updated is_charitable tiers_min_bits tiers_id
#>    <chr>  <chr> <int> <chr>        <lgl>                  <int> <chr>   
#>  1 Cheer  glob~     1 2018-05-22T~ FALSE                      1 1       
#>  2 Cheer  glob~     1 2018-05-22T~ FALSE                    100 100     
#>  3 Cheer  glob~     1 2018-05-22T~ FALSE                   1000 1000    
#>  4 Cheer  glob~     1 2018-05-22T~ FALSE                   5000 5000    
#>  5 Cheer  glob~     1 2018-05-22T~ FALSE                  10000 10000   
#>  6 Doodl~ glob~     1 2018-05-22T~ FALSE                      1 1       
#>  7 Doodl~ glob~     1 2018-05-22T~ FALSE                    100 100     
#>  8 Doodl~ glob~     1 2018-05-22T~ FALSE                   1000 1000    
#>  9 Doodl~ glob~     1 2018-05-22T~ FALSE                   5000 5000    
#> 10 Doodl~ glob~     1 2018-05-22T~ FALSE                  10000 10000   
#> # ... with 170 more rows, and 23 more variables: tiers_color <chr>,
#> #   tiers_images_dark_animated_1 <chr>, tiers_images_dark_animated_1_5 <chr>,
#> #   tiers_images_dark_animated_2 <chr>, tiers_images_dark_animated_3 <chr>,
#> #   tiers_images_dark_animated_4 <chr>, tiers_images_dark_static_1 <chr>,
#> #   tiers_images_dark_static_1_5 <chr>, tiers_images_dark_static_2 <chr>,
#> #   tiers_images_dark_static_3 <chr>, tiers_images_dark_static_4 <chr>,
#> #   tiers_images_light_animated_1 <chr>, tiers_images_light_animated_1_5 <chr>,
#> #   tiers_images_light_animated_2 <chr>, tiers_images_light_animated_3 <chr>,
#> #   tiers_images_light_animated_4 <chr>, tiers_images_light_static_1 <chr>,
#> #   tiers_images_light_static_1_5 <chr>, tiers_images_light_static_2 <chr>,
#> #   tiers_images_light_static_3 <chr>, tiers_images_light_static_4 <chr>,
#> #   tiers_can_cheer <lgl>, tiers_show_in_bits_card <lgl>
```

``` r
videos <- get_videos(user_id = 27699280)

videos
#> $data
#> # A tibble: 20 x 14
#>    id    user_id user_name title description created_at         
#>    <chr> <chr>   <chr>     <chr> <chr>       <dttm>             
#>  1 8187~ 276992~ KoderKow  We P~ "Kyle and ~ 2020-11-28 17:40:21
#>  2 8183~ 276992~ KoderKow  [HL0~ "Why did I~ 2020-11-28 08:49:13
#>  3 8183~ 276992~ KoderKow  [HL0~ "I run int~ 2020-11-28 08:49:13
#>  4 8183~ 276992~ KoderKow  [HL0~ "I make fu~ 2020-11-28 08:49:13
#>  5 8183~ 276992~ KoderKow  [HL0~ "I get coc~ 2020-11-28 08:49:13
#>  6 8183~ 276992~ KoderKow  [HL0~ "This tree~ 2020-11-28 08:49:13
#>  7 8183~ 276992~ KoderKow  [HL0~ "Our favor~ 2020-11-28 08:49:13
#>  8 8183~ 276992~ KoderKow  [HL0~ "Kyle and ~ 2020-11-28 08:03:31
#>  9 8183~ 276992~ KoderKow  [HL0~ "We think ~ 2020-11-28 08:03:31
#> 10 8183~ 276992~ KoderKow  [HL0~ "I win the~ 2020-11-28 07:44:37
#> 11 8183~ 276992~ KoderKow  [HL0~ "I feel so~ 2020-11-28 07:44:37
#> 12 8183~ 276992~ KoderKow  [HL0~ "Kyle defe~ 2020-11-28 07:44:37
#> 13 8183~ 276992~ KoderKow  [HL0~ "Kamek rui~ 2020-11-28 07:44:37
#> 14 8183~ 276992~ KoderKow  [HL0~ "I dominat~ 2020-11-28 07:44:37
#> 15 8183~ 276992~ KoderKow  [HL0~ "I realize~ 2020-11-28 07:44:37
#> 16 8183~ 276992~ KoderKow  [HL0~ "Lol she d~ 2020-11-28 07:44:37
#> 17 8183~ 276992~ KoderKow  [HL0~ "I cleared~ 2020-11-28 07:44:37
#> 18 8183~ 276992~ KoderKow  [HL0~ "Kyle watc~ 2020-11-28 07:44:37
#> 19 8183~ 276992~ KoderKow  [HL0~ "Kyle gets~ 2020-11-28 07:44:37
#> 20 8183~ 276992~ KoderKow  [HL0~ "I freakin~ 2020-11-28 07:44:37
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
