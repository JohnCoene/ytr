
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ytr

R wrapper to the YouTube Analytics API.

## Install

``` r
# install.packages("remotes")
remotes::install_github("JohnCoene/ytr")
```

## Functions

  - `ytr_oauth` - Authenticate
  - `ytr_reports` - Get data
  - `ytr_parse` - Parse results

## Setup

Create a free application in the [Google
Console](https://console.cloud.google.com/) to obtain your client and
secret.

``` r
# OAuth
token <- ytr_oauth("something.apps.googleusercontent.com",
    "xxXx0X0x0X0xXX0")
```

## Examples

``` r
# Total views and likes in the last 3 days
token %>% 
  ytr_reports() %>% 
  ytr_parse()
#> # A tibble: 1 x 2
#>   views likes
#>   <int> <int>
#> 1 24597   237

# Top 10 videos by subs gained in the last 7 days
token %>% 
  ytr_reports(
      start = Sys.Date() - 7,
      metrics = c("estimatedMinutesWatched","views","likes","subscribersGained"), 
      dimensions = "video", 
      maxResults = 10, 
      sort = "-subscribersGained"
    ) %>% 
  ytr_parse()
#> # A tibble: 10 x 5
#>    video       estimatedMinutesWatched views likes subscribersGained
#>    <chr>                         <int> <int> <int>             <int>
#>  1 x2l7KscqRro                   49113 20269   128               185
#>  2 cFhONVldyE0                   37664  6455    96                80
#>  3 WsQ7ysVt-0A                   82857  8260   103                77
#>  4 8vnI5JBBFhU                   40635  5378    37                32
#>  5 4zzVjonyHcQ                   44922  3230    25                31
#>  6 c26OV713-Do                   48037  2469    26                29
#>  7 kpW9JcWxKq0                   10235  2313    17                25
#>  8 Pd8YY-IokMs                   17748  3012    16                18
#>  9 1O3ghiyirvU                   21104  1529    21                16
#> 10 -OiaE6l8ysg                    6944  1508    23                15

# Filter specific videos (by ID)
token %>% 
  ytr_reports(
      start = Sys.Date() - 7,
      metrics = c("estimatedMinutesWatched","views","likes","subscribersGained"), 
      dimensions = "video", 
      maxResults = 10, 
      sort = "-subscribersGained",
      filters = "video==x2l7KscqRro,cFhONVldyE0"
    ) %>% 
  ytr_parse()
#> # A tibble: 2 x 5
#>   video       estimatedMinutesWatched views likes subscribersGained
#>   <chr>                         <int> <int> <int>             <int>
#> 1 x2l7KscqRro                   49113 20269   128               185
#> 2 cFhONVldyE0                   37664  6455    96                80
```
