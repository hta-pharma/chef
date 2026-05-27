# Make an endpoint specification record

Make an endpoint specification record

## Usage

``` r
mk_endpoint_str(
  study_metadata = NULL,
  pop_var = NULL,
  pop_value = NULL,
  custom_pop_filter = NA_character_,
  treatment_var = NULL,
  treatment_refval = NULL,
  period_var = NA_character_,
  period_value = NA_character_,
  endpoint_filter = NA_character_,
  group_by = NA_character_,
  stratify_by = NULL,
  endpoint_label = NA_character_,
  data_prepare = NULL,
  stat_by_strata_by_trt = NULL,
  stat_by_strata_across_trt = NULL,
  stat_across_strata_across_trt = NULL,
  crit_endpoint = NULL,
  crit_by_strata_by_trt = NULL,
  crit_by_strata_across_trt = NULL,
  only_strata_with_events = FALSE,
  env = parent.frame()
)
```

## Arguments

- study_metadata:

  List. Metadata describing the clinical study.

- pop_var:

  Character.

- pop_value:

  Character.

- custom_pop_filter:

  Character.

- treatment_var:

  Character.

- treatment_refval:

  Character.

- period_var:

  Character.

- period_value:

  Character.

- endpoint_filter:

  Character.

- group_by:

  Character.

- stratify_by:

  List.

- endpoint_label:

  Character.

- data_prepare:

  List.

- stat_by_strata_by_trt:

  List.

- stat_by_strata_across_trt:

  List.

- stat_across_strata_across_trt:

  List.

- crit_endpoint:

  List.

- crit_by_strata_by_trt:

  List.

- crit_by_strata_across_trt:

  List.

- only_strata_with_events:

  Boolean.

- env:

  Environment.

## Value

A data.table containing the endpoint specification.
