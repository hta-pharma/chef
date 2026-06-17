# Getting Started with chef

## Introduction

The [chef](https://hta-pharma.github.io/chef/) package provides a
framework for generating statistical evidence from clinical trial data.
It helps you define endpoints and automatically generate statistical
analyses using the [targets](https://docs.ropensci.org/targets/)
pipeline system, enabling reproducible and automated evidence generation
workflows.

[chef](https://hta-pharma.github.io/chef/) is particularly useful for
healthcare technology assessments (HTA) and regulatory submissions where
reproducibility and auditability are critical.

### Getting Started

#### Installation

You can install [chef](https://hta-pharma.github.io/chef/) from CRAN:

``` r

install.packages("chef")
```

Or the development version from GitHub:

``` r

# install.packages("devtools")
devtools::install_github("hta-pharma/chef")
```

#### Basic Workflow

The typical workflow with [chef](https://hta-pharma.github.io/chef/)
involves three main steps:

1.  **Setup your project** with
    [`use_chef()`](https://hta-pharma.github.io/chef/reference/use_chef.md)
2.  **Define your endpoints** in the configuration files
3.  **Run the pipeline** with
    [`run_pipeline()`](https://hta-pharma.github.io/chef/reference/run_pipeline.md)

#### Example: Setting Up a Chef Project

``` r

library(chef)

# Create a new chef project in your working directory
# This creates the necessary template files and directory structure
use_chef(
  path = "my_analysis",
  overwrite = FALSE
)
```

This creates: - `R/` directory for endpoint and function definitions -
`_targets.R` for the targets pipeline configuration - Template functions
for data preparation and statistical analysis - Example endpoint
definitions

#### Defining Endpoints

Endpoints are defined using the
[`define_expanded_ep()`](https://hta-pharma.github.io/chef/reference/define_expanded_ep.md)
function. Each endpoint specifies: - Endpoint name and label -
Population criteria (e.g., safety population) - Event filters and
grouping - Stratification variables - Statistical functions to apply

Example endpoint definition:

``` r

library(data.table)

# Define a simple endpoint
my_endpoints <- define_expanded_ep(
  endpoint_spec_id = 1,
  endpoint_label = "Primary Efficacy",
  pop_var = "SAFFL",
  pop_value = "Y",
  stratify_by = list(c("SEX")),
  treatment_var = "TRT01A"
)
```

#### Running the Pipeline

Once your endpoints and statistical functions are defined, run the
pipeline:

``` r

# Execute the full pipeline
run_pipeline(
  adam_list = list(adae = adae_data, adcm = adcm_data),
  endpoints = my_endpoints
)
```

This automatically: 1. Prepares your clinical data 2. Applies endpoint
criteria 3. Generates stratified analyses 4. Creates statistical outputs

### Key Functions

- [`use_chef()`](https://hta-pharma.github.io/chef/reference/use_chef.md) -
  Initialize a new chef project
- [`define_expanded_ep()`](https://hta-pharma.github.io/chef/reference/define_expanded_ep.md) -
  Define endpoint specifications
- [`expand_over_endpoints()`](https://hta-pharma.github.io/chef/reference/expand_over_endpoints.md) -
  Expand endpoints across stratification levels
- [`add_event_index()`](https://hta-pharma.github.io/chef/reference/add_event_index.md) -
  Map endpoint criteria to data rows
- [`apply_criterion_endpoint()`](https://hta-pharma.github.io/chef/reference/apply_criterion_endpoint.md) -
  Apply inclusion/exclusion criteria
- [`apply_stats()`](https://hta-pharma.github.io/chef/reference/apply_stats.md) -
  Apply statistical functions
- [`run_pipeline()`](https://hta-pharma.github.io/chef/reference/run_pipeline.md) -
  Execute the full analysis pipeline
- [`stage_pipeline()`](https://hta-pharma.github.io/chef/reference/stage_pipeline.md) -
  Prepare pipeline for execution

### Documentation and Examples

For more detailed information on specific functions, see the function
documentation:

``` r

?use_chef
?run_pipeline
?define_expanded_ep
```

### Further Resources

- GitHub: <https://github.com/hta-pharma/chef>
- Documentation: <https://hta-pharma.github.io/chef/>
- {targets} documentation: <https://books.ropensci.org/targets/>

### Contact and Support

For questions, bug reports, or feature requests, please visit:
<https://github.com/hta-pharma/chef/issues>
