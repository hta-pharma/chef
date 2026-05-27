# Load Debugging Session

Loads a previously staged debugging session from an RDS file created by
chef::with_stats_validation, setting up the environment to debug the
function call interactively.

## Usage

``` r
load_debug_session(debug_file)
```

## Arguments

- debug_file:

  The path to the RDS file containing the debugging environment.

## Value

None; this function is used for its side effects.
