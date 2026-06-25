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
#>    criterion_developing criterion_sovereign latitude longitude
#> 1                     0                   0  60.1565   19.8697
#> 2                     1                   0 -14.3267 -170.7472
#> 3                     0                   0  18.2430  -63.0264
#> 4                     0                   1  17.3522  -61.7906
#> 5                     0                   0  12.5174  -69.9728
#> 6                     0                   1  26.4018  -77.1467
#> 7                     0                   1  13.1637  -59.5690
#> 8                     0                   0  32.2966  -64.7636
#> 9                     0                   0  12.1830  -68.2500
#> 10                   NA                   0 -54.4230    3.4130
#> 11                   NA                   0  -6.1908   71.3483
#> 12                    0                   1   4.4483  114.5519
#> 13                    1                   1  15.0748  -23.6394
#> 14                    0                   0  19.3199  -81.2406
#> 15                    0                   0 -10.4910  105.6220
#> 16                    0                   0 -12.1670   96.8330
#> 17                    1                   1 -11.7277   43.3181
#> 18                    1                   0 -21.2160 -159.7857
#> 19                    0                   0  12.1450  -68.9206
#> 20                    0                   1  34.9133   33.0842
#> 21                    1                   1  15.4588  -61.3450
#> 22                    0                   0 -51.6089  -58.7386
#> 23                    0                   0  62.1856   -7.0584
#> 24                    1                   1 -17.8261  177.9754
#> 25                    0                   0 -17.6281 -149.4616
#> 26                   NA                   0 -49.3037   69.1221
#> 27                    0                   0  74.3194  -39.3353
#> 28                    1                   1  12.1132  -61.6805
#> 29                    0                   0  16.2500  -61.5830
#> 30                    0                   0  13.3542  144.7036
#> 31                    0                   0  49.4635   -2.5617
#> 32                   NA                   0 -53.1035   73.5052
#> 33                    0                   1  64.7793  -18.6737
#> 34                    0                   0  54.2208   -4.5301
#> 35                    0                   0  49.2208   -2.0901
#> 36                    1                   1   1.8204 -157.3846
#> 37                    0                   0  22.1297  113.5560
#> 38                    1                   1   4.1744   73.5076
#> 39                    0                   1  35.8929   14.4330
#> 40                    1                   1   7.0826  171.1936
#> 41                    0                   0  14.6420  -61.0000
#> 42                    1                   1 -20.2995   57.5658
#> 43                    1                   0 -12.8230   45.1660
#> 44                    1                   1   6.8876  158.2340
#> 45                    0                   0  16.7372  -62.1883
#> 46                    0                   1  -0.5203  166.9326
#> 47                    0                   0 -21.0647  165.0840
#> 48                    1                   0 -19.0460 -169.8626
#> 49                    0                   0 -29.0330  167.9545
#> 50                    1                   0  15.1882  145.7344
#> 51                    0                   1   7.5183  134.5802
#> 52                    0                   0 -24.3646 -128.3175
#> 53                    0                   0 -21.1330   55.5330
#> 54                    0                   0  17.6300  -63.2330
#> 55                    0                   0  17.9020  -62.8332
#> 56                    1                   0 -15.9505   -5.7126
#> 57                    0                   1  17.3366  -62.7580
#> 58                    1                   1  13.8924  -60.9801
#> 59                    0                   0  18.0813  -63.0494
#> 60                    0                   0  47.0403  -56.3324
#> 61                    1                   1  13.0879  -61.3359
#> 62                    1                   1 -13.6391 -172.4382
#> 63                    1                   1   0.9709    7.0210
#> 64                    0                   1  -4.6767   55.4802
#> 65                    0                   0  17.4900  -62.9730
#> 66                    0                   0  18.0409  -63.0701
#> 67                    1                   1  -8.0295  159.1705
#> 68                   NA                   0 -55.6834  -31.0632
#> 69                    0                   0  78.0000   16.0000
#> 70                    1                   1  -8.8037  125.8547
#> 71                   NA                   0  -9.1670 -171.8330
#> 72                    1                   1 -21.2100 -175.1630
#> 73                    0                   1  10.9989  -60.9184
#> 74                    0                   0  21.8166  -71.7527
#> 75                    1                   1  -8.5137  179.2096
#> 76                    0                   0       NA        NA
#> 77                    1                   1 -15.3715  166.9088
#> 78                    0                   0  18.4266  -64.6366
#> 79                    0                   0  17.7467  -64.7792
#> 80                    1                   0 -14.2864 -178.1374
#>                capital capital_latitude capital_longitude
#> 1            Mariehamn          60.0970           19.9490
#> 2            Pago Pago         -14.2766         -170.7066
#> 3           The Valley          18.2170          -63.0578
#> 4         Saint John's          17.1180          -61.8500
#> 5           Oranjestad          12.5215          -70.0255
#> 6               Nassau          25.0834          -77.3500
#> 7           Bridgetown          13.1020          -59.6165
#> 8             Hamilton          32.2942          -64.7839
#> 9           Kralendijk          12.1442          -68.2655
#> 10                <NA>               NA                NA
#> 11                <NA>               NA                NA
#> 12 Bandar Seri Begawan           4.8833          114.9333
#> 13               Praia          14.9167          -23.5167
#> 14         George Town          19.2947          -81.3716
#> 15    Flying Fish Cove         -10.4217          105.6791
#> 16         West Island         -12.1568           96.8290
#> 17              Moroni         -11.7042           43.2402
#> 18              Avarua         -21.2075         -159.7710
#> 19          Willemstad          12.1123          -68.8724
#> 20             Nicosia          35.1667           33.3666
#> 21              Roseau          15.3010          -61.3870
#> 22             Stanley         -51.7000          -57.8500
#> 23            Tórshavn          62.0079           -6.7714
#> 24                Suva         -18.1330          178.4417
#> 25             Papeete         -17.5334         -149.5667
#> 26   Port-aux-Français         -49.3492           70.2197
#> 27                Nuuk          64.1983          -51.7327
#> 28      Saint George's          12.0526          -61.7416
#> 29         Basse-Terre          16.0000          -61.7333
#> 30               Agana          13.4700          144.7500
#> 31    Saint Peter Port          49.4555           -2.5368
#> 32                <NA>               NA                NA
#> 33           Reykjavík          64.1435          -21.9365
#> 34             Douglas          54.1491           -4.4803
#> 35        Saint Helier          49.1869           -2.1070
#> 36              Tarawa           1.3382          173.0176
#> 37               Macau          22.1891          113.5444
#> 38                Malé           4.1720           73.5089
#> 39            Valletta          35.8997           14.5147
#> 40              Majuro           7.1030          171.3800
#> 41      Fort-de-France          14.6042          -61.0667
#> 42          Port Louis         -20.1666           57.5000
#> 43           Mamoudzou         -12.7800           45.2280
#> 44             Palikir           6.9166          158.1500
#> 45              Brades          16.7920          -62.2110
#> 46               Yaren          -0.5477          166.9209
#> 47              Nouméa         -22.2625          166.4443
#> 48               Alofi         -19.0560         -169.9180
#> 49            Kingston         -29.0556          167.9613
#> 50              Saipan          15.2150          145.7510
#> 51            Melekeok           7.4874          134.6265
#> 52           Adamstown         -25.0662         -130.1027
#> 53         Saint-Denis         -20.8823           55.4504
#> 54          The Bottom          17.6256          -63.2490
#> 55            Gustavia          17.8962          -62.8498
#> 56           Jamestown         -15.9251           -5.7179
#> 57          Basseterre          17.3020          -62.7170
#> 58            Castries          14.0079          -60.9929
#> 59             Marigot          18.0673          -63.0826
#> 60        Saint-Pierre          46.7785          -56.1773
#> 61           Kingstown          13.1558          -61.2202
#> 62                Apia         -13.8357         -171.7686
#> 63            São Tomé           0.3375            6.7296
#> 64            Victoria          -4.6166           55.4500
#> 65          Oranjestad          17.4825          -62.9756
#> 66         Philipsburg          18.0255          -63.0450
#> 67             Honiara          -9.4380          159.9498
#> 68                <NA>               NA                NA
#> 69        Longyearbyen          78.2210           15.6209
#> 70                Dili          -8.5594          125.5795
#> 71                <NA>               NA                NA
#> 72          Nuku'alofa         -21.1385         -175.2206
#> 73       Port-of-Spain          10.6520          -61.5170
#> 74          Grand Turk          21.4664          -71.1360
#> 75            Funafuti          -8.5167          179.2166
#> 76                <NA>               NA                NA
#> 77           Port Vila         -17.7334          168.3166
#> 78           Road Town          18.4286          -64.6185
#> 79    Charlotte Amalie          18.3412          -64.9314
#> 80            Mata-Utu         -13.2816         -176.1745
```
