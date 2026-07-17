---
title: "islandcodes: reference data and helpers for small island states and sub-sovereign territories in R"
tags:
  - R
  - small island developing states
  - SIDS
  - sub-national island jurisdictions
  - Caribbean
  - country codes
  - reproducible research
  - FAIR data
authors:
  - name: Rendell de Kort
    orcid: 0009-0006-5402-0500
    affiliation: "1, 2"
affiliations:
  - name: University of Aruba, Digital Competence Dutch Caribbean (DCDC) Network, Aruba
    index: 1
  - name: Vrije Universiteit Amsterdam, Netherlands
    index: 2
date: 16 July 2026
bibliography: paper.bib
---

# Summary

`islandcodes` is an R package that ships a curated reference dataset of 251
countries and territories, each annotated with the classifications that recur in
small-island research: Small Island Developing State (SIDS) status and tier,
sub-national island jurisdiction (SNIJ) status, World Bank region and income
group, political association, four defining criteria (small, island, developing,
sovereign), and WGS84 coordinates for both a representative point on the main
landmass and the capital city. On top of the data it provides a small, stable
set of helpers: predicate functions (`is_sids()`, `is_snij()`,
`is_small_island()`), a tidy joiner (`island_lookup()`, `add_island_cols()`), a
filtered-subset shorthand (`small_islands()`), and geographic helpers
(`island_coords()`, `island_distance()` for great-circle distances). The package
imports rather than replaces `countrycode` [@countrycode], coercing country
names to ISO codes before lookup so it composes with existing workflows.

Its distinguishing feature is the treatment of sub-sovereign territories that
ISO 3166-1 collapses or omits. Aruba (`AW`), Curaçao (`CW`), and Sint Maarten
(`SX`) have their own ISO alpha-2 codes, but Bonaire, Sint Eustatius, and Saba
share the single code `BQ`. `islandcodes` splits them into the hyphenated
extensions `BQ-BO`, `BQ-SE`, and `BQ-SA` and joins on them consistently, so the
six territories of the Dutch Caribbean, and comparable cases such as the French
overseas collectivities and the Åland Islands, can be analysed as distinct
units.

# Statement of need

Researchers working on small islands and sub-sovereign territories repeatedly
hit two gaps that are individually minor and collectively corrosive to
reproducibility.

The first is identity. General-purpose country-code tools resolve sovereign
states reliably but handle non-independent jurisdictions inconsistently. Because
Bonaire, Sint Eustatius, and Saba share the ISO code `BQ`, any analysis that
needs them as separate observations, which is to say any analysis of the Dutch
Caribbean, has to patch the reference data by hand. Hand-patching is precisely
the undocumented, one-off editing step that silently breaks a pipeline when the
data are refreshed or the code is rerun by someone else.

The second is classification. The two schemes that define this field, the
UN-DESA list of Small Island Developing States [@undesa_sids] and the academic
concept of the sub-national island jurisdiction [@baldacchino2006], are not
carried by any code-conversion package. Joining either onto a research dataset
typically means copying lists out of PDFs and reconciling country strings by
eye, an error-prone step that leaves no audit trail.

A concrete illustration of why curated, tested reference data matters: standard
ingestion routines frequently drop Namibia, whose ISO 3166-1 alpha-2 code is the
literal string `"NA"`, because the build step reads it as a missing value. This
exact bug was present in an earlier version of the bundled dataset and is fixed
and regression-tested in the current release; the dataset now carries 251 rows
rather than 250. The class of error, not the single case, is the point.

`islandcodes` closes both gaps by packaging the classification list as
version-controlled, openly licensed (CC BY 4.0) data with a documented
provenance chain, and by exposing the few helpers needed to join it onto
research data in a single line. The bundled `islands` dataset is mirrored from
the University of Aruba `island-research-reference-data` repository maintained by
the DCDC Network; coordinates are derived from Natural Earth [@naturalearth]
with a hand-curated supplement for the BES islands, the French overseas
departments, and other small territories. The package is deliberately narrow: it
bundles the data, exposes predicates and a joiner, and otherwise stays out of the
way, which makes it a dependency that composes with `countrycode` and the wider
tidyverse rather than competing with them. It supports reproducible,
FAIR-aligned workflows for economists, political scientists, and quantitative
island-studies researchers who currently maintain these lists by hand.

# Functionality

The exported surface is small by design:

- **Classification predicates.** `is_sids()`, `is_snij()`, and
  `is_small_island()` accept country names, ISO codes, or the hyphenated BES
  sub-codes and return a logical vector aligned with the input, resolving
  through the bundled data first and falling back to `countrycode` for the long
  tail of country names.
- **Tidy joining.** `island_lookup()` returns matching rows; `add_island_cols()`
  appends the classification columns onto a user data frame keyed on a
  name-or-code column.
- **Filtered subsets.** `small_islands()` returns subsets by SIDS status or by an
  arbitrary combination of the four defining criteria.
- **Geography.** `island_coords()` returns representative-point or capital-city
  coordinates; `island_distance()` returns great-circle (haversine) distances,
  either a symmetric matrix among one set of islands or element-wise distances
  between two, in kilometres, miles, or nautical miles, implemented in base R
  with no additional dependencies.

The package targets R (>= 4.1.0), imports only `countrycode`, and is documented
with a vignette, a `pkgdown` site, and a `testthat` suite.

# Acknowledgements

The `islands` reference dataset is the work of the Digital Competence Dutch
Caribbean (DCDC) Network at the University of Aruba, which funds and maintains
the upstream data. The naming of the `aruba()` convenience function is a homage
to Edward Cheung's A.R.U.B.A. unit on the Hubble Space Telescope.

# References
