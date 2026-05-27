# Build a pipeline from a template

Build a pipeline from a template

## Usage

``` r
use_chef(
  pipeline_dir = "pipeline/",
  r_functions_dir = "R/",
  pipeline_id,
  mk_endpoint_def_fn = NULL,
  mk_adam_fn = NULL,
  mk_criteria_fn = NULL,
  env = parent.frame()
)
```

## Arguments

- pipeline_dir:

  Character string ending with `/`. The directory where the targets
  pipeline scripts are to be stored. Keep in mind, wherever these
  pipeline scripts are stored, the targets cache files will also be
  stored (these cache files will not be under version control and thus
  only exist on your "machine").

- r_functions_dir:

  Character string ending with `/`. The directory where all the R
  scripts for the project are to be stored. This will include your
  `mk_adam_*()` and criterion functions for example, and any other
  functions that are used in the pipelines.

- pipeline_id:

  Character sting. Alphanumeric only

- mk_endpoint_def_fn:

  If you would like to use an existing `mk_endpoint_def_*()` function as
  the starting point for the pipeline, supply the unquoted function name
  here. This assumes there are no arguments to the function call and the
  functions have to be available from the global enironment (i.e if you
  type `my_fun()` into the console, it would find the function and try
  to run in)

- mk_adam_fn:

  List of functions used for making adam dataset. This is useful if you
  want to supply already existing functions. This must be a list, and
  each element must be an unquoted function name (e.g. `my_adam_fn`).
  The functions have to be available from the global enironment (i.e if
  you type `my_adam_fun()` into the console, it would find the function
  and try to run in). If no functions are supplied, then the default
  functions will be written. If you do not want any functions to be
  written, set `mk_adam_fn = NA`.

- mk_criteria_fn:

  List of functions used for making the criteria for endpoint/analysis
  inclusion. This is useful if you want to supply already existing
  functions that are not part of the chefcriterion package. This must be
  a list, and each element must be an unquoted function name (e.g.
  `my_criteria_fn`). The functions have to be available from the global
  environment (i.e if you type `my_criteria_fn()` into the console, it
  would find the function and try to run in).

- env:

  Environment.

## Value

Nothing, run for side effects.

## Details

Sets up the directory structure and helper files required for making a
chef analysis pipeline.

This function needs be run in the home directory of the project file
(such as the .Rproj) associated with the analysis project. If the
project file is located in a different directory, you will have to
manually set up the required files.
