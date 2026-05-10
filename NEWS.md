# islandcodes 0.1.0

Initial CRAN release.

* Bundled `islands` reference dataset: 250 countries and territories with classifications for SIDS, SNIJ, World Bank region and income group, political association, and the four small-island defining criteria.
* Predicates `is_sids()`, `is_snij()`, `is_small_island()` accept country names, ISO codes, or the hyphenated BES sub-codes (`BQ-BO`, `BQ-SE`, `BQ-SA`).
* `island_lookup()` and `add_island_cols()` for tidy joining onto research data.
* `small_islands()` shorthand for filtered subsets.
* Source data mirrored from `github.com/University-of-Aruba/island-research-reference-data` under CC BY 4.0.
