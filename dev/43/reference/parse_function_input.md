# Parse function inputs

This function processes a list representing a function input. If the
function is supplied with an argument, the argument should be specified
in the form `list(c(fun, arg=x))`. The function returns the input
function unchanged if no arguments are provided or wraps the function
with its arguments using
[`purrr::partial`](https://purrr.tidyverse.org/reference/partial.html)
if arguments are present.

## Usage

``` r
parse_function_input(fn_input)
```

## Arguments

- fn_input:

  A list representing the function input, which may contain a function
  and its arguments.

## Value

A function with arguments wrapped using
[`purrr::partial`](https://purrr.tidyverse.org/reference/partial.html)
if arguments are provided; otherwise, returns the function unchanged.
