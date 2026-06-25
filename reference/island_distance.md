# Great-circle distance between islands

Haversine (great-circle) distance between the coordinates of islands and
territories, resolved from country names or ISO codes via the same
matching as the rest of the package (see
[`is_sids`](https://university-of-aruba.github.io/islandcodes/reference/classify.md)).
A natural primitive for connectivity and isolation work on small
islands.

## Usage

``` r
island_distance(
  x,
  y = NULL,
  which = c("point", "capital"),
  unit = c("km", "mi", "nmi")
)
```

## Arguments

- x:

  A character vector of ISO codes or country names.

- y:

  Optional second character vector. If `NULL` (the default) a full
  symmetric distance matrix among the elements of `x` is returned. If
  supplied, distances are computed element-wise between `x` and `y`,
  recycling the shorter of the two, so a single origin against many
  destinations gives the distance from that origin to each.

- which:

  Coordinate to use: `"point"` (representative landmass point, the
  default) or `"capital"` (capital city).

- unit:

  Output unit: `"km"` (kilometres, the default), `"mi"` (statute miles),
  or `"nmi"` (nautical miles).

## Value

When `y` is `NULL`, a numeric matrix (`length(x)` by `length(x)`) with
`iso_code` dimnames. Otherwise a named numeric vector. Unresolved inputs
and territories without the requested coordinate propagate as `NA`.

## See also

[`island_coords`](https://university-of-aruba.github.io/islandcodes/reference/island_coords.md)

## Examples

``` r
# Spread of the Dutch Caribbean (ABC + SSS), in km
round(island_distance(c("AW", "CW", "BQ-BO", "SX", "BQ-SA", "BQ-SE")))
#>        AW  CW BQ-BO  SX BQ-SA BQ-SE
#> AW      0 122   191 962   920   933
#> CW    122   0    73 908   863   873
#> BQ-BO 191  73     0 856   811   818
#> SX    962 908   856   0    49    62
#> BQ-SA 920 863   811  49     0    32
#> BQ-SE 933 873   818  62    32     0

# One origin to many
island_distance("Aruba", c("Curacao", "Bonaire", "Sint Maarten"))
#>       CW    BQ-BO       SX 
#> 121.5695 190.7913 961.7026 

# Capital-to-capital, in nautical miles
island_distance("AW", "CW", which = "capital", unit = "nmi")
#>       CW 
#> 71.96274 
```
