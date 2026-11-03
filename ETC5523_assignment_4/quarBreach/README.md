# quarBreach
[![pkgdown site](https://img.shields.io/badge/docs-pkgdown-blue)](https://etc5523-2026.github.io/etc5523-assignment-4-urvijoshi18/)

An R package for exploring COVID-19 quarantine breach risk based on
Zachreson et al. (2022).

## Purpose

Helps public-health students explore how vaccine efficacy, community
vaccination coverage, and the basic reproduction number (R0) interact
to determine quarantine breach risk and expected time to a community outbreak.

## Data

- `breach_scenarios`: four scenarios from Table 1 of Zachreson et al. (2022)
- `outbreak_timing`: outbreak horizon (t95) across efficacy x coverage x R0

Source: Zachreson et al. (2022) *Science Advances* 8(14): eabm3624.

## Installation

```r
devtools::install_github("ETC5523-2026/etc5523-assignment-4-urvijoshi18",
                         subdir = "quarBreach")
```

## Launch the app

```r
library(quarBreach)
launch_app()
```

## Use the summary function

```r
summarise_breach_risk()
summarise_breach_risk(r0 = 6)
```
