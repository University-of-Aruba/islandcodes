# Classify countries and territories

Predicate helpers that return a logical vector aligned with the input.

## Usage

``` r
is_sids(x)

is_snij(x)

is_small_island(x)
```

## Arguments

- x:

  A character vector of ISO codes or country names.

## Value

A logical vector the same length as `x`.

## Details

Inputs are resolved in three passes: direct match against the `iso_code`
column of
[`islands`](https://university-of-aruba.github.io/islandcodes/reference/islands.md),
then a case-insensitive match against `name`, then a fallback through
[`countrycode`](https://vincentarelbundock.github.io/countrycode/man/countrycode.html)
from `"country.name"` to `"iso2c"`. Unresolved entries return `NA`.

Hyphenated codes (`"BQ-BO"` for Bonaire, `"BQ-SE"` for Sint Eustatius,
`"BQ-SA"` for Saba) are accepted directly. Bare `"BQ"` is ambiguous
within the bundled dataset; pass the specific island code or the country
name instead.

## Examples

``` r
is_sids(c("Aruba", "Curacao", "Bonaire", "Brazil"))
#> [1]  TRUE  TRUE FALSE FALSE
is_snij(c("Aruba", "Curacao", "Bonaire", "Brazil"))
#> [1]  TRUE  TRUE  TRUE FALSE
is_small_island(c("AW", "CW", "BQ-BO", "BR", "AX"))
#> [1]  TRUE  TRUE  TRUE FALSE  TRUE
```
