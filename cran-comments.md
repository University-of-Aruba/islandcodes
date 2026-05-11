# cran-comments.md

## Resubmission

This is a resubmission addressing reviewer feedback from Uwe Ligges (11 May 2026):

* Removed `+ file LICENSE` from the `License` field in DESCRIPTION; the field now reads `License: CC BY 4.0`.
* Removed the `LICENSE` file (it was the boilerplate template, not used to specify additional restrictions on CC BY 4.0).
* Updated the README's license section to point to the canonical CC BY 4.0 URL instead of the deleted file.

## Submission notes

This is a new package. It bundles the [University of Aruba island-research-reference-data](https://github.com/University-of-Aruba/island-research-reference-data) reference list (CC BY 4.0) and provides predicates and a tidy joiner for small-island and sub-sovereign classification work, intended to extend rather than replace `countrycode`.

## Test environments

* GitHub Actions: macOS-latest (release), windows-latest (release), ubuntu-latest (devel, release, oldrel-1) — all green
* win-builder R-devel (R 2026-05-10 r90034) — 0 errors, 0 warnings, 1 NOTE (see below)

## R CMD check results

0 errors | 0 warnings | 1 NOTE

The NOTE on win-builder has two parts:

**Spell-check.** Possibly misspelled words in DESCRIPTION:

* **Aaland, Bonaire, Maarten, Sint** — place names (Åland Islands, Bonaire, Sint Maarten / Sint Eustatius). Spelled in ASCII per CRAN convention; the bundled `islands` dataset uses the diacritic (Åland) where appropriate.
* **SNIJ** — a standard term in small-island political-geography literature: Sub-National Island Jurisdiction (Baldacchino, 2010).
* **disambiguating** — used in the standard sense (the package disambiguates the three BES islands within ISO 3166-1 alpha-2 `BQ`).

All are intentional and correctly spelled.

**URL check.** `https://orcid.org/0009-0006-5402-0500` was flagged as "invalid" with a 60-second timeout. The URL is the maintainer's valid ORCID identifier and resolves with `HTTP/1.1 200 OK` from independent network checks; the failure is a transient orcid.org reachability issue on the win-builder host, not a defective URL.

## Downstream dependencies

None — this is a new package.
