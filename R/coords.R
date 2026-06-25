#' Get coordinates for islands and territories
#'
#' Returns the latitude and longitude of a vector of country names or ISO
#' codes, one row per input and in input order (with \code{NA} rows for
#' unresolved inputs). Two location semantics are available: a representative
#' point on the territory's main landmass (the default), or the capital city.
#'
#' Inputs are resolved the same way as the predicate helpers (see
#' \code{\link{is_sids}}): by \code{iso_code}, then \code{label}, then the
#' XLSForm \code{name} slug, then a fallback through
#' \code{\link[countrycode]{countrycode}}.
#'
#' Coordinates are WGS84 decimal degrees. A handful of territories carry no
#' coordinate and return \code{NA}: the representative point is missing only for
#' United States Minor Outlying Islands (a scattered, centroid-less collection),
#' while capitals are missing for uninhabited or capital-less territories
#' (Antarctica, Bouvet Island, the British Indian Ocean Territory, Heard Island,
#' South Georgia, Tokelau, US Minor Outlying Islands, and Western Sahara).
#'
#' @param x A character vector of ISO codes or country names.
#' @param which Which location to return: \code{"point"} (default), a
#'   representative point on the main landmass, or \code{"capital"}, the capital
#'   city.
#'
#' @return A data frame with one row per element of \code{x}. For
#'   \code{which = "point"} the columns are \code{label} (the readable place
#'   name), \code{iso_code}, \code{latitude}, and \code{longitude}. For
#'   \code{which = "capital"} a \code{capital} city-name column is inserted
#'   before the coordinates.
#'
#' @examples
#' island_coords(c("Aruba", "Curacao", "Bonaire"))
#'
#' # Capital cities instead of landmass points
#' island_coords(c("AW", "PF", "GL"), which = "capital")
#'
#' # The two can differ substantially for dispersed territories
#' island_coords("French Polynesia")
#' island_coords("French Polynesia", which = "capital")
#'
#' @seealso \code{\link{island_lookup}} for arbitrary columns,
#'   \code{\link{add_island_cols}} to attach coordinates to a data frame.
#'
#' @export
island_coords <- function(x, which = c("point", "capital")) {
  which <- match.arg(which)
  idx <- .resolve(x)
  if (which == "point") {
    out <- data.frame(
      label     = islands$label[idx],
      iso_code  = islands$iso_code[idx],
      latitude  = islands$latitude[idx],
      longitude = islands$longitude[idx],
      stringsAsFactors = FALSE
    )
  } else {
    out <- data.frame(
      label     = islands$label[idx],
      iso_code  = islands$iso_code[idx],
      capital   = islands$capital[idx],
      latitude  = islands$capital_latitude[idx],
      longitude = islands$capital_longitude[idx],
      stringsAsFactors = FALSE
    )
  }
  rownames(out) <- NULL
  out
}
