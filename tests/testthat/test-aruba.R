test_that("aruba() defaults to Aruba and matches island_lookup", {
  expect_equal(
    suppressMessages(aruba(quiet = TRUE)),
    island_lookup("Aruba")
  )
})

test_that("aruba(x) delegates to island_lookup for any input", {
  expect_equal(aruba("Curacao", quiet = TRUE), island_lookup("Curacao"))
  expect_equal(
    aruba(c("AW", "BQ-BO", "CW"), quiet = TRUE),
    island_lookup(c("AW", "BQ-BO", "CW"))
  )
})

test_that("aruba() respects the quiet option", {
  expect_silent(aruba(quiet = TRUE))

  withr_with_option <- function(opts, code) {
    old <- options(opts)
    on.exit(options(old))
    code
  }
  withr_with_option(
    list(islandcodes.aruba.quiet = TRUE),
    expect_silent(aruba())
  )
})
