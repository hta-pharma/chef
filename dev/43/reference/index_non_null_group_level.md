# Index Non-Null Group Levels

Takes a list representing group levels and returns a new list with only
the non-null elements. It is used to filter out null values from a list
of group levels, which can be necessary when defining the expanded
endpoint specifications.

## Usage

``` r
index_non_null_group_level(x)
```

## Arguments

- x:

  A list representing group levels for endpoint grouping.

## Value

A list containing only the non-null elements from the input list.
