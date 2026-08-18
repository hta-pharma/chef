test_that("check_duplicate_functions handles empty directory correctly", {
  tmp <- withr::local_tempdir()
  withr::local_dir(tmp)
  dir.create("R")
  expect_null(check_duplicate_functions("R/"))
})

test_that(
  "check_duplicate_functions handles directory with no duplicate function names correctly",
  {
    tmp <- withr::local_tempdir()
    withr::local_dir(tmp)
    dir.create("R")
    write("f1 <- function(){}", "R/tmp.R")
    write("f2 <- function(){}", "R/tmp.R", append = TRUE)
    expect_null(check_duplicate_functions(dir = "R/"))
  }
)

test_that("check_duplicate_functions correctly identifies duplicate function names", {
  tmp <- withr::local_tempdir()
  withr::local_dir(tmp)
  dir.create("R")
  write("f1 <- function(){}", "R/tmp.R")
  write("f1 <- function(){}", "R/tmp.R", append = TRUE)
  expect_error(
    check_duplicate_functions("R/"), "The following functions"
  )
})

test_that("check_duplicate_functions handles non-existent directory correctly", {
  tmp <- withr::local_tempdir()
  withr::local_dir(tmp)
  expect_error(
    check_duplicate_functions("R_fun"),
    "Directory R_fun does not exist"
  )
})

test_that("check_duplicate_functions handles directory with non-R files correctly", {
  tmp <- withr::local_tempdir()
  withr::local_dir(tmp)
  dir.create("R")
  write("f1 <- function(){}", "R/tmp.R")
  write("f1 <- function(){}", "R/tmp.txt")
  expect_null(check_duplicate_functions("R"))
})

test_that("check_duplicate_functions handles directory with R files but no function definitions correctly", {
  tmp <- withr::local_tempdir()
  withr::local_dir(tmp)
  dir.create("R")
  write("f1 <- function(){}", "R/tmp.R")
  write("f1 <- 5", "R/tmp.R", append = TRUE)
  expect_null(check_duplicate_functions("R"))
})

test_that("check_duplicate_functions correctly identifies all duplicate function names", {
  tmp <- withr::local_tempdir()
  withr::local_dir(tmp)
  dir.create("R")
  write("f1 <- function(){}", "R/tmp.R")
  write("f1 <- function(){}", "R/tmp.R", append = TRUE)
  write("f2 <- function(){}", "R/tmp.R", append = TRUE)
  write("f2 <- function(){}", "R/tmp.R", append = TRUE)

  expect_error(
    check_duplicate_functions("R"),
    regexp = "-f2"
  )
})

test_that("check_duplicate_functions handles function definitions with different parameters but same name correctly", {
  tmp <- withr::local_tempdir()
  withr::local_dir(tmp)
  dir.create("R")
  write("f1 <- function(x){x}", "R/tmp.R")
  write("f1 <- function(y){y}", "R/tmp.R", append = TRUE)
  expect_error(
    check_duplicate_functions("R"),
    "f1"
  )
})


test_that("check_duplicate_functions treats functions with the same name but different case as distinct", {
  tmp <- withr::local_tempdir()
  withr::local_dir(tmp)
  dir.create("R")
  write("f1 <- function(x){x}", "R/tmp.R")
  write("F1 <- function(x){x}", "R/tmp.R", append = TRUE)
  expect_null(check_duplicate_functions("R"))
})
