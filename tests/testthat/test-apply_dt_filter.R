test_that('Applying filter works on low level',
 {
    # SETUP -------------------------------------------------------------------


    filter_str1 <- glue::glue("k2 == \"b\"")
    filter_str2 <- glue::glue("k2 == \"a\" & k1 >= 5")

    new_dt <- data.table::data.table(k1 = c(1, 2, 3, 4, 5),
                                     k2 = c("a", "a", "b", "b", "a"))

    # ACT ---------------------------------------------------------------------
    out1 <- apply_dt_filter(new_dt, filter_str1)
    out2 <- apply_dt_filter(new_dt, filter_str2)


    # EXPECT ------------------------------------------------------------------
    expect_setequal(out1$k1, c(3, 4))

    expect_setequal(out2$k1, c(5))

})


test_that('Applying flags works on low level',
{
  # SETUP -------------------------------------------------------------------
  filter_str1 <- glue::glue("k2 == \"b\"")
  filter_str2 <- glue::glue("k2 == \"a\" & k1 >= 5")

  new_dt <- data.table::data.table(k1 = c(1, 2, 3, 4, 5),
                                   k2 = c("a", "a", "b", "b", "a"))

  # ACT ---------------------------------------------------------------------
  out1 <- apply_dt_filter(new_dt, filter_str1, type = "flag")
  out2 <- apply_dt_filter(new_dt, filter_str2, type = "flag")

  # EXPECT ------------------------------------------------------------------
  expect_setequal(out1$event_flag, c(FALSE, FALSE, TRUE, TRUE, FALSE))
  expect_setequal(out2$event_flag, c(rep(FALSE, 5), TRUE))

})


test_that("Applying a simple filter works on adam level",
{
  # SETUP -------------------------------------------------------------------

  adam <- mk_adae()
  age_max = min(adam$AGE) + 2
  filter_str = glue::glue("AGE <={age_max}")

  # ACT ---------------------------------------------------------------------
  out <- apply_dt_filter(adam, filter_str)

  # EXPECT ------------------------------------------------------------------
  expect_lte(max(out$AGE), expected = age_max)

})
