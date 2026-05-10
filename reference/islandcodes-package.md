# Reference data and helpers for small island states and territories

Provides a curated reference list of countries and territories with
classifications for Small Island Developing States (SIDS), sub-national
island jurisdictions (SNIJ), World Bank region and income group, and
political association. Sub-sovereign cases such as Aruba, Curacao,
Bonaire, Sint Maarten, the French overseas territories, and Aaland
Islands are represented with disambiguating codes that standard
country-code packages often collapse or omit.

## Details

The package is deliberately small. It exposes:

- the bundled
  [`islands`](https://university-of-aruba.github.io/islandcodes/reference/islands.md)
  dataset,

- predicates
  [`is_sids`](https://university-of-aruba.github.io/islandcodes/reference/classify.md),
  [`is_snij`](https://university-of-aruba.github.io/islandcodes/reference/classify.md),
  [`is_small_island`](https://university-of-aruba.github.io/islandcodes/reference/classify.md),

- the joiner
  [`add_island_cols`](https://university-of-aruba.github.io/islandcodes/reference/add_island_cols.md),
  and

- the filter shorthand
  [`small_islands`](https://university-of-aruba.github.io/islandcodes/reference/small_islands.md).

It imports countrycode so country names entered by the user are coerced
to ISO codes before lookup. The intent is to extend rather than replace
countrycode: pass country names in, get small-island classifications
out.

## Source data

The bundled dataset is mirrored from
<https://github.com/University-of-Aruba/island-research-reference-data>
under CC BY 4.0. Run `citation("islandcodes")` for the canonical
references.

## Acknowledgments

With thanks to Edward Cheung, the Aruban engineer at NASA Goddard who
designed A.R.U.B.A. (the ASCS/NCS Relay Unit Breaker Assembly) installed
on the Hubble Space Telescope during the 2002 servicing mission. Cheung
engineered the backronym so children in his home country would have
something concrete to point to on the telescope. The
[`aruba`](https://university-of-aruba.github.io/islandcodes/reference/aruba.md)
function in this package is a small homage in the same style: A.R.U.B.A.
as Annotated Reference for Under-coded Border Areas.

## See also

Useful links:

- <https://github.com/University-of-Aruba/islandcodes>

- <https://university-of-aruba.github.io/islandcodes/>

- Report bugs at
  <https://github.com/University-of-Aruba/islandcodes/issues>

## Author

**Maintainer**: Rendell de Kort <rendell.dekort@ua.aw>
([ORCID](https://orcid.org/0000-0001-9598-9698))

Other contributors:

- University of Aruba (Digital Competence Dutch Caribbean (DCDC)
  Network) \[copyright holder, funder\]
