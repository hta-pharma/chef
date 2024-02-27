test_that("constructing filter logic works accross different flags", {
  ep <-
    data.table(
      pop_var = "A",
      pop_value = "TT",
      period_var = "period",
      period_value = "F",
      treatment_var = "TRT",
      treatment_refval = "B",
      endpoint_filter = ""
    )

  actual1 <-
    construct_data_filter_logic(var_value_pairs = list(
      c(ep$pop_var[[1]], ep$pop_value[[1]]),
      c(ep$period_var[[1]], ep$period_value[[1]])
    ))
  expect_equal(actual1, "A==\"TT\" & period==\"F\"")
  actual2 <- construct_data_filter_logic(list(
    c(ep$pop_var[[1]], ep$pop_value[[1]]),
    c(ep$treatment_var[[1]], ep$treatment_refval[[1]]),
    c(ep$period_var[[1]], ep$period_value[[1]])
  ))
  expect_equal(actual2, "A==\"TT\" & TRT==\"B\" & period==\"F\"")
})



test_that("constructing filter logic works with non-paired filters (singletons)", {
  ep <-
    data.table(
      pop_var = "A",
      pop_value = "TT",
      period_var = "period",
      period_value = "F",
      treatment_var = "TRT",
      treatment_refval = "B",
      endpoint_filter = "AGE < 50"
    )

  actual1 <-
    construct_data_filter_logic(list(
      c(ep$pop_var[[1]], ep$pop_value[[1]]),
      c(ep$period_var[[1]], ep$period_value[[1]])
    ),singletons = ep$endpoint_filter[[1]]
    )
  expect_equal(actual1, "A==\"TT\" & period==\"F\" & AGE < 50")

})
