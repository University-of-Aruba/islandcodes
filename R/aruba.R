#' Aruba
#'
#' A convenience wrapper around \code{\link{island_lookup}} with Aruba
#' as the default. Calling \code{aruba()} returns Aruba's classification
#' row; passing another country or ISO code returns that one instead.
#'
#' Named in homage to Edward Cheung, the Aruban-American engineer at
#' NASA Goddard who, across multiple Hubble Space Telescope servicing
#' missions, made a tradition of finding ways to put the name "Aruba"
#' onto the spacecraft. This package puts it on CRAN.
#'
#' @param x A character vector of country names or ISO codes. Defaults
#'   to \code{"Aruba"}.
#' @param quiet Logical. If \code{FALSE} (the default in interactive
#'   sessions, when called with no arguments) a short homage message is
#'   printed once. Set to \code{TRUE}, or set
#'   \code{options(islandcodes.aruba.quiet = TRUE)} globally, to silence.
#'
#' @return A data frame with one row per element of \code{x} (the same
#'   shape as \code{\link{island_lookup}}).
#'
#' @examples
#' aruba()
#' aruba("Curacao")
#' aruba(c("AW", "BQ-BO", "CW"))
#'
#' @export
aruba <- function(x = "Aruba",
                  quiet = getOption("islandcodes.aruba.quiet", FALSE)) {
  if (!isTRUE(quiet) && interactive() &&
      length(x) == 1L && identical(tolower(x), "aruba")) {
    message(
      "Named in homage to Edward Cheung, the Aruban engineer who put ",
      "Aruba on the Hubble Space Telescope. Set ",
      "options(islandcodes.aruba.quiet = TRUE) to silence."
    )
  }
  island_lookup(x)
}
