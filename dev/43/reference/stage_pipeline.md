# Stage a targets pipeline so that you can work interactively with it

To interact with a targets pipeline (e.g., run the pipeline, load the
completed targets from cache into memory), targets needs to know which
pipeline you want to work with. `This function` is a thin wrapper apound
a Sys.setenv() call, and depends on the \_targets.yaml file being set up
correctly (this happens automatically when you run use_pipeline() to set
up a new pipeline

## Usage

``` r
stage_pipeline(pipeline_id = NULL, pipeline_name = NULL)
```

## Arguments

- pipeline_id:

  A character string. Must not contain non-alphanumeric characters

- pipeline_name:

  Usually leave blank, only for special cases if you use a custom naming
  convention for your pipelines (not recommended). If used, leave
  `pipeline_id` blank and enter your custom pipeline name here.

## Value

Nothing, run for side effects
