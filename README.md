
<!-- README.md is generated from README.Rmd. Please edit that file -->

# chef

# Purpose

To provide an open-source opinionated framework for setting up pipelines
for AMNOG-style HTA analyses. {chef} is currently in a development
phase, so should be used with caution.

# Aim

The {chef} aim is that a programmer has to write minimal code, and no
programming to in order to set-up a new AMNOG-type analyses. For each
study, the programmer will need to make, adjust, or check the following
four types of code:

1.  The definition of each endpoint (or group of endpoints). See
    `vignette("endpoint_definitions")`
2.  A set of adam functions that makes any modifications to existing
    ADaM datasets (e.g., new age grouping in ADSL), or makes new ADaM
    datasets if none exist for the required output. See
    `vignette("mk_adam")`
3.  (If needed) Define a set of criteria for when an endpoint should be
    included in the results. A library of these criteria are stored in
    the companion package {chefCriteria}. See
    `vignette("criteria_functions")`
4.  A specification of the statistical functions used to
    summarize/analyze the data. (see section)

Behind the scenes, {chef} uses the
{[targets](https://books.ropensci.org/targets/)} package to handle the
pipelines.

# Setup

## Install githooks

    git config --local core.hooksPath .githooks/
