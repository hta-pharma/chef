test_that("Discordant columns in result data model", {
    # SETUP -------------------------------------------------------------------
    mk_endpoint_def <- function() {
        ep <- chef::mk_endpoint_str(
            study_metadata = list(),
            pop_var = "SAFFL",
            pop_value = "Y",
            treatment_var = "TRT01A",
            treatment_refval = "Xanomeline High Dose",
            stratify_by = list(c("SEX", "AGEGR1")),
            data_prepare = mk_adae,
            endpoint_label = "A",
            custom_pop_filter =
                "TRT01A %in% c('Placebo', 'Xanomeline High Dose')",
            group_by = list(list(
                AESOC = c(), AESEV = c()
            )),
            stat_by_strata_by_trt = list("E" = chefStats::n_event),
            stat_by_strata_across_trt = list(
                "RR" = chefStats::RR,
                "OR" = chefStats::OR
            ),
            stat_across_strata_across_trt = list("P-interaction" = chefStats::p_val_interaction)
        )
        ep2 <- chef::mk_endpoint_str(
            data_prepare = mk_advs,
            treatment_var = "TRT01A",
            treatment_refval = "Xanomeline High Dose",
            pop_var = "SAFFL",
            pop_value = "Y",
            stratify_by = list(c("AGEGR1", "SEX")),
            stat_by_strata_by_trt = list(chefStats::demographics_counts),
            endpoint_label = "Demographics endpoint (categorical measures)"
        )
        data.table::rbindlist(list(ep, ep2))
    }

    mk_advs <- function(study_metadata) {
        # Read ADSL
        adsl <- data.table::as.data.table(pharmaverseadam::adsl)

        # Filter treatment arms
        adsl <- adsl[adsl$TRT01A %in% c("Placebo", "Xanomeline High Dose")]
        adsl[1, AGEGR1 := NA_character_]
        adsl[2:10, SEX := NA_character_]

        # Read ADVS
        advs <- data.table::as.data.table(pharmaverseadam::advs)

        # Identify baseline body weight
        advs_bw <- advs[advs$PARAMCD == "WEIGHT" & advs$VISIT == "BASELINE"]

        # Create new variable BW_BASELINE
        advs_bw[["BW_BASELINE"]] <- advs_bw[["AVAL"]]

        # Merge ADSL, ADAE and baseline body weight from ADVS
        adam_out <-
            merge(adsl, advs_bw[, c("BW_BASELINE", "USUBJID")], by = "USUBJID", all.x = TRUE)

        return(adam_out)
    }


    # This is needed because mk_adcm it is calling from a new R session, it
    # doesn't have access to the helper-* functions from chef
    path <-
        system.file("templates", package = "chef") |>
        file.path("template-pipeline.R")
    tmp <- readLines(path)
    
    tar_dir({
        dir.create("R")
        dump("mk_adae", file = "R/mk_adae.R")
        dump("mk_advs", file = "R/mk_advs.R")
        dump("mk_endpoint_def", file = "R/mk_endpoint_def.R")

        x <-
            whisker::whisker.render(tmp, data = list(r_script_dir = "R/"))
        writeLines(whisker::whisker.render(tmp, data = list(
            r_script_dir =
                "R/"
        )), con = "_targets.R")
        #browser()
        tar_make()
        x <- tar_meta() |> data.table::setDT()
    })
})
