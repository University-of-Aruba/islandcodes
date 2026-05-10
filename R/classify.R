#' Classify countries and territories
#'
#' Predicate helpers that return a logical vector aligned with the input.
#'
#' Inputs are resolved in three passes: direct match against the
#' \code{iso_code} column of \code{\link{islands}}, then a case-insensitive
#' match against \code{name}, then a fallback through
#' \code{\link[countrycode]{countrycode}} from \code{"country.name"} to
#' \code{"iso2c"}. Unresolved entries return \code{NA}.
#'
#' Hyphenated codes (\code{"BQ-BO"} for Bonaire, \code{"BQ-SE"} for
#' Sint Eustatius, \code{"BQ-SA"} for Saba) are accepted directly. Bare
#' \code{"BQ"} is ambiguous within the bundled dataset; pass the
#' specific island code or the country name instead.
#'
#' @param x A character vector of ISO codes or country names.
#'
#' @return A logical vector the same length as \code{x}.
#'
#' @examples
#' is_sids(c("Aruba", "Curacao", "Bonaire", "Brazil"))
#' is_snij(c("Aruba", "Curacao", "Bonaire", "Brazil"))
#' is_small_island(c("AW", "CW", "BQ-BO", "BR", "AX"))
#'
#' @name classify
NULL

#' @rdname classify
#' @export
is_sids <- function(x) {
  idx <- .resolve(x)
  out <- islands$is_sids[idx] == 1L
  out[is.na(idx)] <- NA
  out
}

#' @rdname classify
#' @export
is_snij <- function(x) {
  idx <- .resolve(x)
  out <- islands$is_snij[idx] == 1L
  out[is.na(idx)] <- NA
  out
}

#' @rdname classify
#' @export
is_small_island <- function(x) {
  idx <- .resolve(x)
  out <- islands$criterion_small[idx] == 1L &
    islands$criterion_island[idx] == 1L
  out[is.na(idx)] <- NA
  out
}

# Resolve a character vector of names or ISO codes to row indices in
# `islands`. NA where no match is found.
.resolve <- function(x) {
  if (!is.character(x)) x <- as.character(x)
  out <- rep(NA_integer_, length(x))

  hit <- match(toupper(x), islands$iso_code)
  out[!is.na(hit)] <- hit[!is.na(hit)]

  # Match against human-readable label column (e.g. "Bonaire", "Curacao").
  todo <- which(is.na(out))
  if (length(todo)) {
    hit <- match(tolower(x[todo]), tolower(islands$label))
    out[todo[!is.na(hit)]] <- hit[!is.na(hit)]
  }

  # Match against the XLSForm slug `name` column as a last direct check.
  todo <- which(is.na(out))
  if (length(todo)) {
    hit <- match(toupper(x[todo]), islands$name)
    out[todo[!is.na(hit)]] <- hit[!is.na(hit)]
  }

  # Fall back to countrycode for the long tail of country names.
  todo <- which(is.na(out))
  if (length(todo)) {
    iso2 <- suppressWarnings(countrycode::countrycode(
      x[todo],
      origin = "country.name",
      destination = "iso2c",
      warn = FALSE
    ))
    hit <- match(iso2, islands$iso_code)
    out[todo[!is.na(hit)]] <- hit[!is.na(hit)]
  }

  out
}
