# Changelog

## islandcodes 0.1.0

Initial CRAN release.

- Bundled `islands` reference dataset: 250 countries and territories
  with classifications for SIDS, SNIJ, World Bank region and income
  group, political association, and the four small-island defining
  criteria.
- Predicates
  [`is_sids()`](https://university-of-aruba.github.io/islandcodes/reference/classify.md),
  [`is_snij()`](https://university-of-aruba.github.io/islandcodes/reference/classify.md),
  [`is_small_island()`](https://university-of-aruba.github.io/islandcodes/reference/classify.md)
  accept country names, ISO codes, or the hyphenated BES sub-codes
  (`BQ-BO`, `BQ-SE`, `BQ-SA`).
- [`island_lookup()`](https://university-of-aruba.github.io/islandcodes/reference/island_lookup.md)
  and
  [`add_island_cols()`](https://university-of-aruba.github.io/islandcodes/reference/add_island_cols.md)
  for tidy joining onto research data.
- [`small_islands()`](https://university-of-aruba.github.io/islandcodes/reference/small_islands.md)
  shorthand for filtered subsets.
- Source data mirrored from
  `github.com/University-of-Aruba/island-research-reference-data` under
  CC BY 4.0.
