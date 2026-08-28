# Distance-decayed market access

Market access of each origin as the sum of destination mass discounted
by distance, \\MA_i = \sum\_{j \neq i} m_j d\_{ij}^{-\theta}\\. This is
the standard reduced-form measure used in economic geography and in the
remote-sensing literature on rural connectivity, where access rather
than raw distance is the quantity that predicts economic outcomes.

## Usage

``` r
island_market_access(
  x,
  mass,
  to = NULL,
  theta = 1,
  which = c("point", "capital"),
  unit = c("km", "mi", "nmi"),
  self = NULL
)
```

## Arguments

- x:

  A character vector of ISO codes or country names: the origins.

- mass:

  Numeric vector of destination mass. If named, names are resolved the
  same way as `x` and matched to the destinations, so the vector may be
  in any order and may cover more territories than are used. If unnamed,
  it must be the same length as the destinations and in the same order.

- to:

  Optional character vector of destinations. Defaults to `NULL`, meaning
  the destinations are `x` itself (access within the set).

- theta:

  Positive distance-decay elasticity. Default `1`.

- which:

  Coordinate to use: `"point"` (representative landmass point, the
  default) or `"capital"`.

- unit:

  Distance unit the decay operates on: `"km"` (default), `"mi"`, or
  `"nmi"`. Changing it rescales the result by a constant factor, so it
  matters for levels but not for rankings.

- self:

  Optional internal distance, in `unit`, used to include each origin's
  own mass as `m_i * self^-theta`. A single number, or one per element
  of `x`. `NULL` (default) excludes own mass.

## Value

A named numeric vector of market access, one element per element of `x`,
named by `iso_code`. Origins that cannot be resolved, or that carry no
coordinate, return `NA`. Destinations with missing mass or missing
coordinates are dropped from the sum rather than propagating.

## Details

The package supplies the geometry, not the mass. Population, GDP,
tourist arrivals, and trade volumes are all time-varying and contested,
so `mass` is always user-supplied and the reference year is the caller's
to document. `theta` is likewise a modelling choice: values near 1 are
conventional for trade gravity, higher values concentrate weight on near
neighbours.

Own mass is excluded by default, because the internal distance of a
territory to itself is undefined at this resolution. Supply `self` to
include it under an explicit internal-distance assumption.

Distances are great-circle, computed by
[`island_distance`](https://university-of-aruba.github.io/islandcodes/reference/island_distance.md).
See the "Profiling the world's small island developing states" vignette
for what that does and does not represent for archipelagos.

## See also

[`island_distance`](https://university-of-aruba.github.io/islandcodes/reference/island_distance.md),
[`island_coords`](https://university-of-aruba.github.io/islandcodes/reference/island_coords.md)

## Examples

``` r
# Illustrative population masses (thousands) for the Dutch Caribbean six.
# Supply your own sourced figures in real work.
pop <- c(AW = 108, CW = 156, SX = 43, "BQ-BO" = 25, "BQ-SE" = 3, "BQ-SA" = 2)
round(island_market_access(names(pop), pop), 3)
#>    AW    CW    SX BQ-BO BQ-SE BQ-SA 
#> 1.464 1.284 0.403 2.759 1.081 1.304 

# Stronger decay concentrates weight on the nearest neighbours, separating
# the ABC and SSS groups sharply.
round(island_market_access(names(pop), pop, theta = 2), 6)
#>       AW       CW       SX    BQ-BO    BQ-SE    BQ-SA 
#> 0.011295 0.012056 0.001956 0.032294 0.013507 0.021399 

# Access to the wider region rather than to each other. Illustrative
# population in thousands.
region <- c(US = 335000, CO = 52000, VE = 28000, DO = 11000)
round(island_market_access(c("AW", "CW", "SX"), region, to = names(region)), 2)
#>     AW     CW     SX 
#> 179.73 181.30 145.18 
```
