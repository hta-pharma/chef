fun_dir <- "{{r_script_dir}}"

# Check that there are not multiple function definitions with the same name
chef::check_duplicate_functions(fun_dir)

## Load your R files
lapply(list.files(normalizePath(fun_dir), full.names = TRUE), source)

targets::tar_option_set(packages = c("chef", "data.table"), format = "qs")
list(
  targets::tar_target(ep,
                      mk_endpoint_def()
                      ),
  tarchetypes::tar_group_by(ep_id, add_id(ep), endpoint_spec_id),
  targets::tar_target(ep_fn_map,
                      unnest_endpoint_functions(data.table::as.data.table(ep_id)),
                      cue = targets::tar_cue(mode = "always"),
                      pattern = map(ep_id)),

  targets::tar_target(user_def_fn,
                      mk_userdef_fn_dt(ep_fn_map, env = environment()),
                      pattern = map(ep_fn_map)),

  targets::tar_target(fn_map,
                            merge(ep_fn_map[, .(endpoint_spec_id, fn_hash)],
                                  user_def_fn,
                                  by = c("fn_hash")),
                            pattern = map(ep_fn_map)),

  # targets::tar_target(fn_map, as.data.table(fn_map_), pattern = map(fn_map_)),
  targets::tar_target(
    study_data,
    fetch_db_data(study_metadata = ep_id$study_metadata[[1]], fn_dt = user_def_fn),
    cue = targets::tar_cue(mode = "always"),
    pattern=map(ep_id)
  ),

  targets::tar_target(ep_and_data,
                      filter_db_data(data.table::as.data.table(ep_id), ep_fn_map, study_data), pattern = map(ep_id)),

  targets::tar_target(ep_with_data_key, ep_and_data$ep),
  targets::tar_target(analysis_data_container, ep_and_data$analysis_data_container),

  targets::tar_target(ep_expanded, expand_over_endpoints(ep_with_data_key, analysis_data_container)),

  targets::tar_target(ep_event_index, add_event_index(ep_expanded, analysis_data_container)),

  targets::tar_target(
    ep_crit_endpoint,
    apply_criterion_endpoint(ep_event_index, analysis_data_container, fn_map)
  ),
  targets::tar_target(
    ep_crit_by_strata_by_trt,
    apply_criterion_by_strata(ep_crit_endpoint, analysis_data_container, fn_map)
  ),

  targets::tar_target(
    ep_crit_by_strata_across_trt,
    apply_criterion_by_strata(ep_crit_by_strata_by_trt, analysis_data_container, fn_map, type = "by_strata_across_trt")
  ),

  targets::tar_target(
    ep_prep_by_strata_by_trt,
    prepare_for_stats(ep_crit_by_strata_across_trt,
                      analysis_data_container,
                      fn_map,
                      type = "stat_by_strata_by_trt"),
    pattern = map(endpoint_spec_id)
  ),

  targets::tar_target(
    ep_prep_by_strata_across_trt,
    prepare_for_stats(ep_crit_by_strata_across_trt,
                      analysis_data_container,
                      fn_map,
                      type = "stat_by_strata_across_trt"),
    pattern = map(endpoint_spec_id)
  ),

  targets::tar_target(
    ep_prep_across_strata_across_trt,
    prepare_for_stats(ep_crit_by_strata_across_trt,
                      analysis_data_container,
                      fn_map,
                      type = "stat_across_strata_across_trt"),
    pattern = map(endpoint_spec_id)
  ),


  targets::tar_target(
    ep_stat_by_strata_by_trt,
    apply_stats(data.table::as.data.table(ep_prep_by_strata_by_trt), analysis_data_container, type = "stat_by_strata_by_trt"),
    pattern = map(ep_prep_by_strata_by_trt)
  ),

  targets::tar_target(
    ep_stat_by_strata_across_trt,
    apply_stats(data.table::as.data.table(ep_prep_by_strata_across_trt), analysis_data_container, type = "stat_by_strata_across_trt"),
    pattern = map(ep_prep_by_strata_across_trt)
  ),

  targets::tar_target(
    ep_stat_across_strata_across_trt,
    apply_stats(data.table::as.data.table(ep_prep_across_strata_across_trt), analysis_data_container, type = "stat_across_strata_across_trt"),
    pattern = map(ep_prep_across_strata_across_trt)
  ),

  targets::tar_target(
    ep_stat_nested,
    rbind(
      ep_stat_by_strata_by_trt,
      ep_stat_by_strata_across_trt,
      ep_stat_across_strata_across_trt
    )
  ),

  targets::tar_target(
    ep_stat,
    tidyr::unnest(ep_stat_nested, cols = stat_result, names_sep = "_") |>
      setDT()
  ),

  targets::tar_target(ep_rejected,
                      ep_crit_by_strata_across_trt[!(crit_accept_endpoint) |
                                                     !(crit_accept_by_strata_by_trt) |
                                                     !(crit_accept_by_strata_across_trt)])

)
