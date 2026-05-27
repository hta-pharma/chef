# Check for duplicate function definitions

Scans a directory for R files and identifies any function definitions
that appear multiple times (by name). This is useful in endpoint
analysis pipelines to prevent accidental function redefinitions that
could cause unexpected behavior. The check is case-sensitive (i.e.,
`func_name` and `Func_name` are considered distinct).

## Usage

``` r
check_duplicate_functions(dir)
```

## Arguments

- dir:

  The directory where the custom functions are defined

## Value

Run for side-effects. Returns `NULL` invisibly if no duplicates are
found. If duplicate functions are detected, an error is thrown with
details about which functions are duplicated.

## Examples

``` r
if (FALSE) { # \dontrun{
  # Create a temporary directory for demonstration
  tmp_dir <- tempdir()

  # Valid case: no duplicate function names
  writeLines("
    compute_n_subjects <- function(dat, ...) {
      nrow(dat)
    }
  ", file.path(tmp_dir, "stat_functions_1.R"))

  writeLines("
    compute_event_rate <- function(dat, ...) {
      sum(dat$is_event) / nrow(dat)
    }
  ", file.path(tmp_dir, "stat_functions_2.R"))

  # Check passes - no duplicates found
  check_duplicate_functions(tmp_dir)

  # Invalid case: duplicate function names cause error
  writeLines("
    compute_n_subjects <- function(dat, ...) {
      sum(!is.na(dat$id))  # Different implementation
    }
  ", file.path(tmp_dir, "stat_functions_2.R"))

  # This will error with message about "compute_n_subjects" being duplicated
  check_duplicate_functions(tmp_dir)
} # }
```
