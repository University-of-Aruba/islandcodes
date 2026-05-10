#' islandcodes: Reference data and helpers for small island states and territories
#'
#' Provides a curated reference list of countries and territories with
#' classifications for Small Island Developing States (SIDS), sub-national
#' island jurisdictions (SNIJ), World Bank region and income group, and
#' political association. Sub-sovereign cases such as Aruba, Curacao,
#' Bonaire, Sint Maarten, the French overseas territories, and Aaland
#' Islands are represented with disambiguating codes that standard
#' country-code packages often collapse or omit.
#'
#' The package is deliberately small. It exposes:
#' \itemize{
#'   \item the bundled \code{\link{islands}} dataset,
#'   \item predicates \code{\link{is_sids}}, \code{\link{is_snij}},
#'         \code{\link{is_small_island}},
#'   \item the joiner \code{\link{add_island_cols}}, and
#'   \item the filter shorthand \code{\link{small_islands}}.
#' }
#'
#' It imports \pkg{countrycode} so country names entered by the user are
#' coerced to ISO codes before lookup. The intent is to extend rather than
#' replace \pkg{countrycode}: pass country names in, get small-island
#' classifications out.
#'
#' @section Source data:
#' The bundled dataset is mirrored from
#' \url{https://github.com/University-of-Aruba/island-research-reference-data}
#' under CC BY 4.0. Run \code{citation("islandcodes")} for the canonical
#' references.
#'
#' @section Acknowledgments:
#' With thanks to Edward Cheung, the Aruban-American engineer at NASA
#' Goddard whose tradition of finding ways to put "Aruba" onto Hubble
#' Space Telescope hardware (most famously the Aruba trolley used during
#' servicing missions) is the inspiration for the \code{\link{aruba}}
#' function in this package. A small island has produced an outsized
#' number of people who quietly insist their island be named.
#'
#' @keywords internal
#' @importFrom countrycode countrycode
"_PACKAGE"
