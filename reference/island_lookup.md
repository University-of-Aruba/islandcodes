# Look up rows in the islands reference list

Returns the matching rows of
[`islands`](https://university-of-aruba.github.io/islandcodes/reference/islands.md)
for a vector of country names or ISO codes. Useful when you want more
than a single classification and want to keep the original input order,
including `NA` rows for unresolved inputs.

## Usage

``` r
island_lookup(x, fields = NULL)
```

## Arguments

- x:

  A character vector of ISO codes or country names.

- fields:

  Optional character vector of column names to return. If `NULL`
  (default) all columns of `islands` are returned.

## Value

A data frame with one row per element of `x`. Rows that could not be
resolved are filled with `NA`.

## Examples

``` r
island_lookup(c("Aruba", "Bonaire", "Brazil"))
#>    name   label iso_code                 wb_region     wb_income_group
#> 1    AW   Aruba       AW Latin America & Caribbean         High income
#> 2 BQ_BO Bonaire    BQ-BO Latin America & Caribbean         High income
#> 3    BR  Brazil       BR Latin America & Caribbean Upper-middle income
#>   political_association is_sids        sids_tier is_snij criterion_small
#> 1         Dutch Kingdom       1 Associate member       1               1
#> 2         Dutch Kingdom       0             <NA>       1               1
#> 3           Independent       0             <NA>       0               0
#>   criterion_island criterion_developing criterion_sovereign
#> 1                1                    0                   0
#> 2                1                    0                   0
#> 3                0                    1                   1
island_lookup(c("AW", "BQ-BO"), fields = c("name", "is_sids", "is_snij"))
#>    name is_sids is_snij
#> 1    AW       1       1
#> 2 BQ_BO       0       1
```
