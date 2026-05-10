test_that("island_lookup returns one row per input, NA for misses", {
  out <- island_lookup(c("Aruba", "Atlantis", "Brazil"))
  expect_equal(nrow(out), 3)
  expect_true(is.na(out$iso_code[2]))
  expect_equal(out$iso_code[1], "AW")
})

test_that("island_lookup `fields` filters columns and rejects bad names", {
  out <- island_lookup("Aruba", fields = c("name", "is_sids"))
  expect_named(out, c("name", "is_sids"))
  expect_error(island_lookup("Aruba", fields = "nonsense"), "Unknown field")
})

test_that("add_island_cols left-joins onto a data frame", {
  df <- data.frame(
    country = c("Aruba", "Curacao", "Bonaire", "Brazil"),
    gdp = c(3.5, 3.1, 0.5, 1900)
  )
  out <- add_island_cols(df, "country")
  expect_equal(nrow(out), 4)
  expect_true("is_sids" %in% names(out))
  # Aruba and Curacao are UN-DESA SIDS associate members; Bonaire is part
  # of the Netherlands proper and not a SIDS; Brazil is not a SIDS.
  expect_equal(out$is_sids, c(1L, 1L, 0L, 0L))
  expect_equal(out$is_snij, c(1L, 1L, 1L, 0L))
})

test_that("add_island_cols rejects missing column and unknown fields", {
  df <- data.frame(country = "Aruba")
  expect_error(add_island_cols(df, "missing"), "not found")
  expect_error(add_island_cols(df, "country", cols = "nope"), "Unknown column")
})

test_that("small_islands() filters by SIDS, SNIJ, and criteria", {
  expect_equal(nrow(small_islands(sids_only = TRUE)), 58)
  expect_equal(nrow(small_islands(snij_only = TRUE)), 47)

  # Sovereign small islands (SIDS members typically)
  out <- small_islands(criteria = c(small = TRUE, island = TRUE,
                                    sovereign = TRUE))
  expect_true(all(out$criterion_sovereign == 1))
  expect_true(all(out$criterion_island == 1))
})

test_that("small_islands rejects unknown criteria names", {
  expect_error(small_islands(criteria = c(badname = TRUE)),
               "Unknown `criteria`")
})

test_that("islands dataset has expected shape and key rows", {
  expect_equal(nrow(islands), 250)
  expected <- c("name", "iso_code", "is_sids", "is_snij")
  expect_true(all(expected %in% names(islands)))
  expect_true("AW" %in% islands$iso_code)
  expect_true("BQ-BO" %in% islands$iso_code)
  expect_true("CW" %in% islands$iso_code)
  expect_true("AX" %in% islands$iso_code)
})
