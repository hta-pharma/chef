# Filter study data based on endpoint specifications

This function filters ADaM datasets according to the specifications for
each endpoint. It merges endpoint definitions with a mapping of
endpoints to function hashes and then with the actual ADaM datasets.
Custom filtering logic is applied to each dataset to produce the output
dataset.

## Usage

``` r
filter_db_data(ep, ep_fn_map, adam_db)
```

## Arguments

- ep:

  A `data.table` containing endpoint definitions.

- ep_fn_map:

  A `data.table` mapping endpoint definitions to function hashes and
  types.

- adam_db:

  A list of ADaM tables obtained from `fetch_db_data`.

## Value

A `data.table` with filtered datasets for each endpoint in the study.
