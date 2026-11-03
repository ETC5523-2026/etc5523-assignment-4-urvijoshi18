#' Summarise quarantine breach risk scenarios
#'
#' Filters \code{\link{breach_scenarios}} to a given R0 value and adds
#' a plain-language interpretation column.
#'
#' @param r0 Integer or \code{NULL}. Must be 3, 6, or NULL (returns all rows).
#'
#' @return A data frame with an added \code{interpretation} column.
#'
#' @examples
#' summarise_breach_risk()
#' summarise_breach_risk(r0 = 6)
#'
#' @export
summarise_breach_risk <- function(r0 = NULL) {
  if (!is.null(r0) && !r0 %in% c(3L, 6L)) {
    stop("`r0` must be 3, 6, or NULL. Got: ", r0)
  }

  df <- quarBreach::breach_scenarios

  if (!is.null(r0)) {
    df <- df[df$r0 == r0, ]
  }

  df$interpretation <- dplyr::case_when(
    df$breach_risk_vs_benchmark < 0.1 ~
      paste0("Room for ~", round(1 / df$breach_risk_vs_benchmark), "\u00d7 more arrivals"),
    df$breach_risk_vs_benchmark <= 1.1 ~
      "Back to the 2020 baseline",
    TRUE ~
      paste0(round(df$breach_risk_vs_benchmark, 1), "\u00d7 the baseline exposure")
  )

  df
}
