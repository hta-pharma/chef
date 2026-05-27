# Expand endpoint definitions

This function takes endpoint definitions and expands them based on
endpoint groups. Each row in the output corresponds to a single table or
figure list (TFL) definition, ensuring that each TFL has a unique
definition. The expansion is done by merging the endpoint definitions
with a mapping table that links these definitions to user-defined
functions, which are then applied to the pre-processed ADaM datasets to
create the expanded endpoints.

## Usage

``` r
expand_over_endpoints(ep, analysis_data_container)
```

## Arguments

- ep:

  A `data.table` containing endpoint definitions, where each row
  corresponds to a different endpoint and contains relevant attributes
  such as the endpoint name, type, and criteria.

- analysis_data_container:

  data.table containing the analysis data.

## Value

A `data.table` where each row corresponds to an expanded endpoint
definition

## Examples

``` r
library(data.table)
library(pharmaverseadam)

# Prepare ADCM data
adcm <- as.data.table(pharmaverseadam::adcm)[!is.na(CMCLAS)]
cmclas_vals <- unique(adcm$CMCLAS)

# Create endpoint definition expanding by therapeutic class
endpoint_def <- data.table(
  endpoint_spec_id = 1L,
  endpoint_label = "Concomitant Medications: <CMCLAS>",
  pop_var = "SAFFL",
  pop_value = "Y",
  period_var = NA_character_,
  period_value = NA_character_,
  treatment_var = "TRT01A",
  treatment_refval = "Xanomeline High Dose",
  endpoint_filter = NA_character_,
  custom_pop_filter = NA_character_,
  stratify_by = list(list()),
  group_by = list(list(CMCLAS = cmclas_vals)),
  key_analysis_data = "a"
)

# Create analysis data container
analysis_data <- data.table(dat = list(adcm), key_analysis_data = "a")
setkey(analysis_data, key_analysis_data)
setkey(endpoint_def, key_analysis_data)

# Expand: 1 row becomes one row per unique CMCLAS value
expanded_ep <- expand_over_endpoints(
  ep = endpoint_def,
  analysis_data_container = analysis_data
)
nrow(expanded_ep)
#> [1] 10
expanded_ep[, .(endpoint_id, endpoint_label, endpoint_group_filter)]
#>     endpoint_id
#>          <char>
#>  1:      1-0001
#>  2:      1-0002
#>  3:      1-0003
#>  4:      1-0004
#>  5:      1-0005
#>  6:      1-0006
#>  7:      1-0007
#>  8:      1-0008
#>  9:      1-0009
#> 10:      1-0010
#>                                                          endpoint_label
#>                                                                  <char>
#>  1:      Concomitant Medications: SYSTEMIC HORMONAL PREPARATIONS, EXCL.
#>  2:                                    Concomitant Medications: UNCODED
#>  3:                             Concomitant Medications: NERVOUS SYSTEM
#>  4:                         Concomitant Medications: RESPIRATORY SYSTEM
#>  5:                      Concomitant Medications: CARDIOVASCULAR SYSTEM
#>  6:     Concomitant Medications: GENITO URINARY SYSTEM AND SEX HORMONES
#>  7: Concomitant Medications: ANTINEOPLASTIC AND IMMUNOMODULATING AGENTS
#>  8:            Concomitant Medications: ALIMENTARY TRACT AND METABOLISM
#>  9:                            Concomitant Medications: DERMATOLOGICALS
#> 10:             Concomitant Medications: BLOOD AND BLOOD FORMING ORGANS
#>                                      endpoint_group_filter
#>                                                     <char>
#>  1:      CMCLAS == "SYSTEMIC HORMONAL PREPARATIONS, EXCL."
#>  2:                                    CMCLAS == "UNCODED"
#>  3:                             CMCLAS == "NERVOUS SYSTEM"
#>  4:                         CMCLAS == "RESPIRATORY SYSTEM"
#>  5:                      CMCLAS == "CARDIOVASCULAR SYSTEM"
#>  6:     CMCLAS == "GENITO URINARY SYSTEM AND SEX HORMONES"
#>  7: CMCLAS == "ANTINEOPLASTIC AND IMMUNOMODULATING AGENTS"
#>  8:            CMCLAS == "ALIMENTARY TRACT AND METABOLISM"
#>  9:                            CMCLAS == "DERMATOLOGICALS"
#> 10:             CMCLAS == "BLOOD AND BLOOD FORMING ORGANS"
```
