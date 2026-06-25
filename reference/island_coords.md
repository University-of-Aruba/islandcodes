# Get coordinates for islands and territories

Returns the latitude and longitude of a vector of country names or ISO
codes, one row per input and in input order (with `NA` rows for
unresolved inputs). Two location semantics are available: a
representative point on the territory's main landmass (the default), or
the capital city.

## Usage

``` r
island_coords(x, which = c("point", "capital"))
```

## Arguments

- x:

  A character vector of ISO codes or country names.

- which:

  Which location to return: `"point"` (default), a representative point
  on the main landmass, or `"capital"`, the capital city.

## Value

A data frame with one row per element of `x`. For `which = "point"` the
columns are `label` (the readable place name), `iso_code`, `latitude`,
and `longitude`. For `which = "capital"` a `capital` city-name column is
inserted before the coordinates.

## Details

Inputs are resolved the same way as the predicate helpers (see
[`is_sids`](https://university-of-aruba.github.io/islandcodes/reference/classify.md)):
by `iso_code`, then `label`, then the XLSForm `name` slug, then a
fallback through
[`countrycode`](https://vincentarelbundock.github.io/countrycode/man/countrycode.html).

Coordinates are WGS84 decimal degrees. A handful of territories carry no
coordinate and return `NA`: the representative point is missing only for
United States Minor Outlying Islands (a scattered, centroid-less
collection), while capitals are missing for uninhabited or capital-less
territories (Antarctica, Bouvet Island, the British Indian Ocean
Territory, Heard Island, South Georgia, Tokelau, US Minor Outlying
Islands, and Western Sahara).

## See also

[`island_lookup`](https://university-of-aruba.github.io/islandcodes/reference/island_lookup.md)
for arbitrary columns,
[`add_island_cols`](https://university-of-aruba.github.io/islandcodes/reference/add_island_cols.md)
to attach coordinates to a data frame.

## Examples

``` r
island_coords(c("Aruba", "Curacao", "Bonaire"))
#>     label iso_code latitude longitude
#> 1   Aruba       AW  12.5174  -69.9728
#> 2 Curaçao       CW  12.1450  -68.9206
#> 3 Bonaire    BQ-BO  12.1830  -68.2500

# Capital cities instead of landmass points
island_coords(c("AW", "PF", "GL"), which = "capital")
#>              label iso_code    capital latitude longitude
#> 1            Aruba       AW Oranjestad  12.5215  -70.0255
#> 2 French Polynesia       PF    Papeete -17.5334 -149.5667
#> 3        Greenland       GL       Nuuk  64.1983  -51.7327

# The two can differ substantially for dispersed territories
island_coords("French Polynesia")
#>              label iso_code latitude longitude
#> 1 French Polynesia       PF -17.6281 -149.4616
island_coords("French Polynesia", which = "capital")
#>              label iso_code capital latitude longitude
#> 1 French Polynesia       PF Papeete -17.5334 -149.5667
```
