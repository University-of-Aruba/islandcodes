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
```

## Source and citation

The bundled dataset is mirrored from the [University of Aruba
island-research-reference-data](https://github.com/University-of-Aruba/island-research-reference-data)
repository, licensed CC BY 4.0. Run `citation("islandcodes")` for the
canonical citation.
