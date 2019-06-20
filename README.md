# ytr

![YouTube](https://lh3.googleusercontent.com/j2SJC1grxLdL94kX7uB9WclD_nqX49oJs3K82Tok1MaPcx4TvB2m7xmw-Ub4dvFORwPSzruQBWePxtizfuY1r3j4GQvi1G9z=s688)

## Install

```r
devtools::install_github("JohnCoene/ytr", auth_token = "xXXXxxXXXxx")
```

## Functions

* `ytr_oauth` - Authenticate
* `ytr_reports` - Get data
* `ytr_parse` - Parse results

## Examples

``` r
# OAuth
token <- ytr_oauth("something.apps.googleusercontent.com",
    "xxXx0X0x0X0xXX0")
    
df <- token %>% 
  ytr_reports() %>% 
  ytr_parse()
```
