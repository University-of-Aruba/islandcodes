# Return a filtered subset of small-island states and territories

Convenience wrapper around
[`islands`](https://university-of-aruba.github.io/islandcodes/reference/islands.md)
that returns the subset matching commonly used small-island filters.

## Usage

``` r
small_islands(sids_only = FALSE, snij_only = FALSE, criteria = NULL)
```

## Arguments

- sids_only:

  Logical. If `TRUE`, return only UN-DESA SIDS.

- snij_only:

  Logical. If `TRUE`, return only sub-national island jurisdictions.

- criteria:

  Optional named logical vector with elements drawn from
  `c("small", "island", "developing", "sovereign")`. Each element
  constrains the corresponding `criterion_*` column.

## Value

A data frame, the relevant subset of `islands`.

## Examples

``` r
nrow(small_islands(sids_only = TRUE))
#> [1] 58
nrow(small_islands(snij_only = TRUE))
#> [1] 47
small_islands(criteria = c(small = TRUE, island = TRUE))
#>     name                                    label iso_code
#> 1     AX                            Åland Islands       AX
#> 2     AS                           American Samoa       AS
#> 3     AI                                 Anguilla       AI
#> 4     AG                      Antigua and Barbuda       AG
#> 5     AW                                    Aruba       AW
#> 6     BS                                  Bahamas       BS
#> 7     BB                                 Barbados       BB
#> 8     BM                                  Bermuda       BM
#> 9  BQ_BO                                  Bonaire    BQ-BO
#> 10    BV                            Bouvet Island       BV
#> 11    IO           British Indian Ocean Territory       IO
#> 12    BN                        Brunei Darussalam       BN
#> 13    CV                               Cabo Verde       CV
#> 14    KY                           Cayman Islands       KY
#> 15    CX                         Christmas Island       CX
#> 16    CC                  Cocos (Keeling) Islands       CC
#> 17    KM                                  Comoros       KM
#> 18    CK                             Cook Islands       CK
#> 19    CW                                  Curaçao       CW
#> 20    CY                                   Cyprus       CY
#> 21    DM                                 Dominica       DM
#> 22    FK                         Falkland Islands       FK
#> 23    FO                            Faroe Islands       FO
#> 24    FJ                                     Fiji       FJ
#> 25    PF                         French Polynesia       PF
#> 26    TF              French Southern Territories       TF
#> 27    GL                                Greenland       GL
#> 28    GD                                  Grenada       GD
#> 29    GP                               Guadeloupe       GP
#> 30    GU                                     Guam       GU
#> 31    GG                                 Guernsey       GG
#> 32    HM        Heard Island and McDonald Islands       HM
#> 33    IS                                  Iceland       IS
#> 34    IM                              Isle of Man       IM
#> 35    JE                                   Jersey       JE
#> 36    KI                                 Kiribati       KI
#> 37    MO                                Macao SAR       MO
#> 38    MV                                 Maldives       MV
#> 39    MT                                    Malta       MT
#> 40    MH                         Marshall Islands       MH
#> 41    MQ                               Martinique       MQ
#> 42    MU                                Mauritius       MU
#> 43    YT                                  Mayotte       YT
#> 44    FM            Micronesia (Federated States)       FM
#> 45    MS                               Montserrat       MS
#> 46    NR                                    Nauru       NR
#> 47    NC                            New Caledonia       NC
#> 48    NU                                     Niue       NU
#> 49    NF                           Norfolk Island       NF
#> 50    MP                 Northern Mariana Islands       MP
#> 51    PW                                    Palau       PW
#> 52    PN                                 Pitcairn       PN
#> 53    RE                                  Réunion       RE
#> 54 BQ_SA                                     Saba    BQ-SA
#> 55    BL                         Saint Barthélemy       BL
#> 56    SH                             Saint Helena       SH
#> 57    KN                    Saint Kitts and Nevis       KN
#> 58    LC                              Saint Lucia       LC
#> 59    MF               Saint Martin (French part)       MF
#> 60    PM                Saint Pierre and Miquelon       PM
#> 61    VC         Saint Vincent and the Grenadines       VC
#> 62    WS                                    Samoa       WS
#> 63    ST                    São Tomé and Príncipe       ST
#> 64    SC                               Seychelles       SC
#> 65 BQ_SE                           Sint Eustatius    BQ-SE
#> 66    SX                             Sint Maarten       SX
#> 67    SB                          Solomon Islands       SB
#> 68    GS South Georgia and South Sandwich Islands       GS
#> 69    SJ                   Svalbard and Jan Mayen       SJ
#> 70    TL                              Timor-Leste       TL
#> 71    TK                                  Tokelau       TK
#> 72    TO                                    Tonga       TO
#> 73    TT                      Trinidad and Tobago       TT
#> 74    TC                 Turks and Caicos Islands       TC
#> 75    TV                                   Tuvalu       TV
#> 76    UM     United States Minor Outlying Islands       UM
#> 77    VU                                  Vanuatu       VU
#> 78    VG                 Virgin Islands (British)       VG
#> 79    VI                    Virgin Islands (U.S.)       VI
#> 80    WF                        Wallis and Futuna       WF
#>                    wb_region     wb_income_group political_association is_sids
#> 1      Europe & Central Asia         High income               Finland       0
#> 2        East Asia & Pacific Upper-middle income         United States       1
#> 3  Latin America & Caribbean         High income        United Kingdom       1
#> 4  Latin America & Caribbean         High income           Independent       1
#> 5  Latin America & Caribbean         High income         Dutch Kingdom       1
#> 6  Latin America & Caribbean         High income           Independent       1
#> 7  Latin America & Caribbean         High income           Independent       1
#> 8              North America         High income        United Kingdom       1
#> 9  Latin America & Caribbean         High income         Dutch Kingdom       0
#> 10                      <NA>                <NA>                Norway       0
#> 11                South Asia                <NA>        United Kingdom       0
#> 12       East Asia & Pacific         High income           Independent       0
#> 13        Sub-Saharan Africa Lower-middle income           Independent       1
#> 14 Latin America & Caribbean         High income        United Kingdom       1
#> 15       East Asia & Pacific         High income             Australia       0
#> 16       East Asia & Pacific         High income             Australia       0
#> 17        Sub-Saharan Africa          Low income           Independent       1
#> 18       East Asia & Pacific Upper-middle income           New Zealand       1
#> 19 Latin America & Caribbean         High income         Dutch Kingdom       1
#> 20     Europe & Central Asia         High income           Independent       0
#> 21 Latin America & Caribbean Upper-middle income           Independent       1
#> 22 Latin America & Caribbean         High income        United Kingdom       0
#> 23     Europe & Central Asia         High income               Denmark       0
#> 24       East Asia & Pacific Upper-middle income           Independent       1
#> 25       East Asia & Pacific         High income       French Republic       1
#> 26                      <NA>                <NA>       French Republic       0
#> 27     Europe & Central Asia         High income               Denmark       0
#> 28 Latin America & Caribbean Upper-middle income           Independent       1
#> 29 Latin America & Caribbean         High income       French Republic       1
#> 30       East Asia & Pacific         High income         United States       1
#> 31     Europe & Central Asia         High income        United Kingdom       0
#> 32                      <NA>                <NA>             Australia       0
#> 33     Europe & Central Asia         High income           Independent       0
#> 34     Europe & Central Asia         High income        United Kingdom       0
#> 35     Europe & Central Asia         High income        United Kingdom       0
#> 36       East Asia & Pacific Lower-middle income           Independent       1
#> 37       East Asia & Pacific         High income                 China       0
#> 38                South Asia Upper-middle income           Independent       1
#> 39     Europe & Central Asia         High income           Independent       0
#> 40       East Asia & Pacific Upper-middle income           Independent       1
#> 41 Latin America & Caribbean         High income       French Republic       1
#> 42        Sub-Saharan Africa Upper-middle income           Independent       1
#> 43        Sub-Saharan Africa Upper-middle income       French Republic       0
#> 44       East Asia & Pacific Lower-middle income           Independent       1
#> 45 Latin America & Caribbean         High income        United Kingdom       1
#> 46       East Asia & Pacific         High income           Independent       1
#> 47       East Asia & Pacific         High income       French Republic       1
#> 48       East Asia & Pacific Upper-middle income           New Zealand       1
#> 49       East Asia & Pacific         High income             Australia       0
#> 50       East Asia & Pacific Upper-middle income         United States       1
#> 51       East Asia & Pacific         High income           Independent       1
#> 52       East Asia & Pacific         High income        United Kingdom       0
#> 53        Sub-Saharan Africa         High income       French Republic       0
#> 54 Latin America & Caribbean         High income         Dutch Kingdom       0
#> 55 Latin America & Caribbean         High income       French Republic       0
#> 56        Sub-Saharan Africa Upper-middle income        United Kingdom       0
#> 57 Latin America & Caribbean         High income           Independent       1
#> 58 Latin America & Caribbean Upper-middle income           Independent       1
#> 59 Latin America & Caribbean         High income       French Republic       0
#> 60             North America         High income       French Republic       0
#> 61 Latin America & Caribbean Upper-middle income           Independent       1
#> 62       East Asia & Pacific Lower-middle income           Independent       1
#> 63        Sub-Saharan Africa Lower-middle income           Independent       1
#> 64        Sub-Saharan Africa         High income           Independent       1
#> 65 Latin America & Caribbean         High income         Dutch Kingdom       0
#> 66 Latin America & Caribbean         High income         Dutch Kingdom       1
#> 67       East Asia & Pacific Lower-middle income           Independent       1
#> 68                      <NA>                <NA>        United Kingdom       0
#> 69     Europe & Central Asia         High income                Norway       0
#> 70       East Asia & Pacific Lower-middle income           Independent       1
#> 71       East Asia & Pacific                <NA>           New Zealand       0
#> 72       East Asia & Pacific Lower-middle income           Independent       1
#> 73 Latin America & Caribbean         High income           Independent       1
#> 74 Latin America & Caribbean         High income        United Kingdom       1
#> 75       East Asia & Pacific Upper-middle income           Independent       1
#> 76       East Asia & Pacific         High income         United States       0
#> 77       East Asia & Pacific Lower-middle income           Independent       1
#> 78 Latin America & Caribbean         High income        United Kingdom       1
#> 79 Latin America & Caribbean         High income         United States       1
#> 80       East Asia & Pacific Upper-middle income       French Republic       0
#>           sids_tier is_snij criterion_small criterion_island
#> 1              <NA>       1               1                1
#> 2  Associate member       1               1                1
#> 3  Associate member       1               1                1
#> 4  Sovereign member       0               1                1
#> 5  Associate member       1               1                1
#> 6  Sovereign member       0               1                1
#> 7  Sovereign member       0               1                1
#> 8  Associate member       1               1                1
#> 9              <NA>       1               1                1
#> 10             <NA>       0               1                1
#> 11             <NA>       1               1                1
#> 12             <NA>       0               1                1
#> 13 Sovereign member       0               1                1
#> 14 Associate member       1               1                1
#> 15             <NA>       1               1                1
#> 16             <NA>       1               1                1
#> 17 Sovereign member       0               1                1
#> 18 Sovereign member       1               1                1
#> 19 Associate member       1               1                1
#> 20             <NA>       0               1                1
#> 21 Sovereign member       0               1                1
#> 22             <NA>       1               1                1
#> 23             <NA>       1               1                1
#> 24 Sovereign member       0               1                1
#> 25 Associate member       1               1                1
#> 26             <NA>       0               1                1
#> 27             <NA>       1               1                1
#> 28 Sovereign member       0               1                1
#> 29 Associate member       1               1                1
#> 30 Associate member       1               1                1
#> 31             <NA>       1               1                1
#> 32             <NA>       0               1                1
#> 33             <NA>       0               1                1
#> 34             <NA>       1               1                1
#> 35             <NA>       1               1                1
#> 36 Sovereign member       0               1                1
#> 37             <NA>       1               1                1
#> 38 Sovereign member       0               1                1
#> 39             <NA>       0               1                1
#> 40 Sovereign member       0               1                1
#> 41 Associate member       1               1                1
#> 42 Sovereign member       0               1                1
#> 43             <NA>       1               1                1
#> 44 Sovereign member       0               1                1
#> 45 Associate member       1               1                1
#> 46 Sovereign member       0               1                1
#> 47 Associate member       1               1                1
#> 48 Sovereign member       1               1                1
#> 49             <NA>       1               1                1
#> 50 Associate member       1               1                1
#> 51 Sovereign member       0               1                1
#> 52             <NA>       1               1                1
#> 53             <NA>       1               1                1
#> 54             <NA>       1               1                1
#> 55             <NA>       1               1                1
#> 56             <NA>       1               1                1
#> 57 Sovereign member       0               1                1
#> 58 Sovereign member       0               1                1
#> 59             <NA>       1               1                1
#> 60             <NA>       1               1                1
#> 61 Sovereign member       0               1                1
#> 62 Sovereign member       0               1                1
#> 63 Sovereign member       0               1                1
#> 64 Sovereign member       0               1                1
#> 65             <NA>       1               1                1
#> 66 Associate member       1               1                1
#> 67 Sovereign member       0               1                1
#> 68             <NA>       0               1                1
#> 69             <NA>       0               1                1
#> 70 Sovereign member       0               1                1
#> 71             <NA>       1               1                1
#> 72 Sovereign member       0               1                1
#> 73 Sovereign member       0               1                1
#> 74 Associate member       1               1                1
#> 75 Sovereign member       0               1                1
#> 76             <NA>       1               1                1
#> 77 Sovereign member       0               1                1
#> 78 Associate member       1               1                1
#> 79 Associate member       1               1                1
#> 80             <NA>       1               1                1
#>    criterion_developing criterion_sovereign
#> 1                     0                   0
#> 2                     1                   0
#> 3                     0                   0
#> 4                     0                   1
#> 5                     0                   0
#> 6                     0                   1
#> 7                     0                   1
#> 8                     0                   0
#> 9                     0                   0
#> 10                   NA                   0
#> 11                   NA                   0
#> 12                    0                   1
#> 13                    1                   1
#> 14                    0                   0
#> 15                    0                   0
#> 16                    0                   0
#> 17                    1                   1
#> 18                    1                   0
#> 19                    0                   0
#> 20                    0                   1
#> 21                    1                   1
#> 22                    0                   0
#> 23                    0                   0
#> 24                    1                   1
#> 25                    0                   0
#> 26                   NA                   0
#> 27                    0                   0
#> 28                    1                   1
#> 29                    0                   0
#> 30                    0                   0
#> 31                    0                   0
#> 32                   NA                   0
#> 33                    0                   1
#> 34                    0                   0
#> 35                    0                   0
#> 36                    1                   1
#> 37                    0                   0
#> 38                    1                   1
#> 39                    0                   1
#> 40                    1                   1
#> 41                    0                   0
#> 42                    1                   1
#> 43                    1                   0
#> 44                    1                   1
#> 45                    0                   0
#> 46                    0                   1
#> 47                    0                   0
#> 48                    1                   0
#> 49                    0                   0
#> 50                    1                   0
#> 51                    0                   1
#> 52                    0                   0
#> 53                    0                   0
#> 54                    0                   0
#> 55                    0                   0
#> 56                    1                   0
#> 57                    0                   1
#> 58                    1                   1
#> 59                    0                   0
#> 60                    0                   0
#> 61                    1                   1
#> 62                    1                   1
#> 63                    1                   1
#> 64                    0                   1
#> 65                    0                   0
#> 66                    0                   0
#> 67                    1                   1
#> 68                   NA                   0
#> 69                    0                   0
#> 70                    1                   1
#> 71                   NA                   0
#> 72                    1                   1
#> 73                    0                   1
#> 74                    0                   0
#> 75                    1                   1
#> 76                    0                   0
#> 77                    1                   1
#> 78                    0                   0
#> 79                    0                   0
#> 80                    1                   0
```
