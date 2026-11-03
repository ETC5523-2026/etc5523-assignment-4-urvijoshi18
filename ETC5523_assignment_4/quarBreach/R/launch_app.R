#' Launch the quarBreach Shiny app
#'
#' Opens the interactive Shiny app for exploring quarantine breach risk.
#'
#' @return Called for its side-effect; does not return a value.
#'
#' @examples
#' if (interactive()) {
#'   launch_app()
#' }
#'
#' @export
launch_app <- function() {
  app_dir <- system.file("shiny", package = "quarBreach")
  if (app_dir == "") {
    stop("Could not find the app directory. Try reinstalling quarBreach.")
  }
  shiny::runApp(app_dir, display.mode = "normal")
}
