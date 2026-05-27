# Apply filtering logic to a data.table

This utility function applies a specified filter to a `data.table`. The
filter can be applied to either subset the data (type = "filter") or to
create a new flag column within the data (type = "flag").

## Usage

``` r
apply_dt_filter(adam_dt, filter_string, type = c("filter", "flag"))
```

## Arguments

- adam_dt:

  A `data.table` object to which the filter will be applied.

- filter_string:

  A character string representing the filtering logic, which will be
  evaluated within the `data.table`.

- type:

  A character string specifying the type of operation to perform:
  "filter" to subset the data or "flag" to create a flag column.

## Value

A `data.table` that has been filtered according to the specified logic,
or with an added flag column.
