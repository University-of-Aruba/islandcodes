#' Great-circle distance between islands
#'
#' Haversine (great-circle) distance between the coordinates of islands and
#' territories, resolved from country names or ISO codes via the same matching
#' as the rest of the package (see \code{\link{is_sids}}). A natural primitive
#' for connectivity and isolation work on small islands.
#'
#' @param x A character vector of ISO codes or country names.
#' @param y Optional second character vector. If \code{NULL} (the default) a
#'   full symmetric distance matrix among the elements of \code{x} is returned.
#'   If supplied, distances are computed element-wise between \code{x} and
#'   \code{y}, recycling the shorter of the two, so a single origin against many
#'   destinations gives the distance from that origin to each.
#' @param which Coordinate to use: \code{"point"} (representative landmass
#'   point, the default) or \code{"capital"} (capital city).
#' @param unit Output unit: \code{"km"} (kilometres, the default), \code{"mi"}
#'   (statute miles), or \code{"nmi"} (nautical miles).
#'
#' @return When \code{y} is \code{NULL}, a numeric matrix
#'   (\code{length(x)} by \code{length(x)}) with \code{iso_code} dimnames.
#'   Otherwise a named numeric vector. Unresolved inputs and territories without
#'   the requested coordinate propagate as \code{NA}.
#'
#' @examples
#' # Spread of the Dutch Caribbean (ABC + SSS), in km
#' round(island_distance(c("AW", "CW", "BQ-BO", "SX", "BQ-SA", "BQ-SE")))
#'
#' # One origin to many
#' island_distance("Aruba", c("Curacao", "Bonaire", "Sint Maarten"))
#'
#' # Capital-to-capital, in nautical miles
#' island_distance("AW", "CW", which = "capital", unit = "nmi")
#'
#' @seealso \code{\link{island_coords}}
#' @export
island_distance <- function(x, y = NULL, which = c("point", "capital"),
                            unit = c("km", "mi", "nmi")) {
  which <- match.arg(which)
  unit  <- match.arg(unit)
  radius_km <- 6371
  scale <- c(km = 1, mi = 0.621371, nmi = 0.539957)[[unit]]

  cx <- island_coords(x, which = which)

  if (is.null(y)) {
    lat <- cx$latitude
    lon <- cx$longitude
    n <- length(lat)
    m <- matrix(NA_real_, n, n,
                dimnames = list(cx$iso_code, cx$iso_code))
    for (i in seq_len(n)) {
      m[i, ] <- .haversine(lat[i], lon[i], lat, lon, radius_km) * scale
    }
    return(m)
  }

  cy <- island_coords(y, which = which)
  n  <- max(nrow(cx), nrow(cy))
  ix <- rep_len(seq_len(nrow(cx)), n)
  iy <- rep_len(seq_len(nrow(cy)), n)
  out <- .haversine(cx$latitude[ix], cx$longitude[ix],
                    cy$latitude[iy], cy$longitude[iy], radius_km) * scale
  names(out) <- if (nrow(cy) >= nrow(cx)) cy$iso_code[iy] else cx$iso_code[ix]
  out
}

# Vectorised haversine. Radius `r` sets the output unit (km here); inputs are
# decimal degrees.
.haversine <- function(lat1, lon1, lat2, lon2, r) {
  p <- pi / 180
  a <- sin((lat2 - lat1) * p / 2)^2 +
    cos(lat1 * p) * cos(lat2 * p) * sin((lon2 - lon1) * p / 2)^2
  2 * r * asin(pmin(1, sqrt(a)))
}
