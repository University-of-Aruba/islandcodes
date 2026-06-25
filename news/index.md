# Changelog

## islandcodes 0.2.0

- The `islands` dataset gains five coordinate columns (WGS84 decimal
  degrees): `latitude`/`longitude` (a representative point on each
  territory’s main landmass) and
  `capital`/`capital_latitude`/`capital_longitude` (the capital city).
  Sourced from Natural Earth with a hand-curated supplement for the BES
  islands, French overseas departments, and other small territories; see
  the upstream `island-research-reference-data` for provenance.
- New
  [`island_coords()`](https://university-of-aruba.github.io/islandcodes/reference/island_coords.md)
  returns coordinates for a vector of names or ISO codes, with
  `which = "point"` (default) or `which = "capital"`.
- New
  [`island_distance()`](https://university-of-aruba.github.io/islandcodes/reference/island_distance.md)
  gives great-circle (haversine) distances between islands: a full
  symmetric matrix among one set, or element-wise/recycled distances
  between two. Supports `which` (point or capital) and `unit` (km, mi,
  nmi). Base R, no new dependencies.
- Bug fix: Namibia is no longer dropped from `islands`. Its ISO 3166-1
  alpha-2 code is the literal string `"NA"`, which the data-build step
  previously treated as a missing value. The dataset now has 251 rows
  (was 250).

## islandcodes 0.1.1

CRAN release: 2026-05-15

Resubmission addressing CRAN reviewer feedback (Uwe Ligges).

- `License` field simplified to `CC BY 4.0`; the `+ file LICENSE` suffix
  and the accompanying boilerplate `LICENSE` file have been removed (the
  file was not used to specify additional restrictions on CC BY 4.0).

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
- [`aruba()`](https://university-of-aruba.github.io/islandcodes/reference/aruba.md)
  — A.R.U.B.A. (Annotated Reference for Under-coded Border Areas): a
  convenience wrapper around
  [`island_lookup()`](https://university-of-aruba.github.io/islandcodes/reference/island_lookup.md)
  with Aruba as the default. A homage to Edward Cheung’s A.R.U.B.A.
  (ASCS/NCS Relay Unit Breaker Assembly) on the Hubble Space Telescope.
- Source data mirrored from
  `github.com/University-of-Aruba/island-research-reference-data` under
  CC BY 4.0.
