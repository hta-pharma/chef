% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/apply_criterion.R
\name{apply_criterion_by_strata}
\alias{apply_criterion_by_strata}
\title{Apply criterion by strata}
\usage{
apply_criterion_by_strata(
  ep,
  analysis_data_container,
  fn_map,
  type = c("by_strata_by_trt", "by_strata_across_trt")
)
}
\arguments{
\item{ep}{A \code{data.table} containing endpoint data with applied endpoint
criteria, typically the output from \code{apply_criterion_endpoint}.}

\item{analysis_data_container}{data.table containing the analysis data.}

\item{fn_map}{A \code{data.table} mapping endpoint definitions to by-strata
criteria functions.}

\item{type}{The type of criterion to apply, either
"by_strata_by_trt" or "by_strata_across_trt".}
}
\value{
A \code{data.table} with one row per stratum for each endpoint, with an
additional logical column indicating whether each row meets the criteria.
}
\description{
Applies by_strata_by_trt and by_strata_across_trt
functions to the endpoints data to determine eligibility for strata
statistics. It adds a logical column to the data indicating
whether each row meet the criteria.
}
