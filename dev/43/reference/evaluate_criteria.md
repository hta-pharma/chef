# Evaluate criteria for inclusion of endpoints or endpoint strata

Evaluate criteria for inclusion of endpoints or endpoint strata

## Usage

``` r
evaluate_criteria(
  endpoints,
  adam_set,
  criteria_type = c("endpoint", "subgroup_description", "subgroup_analysis")
)
```

## Arguments

- endpoints:

  A data table with endpoint definitions.

- adam_set:

  A list of pre-processed ADaM tables.

- criteria_type:

  A string specifying the type of criteria. This can either be
  "endpoint", "subgroup_description" or "subgroup_analysis", which apply
  criteria on whether to include the endpoint, or by/across treatment
  and strata in the final submission.

## Value

A data table with endpoint definitions enriched with indications of
whether to keep the endpoint/strata or not.

## Examples

``` r
if (FALSE) { # \dontrun{
library(data.table)
library(pharmaverseadam)

# Define endpoints
endpoints <- data.table(
  endpoint_spec_id = 1:2,
  endpoint_label = c("Safety Events", "Efficacy Events"),
  crit_endpoint = list(NULL, NULL),
  key_analysis_data = "a"
)

# Prepare ADAM data in list format
adam_set <- list(
  adcm = as.data.table(pharmaverseadam::adcm),
  adae = as.data.table(pharmaverseadam::adae)
)

# evaluate_criteria is designed to run within a {targets} pipeline where
# criterion_wrapper is provided by the pipeline environment
result <- evaluate_criteria(
  endpoints = endpoints,
  adam_set = adam_set,
  criteria_type = "endpoint"
)
result[, .(endpoint_label, keep_endpoint)]
} # }
```
