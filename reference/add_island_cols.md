# Add island classification columns to a data frame

Left-joins selected columns from
[`islands`](https://university-of-aruba.github.io/islandcodes/reference/islands.md)
onto an existing data frame, matching on a column of country names or
ISO codes. Designed for tidy pipelines but written in base R, so it
works with plain data frames, tibbles, and (read-only) data.tables.

## Usage

``` r
add_island_cols(
  .data,
  code_col,
  cols = c("iso_code", "is_sids", "is_snij", "sids_tier", "political_association",
    "wb_region", "wb_income_group")
)
```

## Arguments

- .data:

  A data frame.

- code_col:

  String. Name of the column in `.data` that holds country names or ISO
  codes.

- cols:

  Character vector of columns from `islands` to attach. Defaults to the
  most common classification fields.

## Value

`.data` with the requested columns appended. Rows whose `code_col` value
cannot be resolved get `NA` in the new columns.

## Examples

``` r
df <- data.frame(
  country = c("Aruba", "Curacao", "Bonaire", "Brazil"),
  gdp = c(3.5, 3.1, 0.5, 1900)
)
add_island_cols(df, "country")
#>   country    gdp iso_code is_sids is_snij        sids_tier
#> 1   Aruba    3.5       AW       1       1 Associate member
#> 2 Curacao    3.1       CW       1       1 Associate member
#> 3 Bonaire    0.5    BQ-BO       0       1             <NA>
#> 4  Brazil 1900.0       BR       0       0             <NA>
#>   political_association                 wb_region     wb_income_group
#> 1         Dutch Kingdom Latin America & Caribbean         High income
#> 2         Dutch Kingdom Latin America & Caribbean         High income
#> 3         Dutch Kingdom Latin America & Caribbean         High income
#> 4           Independent Latin America & Caribbean Upper-middle income
```
