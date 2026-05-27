# Try and Validate Wrapper for Statistical Functions

Attempts to execute a statistical function and validates its output. If
the function fails or the output is invalid, it provides meaningful
error messages and sets up a debugging environment.

## Usage

``` r
try_and_validate(
  expr_,
  expr_name = NA_character_,
  debug_dir = "debug",
  validator = function(expr_result) {
     NA_character_
 },
  stage_debugging = TRUE
)
```

## Arguments

- expr\_:

  The expression of type `call` to be evaluated, typically a call to a
  statistical function.

- expr_name:

  The name of the expression, used for debugging purposes.

- debug_dir:

  The directory where debugging information will be stored.

- validator:

  A function used to validate the output of the expression.

- stage_debugging:

  A flag indicating whether to stage debugging information in case of
  errors.

## Value

The result of the evaluated expression if successful and valid.
