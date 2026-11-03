library(readr)
library(dplyr)

## breach_scenarios ----
breach_scenarios <- read_csv("data-raw/breach_scenarios.csv") |>
  mutate(
    scenario     = factor(scenario, levels = scenario),
    r0           = as.integer(r0),
    efficacy_pct = as.integer(efficacy_pct)
  )

usethis::use_data(breach_scenarios, overwrite = TRUE)

## outbreak_timing ----
outbreak_timing <- read_csv("data-raw/outbreak_timing.csv") |>
  mutate(
    r0           = as.integer(r0),
    coverage_pct = as.integer(coverage_pct),
    efficacy_pct = as.integer(efficacy_pct)
  )

usethis::use_data(outbreak_timing, overwrite = TRUE)
