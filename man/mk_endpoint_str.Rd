% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mk_endpoint_str.R
\name{mk_endpoint_str}
\alias{mk_endpoint_str}
\title{Make an endpoint specification record}
\usage{
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
}
\arguments{
\item{study_metadata}{List. Metadata describing the clinical study.}

\item{pop_var}{Character.}

\item{pop_value}{Character.}

\item{custom_pop_filter}{Character.}

\item{treatment_var}{Character.}

\item{treatment_refval}{Character.}

\item{period_var}{Character.}

\item{period_value}{Character.}

\item{endpoint_filter}{Character.}

\item{group_by}{Character.}

\item{stratify_by}{List.}

\item{endpoint_label}{Character.}

\item{data_prepare}{List.}

\item{stat_by_strata_by_trt}{List.}

\item{stat_by_strata_across_trt}{List.}

\item{stat_across_strata_across_trt}{List.}

\item{crit_endpoint}{List.}

\item{crit_by_strata_by_trt}{List.}

\item{crit_by_strata_across_trt}{List.}

\item{only_strata_with_events}{Boolean.}

\item{env}{Environment.}
}
\value{
A data.table containing the endpoint specification.
}
\description{
Make an endpoint specification record
}
