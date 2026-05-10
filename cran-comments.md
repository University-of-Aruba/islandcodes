# cran-comments.md

## Submission notes

This is a new package. It bundles the [University of Aruba island-research-reference-data](https://github.com/University-of-Aruba/island-research-reference-data) reference list (CC BY 4.0) and provides predicates and a tidy joiner for small-island and sub-sovereign classification work, intended to extend rather than replace `countrycode`.

## Test environments

* local: Windows 11, R 4.2.2 — 0 errors, 0 warnings, 2 NOTEs (expected, see below)
* GitHub Actions:
  * windows-latest, R release
  * macos-latest, R release
  * ubuntu-latest, R devel
  * ubuntu-latest, R release
  * ubuntu-latest, R oldrel-1

## R CMD check results

0 errors | 0 warnings | 2 NOTEs

Both NOTEs are expected for a first submission:

1. *New submission*. License clause about "components with restrictions" is the standard CC BY 4.0 + file LICENSE acknowledgement.
2. *Possibly invalid URLs (404)* — these point to the package repository and pkgdown site, which are live by the time of submission. They were 404 only during local pre-submission checks before the repo was made public.

## Downstream dependencies

None — this is a new package.
