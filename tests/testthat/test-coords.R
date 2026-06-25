test_that("island_coords returns one row per input in order, NA for misses", {
  out <- island_coords(c("Aruba", "Atlantis", "Brazil"))
  expect_equal(nrow(out), 3)
  expect_named(out, c("label", "iso_code", "latitude", "longitude"))
  expect_equal(out$iso_code[1], "AW")
  expect_true(is.na(out$latitude[2]))
  expect_true(is.numeric(out$latitude))
  # Aruba sits around 12.5 N, 70 W.
  expect_true(out$latitude[1] > 11 && out$latitude[1] < 14)
  expect_true(out$longitude[1] < -68 && out$longitude[1] > -71)
})

test_that("island_coords capital variant adds a capital column", {
  out <- island_coords(c("AW", "PF"), which = "capital")
  expect_named(out, c("label", "iso_code", "capital", "latitude", "longitude"))
  expect_equal(out$capital, c("Oranjestad", "Papeete"))
})

test_that("island_coords point and capital can differ", {
  pt  <- island_coords("French Polynesia")
  cap <- island_coords("French Polynesia", which = "capital")
  expect_false(isTRUE(all.equal(pt$latitude, cap$latitude)))
})

test_that("island_coords rejects an unknown `which`", {
  expect_error(island_coords("Aruba", which = "nonsense"))
})

test_that("territories without coordinates return NA, not an error", {
  # US Minor Outlying Islands has no representative point.
  expect_true(is.na(island_coords("UM")$latitude))
  # Antarctica has no capital.
  expect_true(is.na(island_coords("AQ", which = "capital")$latitude))
})
