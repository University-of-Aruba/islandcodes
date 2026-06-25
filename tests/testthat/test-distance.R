test_that("island_distance returns a symmetric matrix when y is NULL", {
  m <- island_distance(c("AW", "CW", "SX"))
  expect_true(is.matrix(m))
  expect_equal(dim(m), c(3, 3))
  expect_equal(rownames(m), c("AW", "CW", "SX"))
  expect_equal(diag(m), c(AW = 0, CW = 0, SX = 0))
  expect_equal(m[1, 2], m[2, 1])           # symmetric
})

test_that("island_distance computes a sensible known distance", {
  # Aruba to Curacao is roughly 120 km between landmass points.
  d <- island_distance("AW", "CW")
  expect_true(d > 100 && d < 150)
})

test_that("island_distance recycles a single origin against many", {
  d <- island_distance("Aruba", c("Curacao", "Bonaire", "Sint Maarten"))
  expect_length(d, 3)
  expect_named(d, c("CW", "BQ-BO", "SX"))
  # Sint Maarten (SSS) is much farther than Curacao (ABC).
  expect_true(d[["SX"]] > d[["CW"]])
})

test_that("island_distance honours unit", {
  km  <- island_distance("AW", "CW", unit = "km")
  mi  <- island_distance("AW", "CW", unit = "mi")
  nmi <- island_distance("AW", "CW", unit = "nmi")
  expect_equal(mi,  km * 0.621371, tolerance = 1e-6)
  expect_equal(nmi, km * 0.539957, tolerance = 1e-6)
})

test_that("island_distance point and capital differ for dispersed cases", {
  pt  <- island_distance("French Polynesia", "AW")
  cap <- island_distance("French Polynesia", "AW", which = "capital")
  expect_false(isTRUE(all.equal(unname(pt), unname(cap))))
})

test_that("island_distance propagates NA for misses and coordinate-less rows", {
  expect_true(is.na(island_distance("Atlantis", "AW")))
  # US Minor Outlying Islands has no representative point.
  expect_true(is.na(island_distance("UM", "AW")))
})

test_that("island_distance rejects bad which/unit", {
  expect_error(island_distance("AW", "CW", which = "nope"))
  expect_error(island_distance("AW", "CW", unit = "furlong"))
})
