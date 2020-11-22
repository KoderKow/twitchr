
<!-- README.md is generated from README.Rmd. Please edit that file -->

# twitchr

<!-- badges: start -->

<!-- badges: end -->

R wrapper for the Twitch API.

Thanks to

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
#> # A tibble: 185 x 30
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
#> # ... with 175 more rows, and 23 more variables: tiers_color <chr>,
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
#>  1 8110~ 276992~ KoderKow  High~ "Kyle gets~ 2020-11-21 19:20:11
#>  2 8110~ 276992~ KoderKow  High~ "Debby goe~ 2020-11-21 19:20:11
#>  3 8110~ 276992~ KoderKow  High~ "Kyle dips~ 2020-11-21 19:20:11
#>  4 8110~ 276992~ KoderKow  High~ "We really~ 2020-11-21 19:20:11
#>  5 8110~ 276992~ KoderKow  High~ "Kyle gets~ 2020-11-21 19:20:11
#>  6 8110~ 276992~ KoderKow  High~ "You alrea~ 2020-11-21 19:20:11
#>  7 8110~ 276992~ KoderKow  High~ "We actual~ 2020-11-21 19:20:10
#>  8 8110~ 276992~ KoderKow  High~ "Kyle leav~ 2020-11-21 19:20:10
#>  9 8110~ 276992~ KoderKow  High~ "Kyle cons~ 2020-11-21 19:20:10
#> 10 8110~ 276992~ KoderKow  High~ "We see th~ 2020-11-21 19:20:10
#> 11 8110~ 276992~ KoderKow  High~ "Our plan ~ 2020-11-21 19:20:10
#> 12 8110~ 276992~ KoderKow  High~ "What is w~ 2020-11-21 19:20:10
#> 13 8101~ 276992~ KoderKow  WE L~ ""          2020-11-21 01:59:24
#> 14 8098~ 276992~ KoderKow  High~ "My best f~ 2020-11-20 21:42:18
#> 15 8098~ 276992~ KoderKow  High~ "Kyle give~ 2020-11-20 21:42:18
#> 16 8098~ 276992~ KoderKow  High~ ""          2020-11-20 21:42:18
#> 17 8098~ 276992~ KoderKow  High~ "Kyle give~ 2020-11-20 21:42:18
#> 18 8098~ 276992~ KoderKow  High~ "These mus~ 2020-11-20 21:42:18
#> 19 8098~ 276992~ KoderKow  High~ ""          2020-11-20 21:42:18
#> 20 8098~ 276992~ KoderKow  High~ "Kyle almo~ 2020-11-20 21:42:18
#> # ... with 8 more variables: published_at <dttm>, url <chr>,
#> #   thumbnail_url <chr>, viewable <chr>, view_count <int>, language <chr>,
#> #   type <chr>, duration <chr>
#> 
#> $pagination
#> [1] "eyJiIjpudWxsLCJhIjp7Ik9mZnNldCI6MjB9fQ"
```

## Thanks to

  - [Freguglia](https://github.com/Freguglia/rTwitchAPI) for getting me
    started on the oauth code
