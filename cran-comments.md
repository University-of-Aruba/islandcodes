# cran-comments.md

## Submission notes

This is an update of an existing CRAN package (0.1.1 -> 0.2.0).

New in this version:

* The bundled `islands` dataset gains five coordinate columns (WGS84 decimal degrees): a representative point on each territory's main landmass and the capital city.
* New exported helpers `island_coords()` and `island_distance()` for retrieving coordinates and computing great-circle distances between islands.
* Bug fix: Namibia was previously dropped from `islands` because its ISO 3166-1 alpha-2 code is the literal string "NA", which the data-build step treated as a missing value. The dataset now has 251 rows (was 250).

The reference data continues to be bundled from the [University of Aruba island-research-reference-data](https://github.com/University-of-Aruba/island-research-reference-data) repository (CC BY 4.0).

## Test environments

* Local: Windows 11, R 4.2.2 — `R CMD check --as-cran`: 0 errors, 0 warnings, 1 NOTE (see below)
* GitHub Actions: macOS-latest (release), windows-latest (release), ubuntu-latest (devel, release, oldrel-1)
* win-builder R-devel

## R CMD check results

0 errors | 0 warnings | 1 NOTE

The NOTE is the spell-check on DESCRIPTION:

* **Aaland, Bonaire, Maarten, Sint** — place names (Åland Islands, Bonaire, Sint Maarten / Sint Eustatius). Spelled in ASCII per CRAN convention; the bundled `islands` dataset uses the diacritic (Åland) where appropriate.
* **SNIJ** — a standard term in small-island political-geography literature: Sub-National Island Jurisdiction (Baldacchino, 2010).
* **disambiguating** — used in the standard sense (the package disambiguates the three BES islands within ISO 3166-1 alpha-2 `BQ`).

All are intentional and correctly spelled.

## Downstream dependencies

None affected. There are no reverse dependencies on CRAN.
