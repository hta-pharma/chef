# Make list of lists

Creates a nested list structure where the input elements are wrapped in
an outer list. This is useful for organizing function specifications in
analysis pipelines, particularly when using the targets framework.

## Usage

``` r
llist(...)
```

## Arguments

- ...:

  Elements to be included in the nested list

## Value

A list object containing a list where each element is defined by `...`

## Examples

``` r
# Create a nested list structure for endpoint statistics configurations
# Common use case: grouping multiple statistical functions by analysis level
stats_config <- llist(
  n_subjects = function(dat, ...) {
    data.table::data.table(
      label = "N",
      description = "Number of subjects",
      qualifiers = NA_character_,
      value = nrow(dat)
    )
  },
  mean_value = function(dat, var, ...) {
    data.table::data.table(
      label = "Mean",
      description = paste("Mean of", var),
      qualifiers = NA_character_,
      value = mean(dat[[var]], na.rm = TRUE)
    )
  }
)

# The structure enables targets to handle multiple analysis functions
str(stats_config)
#> List of 1
#>  $ :List of 2
#>   ..$ n_subjects:function (dat, ...)  
#>   ..$ mean_value:function (dat, var, ...)  
```
