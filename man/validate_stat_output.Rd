% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/try_and_validate.R
\name{validate_stat_output}
\alias{validate_stat_output}
\title{Validate Output from Statistical Functions}
\usage{
validate_stat_output(output)
}
\arguments{
\item{output}{The output from a statistical function.}
}
\value{
An error message if validation fails, otherwise NA.
}
\description{
Validates the output of statistical functions to ensure it
conforms to expected structure. The expected structure includes specific
column names and non-empty results.
}
