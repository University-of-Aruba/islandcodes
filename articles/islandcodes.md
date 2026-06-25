# Extending countrycode for small-island research

## The problem

Researchers working on Small Island Developing States (SIDS), the
Caribbean, or other sub-sovereign territories run into two recurring
frictions when joining classifications onto their data.

The first is sub-sovereign disambiguation. Aruba (`AW`), Curaçao (`CW`),
and Sint Maarten (`SX`) have their own ISO 3166-1 codes, but Bonaire,
Sint Eustatius, and Saba share `BQ`. Most country-code packages either
drop these three or collapse them into one row, which silently corrupts
joins.

The second is classification. UN-DESA’s SIDS list, including both
sovereign and associate members, and the broader sub-national island
jurisdiction (SNIJ) literature, are not standard fields in country-code
dictionaries. Researchers tend to keep these as a side spreadsheet and
hand-copy them onto each project.

`islandcodes` does one thing: it ships the classification list, with
disambiguating codes for the sub-sovereign cases, and a few helpers that
work alongside `countrycode`.

## A first pass

``` r

library(islandcodes)
#> 
#> Attaching package: 'islandcodes'
#> The following object is masked from 'package:datasets':
#> 
#>     islands

is_sids(c("Aruba", "Curacao", "Bonaire", "Brazil"))
#> [1]  TRUE  TRUE FALSE FALSE
is_snij(c("Aruba", "Curacao", "Bonaire", "Brazil"))
#> [1]  TRUE  TRUE  TRUE FALSE
```

Notice that Aruba returns `TRUE` for both `is_sids` and `is_snij`. It is
a UN-DESA SIDS associate member and a sub-national island jurisdiction
within the Kingdom of the Netherlands. Bonaire returns `FALSE` for SIDS
but `TRUE` for SNIJ: it is part of the Netherlands proper as a special
municipality, not a separate jurisdiction recognised by UN-DESA.

The package accepts country names, ISO 3166-1 alpha-2 codes, or the
hyphenated extensions used here for the three BES islands.

``` r

is_sids(c("AW", "CW", "BQ-BO", "AX", "BR"))
#> [1]  TRUE  TRUE FALSE FALSE FALSE
```

## Adding columns to a research data frame

``` r

df <- data.frame(
  country  = c("Aruba", "Curacao", "Bonaire", "Sint Maarten", "Brazil"),
  variable = c(3.5, 3.1, 0.5, 1.2, 1900)
)

add_island_cols(df, "country")
#>        country variable iso_code is_sids is_snij        sids_tier
#> 1        Aruba      3.5       AW       1       1 Associate member
#> 2      Curacao      3.1       CW       1       1 Associate member
#> 3      Bonaire      0.5    BQ-BO       0       1             <NA>
#> 4 Sint Maarten      1.2       SX       1       1 Associate member
#> 5       Brazil   1900.0       BR       0       0             <NA>
#>   political_association                 wb_region     wb_income_group
#> 1         Dutch Kingdom Latin America & Caribbean         High income
#> 2         Dutch Kingdom Latin America & Caribbean         High income
#> 3         Dutch Kingdom Latin America & Caribbean         High income
#> 4         Dutch Kingdom Latin America & Caribbean         High income
#> 5           Independent Latin America & Caribbean Upper-middle income
```

By default `add_island_cols` attaches `iso_code`, `is_sids`, `is_snij`,
`sids_tier`, `political_association`, `wb_region`, and
`wb_income_group`. Override `cols` for a narrower selection.

## Working alongside countrycode

`islandcodes` imports `countrycode` for name-to-code resolution on the
long tail of country names. For projects that already use `countrycode`,
run it first to get an ISO column, then pass that column to
`islandcodes`.

``` r

library(countrycode)

df$iso2 <- countrycode(df$country, "country.name", "iso2c")
#> Warning: Some values were not matched unambiguously: Bonaire
#> To fix unmatched values, please use the `custom_match` argument. If you think the default matching rules should be improved, please file an issue at https://github.com/vincentarelbundock/countrycode/issues
df$iso2  # note Bonaire collapses to NA in countrycode
#> [1] "AW" "CW" NA   "SX" "BR"

# islandcodes recovers the BES cases via direct hyphenated lookup
add_island_cols(df, "country",
                cols = c("iso_code", "is_sids", "is_snij"))
#>        country variable iso2 iso_code is_sids is_snij
#> 1        Aruba      3.5   AW       AW       1       1
#> 2      Curacao      3.1   CW       CW       1       1
#> 3      Bonaire      0.5 <NA>    BQ-BO       0       1
#> 4 Sint Maarten      1.2   SX       SX       1       1
#> 5       Brazil   1900.0   BR       BR       0       0
```

The pattern is: `countrycode` for the standard ISO conversion,
`islandcodes` for everything that does not fit.

## Filtered subsets

``` r

nrow(small_islands(sids_only = TRUE))
#> [1] 58
nrow(small_islands(snij_only = TRUE))
#> [1] 47

head(small_islands(criteria = c(small = TRUE, island = TRUE, sovereign = TRUE)),
     8)
#>   name               label iso_code                 wb_region
#> 1   AG Antigua and Barbuda       AG Latin America & Caribbean
#> 2   BS             Bahamas       BS Latin America & Caribbean
#> 3   BB            Barbados       BB Latin America & Caribbean
#> 4   BN   Brunei Darussalam       BN       East Asia & Pacific
#> 5   CV          Cabo Verde       CV        Sub-Saharan Africa
#> 6   KM             Comoros       KM        Sub-Saharan Africa
#> 7   CY              Cyprus       CY     Europe & Central Asia
#> 8   DM            Dominica       DM Latin America & Caribbean
#>       wb_income_group political_association is_sids        sids_tier is_snij
#> 1         High income           Independent       1 Sovereign member       0
#> 2         High income           Independent       1 Sovereign member       0
#> 3         High income           Independent       1 Sovereign member       0
#> 4         High income           Independent       0             <NA>       0
#> 5 Lower-middle income           Independent       1 Sovereign member       0
#> 6          Low income           Independent       1 Sovereign member       0
#> 7         High income           Independent       0             <NA>       0
#> 8 Upper-middle income           Independent       1 Sovereign member       0
#>   criterion_small criterion_island criterion_developing criterion_sovereign
#> 1               1                1                    0                   1
#> 2               1                1                    0                   1
#> 3               1                1                    0                   1
#> 4               1                1                    0                   1
#> 5               1                1                    1                   1
#> 6               1                1                    1                   1
#> 7               1                1                    0                   1
#> 8               1                1                    1                   1
#>   latitude longitude             capital capital_latitude capital_longitude
#> 1  17.3522  -61.7906        Saint John's          17.1180          -61.8500
#> 2  26.4018  -77.1467              Nassau          25.0834          -77.3500
#> 3  13.1637  -59.5690          Bridgetown          13.1020          -59.6165
#> 4   4.4483  114.5519 Bandar Seri Begawan           4.8833          114.9333
#> 5  15.0748  -23.6394               Praia          14.9167          -23.5167
#> 6 -11.7277   43.3181              Moroni         -11.7042           43.2402
#> 7  34.9133   33.0842             Nicosia          35.1667           33.3666
#> 8  15.4588  -61.3450              Roseau          15.3010          -61.3870
```

## Coordinates

Each territory carries two kinds of location, both in WGS84 decimal
degrees: a representative point on the main landmass (`latitude`,
`longitude`) and the capital city (`capital`, `capital_latitude`,
`capital_longitude`).
[`island_coords()`](https://university-of-aruba.github.io/islandcodes/reference/island_coords.md)
returns them for a vector of names or codes, in input order.

``` r

island_coords(c("Aruba", "Curacao", "Bonaire", "Sint Maarten"))
#>          label iso_code latitude longitude
#> 1        Aruba       AW  12.5174  -69.9728
#> 2      Curaçao       CW  12.1450  -68.9206
#> 3      Bonaire    BQ-BO  12.1830  -68.2500
#> 4 Sint Maarten       SX  18.0409  -63.0701
```

The two semantics differ for dispersed territories. For French Polynesia
the landmass point sits near Tahiti while the capital is Papeete; for
the United States the landmass point is in the continental interior, far
from Washington.

``` r

island_coords(c("PF", "US"))
#>              label iso_code latitude longitude
#> 1 French Polynesia       PF -17.6281 -149.4616
#> 2    United States       US  39.5385  -97.4826
island_coords(c("PF", "US"), which = "capital")
#>              label iso_code          capital latitude longitude
#> 1 French Polynesia       PF          Papeete -17.5334 -149.5667
#> 2    United States       US Washington, D.C.  38.9015  -77.0114
```

## Distance and isolation

[`island_distance()`](https://university-of-aruba.github.io/islandcodes/reference/island_distance.md)
turns the coordinates into great-circle (haversine) distances. Given a
single set it returns a symmetric matrix, which exposes the spread of
the Dutch Caribbean, from the ABC islands off Venezuela to the SSS
islands some 900 km to the northeast.

``` r

round(island_distance(c("AW", "CW", "BQ-BO", "SX", "BQ-SA", "BQ-SE")))
#>        AW  CW BQ-BO  SX BQ-SA BQ-SE
#> AW      0 122   191 962   920   933
#> CW    122   0    73 908   863   873
#> BQ-BO 191  73     0 856   811   818
#> SX    962 908   856   0    49    62
#> BQ-SA 920 863   811  49     0    32
#> BQ-SE 933 873   818  62    32     0
```

Pass a second argument for distances from one or more origins to a set
of destinations. The shorter side is recycled, so a single origin
against many destinations gives the distance to each.

``` r

island_distance("Aruba", c("Curacao", "Bonaire", "Sint Maarten"))
#>       CW    BQ-BO       SX 
#> 121.5695 190.7913 961.7026
```

`which = "capital"` measures between capital cities instead of landmass
points, and `unit` switches between kilometres, statute miles, and
nautical miles.

``` r

island_distance("AW", "CW", which = "capital", unit = "nmi")
#>       CW 
#> 71.96274
```

Because both helpers keep input order and fill unresolved rows with
`NA`, they slot directly into a pipeline: resolve a column of names,
attach coordinates or distances, then rank by isolation or hand the
points to a mapping package. A quick isolation measure is each island’s
nearest neighbour, the smallest off-diagonal distance in its row.

``` r

abc <- island_distance(c("AW", "CW", "BQ-BO"))
diag(abc) <- NA
apply(abc, 1, min, na.rm = TRUE)  # km to nearest of the other two
#>        AW        CW     BQ-BO 
#> 121.56948  73.01551  73.01551
```

## Source and citation

The bundled dataset is mirrored from the [University of Aruba
island-research-reference-data](https://github.com/University-of-Aruba/island-research-reference-data)
repository, licensed CC BY 4.0. Run `citation("islandcodes")` for the
canonical citation.
