# Define Expanded Endpoint Specifications

Takes a dataset and an endpoint group specification, and it defines the
expanded endpoint specifications. It creates metadata and filter strings
for each endpoint group, which are used to subset the data accordingly.
The function ensures that each endpoint group has the necessary
information for further analysis.

## Usage

``` r
define_expanded_ep(
  x,
  group_by,
  forced_group_levels = NULL,
  col_prefix = "endpoint_group"
)
```

## Arguments

- x:

  A `data.table` containing the data associated with the endpoints.

- group_by:

  A list specifying the grouping for endpoints, where each element
  corresponds to a variable used for grouping endpoints and contains the
  levels for that grouping variable.

- forced_group_levels:

  data.table (optional). Table with group levels that must be included
  in the expansion, regardless of `group_by`.

- col_prefix:

  A prefix used to create the names of the metadata and filter columns
  in the output `data.table`. Defaults to "endpoint_group".

## Value

A `data.table` with additional columns for metadata and filter
conditions for each endpoint group. If the endpoint group is empty or
consists only of `NA` values, the function returns `NA`.

## Examples

``` r
library(data.table)
library(pharmaverseadam)

# Load sample data and add INDEX_ column
adcm <- as.data.table(pharmaverseadam::adcm)
adcm <- adcm[!is.na(CMCLAS)][1:50]  # Subset for brevity

# Define grouping: expand endpoint by therapeutic class
group_by <- list(CMCLAS = unique(adcm$CMCLAS))

# Generate expanded endpoint specifications
expanded <- define_expanded_ep(x = adcm, group_by = group_by)

# View structure: each row = one group level
expanded
#>    endpoint_group_metadata                             endpoint_group_filter
#>                     <list>                                            <char>
#> 1:               <list[1]> CMCLAS == "SYSTEMIC HORMONAL PREPARATIONS, EXCL."
#> 2:               <list[1]>                               CMCLAS == "UNCODED"
# Note: endpoint_group_metadata contains the group values
# endpoint_group_filter contains the filter string (e.g., 'CMCLAS == "NERVOUS SYSTEM"')
```
