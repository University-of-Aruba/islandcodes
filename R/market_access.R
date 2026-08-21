#' Distance-decayed market access
#'
#' Market access of each origin as the sum of destination mass discounted by
#' distance, \eqn{MA_i = \sum_{j \neq i} m_j d_{ij}^{-\theta}}. This is the
#' standard reduced-form measure used in economic geography and in the
#' remote-sensing literature on rural connectivity, where access rather than
#' raw distance is the quantity that predicts economic outcomes.
#'
#' The package supplies the geometry, not the mass. Population, GDP, tourist
#' arrivals, and trade volumes are all time-varying and contested, so
#' \code{mass} is always user-supplied and the reference year is the caller's
#' to document. \code{theta} is likewise a modelling choice: values near 1 are
#' conventional for trade gravity, higher values concentrate weight on near
#' neighbours.
#'
#' Own mass is excluded by default, because the internal distance of a
#' territory to itself is undefined at this resolution. Supply \code{self} to
#' include it under an explicit internal-distance assumption.
#'
#' Distances are great-circle, computed by \code{\link{island_distance}}. See
#' the "Profiling the world's small island developing states" vignette for what
#' that does and does not represent for archipelagos.
#'
#' @param x A character vector of ISO codes or country names: the origins.
#' @param mass Numeric vector of destination mass. If named, names are resolved
#'   the same way as \code{x} and matched to the destinations, so the vector
#'   may be in any order and may cover more territories than are used. If
#'   unnamed, it must be the same length as the destinations and in the same
#'   order.
#' @param to Optional character vector of destinations. Defaults to \code{NULL},
#'   meaning the destinations are \code{x} itself (access within the set).
#' @param theta Positive distance-decay elasticity. Default \code{1}.
#' @param which Coordinate to use: \code{"point"} (representative landmass
#'   point, the default) or \code{"capital"}.
#' @param unit Distance unit the decay operates on: \code{"km"} (default),
#'   \code{"mi"}, or \code{"nmi"}. Changing it rescales the result by a
#'   constant factor, so it matters for levels but not for rankings.
#' @param self Optional internal distance, in \code{unit}, used to include each
#'   origin's own mass as \code{m_i * self^-theta}. A single number, or one per
#'   element of \code{x}. \code{NULL} (default) excludes own mass.
#'
#' @return A named numeric vector of market access, one element per element of
#'   \code{x}, named by \code{iso_code}. Origins that cannot be resolved, or
#'   that carry no coordinate, return \code{NA}. Destinations with missing mass
#'   or missing coordinates are dropped from the sum rather than propagating.
#'
#' @examples
#' # Illustrative population masses (thousands) for the Dutch Caribbean six.
#' # Supply your own sourced figures in real work.
#' pop <- c(AW = 108, CW = 156, SX = 43, "BQ-BO" = 25, "BQ-SE" = 3, "BQ-SA" = 2)
#' round(island_market_access(names(pop), pop), 3)
#'
#' # Stronger decay concentrates weight on the nearest neighbours, separating
#' # the ABC and SSS groups sharply.
#' round(island_market_access(names(pop), pop, theta = 2), 6)
#'
#' # Access to the wider region rather than to each other. Illustrative
#' # population in thousands.
#' region <- c(US = 335000, CO = 52000, VE = 28000, DO = 11000)
#' round(island_market_access(c("AW", "CW", "SX"), region, to = names(region)), 2)
#'
#' @seealso \code{\link{island_distance}}, \code{\link{island_coords}}
#' @export
island_market_access <- function(x, mass, to = NULL, theta = 1,
                                 which = c("point", "capital"),
                                 unit = c("km", "mi", "nmi"),
                                 self = NULL) {
  which <- match.arg(which)
  unit  <- match.arg(unit)

  if (!is.numeric(theta) || length(theta) != 1L ||
      is.na(theta) || theta <= 0) {
    stop("`theta` must be a single positive number.", call. = FALSE)
  }

  dest <- if (is.null(to)) x else to
  m    <- .align_mass(mass, dest)

  cx <- island_coords(x, which = which)
  cd <- island_coords(dest, which = which)

  radius_km <- 6371
  scale <- c(km = 1, mi = 0.621371, nmi = 0.539957)[[unit]]

  n <- nrow(cx)
  k <- nrow(cd)
  w <- matrix(NA_real_, n, k)
  for (i in seq_len(n)) {
    d <- .haversine(cx$latitude[i], cx$longitude[i],
                    cd$latitude, cd$longitude, radius_km) * scale
    w[i, ] <- d^(-theta)
  }

  # Zero distance gives an infinite weight: drop self-pairs and any exact
  # coordinate ties rather than letting them dominate the sum.
  w[!is.finite(w)] <- NA_real_
  same <- outer(cx$iso_code, cd$iso_code, function(a, b) !is.na(a) & a == b)
  w[same] <- NA_real_

  contrib <- w * rep(m, each = n)
  ok <- !is.na(contrib)
  out <- rowSums(contrib, na.rm = TRUE)
  out[rowSums(ok) == 0L] <- NA_real_

  if (!is.null(self)) {
    if (!is.numeric(self)) {
      stop("`self` must be numeric (an internal distance in ", unit, ").",
           call. = FALSE)
    }
    s <- rep_len(as.numeric(self), n)
    if (any(!is.na(s) & s <= 0)) {
      stop("`self` must be positive.", call. = FALSE)
    }
    own <- m[match(cx$iso_code, cd$iso_code)]
    add <- own * s^(-theta)
    add[is.na(add)] <- 0
    out <- out + add
  }

  names(out) <- cx$iso_code
  out
}

# Resolve a user-supplied mass vector onto a destination vector. Named mass is
# matched by resolved iso_code (order-free, may be a superset); unnamed mass
# must already be aligned.
.align_mass <- function(mass, dest) {
  if (!is.numeric(mass)) {
    stop("`mass` must be a numeric vector.", call. = FALSE)
  }
  if (is.null(names(mass))) {
    if (length(mass) != length(dest)) {
      stop("Unnamed `mass` must have one element per destination (",
           length(dest), " expected, ", length(mass), " supplied).",
           call. = FALSE)
    }
    return(as.numeric(mass))
  }
  dest_iso <- islands$iso_code[.resolve(dest)]
  mass_iso <- islands$iso_code[.resolve(names(mass))]
  if (anyDuplicated(mass_iso[!is.na(mass_iso)])) {
    stop("`mass` names resolve to duplicate territories.", call. = FALSE)
  }
  as.numeric(mass)[match(dest_iso, mass_iso)]
}
