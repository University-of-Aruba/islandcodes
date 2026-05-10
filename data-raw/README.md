# data-raw/

Reproducible build for the bundled `islands` dataset.

The canonical source is the [University of Aruba island-research-reference-data](https://github.com/University-of-Aruba/island-research-reference-data) repository, licensed CC BY 4.0. `DATASET.R` pulls the current CSV, normalises column types, and writes `data/islands.rda`.

To rebuild after the upstream CSV updates:

```r
source("data-raw/DATASET.R")
```

This directory is excluded from the built package via `.Rbuildignore`.
