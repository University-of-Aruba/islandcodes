#' A.R.U.B.A.: Annotated Reference for Under-coded Border Areas
#'
#' A convenience wrapper around \code{\link{island_lookup}} with Aruba
#' as the default. Calling \code{aruba()} returns Aruba's classification
#' row; passing another country or ISO code returns that one instead.
#'
#' Named in homage to Edward Cheung, the Aruban engineer at NASA
#' Goddard who designed A.R.U.B.A. (the ASCS/NCS Relay Unit Breaker
#' Assembly) installed on the Hubble Space Telescope during the 2002
#' servicing mission. Cheung engineered the backronym specifically so
#' children in his home country would have something concrete to point
#' to on the telescope. We borrowed the trick. His ARUBA cuts power to
#' Hubble's instruments when there is a fault; ours returns a row of
#' classification data. Both spell Aruba.
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
      "A.R.U.B.A. — Annotated Reference for Under-coded Border Areas.\n",
      "Named in homage to Edward Cheung's A.R.U.B.A. (ASCS/NCS Relay Unit\n",
      "Breaker Assembly), installed on the Hubble Space Telescope during\n",
      "the 2002 servicing mission. Set options(islandcodes.aruba.quiet = TRUE)\n",
      "to silence."
    )
  }
  island_lookup(x)
}
