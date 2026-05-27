# Generate a row for the function table

This helper function is used within `mk_userdef_fn_dt` to process each
unique function definition in the input `data.table` and create a new
row with the parsed function information. It handles null functions by
creating empty entries and for non-null functions creates a character
representation and a callable function.

## Usage

``` r
generate_function_table_row(fn_type, fn, fn_name, fn_hash, env)
```

## Arguments

- fn_type:

  The type of the function as a character string.

- fn:

  A list containing the function to be called.

- fn_name:

  The name of the function as a character string.

- fn_hash:

  The unique hash of the function as a character string.

- env:

  The environment in which to evaluate the function.

## Value

A `data.table` row with the function's details.
