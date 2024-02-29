
<!-- Insert badges here -->

[![R-CMD-check](https://github.com/hta-pharma/chef/actions/workflows/package-check-test.yaml/badge.svg)](https://github.com/hta-pharma/chef/actions/workflows/package-check-test.yaml)
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

This project supports two styles of githooks.

1.  The first style is to use the githooks provided in the `.githooks`
    directory. To use these hooks, run the following command in the root
    of the project:

- These hooks are very simple just blocking the commit to protected
  branches.

<!-- -->

    git config --local core.hooksPath .githooks/

2.  The second is to install the precommit tool (for linux)
    [precommit](https://pre-commit.com/).

- These are much more powerful and can be used to run checks on the code
  before it is committed.

<!-- -->

    pipx install pre-commit
    # Then run in the root of repo:
    pre-commit install
