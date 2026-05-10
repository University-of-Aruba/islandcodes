test_that("is_sids resolves names, ISO codes, and BES sub-codes", {
  expect_true(is_sids("Barbados"))
  expect_true(is_sids("BB"))
  expect_false(is_sids("Brazil"))

  # SNIJ that IS a SIDS associate member (Aruba)
  expect_true(is_sids("Aruba"))
  expect_true(is_sids("AW"))

  # SNIJ that is NOT a SIDS member (Bonaire)
  expect_false(is_sids("BQ-BO"))
})

test_that("is_snij flags Dutch Caribbean and other sub-national jurisdictions", {
  expect_true(is_snij("Aruba"))
  expect_true(is_snij("Curacao"))
  expect_true(is_snij("BQ-BO"))
  expect_true(is_snij("Aaland Islands") | is_snij("AX"))
  expect_false(is_snij("Brazil"))
})

test_that("is_small_island combines small and island criteria", {
  expect_true(is_small_island("Aruba"))
  expect_true(is_small_island("AW"))
  expect_false(is_small_island("Brazil"))
})

test_that("predicates return NA for unresolved input and preserve length", {
  out <- is_sids(c("Aruba", "Atlantis", "Brazil"))
  expect_length(out, 3)
  expect_true(is.na(out[2]))
  expect_true(out[1])
  expect_false(out[3])
})

test_that("country names route through countrycode for the long tail", {
  # countrycode resolves "USA" to "US"; US is not a SIDS
  expect_false(is_sids("USA"))
  expect_false(is_sids("United States"))
})
