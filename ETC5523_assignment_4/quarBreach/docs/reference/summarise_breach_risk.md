# Summarise quarantine breach risk scenarios

Filters
[`breach_scenarios`](https://etc5523-2026.github.io/etc5523-assignment-4-urvijoshi18/reference/breach_scenarios.md)
to a given R0 value and adds a plain-language interpretation column.

## Usage

``` r
summarise_breach_risk(r0 = NULL)
```

## Arguments

- r0:

  Integer or `NULL`. Must be 3, 6, or NULL (returns all rows).

## Value

A data frame with an added `interpretation` column.

## Examples

``` r
summarise_breach_risk()
#> # A tibble: 4 × 6
#>   scenario           r0 efficacy_pct breach_risk_vs_bench…¹ label interpretation
#>   <fct>           <int>        <int>                  <dbl> <chr> <chr>         
#> 1 Pre-Delta unva…     3            0                   1    2020… Back to the 2…
#> 2 Pre-Delta vacc…     3           90                   0.03 Alph… Room for ~33×…
#> 3 Delta unvaccin…     6            0                   3    Delt… 3× the baseli…
#> 4 Delta vaccinat…     6           60                   1    Delt… Back to the 2…
#> # ℹ abbreviated name: ¹​breach_risk_vs_benchmark
summarise_breach_risk(r0 = 6)
#> # A tibble: 2 × 6
#>   scenario           r0 efficacy_pct breach_risk_vs_bench…¹ label interpretation
#>   <fct>           <int>        <int>                  <dbl> <chr> <chr>         
#> 1 Delta unvaccin…     6            0                      3 Delt… 3× the baseli…
#> 2 Delta vaccinat…     6           60                      1 Delt… Back to the 2…
#> # ℹ abbreviated name: ¹​breach_risk_vs_benchmark
```
