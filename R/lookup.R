#' Look up rows in the islands reference list
#'
#' Returns the matching rows of \code{\link{islands}} for a vector of
#' country names or ISO codes. Useful when you want more than a single
#' classification and want to keep the original input order, including
#' \code{NA} rows for unresolved inputs.
#'
#' @param x A character vector of ISO codes or country names.
#' @param fields Optional character vector of column names to return. If
#'   \code{NULL} (default) all columns of \code{islands} are returned.
#'
#' @return A data frame with one row per element of \code{x}. Rows that
#'   could not be resolved are filled with \code{NA}.
#'
#' @examples
#' island_lookup(c("Aruba", "Bonaire", "Brazil"))
#' island_lookup(c("AW", "BQ-BO"), fields = c("name", "is_sids", "is_snij"))
#'
#' @export
island_lookup <- function(x, fields = NULL) {
  idx <- .resolve(x)
  if (is.null(fields)) {
    out <- islands[idx, , drop = FALSE]
  } else {
    miss <- setdiff(fields, names(islands))
    if (length(miss)) {
      stop("Unknown field(s): ", paste(miss, collapse = ", "),
           ".\nAvailable: ", paste(names(islands), collapse = ", "),
           call. = FALSE)
    }
    out <- islands[idx, fields, drop = FALSE]
  }
  rownames(out) <- NULL
  out
}

#' Add island classification columns to a data frame
#'
#' Left-joins selected columns from \code{\link{islands}} onto an
#' existing data frame, matching on a column of country names or ISO
#' codes. Designed for tidy pipelines but written in base R, so it works
#' with plain data frames, tibbles, and (read-only) data.tables.
#'
#' @param .data A data frame.
#' @param code_col String. Name of the column in \code{.data} that holds
#'   country names or ISO codes.
#' @param cols Character vector of columns from \code{islands} to attach.
#'   Defaults to the most common classification fields.
#'
#' @return \code{.data} with the requested columns appended. Rows whose
#'   \code{code_col} value cannot be resolved get \code{NA} in the new
#'   columns.
#'
#' @examples
#' df <- data.frame(
#'   country = c("Aruba", "Curacao", "Bonaire", "Brazil"),
#'   gdp = c(3.5, 3.1, 0.5, 1900)
#' )
#' add_island_cols(df, "country")
#'
#' @export
add_island_cols <- function(.data,
                            code_col,
                            cols = c("iso_code", "is_sids", "is_snij",
                                     "sids_tier", "political_association",
                                     "wb_region", "wb_income_group")) {
  if (!is.data.frame(.data)) {
    stop("`.data` must be a data frame.", call. = FALSE)
  }
  if (!code_col %in% names(.data)) {
    stop("Column ", sQuote(code_col), " not found in `.data`.", call. = FALSE)
  }
  miss <- setdiff(cols, names(islands))
  if (length(miss)) {
    stop("Unknown column(s) in `cols`: ", paste(miss, collapse = ", "),
         ".\nAvailable: ", paste(names(islands), collapse = ", "),
         call. = FALSE)
  }

  idx <- .resolve(.data[[code_col]])
  add <- islands[idx, cols, drop = FALSE]
  rownames(add) <- NULL

  # Suffix any existing collisions with .island
  collide <- intersect(names(add), names(.data))
  if (length(collide)) {
    names(add)[match(collide, names(add))] <-
      paste0(collide, ".island")
  }

  cbind(.data, add)
}

#' Return a filtered subset of small-island states and territories
#'
#' Convenience wrapper around \code{\link{islands}} that returns the
#' subset matching commonly used small-island filters.
#'
#' @param sids_only Logical. If \code{TRUE}, return only UN-DESA SIDS.
#' @param snij_only Logical. If \code{TRUE}, return only sub-national
#'   island jurisdictions.
#' @param criteria Optional named logical vector with elements drawn
#'   from \code{c("small", "island", "developing", "sovereign")}. Each
#'   element constrains the corresponding \code{criterion_*} column.
#'
#' @return A data frame, the relevant subset of \code{islands}.
#'
#' @examples
#' nrow(small_islands(sids_only = TRUE))
#' nrow(small_islands(snij_only = TRUE))
#' small_islands(criteria = c(small = TRUE, island = TRUE))
#'
#' @export
small_islands <- function(sids_only = FALSE,
                          snij_only = FALSE,
                          criteria = NULL) {
  keep <- rep(TRUE, nrow(islands))
  if (isTRUE(sids_only)) keep <- keep & islands$is_sids == 1L
  if (isTRUE(snij_only)) keep <- keep & islands$is_snij == 1L

  if (!is.null(criteria)) {
    valid <- c("small", "island", "developing", "sovereign")
    bad <- setdiff(names(criteria), valid)
    if (length(bad)) {
      stop("Unknown `criteria` name(s): ", paste(bad, collapse = ", "),
           ".\nUse: ", paste(valid, collapse = ", "), call. = FALSE)
    }
    for (nm in names(criteria)) {
      col <- paste0("criterion_", nm)
      target <- if (isTRUE(criteria[[nm]])) 1L else 0L
      keep <- keep & islands[[col]] == target
    }
  }

  out <- islands[keep & !is.na(keep), , drop = FALSE]
  rownames(out) <- NULL
  out
}
