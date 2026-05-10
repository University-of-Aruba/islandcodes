# cran-comments.md

## Submission notes

This is a new package. It bundles the [University of Aruba island-research-reference-data](https://github.com/University-of-Aruba/island-research-reference-data) reference list (CC BY 4.0) and provides predicates and a tidy joiner for small-island and sub-sovereign classification work, intended to extend rather than replace `countrycode`.

## Test environments

* local: Windows 11, R 4.2.2 — 0 errors, 0 warnings, 2 NOTEs (expected, see below)
* GitHub Actions: macOS-latest (release), windows-latest (release), ubuntu-latest (devel, release, oldrel-1) — all green
* win-builder R-devel — 0 errors, 0 warnings, 1 NOTE (spelling, see below)

## R CMD check results

0 errors | 0 warnings | 1 NOTE

The remaining NOTE is the spell-checker flagging the following words as possibly misspelled:

* **Aaland, Bonaire, Maarten, Sint** — place names (Åland Islands, Bonaire, Sint Maarten / Sint Eustatius). Spelled in ASCII per CRAN convention; the bundled `islands` dataset uses the diacritic (Åland) where appropriate.
* **SNIJ** — a standard term in small-island political-geography literature: Sub-National Island Jurisdiction (Baldacchino, 2010).
* **disambiguating** — used in the standard sense (the package disambiguates the three BES islands within ISO 3166-1 alpha-2 `BQ`).

All are intentional and correctly spelled.

## Downstream dependencies

None — this is a new package.
