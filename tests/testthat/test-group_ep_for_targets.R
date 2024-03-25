test_that("grouping works for different values", {
  dt <- data.table(value = 1:50)
  actual <- group_ep_for_targets(dt, 10)
  expect_equal(unique(actual$targets_group), 0:4)
  actual <- group_ep_for_targets(dt, 25)
  expect_equal(unique(actual$targets_group), 0:1)
})
