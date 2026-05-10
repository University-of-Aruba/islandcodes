# Reference list of countries and territories with small-island classifications

A curated dataset of 251 countries and territories, including
sub-sovereign island jurisdictions (Aruba, Curacao, Bonaire, Sint
Maarten, the French overseas collectivities, Aaland Islands, and others)
that are typically collapsed or omitted by ISO 3166-1 country-code
lists.

## Usage

``` r
islands
```

## Format

A data frame with 251 rows and 13 columns:

- name:

  Short common name (e.g. "Aruba", "Curacao", "Bonaire").

- label:

  Display label, used by the upstream XLSForm survey.

- iso_code:

  ISO 3166-1 alpha-2 code, with hyphenated extensions for the three BES
  islands (`BQ-BO` Bonaire, `BQ-SE` Sint Eustatius, `BQ-SA` Saba) so
  they can be distinguished within the shared `BQ` prefix.

- wb_region:

  World Bank region.

- wb_income_group:

  World Bank income group.

- political_association:

  Sovereign power for non-independent territories; `"Independent"`
  otherwise.

- is_sids:

  1 if a UN-DESA recognised Small Island Developing State (member or
  associate); 0 otherwise.

- sids_tier:

  `"Sovereign member"`, `"Associate member"`, or `NA` where not
  applicable.

- is_snij:

  1 if a sub-national island jurisdiction; 0 otherwise.

- criterion_small:

  1 if meets the small-population/small-area criterion; 0 otherwise.

- criterion_island:

  1 if an island or archipelago; 0 otherwise.

- criterion_developing:

  1 if classified as developing; 0 otherwise.

- criterion_sovereign:

  1 if a sovereign state; 0 otherwise.

## Source

University of Aruba, Digital Competence Dutch Caribbean (DCDC) Network.
*island-research-reference-data*, CC BY 4.0.
<https://github.com/University-of-Aruba/island-research-reference-data>

## Examples

``` r
head(islands)
#>   name          label iso_code                  wb_region     wb_income_group
#> 1   AF    Afghanistan       AF                 South Asia          Low income
#> 2   AX  Åland Islands       AX      Europe & Central Asia         High income
#> 3   AL        Albania       AL      Europe & Central Asia Upper-middle income
#> 4   DZ        Algeria       DZ Middle East & North Africa Lower-middle income
#> 5   AS American Samoa       AS        East Asia & Pacific Upper-middle income
#> 6   AD        Andorra       AD      Europe & Central Asia         High income
#>   political_association is_sids        sids_tier is_snij criterion_small
#> 1           Independent       0             <NA>       0               0
#> 2               Finland       0             <NA>       1               1
#> 3           Independent       0             <NA>       0               0
#> 4           Independent       0             <NA>       0               0
#> 5         United States       1 Associate member       1               1
#> 6           Independent       0             <NA>       0               1
#>   criterion_island criterion_developing criterion_sovereign
#> 1                0                    1                   1
#> 2                1                    0                   0
#> 3                0                    1                   1
#> 4                0                    1                   1
#> 5                1                    1                   0
#> 6                0                    0                   1

# SIDS by World Bank region
table(islands$wb_region[islands$is_sids == 1])
#> 
#>        East Asia & Pacific  Latin America & Caribbean 
#>                         21                         28 
#> Middle East & North Africa              North America 
#>                          1                          1 
#>                 South Asia         Sub-Saharan Africa 
#>                          1                          6 

# Dutch Kingdom territories (an example of the SNIJ axis)
islands[islands$political_association == "Dutch Kingdom",
        c("name", "iso_code", "is_sids", "is_snij")]
#>      name iso_code is_sids is_snij
#> 13     AW       AW       1       1
#> 28  BQ_BO    BQ-BO       0       1
#> 58     CW       CW       1       1
#> 156    NL       NL       0       0
#> 185 BQ_SA    BQ-SA       0       1
#> 202 BQ_SE    BQ-SE       0       1
#> 203    SX       SX       1       1
```
