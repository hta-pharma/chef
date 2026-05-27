# Run a targets pipeline

A wrapper for targets::tar_make() that ensures the correct pipeline is
run, and the correct cache location is used for that pipeline. Relies on
the \_targets.yaml file existing in the home directory of the project.

## Usage

``` r
run_pipeline(pipeline_id = NULL, pipeline_name = NULL)
```

## Arguments

- pipeline_id:

  A character string that will function as the pipeline ID. Must not
  contain non-alphanumeric characters

- pipeline_name:

  Usually leave blank, only for special cases if you use a custom naming
  convention for your pipelines (not recommended). If used, leave
  `pipeline_id` blank and enter your custom pipeline name here.

## Value

Nothing, run for side effects
