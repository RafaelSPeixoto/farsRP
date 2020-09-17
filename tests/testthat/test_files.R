context("Files")

test_that("make_filename is writing the correct filename", {
  expect_equal(make_filename(2014), "accident_2014.csv.bz2")
  expect_equal(make_filename("2020"), "accident_2020.csv.bz2")
})

test_that("a warning is given when the file is missing", {
  year <- 0123
  warning_year <- paste0("invalid year: ", year)
  expect_warning(fars_read_years(c(0123)), warning_year)
  year <- "abcd"
  warning_year <- paste0("invalid year: ", year)
  expect_warning(fars_read_years(c("abcd")), warning_year)
})
