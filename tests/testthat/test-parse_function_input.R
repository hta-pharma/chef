test_that("parse function works with namesspace defined", {
  test_data <- rnorm(20, mean = 50, sd = 100)

  # Defining statistical functions of interest:
  # to be included in endpoints definition.

  stat_funcs <- list(
    mean,
    c(base::mean, trim = 0.4), # include arguments.
    max,
    min
  )
  stat_funcs_parsed <- lapply(stat_funcs, parse_function_input)
  expect_true(all(sapply(stat_funcs_parsed, is.function)))
  expect_true(inherits(stat_funcs_parsed[[2]], "purrr_function_partial"))
})

test_that("functions parsed can be excecuted", {
  withr::with_seed(123, {
    data <- rnbinom(n = 20, size = 2, prob = 0.1)
  })

  # Defining statistical functions of interest:
  # to be included in endpoints definition.

  stat_funcs <- list(
    mean,
    c(base::mean, trim = 0.4), # include arguments.
    max
  )
  fn_parsed <- lapply(stat_funcs, parse_function_input)
  # apply the functions
  out <- sapply(fn_parsed, function(fn) {
    fn(data)
  })
  expect_equal(out, c(14.1, 12.75, 36))
})
