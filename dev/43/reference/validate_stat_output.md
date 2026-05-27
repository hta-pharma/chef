# Validate Output from Statistical Functions

Validates the output of statistical functions to ensure it conforms to
expected structure. The expected structure includes specific column
names (`label`, `description`, `qualifiers`, `value`) and at least one
row. This validator is typically used with
[`try_and_validate()`](https://hta-pharma.github.io/chef/reference/try_and_validate.md)
to ensure statistical functions return correctly formatted results.

## Usage

``` r
validate_stat_output(output)
```

## Arguments

- output:

  The output from a statistical function.

## Value

An error message (character) if validation fails, otherwise
`NA_character_`. Use with
[`try_and_validate()`](https://hta-pharma.github.io/chef/reference/try_and_validate.md)
to automatically handle validation failures.

## Examples

``` r
library(data.table)

# Valid statistical output - correctly formatted
valid_stats <- data.table(
  label = c("N", "n_events", "Rate"),
  description = c(
    "Number of subjects",
    "Number with adverse events",
    "Percentage with events"
  ),
  qualifiers = NA_character_,
  value = c(250L, 45L, 18.0)
)

# Validation passes
validate_stat_output(valid_stats)  # Returns NA_character_
#> [1] NA

# Invalid: wrong class (must be data.table)
invalid_vector <- c(N = 250, events = 45)
validate_stat_output(invalid_vector)  # Returns error message
#> [1] "Expected (data.table::data.table). Found: numeric"

# Invalid: missing required columns
incomplete_stats <- data.table(
  label = c("N", "Rate"),
  value = c(250L, 18.0)
)
validate_stat_output(incomplete_stats)  # Shows missing columns
#> [1] "Expected columns: ( description, label, qualifiers, value )\nFound columns: ( label, value )\n\tMissing items in actual: ( description, qualifiers )"

# Invalid: empty result (0 rows)
empty_stats <- data.table(
  label = character(),
  description = character(),
  qualifiers = character(),
  value = numeric()
)
validate_stat_output(empty_stats)  # Error: 0 rows returned
#> [1] "The statistical function returned a data.table with 0 rows"
```
