# Iteration: 1
# Build script for the bundled `islands` dataset.
# Pulls the canonical CSV from the UA reference-data repo, normalises
# column types, and writes data/islands.rda. Re-run whenever the upstream
# CSV changes.
#
# Usage (from the package root):
#   source("data-raw/DATASET.R")

library(utils)

source_url <- paste0(
  "https://raw.githubusercontent.com/University-of-Aruba/",
  "island-research-reference-data/main/countries/",
  "countries_reference_xlsform.csv"
)

# na.strings = "" (empty only): the upstream CSV uses empty cells for missing
# values, never the literal "NA". Critically, Namibia's ISO 3166-1 alpha-2 code
# IS the string "NA"; treating "NA" as missing here would silently drop Namibia.
raw <- utils::read.csv(
  source_url,
  stringsAsFactors = FALSE,
  encoding = "UTF-8",
  na.strings = ""
)

# Drop the XLSForm scaffolding column; researchers don't need it.
raw$list_name <- NULL

# Logical flags: keep as integer 0/1 in the bundled object so it round-trips
# cleanly with users running base R or with strict-type frameworks. Helpers
# in R/classify.R coerce to logical at the API surface.
flag_cols <- c(
  "is_sids", "is_snij",
  "criterion_small", "criterion_island",
  "criterion_developing", "criterion_sovereign"
)
for (col in flag_cols) {
  raw[[col]] <- suppressWarnings(as.integer(raw[[col]]))
}

# Coordinate columns: keep as numeric (decimal degrees, WGS84).
coord_cols <- c("latitude", "longitude", "capital_latitude", "capital_longitude")
for (col in coord_cols) {
  raw[[col]] <- suppressWarnings(as.numeric(raw[[col]]))
}

# Order columns: identity first, classifications next, criteria, then coordinates.
col_order <- c(
  "name", "label", "iso_code",
  "wb_region", "wb_income_group", "political_association",
  "is_sids", "sids_tier", "is_snij",
  "criterion_small", "criterion_island",
  "criterion_developing", "criterion_sovereign",
  "latitude", "longitude",
  "capital", "capital_latitude", "capital_longitude"
)
islands <- raw[, col_order, drop = FALSE]

# Drop rows with no usable identifier (defensive).
islands <- islands[!is.na(islands$iso_code) & nzchar(islands$iso_code), ]
rownames(islands) <- NULL

# Write to data/ for lazy loading. Using base save() rather than usethis
# so the build script has no extra dependencies.
if (!dir.exists("data")) dir.create("data")
save(islands, file = "data/islands.rda", compress = "xz")

message(sprintf(
  "Built islands.rda: %d rows, %d cols. SIDS=%d, SNIJ=%d. Coords: %d point, %d capital.",
  nrow(islands), ncol(islands),
  sum(islands$is_sids == 1, na.rm = TRUE),
  sum(islands$is_snij == 1, na.rm = TRUE),
  sum(!is.na(islands$latitude)),
  sum(!is.na(islands$capital_latitude))
))
