# A.R.U.B.A.: Annotated Reference for Under-coded Border Areas

A convenience wrapper around
[`island_lookup`](https://university-of-aruba.github.io/islandcodes/reference/island_lookup.md)
with Aruba as the default. Calling `aruba()` returns Aruba's
classification row; passing another country or ISO code returns that one
instead.

## Usage

``` r
aruba(x = "Aruba", quiet = getOption("islandcodes.aruba.quiet", FALSE))
```

## Arguments

- x:

  A character vector of country names or ISO codes. Defaults to
  `"Aruba"`.

- quiet:

  Logical. If `FALSE` (the default in interactive sessions, when called
  with no arguments) a short homage message is printed once. Set to
  `TRUE`, or set `options(islandcodes.aruba.quiet = TRUE)` globally, to
  silence.

## Value

A data frame with one row per element of `x` (the same shape as
[`island_lookup`](https://university-of-aruba.github.io/islandcodes/reference/island_lookup.md)).

## Details

Named in homage to Edward Cheung, the Aruban engineer at NASA Goddard
who designed A.R.U.B.A. (the ASCS/NCS Relay Unit Breaker Assembly)
installed on the Hubble Space Telescope during the 2002 servicing
mission. Cheung engineered the backronym specifically so children in his
home country would have something concrete to point to on the telescope.
We borrowed the trick. His ARUBA cuts power to Hubble's instruments when
there is a fault; ours returns a row of classification data. Both spell
Aruba.

## Examples

``` r
aruba()
#>   name label iso_code                 wb_region wb_income_group
#> 1   AW Aruba       AW Latin America & Caribbean     High income
#>   political_association is_sids        sids_tier is_snij criterion_small
#> 1         Dutch Kingdom       1 Associate member       1               1
#>   criterion_island criterion_developing criterion_sovereign
#> 1                1                    0                   0
aruba("Curacao")
#>   name   label iso_code                 wb_region wb_income_group
#> 1   CW Curaçao       CW Latin America & Caribbean     High income
#>   political_association is_sids        sids_tier is_snij criterion_small
#> 1         Dutch Kingdom       1 Associate member       1               1
#>   criterion_island criterion_developing criterion_sovereign
#> 1                1                    0                   0
aruba(c("AW", "BQ-BO", "CW"))
#>    name   label iso_code                 wb_region wb_income_group
#> 1    AW   Aruba       AW Latin America & Caribbean     High income
#> 2 BQ_BO Bonaire    BQ-BO Latin America & Caribbean     High income
#> 3    CW Curaçao       CW Latin America & Caribbean     High income
#>   political_association is_sids        sids_tier is_snij criterion_small
#> 1         Dutch Kingdom       1 Associate member       1               1
#> 2         Dutch Kingdom       0             <NA>       1               1
#> 3         Dutch Kingdom       1 Associate member       1               1
#>   criterion_island criterion_developing criterion_sovereign
#> 1                1                    0                   0
#> 2                1                    0                   0
#> 3                1                    0                   0
```
