# Add ID to user-defined endpoint groups

Adds a sequential identifier (`endpoint_spec_id`) to each row of an
endpoint definition table. These IDs track endpoint specifications
through the analysis pipeline and enable mapping of results back to
original endpoint definitions.

## Usage

``` r
add_id(ep)
```

## Arguments

- ep:

  A `data.table` containing endpoint definitions.

## Value

data.table with an additional `endpoint_spec_id` column containing
sequential integers starting from 1.

## Examples

``` r
library(data.table)

# Typical endpoint definition table from chef workflows
endpoints <- data.table(
  endpoint_label = c("Primary Efficacy", "Safety", "Tolerability"),
  analysis_type = c("efficacy", "adverse_event", "adverse_event"),
  custom_pop_filter = c("AGE >= 18", "SAFFL=='Y'", "SAFFL=='Y'")
)

# Add sequential IDs for tracking through analysis pipeline
endpoints_with_ids <- add_id(endpoints)

endpoints_with_ids
#>      endpoint_label analysis_type custom_pop_filter endpoint_spec_id
#>              <char>        <char>            <char>            <int>
#> 1: Primary Efficacy      efficacy         AGE >= 18                1
#> 2:           Safety adverse_event        SAFFL=='Y'                2
#> 3:     Tolerability adverse_event        SAFFL=='Y'                3

# The endpoint_spec_id column now uniquely identifies each endpoint
# and can be used to map statistical results back to endpoint definitions
```
