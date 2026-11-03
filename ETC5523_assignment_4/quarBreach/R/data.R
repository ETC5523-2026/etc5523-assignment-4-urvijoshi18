#' Quarantine breach risk under four COVID-19 scenarios
#'
#' A dataset reconstructed from Table 1 of Zachreson et al. (2022),
#' giving breach risk relative to the pre-Delta unvaccinated benchmark.
#'
#' @format A data frame with 4 rows and 5 variables:
#' \describe{
#'   \item{scenario}{Descriptive label for the scenario.}
#'   \item{r0}{Basic reproduction number (3 = ancestral; 6 = Delta).}
#'   \item{efficacy_pct}{Vaccine efficacy against infection (\%).}
#'   \item{breach_risk_vs_benchmark}{Relative breach risk vs. 2020 baseline.}
#'   \item{label}{Short label for display.}
#' }
#' @source Zachreson et al. (2022) \emph{Science Advances} 8(14): eabm3624.
"breach_scenarios"


#' Outbreak timing by efficacy, coverage, and transmissibility
#'
#' Approximate values of t95 (days until a community outbreak is 95\% likely
#' after a quarantine breach), read from Figure 4 of Zachreson et al. (2022).
#'
#' @format A data frame with 32 rows and 4 variables:
#' \describe{
#'   \item{r0}{Basic reproduction number (6 or 10).}
#'   \item{coverage_pct}{Community vaccination coverage (\%).}
#'   \item{efficacy_pct}{Vaccine efficacy against infection (\%).}
#'   \item{t95_days}{Days until an outbreak is 95\% likely after a breach.}
#' }
#' @source Approximated from Zachreson et al. (2022) \emph{Science Advances} 8(14): eabm3624, Figure 4.
"outbreak_timing"
