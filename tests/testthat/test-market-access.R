test_that("market access is a named numeric vector, one per origin", {
  pop <- c(AW = 108, CW = 156, SX = 43)
  ma <- island_market_access(names(pop), pop)
  expect_type(ma, "double")
  expect_length(ma, 3L)
  expect_equal(names(ma), c("AW", "CW", "SX"))
  expect_true(all(ma > 0))
})

test_that("own mass is excluded unless `self` is supplied", {
  pop <- c(AW = 108, CW = 156, SX = 43)
  ma  <- island_market_access(names(pop), pop)
  mas <- island_market_access(names(pop), pop, self = 20)
  # Adding own mass at a finite internal distance must strictly raise access.
  expect_true(all(mas > ma))
  # And by exactly the analytic own-mass term.
  expect_equal(unname(mas - ma), unname(pop / 20), tolerance = 1e-10)
})

test_that("stronger decay shifts weight toward near neighbours", {
  # Bonaire is ~85 km from Curacao; Sint Maarten is ~900 km away.
  set <- c("BQ-BO", "CW", "SX")
  m   <- c("BQ-BO" = 25, CW = 156, SX = 43)
  share <- function(theta) {
    d <- island_distance("BQ-BO", c("CW", "SX"))
    w <- d^(-theta) * c(156, 43)
    unname(w[1] / sum(w))
  }
  expect_gt(share(2), share(1))
  # Sanity: the function itself agrees with the hand computation at theta = 1.
  hand <- sum(island_distance("BQ-BO", c("CW", "SX"))^(-1) * c(156, 43))
  expect_equal(unname(island_market_access(set, m)[["BQ-BO"]]), hand,
               tolerance = 1e-10)
})

test_that("named mass is order-free and may be a superset", {
  full <- c(SX = 43, CW = 156, AW = 108, BR = 215000)
  a <- island_market_access(c("AW", "CW", "SX"), full)
  b <- island_market_access(c("AW", "CW", "SX"), c(AW = 108, CW = 156, SX = 43))
  expect_equal(a, b)
})

test_that("`to` separates origins from destinations", {
  region <- c(US = 335000, CO = 52000)
  ma <- island_market_access(c("AW", "CW"), region, to = names(region))
  expect_length(ma, 2L)
  expect_true(all(is.finite(ma)))
})

test_that("unnamed mass must align with the destinations", {
  expect_error(island_market_access(c("AW", "CW"), c(1, 2, 3)),
               "one element per destination")
  expect_equal(
    unname(island_market_access(c("AW", "CW"), c(108, 156))),
    unname(island_market_access(c("AW", "CW"), c(AW = 108, CW = 156)))
  )
})

test_that("unresolved origins and coordinate-less territories give NA", {
  ma <- island_market_access(c("AW", "Zzzzland"),
                             c(AW = 108, CW = 156, SX = 43),
                             to = c("CW", "SX"))
  expect_true(is.na(ma[[2]]))
  expect_false(is.na(ma[[1]]))
})

test_that("theta and self are validated", {
  pop <- c(AW = 108, CW = 156)
  expect_error(island_market_access(names(pop), pop, theta = 0), "positive")
  expect_error(island_market_access(names(pop), pop, theta = c(1, 2)), "single")
  expect_error(island_market_access(names(pop), pop, self = -5), "positive")
  expect_error(island_market_access(names(pop), pop, self = "near"), "numeric")
  expect_error(island_market_access(names(pop), "big"), "numeric vector")
})

test_that("unit rescales levels but preserves the ranking", {
  pop <- c(AW = 108, CW = 156, SX = 43, "BQ-BO" = 25)
  km  <- island_market_access(names(pop), pop, unit = "km")
  nmi <- island_market_access(names(pop), pop, unit = "nmi")
  expect_false(isTRUE(all.equal(unname(km), unname(nmi))))
  expect_equal(order(km), order(nmi))
})
