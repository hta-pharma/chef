# Add Event Index to Expanded Endpoints

This function adds an event index to each row of the expanded endpoints
`data.table`. The event index is created based on variable-value pairs
and singleton conditions that define specific events of interest within
the dataset. This index can be used to identify events in the
user-supplied criteria and/or statistical functions

## Usage

``` r
add_event_index(ep, analysis_data_container)
```

## Arguments

- ep:

  A `data.table` that contains expanded endpoint definitions, typically
  the output from `expand_over_endpoints`. It assumes the inclusion of
  the columns `pop_var`, `pop_value`, `period_var`, `period_value`,
  `endpoint_filter`, `endpoint_group_filter`, and `custom_pop_filter`,
  which are used to define the conditions for event indexing.

- analysis_data_container:

  A data.table containing the analysis data.

## Value

A `data.table` similar to the input but with an additional `event_index`
column, which contains the indices of events as determined by the
specified conditions for each endpoint. The indices refer to the
`INDEX_` column in the clinical data. This `INDEX_` column is created by
chef when a user supplies a clinical dataset.

## Examples

``` r
library(data.table)
#> 
#> Attaching package: ‘data.table’
#> The following object is masked from ‘package:base’:
#> 
#>     %notin%
library(pharmaverseadam)

# Prepare clinical data with INDEX_ column
adcm_data <- as.data.table(pharmaverseadam::adcm)
adcm_data[, INDEX_ := .I]
#>            STUDYID     USUBJID SUBJID SITEID COUNTRY DOMAIN    RFSTDTC
#>             <char>      <char> <char> <char>  <char> <char>     <char>
#>    1: CDISCPILOT01 01-701-1015   1015    701     USA     CM 2014-01-02
#>    2: CDISCPILOT01 01-701-1015   1015    701     USA     CM 2014-01-02
#>    3: CDISCPILOT01 01-701-1015   1015    701     USA     CM 2014-01-02
#>    4: CDISCPILOT01 01-701-1015   1015    701     USA     CM 2014-01-02
#>    5: CDISCPILOT01 01-701-1015   1015    701     USA     CM 2014-01-02
#>   ---                                                                 
#> 7506: CDISCPILOT01 01-718-1427   1427    718     USA     CM 2012-12-17
#> 7507: CDISCPILOT01 01-718-1427   1427    718     USA     CM 2012-12-17
#> 7508: CDISCPILOT01 01-718-1427   1427    718     USA     CM 2012-12-17
#> 7509: CDISCPILOT01 01-718-1427   1427    718     USA     CM 2012-12-17
#> 7510: CDISCPILOT01 01-718-1427   1427    718     USA     CM 2012-12-17
#>          RFENDTC   RFXSTDTC   RFXENDTC         RFPENDTC SCRFDT      FRVDT
#>           <char>     <char>     <char>           <char> <Date>     <Date>
#>    1: 2014-07-02 2014-01-02 2014-07-02 2014-07-02T11:45   <NA>       <NA>
#>    2: 2014-07-02 2014-01-02 2014-07-02 2014-07-02T11:45   <NA>       <NA>
#>    3: 2014-07-02 2014-01-02 2014-07-02 2014-07-02T11:45   <NA>       <NA>
#>    4: 2014-07-02 2014-01-02 2014-07-02 2014-07-02T11:45   <NA>       <NA>
#>    5: 2014-07-02 2014-01-02 2014-07-02 2014-07-02T11:45   <NA>       <NA>
#>   ---                                                                    
#> 7506: 2013-02-18 2012-12-17 2013-02-11       2013-06-03   <NA> 2013-06-03
#> 7507: 2013-02-18 2012-12-17 2013-02-11       2013-06-03   <NA> 2013-06-03
#> 7508: 2013-02-18 2012-12-17 2013-02-11       2013-06-03   <NA> 2013-06-03
#> 7509: 2013-02-18 2012-12-17 2013-02-11       2013-06-03   <NA> 2013-06-03
#> 7510: 2013-02-18 2012-12-17 2013-02-11       2013-06-03   <NA> 2013-06-03
#>       DTHDTC DTHADY  DTHFL LDDTHELD LDDTHGR1 DTH30FL DTHA30FL DTHDOM DTHB30FL
#>       <char>  <num> <char>    <num>   <char>  <char>   <char> <char>   <char>
#>    1:   <NA>     NA   <NA>       NA     <NA>    <NA>     <NA>   <NA>     <NA>
#>    2:   <NA>     NA   <NA>       NA     <NA>    <NA>     <NA>   <NA>     <NA>
#>    3:   <NA>     NA   <NA>       NA     <NA>    <NA>     <NA>   <NA>     <NA>
#>    4:   <NA>     NA   <NA>       NA     <NA>    <NA>     <NA>   <NA>     <NA>
#>    5:   <NA>     NA   <NA>       NA     <NA>    <NA>     <NA>   <NA>     <NA>
#>   ---                                                                        
#> 7506:   <NA>     NA   <NA>       NA     <NA>    <NA>     <NA>   <NA>     <NA>
#> 7507:   <NA>     NA   <NA>       NA     <NA>    <NA>     <NA>   <NA>     <NA>
#> 7508:   <NA>     NA   <NA>       NA     <NA>    <NA>     <NA>   <NA>     <NA>
#> 7509:   <NA>     NA   <NA>       NA     <NA>    <NA>     <NA>   <NA>     <NA>
#> 7510:   <NA>     NA   <NA>       NA     <NA>    <NA>     <NA>   <NA>     <NA>
#>       REGION1      DMDTC  DMDY   AGE   AGEU AGEGR1    SEX
#>        <char>     <char> <num> <num> <char> <char> <char>
#>    1:      NA 2013-12-26    -7    63  YEARS  18-64      F
#>    2:      NA 2013-12-26    -7    63  YEARS  18-64      F
#>    3:      NA 2013-12-26    -7    63  YEARS  18-64      F
#>    4:      NA 2013-12-26    -7    63  YEARS  18-64      F
#>    5:      NA 2013-12-26    -7    63  YEARS  18-64      F
#>   ---                                                    
#> 7506:      NA 2012-12-13    -4    74  YEARS    >64      F
#> 7507:      NA 2012-12-13    -4    74  YEARS    >64      F
#> 7508:      NA 2012-12-13    -4    74  YEARS    >64      F
#> 7509:      NA 2012-12-13    -4    74  YEARS    >64      F
#> 7510:      NA 2012-12-13    -4    74  YEARS    >64      F
#>                            RACE   RACEGR1                 ETHNIC  SAFFL
#>                          <char>    <char>                 <char> <char>
#>    1:                     WHITE     White     HISPANIC OR LATINO      Y
#>    2:                     WHITE     White     HISPANIC OR LATINO      Y
#>    3:                     WHITE     White     HISPANIC OR LATINO      Y
#>    4:                     WHITE     White     HISPANIC OR LATINO      Y
#>    5:                     WHITE     White     HISPANIC OR LATINO      Y
#>   ---                                                                  
#> 7506: BLACK OR AFRICAN AMERICAN Non-white NOT HISPANIC OR LATINO      Y
#> 7507: BLACK OR AFRICAN AMERICAN Non-white NOT HISPANIC OR LATINO      Y
#> 7508: BLACK OR AFRICAN AMERICAN Non-white NOT HISPANIC OR LATINO      Y
#> 7509: BLACK OR AFRICAN AMERICAN Non-white NOT HISPANIC OR LATINO      Y
#> 7510: BLACK OR AFRICAN AMERICAN Non-white NOT HISPANIC OR LATINO      Y
#>                        ARM  ARMCD               ACTARM ACTARMCD
#>                     <char> <char>               <char>   <char>
#>    1:              Placebo    Pbo              Placebo      Pbo
#>    2:              Placebo    Pbo              Placebo      Pbo
#>    3:              Placebo    Pbo              Placebo      Pbo
#>    4:              Placebo    Pbo              Placebo      Pbo
#>    5:              Placebo    Pbo              Placebo      Pbo
#>   ---                                                          
#> 7506: Xanomeline High Dose Xan_Hi Xanomeline High Dose   Xan_Hi
#> 7507: Xanomeline High Dose Xan_Hi Xanomeline High Dose   Xan_Hi
#> 7508: Xanomeline High Dose Xan_Hi Xanomeline High Dose   Xan_Hi
#> 7509: Xanomeline High Dose Xan_Hi Xanomeline High Dose   Xan_Hi
#> 7510: Xanomeline High Dose Xan_Hi Xanomeline High Dose   Xan_Hi
#>                       TRTP                 TRTA               TRT01P
#>                     <char>               <char>               <char>
#>    1:              Placebo              Placebo              Placebo
#>    2:              Placebo              Placebo              Placebo
#>    3:              Placebo              Placebo              Placebo
#>    4:              Placebo              Placebo              Placebo
#>    5:              Placebo              Placebo              Placebo
#>   ---                                                               
#> 7506: Xanomeline High Dose Xanomeline High Dose Xanomeline High Dose
#> 7507: Xanomeline High Dose Xanomeline High Dose Xanomeline High Dose
#> 7508: Xanomeline High Dose Xanomeline High Dose Xanomeline High Dose
#> 7509: Xanomeline High Dose Xanomeline High Dose Xanomeline High Dose
#> 7510: Xanomeline High Dose Xanomeline High Dose Xanomeline High Dose
#>                     TRT01A     TRTSDT    TRTSDTM TRTSTMF     TRTEDT
#>                     <char>     <Date>     <POSc>  <char>     <Date>
#>    1:              Placebo 2014-01-02 2014-01-02       H 2014-07-02
#>    2:              Placebo 2014-01-02 2014-01-02       H 2014-07-02
#>    3:              Placebo 2014-01-02 2014-01-02       H 2014-07-02
#>    4:              Placebo 2014-01-02 2014-01-02       H 2014-07-02
#>    5:              Placebo 2014-01-02 2014-01-02       H 2014-07-02
#>   ---                                                              
#> 7506: Xanomeline High Dose 2012-12-17 2012-12-17       H 2013-02-11
#> 7507: Xanomeline High Dose 2012-12-17 2012-12-17       H 2013-02-11
#> 7508: Xanomeline High Dose 2012-12-17 2012-12-17       H 2013-02-11
#> 7509: Xanomeline High Dose 2012-12-17 2012-12-17       H 2013-02-11
#> 7510: Xanomeline High Dose 2012-12-17 2012-12-17       H 2013-02-11
#>                   TRTEDTM TRTETMF        APHASE APHASEN       EOSSTT      EOSDT
#>                    <POSc>  <char>        <char>   <num>       <char>     <Date>
#>    1: 2014-07-02 23:59:59       H  On-Treatment       2    COMPLETED 2014-07-02
#>    2: 2014-07-02 23:59:59       H  On-Treatment       2    COMPLETED 2014-07-02
#>    3: 2014-07-02 23:59:59       H  On-Treatment       2    COMPLETED 2014-07-02
#>    4: 2014-07-02 23:59:59       H  On-Treatment       2    COMPLETED 2014-07-02
#>    5: 2014-07-02 23:59:59       H  On-Treatment       2    COMPLETED 2014-07-02
#>   ---                                                                          
#> 7506: 2013-02-11 23:59:59       H Pre-Treatment       1 DISCONTINUED 2013-02-18
#> 7507: 2013-02-11 23:59:59       H Pre-Treatment       1 DISCONTINUED 2013-02-18
#> 7508: 2013-02-11 23:59:59       H Pre-Treatment       1 DISCONTINUED 2013-02-18
#> 7509: 2013-02-11 23:59:59       H Pre-Treatment       1 DISCONTINUED 2013-02-18
#> 7510: 2013-02-11 23:59:59       H Pre-Treatment       1 DISCONTINUED 2013-02-18
#>       RFICDTC     RANDDT   LSTALVDT TRTDURD  DTHDT DTHDTF DTHCAUS DTHCGR1 CMSEQ
#>        <char>     <Date>     <Date>   <num> <Date> <char>  <char>  <char> <num>
#>    1:    <NA> 2014-01-02 2014-07-02     182   <NA>   <NA>    <NA>    <NA>    48
#>    2:    <NA> 2014-01-02 2014-07-02     182   <NA>   <NA>    <NA>    <NA>    54
#>    3:    <NA> 2014-01-02 2014-07-02     182   <NA>   <NA>    <NA>    <NA>    60
#>    4:    <NA> 2014-01-02 2014-07-02     182   <NA>   <NA>    <NA>    <NA>    66
#>    5:    <NA> 2014-01-02 2014-07-02     182   <NA>   <NA>    <NA>    <NA>    17
#>   ---                                                                          
#> 7506:    <NA> 2012-12-17 2013-02-25      57   <NA>   <NA>    <NA>    <NA>     6
#> 7507:    <NA> 2012-12-17 2013-02-25      57   <NA>   <NA>    <NA>    <NA>     8
#> 7508:    <NA> 2012-12-17 2013-02-25      57   <NA>   <NA>    <NA>    <NA>     9
#> 7509:    <NA> 2012-12-17 2013-02-25      57   <NA>   <NA>    <NA>    <NA>    12
#> 7510:    <NA> 2012-12-17 2013-02-25      57   <NA>   <NA>    <NA>    <NA>    13
#>              CMDECOD           CMTRT                                CMCLAS
#>               <char>          <char>                                <char>
#>    1: HYDROCORTISONE  HYDROCORTISONE SYSTEMIC HORMONAL PREPARATIONS, EXCL.
#>    2: HYDROCORTISONE  HYDROCORTISONE SYSTEMIC HORMONAL PREPARATIONS, EXCL.
#>    3: HYDROCORTISONE  HYDROCORTISONE SYSTEMIC HORMONAL PREPARATIONS, EXCL.
#>    4: HYDROCORTISONE  HYDROCORTISONE SYSTEMIC HORMONAL PREPARATIONS, EXCL.
#>    5:        UNCODED NEOSPORIN /USA/                               UNCODED
#>   ---                                                                     
#> 7506:        UNCODED   MULTIVITAMINS                               UNCODED
#> 7507:        UNCODED   MULTIVITAMINS                               UNCODED
#> 7508:        UNCODED   MULTIVITAMINS                               UNCODED
#> 7509:        UNCODED   MULTIVITAMINS                               UNCODED
#> 7510:        UNCODED   MULTIVITAMINS                               UNCODED
#>          CMSTDTC      ASTDT     ASTDTM ASTDTF ASTTMF CMENDTC  AENDT AENDTM
#>           <char>     <Date>     <POSc> <char> <char>  <char> <Date> <POSc>
#>    1: 2014-03-27 2014-03-27 2014-03-27   <NA>      H    <NA>   <NA>   <NA>
#>    2: 2014-03-27 2014-03-27 2014-03-27   <NA>      H    <NA>   <NA>   <NA>
#>    3: 2014-03-27 2014-03-27 2014-03-27   <NA>      H    <NA>   <NA>   <NA>
#>    4: 2014-03-27 2014-03-27 2014-03-27   <NA>      H    <NA>   <NA>   <NA>
#>    5: 2014-01-03 2014-01-03 2014-01-03   <NA>      H    <NA>   <NA>   <NA>
#>   ---                                                                     
#> 7506:    2002-08 2002-08-01 2002-08-01      D      H    <NA>   <NA>   <NA>
#> 7507:    2002-08 2002-08-01 2002-08-01      D      H    <NA>   <NA>   <NA>
#> 7508:    2002-08 2002-08-01 2002-08-01      D      H    <NA>   <NA>   <NA>
#> 7509:    2002-08 2002-08-01 2002-08-01      D      H    <NA>   <NA>   <NA>
#> 7510:    2002-08 2002-08-01 2002-08-01      D      H    <NA>   <NA>   <NA>
#>       AENDTF AENTMF ASTDY CMSTDY AENDY CMENDY ADURN  ADURU ANL01FL ONTRTFL
#>       <char> <char> <num>  <num> <num>  <num> <num> <char>  <char>  <char>
#>    1:   <NA>   <NA>    85     85    NA     NA    NA   <NA>       Y       Y
#>    2:   <NA>   <NA>    85     85    NA     NA    NA   <NA>       Y       Y
#>    3:   <NA>   <NA>    85     85    NA     NA    NA   <NA>       Y       Y
#>    4:   <NA>   <NA>    85     85    NA     NA    NA   <NA>       Y       Y
#>    5:   <NA>   <NA>     2      2    NA     NA    NA   <NA>       Y       Y
#>   ---                                                                     
#> 7506:   <NA>   <NA> -3791     NA    NA     NA    NA   <NA>    <NA>    <NA>
#> 7507:   <NA>   <NA> -3791     NA    NA     NA    NA   <NA>    <NA>    <NA>
#> 7508:   <NA>   <NA> -3791     NA    NA     NA    NA   <NA>    <NA>    <NA>
#> 7509:   <NA>   <NA> -3791     NA    NA     NA    NA   <NA>    <NA>    <NA>
#> 7510:   <NA>   <NA> -3791     NA    NA     NA    NA   <NA>    <NA>    <NA>
#>        PREFL  FUPFL AOCCPFL                             CMINDC CMDOSE CMDOSU
#>       <char> <char>  <char>                             <char>  <num> <char>
#>    1:   <NA>   <NA>       Y                               <NA>      1   VIAL
#>    2:   <NA>   <NA>    <NA>                               <NA>      1   VIAL
#>    3:   <NA>   <NA>    <NA>                               <NA>      1   VIAL
#>    4:   <NA>   <NA>    <NA>                               <NA>      1   VIAL
#>    5:   <NA>   <NA>       Y                               <NA>      1   VIAL
#>   ---                                                                       
#> 7506:      Y   <NA>    <NA> PROPHYLAXIS OR NON-THERAPEUTIC USE      1 TABLET
#> 7507:      Y   <NA>    <NA> PROPHYLAXIS OR NON-THERAPEUTIC USE      1 TABLET
#> 7508:      Y   <NA>    <NA> PROPHYLAXIS OR NON-THERAPEUTIC USE      1 TABLET
#> 7509:      Y   <NA>    <NA> PROPHYLAXIS OR NON-THERAPEUTIC USE      1 TABLET
#> 7510:      Y   <NA>    <NA> PROPHYLAXIS OR NON-THERAPEUTIC USE      1 TABLET
#>       CMDOSFRQ CMROUTE CMSPID CMENRTPT VISITNUM             VISIT VISITDY
#>         <char>  <char> <char>   <char>    <num>            <char>   <num>
#>    1:      PRN TOPICAL      6  ONGOING       10           WEEK 16     112
#>    2:      PRN TOPICAL      6  ONGOING       11           WEEK 20     140
#>    3:      PRN TOPICAL      6  ONGOING       12           WEEK 24     168
#>    4:      PRN TOPICAL      6  ONGOING       13           WEEK 26     182
#>    5:      PRN TOPICAL      5  ONGOING        4            WEEK 2      14
#>   ---                                                                    
#> 7506:       QD    ORAL      1  ONGOING        5            WEEK 4      28
#> 7507:       QD    ORAL      1  ONGOING        6 AMBUL ECG REMOVAL      30
#> 7508:       QD    ORAL      1  ONGOING        7            WEEK 6      42
#> 7509:       QD    ORAL      1  ONGOING        8            WEEK 8      56
#> 7510:       QD    ORAL      1  ONGOING      201         RETRIEVAL     168
#>            CMDTC INDEX_
#>           <char>  <int>
#>    1: 2014-05-07      1
#>    2: 2014-05-21      2
#>    3: 2014-06-18      3
#>    4: 2014-07-02      4
#>    5: 2014-01-16      5
#>   ---                  
#> 7506: 2013-01-17   7506
#> 7507: 2013-01-19   7507
#> 7508: 2013-01-28   7508
#> 7509: 2013-02-18   7509
#> 7510: 2013-06-03   7510

analysis_data_container <- data.table(
  dat = list(adcm_data),
  key_analysis_data = "a"
)
setkey(analysis_data_container, key_analysis_data)

# Create endpoint with specific filters
ep <- data.table(
  endpoint_id = 1L,
  pop_var = "SAFFL",
  pop_value = "Y",
  period_var = NA_character_,
  period_value = NA_character_,
  endpoint_filter = NA_character_,
  endpoint_group_filter = NA_character_,
  custom_pop_filter = NA_character_,
  key_analysis_data = "a"
)
setkey(ep, key_analysis_data)

# Add event index: identifies which rows match endpoint criteria
ep_with_index <- add_event_index(ep, analysis_data_container)

# event_index contains row numbers from adcm_data matching the criteria
str(ep_with_index$event_index)  # integer vector of INDEX_ values
#> List of 1
#>  $ : int [1:7510] 1 2 3 4 5 6 7 8 9 10 ...
length(ep_with_index$event_index[[1]])  # e.g., 47 events match SAFFL="Y"
#> [1] 7510
```
