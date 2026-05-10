# islandcodes

`islandcodes` is a small R package that ships a curated reference list
of countries and territories with classifications for **Small Island
Developing States (SIDS)**, **sub-national island jurisdictions
(SNIJ)**, World Bank region and income group, and political association.
It is designed to extend `countrycode` for researchers working on small
islands, sub-sovereign territories, and the Caribbean.

The bundled dataset includes Aruba, Curaçao, Bonaire, Sint Eustatius,
Saba, Sint Maarten, the French overseas collectivities, Åland Islands,
and other sub-sovereign cases that ISO 3166-1 country-code lists
typically collapse or omit.

## Installation

From CRAN once available:

``` r

install.packages("islandcodes")
```

Development version from GitHub:

``` r

# install.packages("remotes")
remotes::install_github("University-of-Aruba/islandcodes")
```

## Quick start

``` r

library(islandcodes)

is_sids(c("Aruba", "Curacao", "Bonaire", "Brazil"))
#> [1]  TRUE FALSE FALSE FALSE

is_snij(c("Aruba", "Curacao", "Bonaire", "Brazil"))
#> [1] TRUE TRUE TRUE FALSE

# Add classification columns to your own data frame
df <- data.frame(
  country = c("Aruba", "Curacao", "Bonaire", "Brazil"),
  gdp     = c(3.5, 3.1, 0.5, 1900)
)
add_island_cols(df, "country")

# Filtered subsets
small_islands(sids_only = TRUE)
small_islands(criteria = c(small = TRUE, island = TRUE, sovereign = FALSE))
```

## Why a separate package

`countrycode` is excellent for the standard ISO 3166-1 country-code
conversion problem. It is less reliable for small-island and
sub-sovereign work for two reasons:

1.  **Sub-sovereign territories.** Aruba (`AW`), Curaçao (`CW`), and
    Sint Maarten (`SX`) have their own ISO codes, but Bonaire, Sint
    Eustatius, and Saba share `BQ` in ISO 3166-1. `islandcodes` ships
    the disambiguating codes `BQ-BO`, `BQ-SE`, `BQ-SA` and joins them on
    consistently.
2.  **SIDS / SNIJ classification.** UN-DESA’s SIDS list (sovereign and
    associate members) and the academic SNIJ classification are not in
    `countrycode`. Joining either onto a research dataset usually means
    hand-copying lists from PDFs.

`islandcodes` does one thing: it bundles the classification list,
exposes a few predicates and a tidy joiner, and stays out of the way
otherwise. It imports `countrycode` so country names are coerced to ISO
codes before lookup.

## Data source

The bundled `islands` dataset is mirrored from the [University of Aruba
island-research-reference-data](https://github.com/University-of-Aruba/island-research-reference-data)
repository, maintained by the [DCDC Network](https://dcdc.network)
(Digital Competence Dutch Caribbean), licensed CC BY 4.0. The build
script at `data-raw/DATASET.R` pulls the canonical CSV; rebuild after
any upstream change.

## Citation

Please cite both the package and the underlying reference dataset in
academic work. Run `citation("islandcodes")` for the canonical
references.

## License

CC BY 4.0. See
[LICENSE.md](https://university-of-aruba.github.io/islandcodes/LICENSE.md).
