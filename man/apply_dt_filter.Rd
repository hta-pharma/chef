% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filter_db_data.R
\name{apply_dt_filter}
\alias{apply_dt_filter}
\title{Apply filtering logic to a data.table}
\usage{
apply_dt_filter(adam_dt, filter_string, type = c("filter", "flag"))
}
\arguments{
\item{adam_dt}{A \code{data.table} object to which the filter will be applied.}

\item{filter_string}{A character string representing the filtering logic,
which will be evaluated within the \code{data.table}.}

\item{type}{A character string specifying the type of operation to perform:
"filter" to subset the data or "flag" to create a flag column.}
}
\value{
A \code{data.table} that has been filtered according to the specified
logic, or with an added flag column.
}
\description{
This utility function applies a specified filter to a \code{data.table}. The
filter can be applied to either subset the data (type = "filter") or to
create a new flag column within the data (type = "flag").
}
