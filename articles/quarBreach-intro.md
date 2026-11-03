# Getting started with quarBreach

## What this package does

`quarBreach` lets you explore the Zachreson et al. (2022) quarantine
model’s key parameter interactions. The central question: at what
combination of vaccine efficacy and community coverage does the expected
time to a community outbreak shift dramatically — and how does R0 move
that cliff?

## Installation

``` r

devtools::install_github("ETC5523-2026/etc5523-assignment-4-urvijoshi18",
                         subdir = "quarBreach")
```

## The data

``` r

library(quarBreach)
breach_scenarios
#>                 scenario r0 efficacy_pct breach_risk_vs_benchmark
#> 1 Pre-Delta unvaccinated  3            0                     1.00
#> 2   Pre-Delta vaccinated  3           90                     0.03
#> 3     Delta unvaccinated  6            0                     3.00
#> 4       Delta vaccinated  6           60                     1.00
#>                  label
#> 1        2020 baseline
#> 2 Alpha-era vaccinated
#> 3   Delta unvaccinated
#> 4     Delta vaccinated
```

`breach_scenarios` contains the four scenarios from Table 1 of the
paper. The key result: a fully vaccinated Delta pathway returns to
exactly the 2020 benchmark — the headroom vaccines were expected to buy
has gone.

``` r

head(outbreak_timing, 8)
#>   r0 coverage_pct efficacy_pct t95_days
#> 1  6           10           40       12
#> 2  6           10           60       18
#> 3  6           10           80       45
#> 4  6           10           90       80
#> 5  6           50           40       15
#> 6  6           50           60       35
#> 7  6           50           80      180
#> 8  6           50           90      400
```

`outbreak_timing` records t95 (days until a community outbreak is 95%
likely after a breach) across a grid of efficacy x coverage x R0 values.

## The summary function

[`summarise_breach_risk()`](../reference/summarise_breach_risk.md)
filters to a given R0 and adds a plain-language interpretation column:

``` r

summarise_breach_risk(r0 = 6)
#> # A tibble: 2 × 6
#>   scenario           r0 efficacy_pct breach_risk_vs_bench…¹ label interpretation
#>   <fct>           <int>        <int>                  <dbl> <chr> <chr>         
#> 1 Delta unvaccin…     6            0                      3 Delt… 3× the baseli…
#> 2 Delta vaccinat…     6           60                      1 Delt… Back to the 2…
#> # ℹ abbreviated name: ¹​breach_risk_vs_benchmark
```

## Launching the app

``` r

launch_app()
```

The app has two controls:

- **R0 (radio buttons):** switches between Delta (6) and a stress-test
  (10). Move this to see how higher transmissibility shifts the cliff.
- **Vaccine efficacy (slider):** drag below 60% to watch the heat map
  turn red regardless of coverage.
- **Community coverage (slider):** high coverage only helps when
  efficacy is also high — efficacy and coverage are complements, not
  substitutes.

## Interpreting the outputs

The **heat map** shows t95 for every efficacy x coverage combination. A
jump from red to green within a column is the cliff — below about 60%
efficacy the whole map stays red regardless of coverage.

The **bar chart** shows the four scenarios from Table 1. Delta
unvaccinated is 3x the 2020 baseline. A fully vaccinated Delta pathway
lands back at 1x — exactly where unvaccinated travellers were in 2020.
