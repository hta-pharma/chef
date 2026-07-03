# Parse functions supplied by user

This function takes a `data.table` containing user-supplied function
definitions and parses them into a structured format. The input
`data.table` is expected to have specific columns that include the
function type, the function itself, the name of the function, and a
unique hash for the function. The output is a list of `data.table`
objects, where each `data.table` corresponds to a unique function type
and contains detailed information about each function, including a
character representation and the callable function itself.

## Usage

``` r
mk_userdef_fn_dt(x, env = parent.frame())
```

## Arguments

- x:

  A `data.table` object representing the endpoint definition data model,
  which should contain the following columns:

  - fn_type: Character vector specifying the type of function.

  - fn: List of callables (length 1) representing the function to be
    called.

  - fn_name: Character vector with the name of the function.

  - fn_hash: Character vector with a unique hash for each function.

- env:

  The environment from which to evaluate the functions. The default is
  the parent frame from which the function is called.

## Value

A `data.table` with each row containing a parsed function definition.
The columns include:

- fn_type: Character vector with the type of function.

- fn_hash: Character vector with the unique hash of the function.

- fn_name: Character vector with the name of the function.

- fn_call_char: Character vector with the function call as a string.

- fn_callable: List of callables representing the parsed function.

## Examples

``` r
library(data.table)

# Create function table with user-defined functions
# (typically from endpoint definitions via unnest_endpoint_functions)
endpoint_fns <- data.table(
  endpoint_spec_id = c(1, 1, 2, 2),
  fn_type = c("data_prepare", "stat_by_strata_by_trt",
              "data_prepare", "stat_by_strata_by_trt"),
  fn = list(
    quote(function(study_metadata) NULL),
    quote(function(dat, ...) nrow(dat)),
    quote(function(study_metadata) NULL),
    quote(function(dat, ...) nrow(dat))
  ),
  fn_name = c("prep_fn", "n_subj", "prep_fn", "n_subj"),
  fn_hash = c("hash1", "hash2", "hash1", "hash2")
)

# Parse functions into callable format
fn_table <- mk_userdef_fn_dt(endpoint_fns)

# Result: unique functions by hash, deduplicated
nrow(fn_table)  # 2 (hash1, hash2)
#> [1] 2
fn_table[, .(fn_type, fn_name)]
#>                  fn_type fn_name
#>                   <char>  <char>
#> 1:          data_prepare prep_fn
#> 2: stat_by_strata_by_trt  n_subj

# fn_callable column contains executable functions
fn_table$fn_callable[[1]]  # Callable function
#> function (study_metadata) 
#> NULL
#> <environment: 0x56094fc4d468>
```
