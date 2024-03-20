expect_str_contains <- function(object, substring) {
  # Capture objet and label
  act <- quasi_label(rlang::enquo(object), arg = "object")

  # expect
  act$character <- as.character(object)
  expect(
    grepl(substring, act$character, fixed = T),
    sprintf("%s Does not contain the substring\n(%s)%s\n(sub)'%s'", act$lab, act$lab, act$character, substring)
  )
  invisible(act$character)
}

expect_na_or_null <- function(object) {
  # Capture objet and label
  act <- quasi_label(rlang::enquo(object), arg = "object")

  # expect
  expect(
    is.na(object) || is.null(object),
    sprintf("%s is not na/null: (%s)", act$lab, object)
  )
  invisible(object)
}

# Define a custom expect_ function
expect_same_items <- function(actual, expected, ...) {
  # Sort the lists before comparing them
  actual_sorted <- sort(actual)
  expected_sorted <- sort(expected)

  # Check if the sorted lists are identical
  if (!identical(actual_sorted, expected_sorted)) {
    # If the lists are not identical, find the differences
    actual_diff <- setdiff(actual_sorted, expected_sorted)
    expected_diff <- setdiff(expected_sorted, actual_sorted)

    # Create the error message with the differences highlighted
    exp_msg <- paste0(
      "Expected: (", paste(expected_sorted, collapse = ", "), ")",
      "\nFound: (", paste(actual_sorted, collapse = ", ")
    )
    if (length(actual_diff) > 0) {
      exp_msg <- paste(exp_msg, "\nExtra items in actual:", actual_diff)
    }
    if (length(expected_diff) > 0) {
      exp_msg <- paste(exp_msg, "\nMissing items in actual:", expected_diff)
    }

    # Fail the test with the custom error message
    testthat::expect(FALSE, failure_message = exp_msg, ...)
  }
  invisible(actual)
}
