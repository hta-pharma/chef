# Non-branching targets pipeline works

    Code
      ep_stat
    Output
          endpoint_spec_id study_metadata pop_var pop_value treatment_var
       1:                1      <list[0]>   SAFFL         Y        TRT01A
       2:                1      <list[0]>   SAFFL         Y        TRT01A
       3:                1      <list[0]>   SAFFL         Y        TRT01A
       4:                1      <list[0]>   SAFFL         Y        TRT01A
       5:                1      <list[0]>   SAFFL         Y        TRT01A
       6:                1      <list[0]>   SAFFL         Y        TRT01A
       7:                1      <list[0]>   SAFFL         Y        TRT01A
       8:                1      <list[0]>   SAFFL         Y        TRT01A
       9:                1      <list[0]>   SAFFL         Y        TRT01A
      10:                1      <list[0]>   SAFFL         Y        TRT01A
      11:                1      <list[0]>   SAFFL         Y        TRT01A
      12:                1      <list[0]>   SAFFL         Y        TRT01A
      13:                1      <list[0]>   SAFFL         Y        TRT01A
      14:                1      <list[0]>   SAFFL         Y        TRT01A
      15:                1      <list[0]>   SAFFL         Y        TRT01A
      16:                1      <list[0]>   SAFFL         Y        TRT01A
      17:                1      <list[0]>   SAFFL         Y        TRT01A
      18:                1      <list[0]>   SAFFL         Y        TRT01A
      19:                1      <list[0]>   SAFFL         Y        TRT01A
      20:                1      <list[0]>   SAFFL         Y        TRT01A
      21:                1      <list[0]>   SAFFL         Y        TRT01A
      22:                1      <list[0]>   SAFFL         Y        TRT01A
      23:                1      <list[0]>   SAFFL         Y        TRT01A
      24:                1      <list[0]>   SAFFL         Y        TRT01A
      25:                1      <list[0]>   SAFFL         Y        TRT01A
      26:                1      <list[0]>   SAFFL         Y        TRT01A
      27:                1      <list[0]>   SAFFL         Y        TRT01A
      28:                1      <list[0]>   SAFFL         Y        TRT01A
      29:                1      <list[0]>   SAFFL         Y        TRT01A
      30:                1      <list[0]>   SAFFL         Y        TRT01A
      31:                1      <list[0]>   SAFFL         Y        TRT01A
      32:                1      <list[0]>   SAFFL         Y        TRT01A
      33:                1      <list[0]>   SAFFL         Y        TRT01A
      34:                1      <list[0]>   SAFFL         Y        TRT01A
      35:                1      <list[0]>   SAFFL         Y        TRT01A
      36:                1      <list[0]>   SAFFL         Y        TRT01A
          endpoint_spec_id study_metadata pop_var pop_value treatment_var
              treatment_refval period_var period_value
       1: Xanomeline High Dose    ANL01FL            Y
       2: Xanomeline High Dose    ANL01FL            Y
       3: Xanomeline High Dose    ANL01FL            Y
       4: Xanomeline High Dose    ANL01FL            Y
       5: Xanomeline High Dose    ANL01FL            Y
       6: Xanomeline High Dose    ANL01FL            Y
       7: Xanomeline High Dose    ANL01FL            Y
       8: Xanomeline High Dose    ANL01FL            Y
       9: Xanomeline High Dose    ANL01FL            Y
      10: Xanomeline High Dose    ANL01FL            Y
      11: Xanomeline High Dose    ANL01FL            Y
      12: Xanomeline High Dose    ANL01FL            Y
      13: Xanomeline High Dose    ANL01FL            Y
      14: Xanomeline High Dose    ANL01FL            Y
      15: Xanomeline High Dose    ANL01FL            Y
      16: Xanomeline High Dose    ANL01FL            Y
      17: Xanomeline High Dose    ANL01FL            Y
      18: Xanomeline High Dose    ANL01FL            Y
      19: Xanomeline High Dose    ANL01FL            Y
      20: Xanomeline High Dose    ANL01FL            Y
      21: Xanomeline High Dose    ANL01FL            Y
      22: Xanomeline High Dose    ANL01FL            Y
      23: Xanomeline High Dose    ANL01FL            Y
      24: Xanomeline High Dose    ANL01FL            Y
      25: Xanomeline High Dose    ANL01FL            Y
      26: Xanomeline High Dose    ANL01FL            Y
      27: Xanomeline High Dose    ANL01FL            Y
      28: Xanomeline High Dose    ANL01FL            Y
      29: Xanomeline High Dose    ANL01FL            Y
      30: Xanomeline High Dose    ANL01FL            Y
      31: Xanomeline High Dose    ANL01FL            Y
      32: Xanomeline High Dose    ANL01FL            Y
      33: Xanomeline High Dose    ANL01FL            Y
      34: Xanomeline High Dose    ANL01FL            Y
      35: Xanomeline High Dose    ANL01FL            Y
      36: Xanomeline High Dose    ANL01FL            Y
              treatment_refval period_var period_value
                                         custom_pop_filter endpoint_filter  group_by
       1: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       2: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       3: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       4: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       5: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       6: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       7: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       8: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       9: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      10: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      11: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      12: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      13: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      14: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      15: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      16: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      17: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      18: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      19: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      20: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      21: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      22: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      23: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      24: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      25: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      26: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      27: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      28: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      29: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      30: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      31: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      32: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      33: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      34: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      35: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      36: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
                                         custom_pop_filter endpoint_filter  group_by
          stratify_by only_strata_with_events                key_analysis_data
       1:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       2:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       3:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       4:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       5:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       6:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       7:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       8:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       9:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      10:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      11:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      12:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      13:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      14:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      15:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      16:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      17:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      18:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      19:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      20:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      21:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      22:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      23:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      24:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      25:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      26:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      27:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      28:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      29:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      30:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      31:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      32:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      33:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      34:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      35:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      36:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
          stratify_by only_strata_with_events                key_analysis_data
          endpoint_group_metadata                      endpoint_group_filter
       1:               <list[1]>                            RACE == "WHITE"
       2:               <list[1]>                            RACE == "WHITE"
       3:               <list[1]>                            RACE == "WHITE"
       4:               <list[1]>                            RACE == "WHITE"
       5:               <list[1]>                            RACE == "WHITE"
       6:               <list[1]>                            RACE == "WHITE"
       7:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
       8:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
       9:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      10:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      11:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      12:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      13:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      14:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      15:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      16:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      17:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      18:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      19:               <list[1]>                            RACE == "WHITE"
      20:               <list[1]>                            RACE == "WHITE"
      21:               <list[1]>                            RACE == "WHITE"
      22:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      23:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      24:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      25:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      26:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      27:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      28:               <list[1]>                            RACE == "WHITE"
      29:               <list[1]>                            RACE == "WHITE"
      30:               <list[1]>                            RACE == "WHITE"
      31:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      32:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      33:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      34:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      35:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      36:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
          endpoint_group_metadata                      endpoint_group_filter
          endpoint_id endpoint_label                       event_index
       1:      1-0001              A                   1,2,3,4,5,6,...
       2:      1-0001              A                   1,2,3,4,5,6,...
       3:      1-0001              A                   1,2,3,4,5,6,...
       4:      1-0001              A                   1,2,3,4,5,6,...
       5:      1-0001              A                   1,2,3,4,5,6,...
       6:      1-0001              A                   1,2,3,4,5,6,...
       7:      1-0002              A  670, 671, 672, 673,1057,1058,...
       8:      1-0002              A  670, 671, 672, 673,1057,1058,...
       9:      1-0002              A  670, 671, 672, 673,1057,1058,...
      10:      1-0002              A  670, 671, 672, 673,1057,1058,...
      11:      1-0002              A  670, 671, 672, 673,1057,1058,...
      12:      1-0002              A  670, 671, 672, 673,1057,1058,...
      13:      1-0003              A                   783,784,785,786
      14:      1-0003              A                   783,784,785,786
      15:      1-0003              A                   783,784,785,786
      16:      1-0003              A                   783,784,785,786
      17:      1-0003              A                   783,784,785,786
      18:      1-0003              A                   783,784,785,786
      19:      1-0001              A                   1,2,3,4,5,6,...
      20:      1-0001              A                   1,2,3,4,5,6,...
      21:      1-0001              A                   1,2,3,4,5,6,...
      22:      1-0002              A  670, 671, 672, 673,1057,1058,...
      23:      1-0002              A  670, 671, 672, 673,1057,1058,...
      24:      1-0002              A  670, 671, 672, 673,1057,1058,...
      25:      1-0003              A                   783,784,785,786
      26:      1-0003              A                   783,784,785,786
      27:      1-0003              A                   783,784,785,786
      28:      1-0001              A                   1,2,3,4,5,6,...
      29:      1-0001              A                   1,2,3,4,5,6,...
      30:      1-0001              A                   1,2,3,4,5,6,...
      31:      1-0002              A  670, 671, 672, 673,1057,1058,...
      32:      1-0002              A  670, 671, 672, 673,1057,1058,...
      33:      1-0002              A  670, 671, 672, 673,1057,1058,...
      34:      1-0003              A                   783,784,785,786
      35:      1-0003              A                   783,784,785,786
      36:      1-0003              A                   783,784,785,786
          endpoint_id endpoint_label                       event_index
          crit_accept_endpoint strata_var   strata_id crit_accept_by_strata_by_trt
       1:                 TRUE     TOTAL_ 1-0001-0001                         TRUE
       2:                 TRUE     TOTAL_ 1-0001-0001                         TRUE
       3:                 TRUE        SEX 1-0001-0002                         TRUE
       4:                 TRUE        SEX 1-0001-0002                         TRUE
       5:                 TRUE        SEX 1-0001-0002                         TRUE
       6:                 TRUE        SEX 1-0001-0002                         TRUE
       7:                 TRUE     TOTAL_ 1-0002-0001                         TRUE
       8:                 TRUE     TOTAL_ 1-0002-0001                         TRUE
       9:                 TRUE        SEX 1-0002-0002                         TRUE
      10:                 TRUE        SEX 1-0002-0002                         TRUE
      11:                 TRUE        SEX 1-0002-0002                         TRUE
      12:                 TRUE        SEX 1-0002-0002                         TRUE
      13:                 TRUE     TOTAL_ 1-0003-0001                         TRUE
      14:                 TRUE     TOTAL_ 1-0003-0001                         TRUE
      15:                 TRUE        SEX 1-0003-0002                         TRUE
      16:                 TRUE        SEX 1-0003-0002                         TRUE
      17:                 TRUE        SEX 1-0003-0002                         TRUE
      18:                 TRUE        SEX 1-0003-0002                         TRUE
      19:                 TRUE     TOTAL_ 1-0001-0001                         TRUE
      20:                 TRUE        SEX 1-0001-0002                         TRUE
      21:                 TRUE        SEX 1-0001-0002                         TRUE
      22:                 TRUE     TOTAL_ 1-0002-0001                         TRUE
      23:                 TRUE        SEX 1-0002-0002                         TRUE
      24:                 TRUE        SEX 1-0002-0002                         TRUE
      25:                 TRUE     TOTAL_ 1-0003-0001                         TRUE
      26:                 TRUE        SEX 1-0003-0002                         TRUE
      27:                 TRUE        SEX 1-0003-0002                         TRUE
      28:                 TRUE        SEX 1-0001-0002                         TRUE
      29:                 TRUE        SEX 1-0001-0002                         TRUE
      30:                 TRUE        SEX 1-0001-0002                         TRUE
      31:                 TRUE        SEX 1-0002-0002                         TRUE
      32:                 TRUE        SEX 1-0002-0002                         TRUE
      33:                 TRUE        SEX 1-0002-0002                         TRUE
      34:                 TRUE        SEX 1-0003-0002                         TRUE
      35:                 TRUE        SEX 1-0003-0002                         TRUE
      36:                 TRUE        SEX 1-0003-0002                         TRUE
          crit_accept_endpoint strata_var   strata_id crit_accept_by_strata_by_trt
          crit_accept_by_strata_across_trt stat_metadata
       1:                             TRUE     <list[2]>
       2:                             TRUE     <list[2]>
       3:                             TRUE     <list[2]>
       4:                             TRUE     <list[2]>
       5:                             TRUE     <list[2]>
       6:                             TRUE     <list[2]>
       7:                             TRUE     <list[2]>
       8:                             TRUE     <list[2]>
       9:                             TRUE     <list[2]>
      10:                             TRUE     <list[2]>
      11:                             TRUE     <list[2]>
      12:                             TRUE     <list[2]>
      13:                             TRUE     <list[2]>
      14:                             TRUE     <list[2]>
      15:                             TRUE     <list[2]>
      16:                             TRUE     <list[2]>
      17:                             TRUE     <list[2]>
      18:                             TRUE     <list[2]>
      19:                             TRUE     <list[1]>
      20:                             TRUE     <list[1]>
      21:                             TRUE     <list[1]>
      22:                             TRUE     <list[1]>
      23:                             TRUE     <list[1]>
      24:                             TRUE     <list[1]>
      25:                             TRUE     <list[1]>
      26:                             TRUE     <list[1]>
      27:                             TRUE     <list[1]>
      28:                             TRUE     <list[2]>
      29:                             TRUE     <list[2]>
      30:                             TRUE     <list[2]>
      31:                             TRUE     <list[2]>
      32:                             TRUE     <list[2]>
      33:                             TRUE     <list[2]>
      34:                             TRUE     <list[2]>
      35:                             TRUE     <list[2]>
      36:                             TRUE     <list[2]>
          crit_accept_by_strata_across_trt stat_metadata
                                                   stat_filter
       1:              TOTAL_ == "total" & TRT01A == "Placebo"
       2: TOTAL_ == "total" & TRT01A == "Xanomeline High Dose"
       3:                     SEX == "F" & TRT01A == "Placebo"
       4:                     SEX == "M" & TRT01A == "Placebo"
       5:        SEX == "F" & TRT01A == "Xanomeline High Dose"
       6:        SEX == "M" & TRT01A == "Xanomeline High Dose"
       7:              TOTAL_ == "total" & TRT01A == "Placebo"
       8: TOTAL_ == "total" & TRT01A == "Xanomeline High Dose"
       9:                     SEX == "F" & TRT01A == "Placebo"
      10:                     SEX == "M" & TRT01A == "Placebo"
      11:        SEX == "F" & TRT01A == "Xanomeline High Dose"
      12:        SEX == "M" & TRT01A == "Xanomeline High Dose"
      13:              TOTAL_ == "total" & TRT01A == "Placebo"
      14: TOTAL_ == "total" & TRT01A == "Xanomeline High Dose"
      15:                     SEX == "F" & TRT01A == "Placebo"
      16:                     SEX == "M" & TRT01A == "Placebo"
      17:        SEX == "F" & TRT01A == "Xanomeline High Dose"
      18:        SEX == "M" & TRT01A == "Xanomeline High Dose"
      19:                                    TOTAL_ == "total"
      20:                                           SEX == "F"
      21:                                           SEX == "M"
      22:                                    TOTAL_ == "total"
      23:                                           SEX == "F"
      24:                                           SEX == "M"
      25:                                    TOTAL_ == "total"
      26:                                           SEX == "F"
      27:                                           SEX == "M"
      28:                                                     
      29:                                                     
      30:                                                     
      31:                                                     
      32:                                                     
      33:                                                     
      34:                                                     
      35:                                                     
      36:                                                     
                                                   stat_filter
                           cell_index stat_event_exist
       1:             1,2,3,4,5,6,...             TRUE
       2:       88,89,90,91,92,93,...             TRUE
       3:             1,2,3,4,5,6,...             TRUE
       4:       67,68,69,70,71,72,...             TRUE
       5: 134,135,136,137,138,139,...             TRUE
       6:       88,89,90,91,92,93,...             TRUE
       7:             1,2,3,4,5,6,...             TRUE
       8:       88,89,90,91,92,93,...             TRUE
       9:             1,2,3,4,5,6,...             TRUE
      10:       67,68,69,70,71,72,...             TRUE
      11: 134,135,136,137,138,139,...             TRUE
      12:       88,89,90,91,92,93,...             TRUE
      13:             1,2,3,4,5,6,...            FALSE
      14:       88,89,90,91,92,93,...             TRUE
      15:             1,2,3,4,5,6,...            FALSE
      16:       67,68,69,70,71,72,...            FALSE
      17: 134,135,136,137,138,139,...            FALSE
      18:       88,89,90,91,92,93,...             TRUE
      19:             1,2,3,4,5,6,...             TRUE
      20:             1,2,3,4,5,6,...             TRUE
      21:       67,68,69,70,71,72,...             TRUE
      22:             1,2,3,4,5,6,...             TRUE
      23:             1,2,3,4,5,6,...             TRUE
      24:       67,68,69,70,71,72,...             TRUE
      25:             1,2,3,4,5,6,...             TRUE
      26:             1,2,3,4,5,6,...            FALSE
      27:       67,68,69,70,71,72,...             TRUE
      28:             1,2,3,4,5,6,...             TRUE
      29:             1,2,3,4,5,6,...             TRUE
      30:             1,2,3,4,5,6,...             TRUE
      31:             1,2,3,4,5,6,...             TRUE
      32:             1,2,3,4,5,6,...             TRUE
      33:             1,2,3,4,5,6,...             TRUE
      34:             1,2,3,4,5,6,...             TRUE
      35:             1,2,3,4,5,6,...             TRUE
      36:             1,2,3,4,5,6,...             TRUE
                           cell_index stat_event_exist
                                   fn_hash                       fn_type
       1: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
       2: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
       3: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
       4: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
       5: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
       6: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
       7: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
       8: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
       9: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
      10: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
      11: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
      12: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
      13: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
      14: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
      15: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
      16: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
      17: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
      18: 813b7f4a4a29eecccb80f54451802205         stat_by_strata_by_trt
      19: f60151928d92ca8d670863797256c7c6     stat_by_strata_across_trt
      20: f60151928d92ca8d670863797256c7c6     stat_by_strata_across_trt
      21: f60151928d92ca8d670863797256c7c6     stat_by_strata_across_trt
      22: f60151928d92ca8d670863797256c7c6     stat_by_strata_across_trt
      23: f60151928d92ca8d670863797256c7c6     stat_by_strata_across_trt
      24: f60151928d92ca8d670863797256c7c6     stat_by_strata_across_trt
      25: f60151928d92ca8d670863797256c7c6     stat_by_strata_across_trt
      26: f60151928d92ca8d670863797256c7c6     stat_by_strata_across_trt
      27: f60151928d92ca8d670863797256c7c6     stat_by_strata_across_trt
      28: dc43955ca4ffa21cc694e5987fe454f7 stat_across_strata_across_trt
      29: dc43955ca4ffa21cc694e5987fe454f7 stat_across_strata_across_trt
      30: dc43955ca4ffa21cc694e5987fe454f7 stat_across_strata_across_trt
      31: dc43955ca4ffa21cc694e5987fe454f7 stat_across_strata_across_trt
      32: dc43955ca4ffa21cc694e5987fe454f7 stat_across_strata_across_trt
      33: dc43955ca4ffa21cc694e5987fe454f7 stat_across_strata_across_trt
      34: dc43955ca4ffa21cc694e5987fe454f7 stat_across_strata_across_trt
      35: dc43955ca4ffa21cc694e5987fe454f7 stat_across_strata_across_trt
      36: dc43955ca4ffa21cc694e5987fe454f7 stat_across_strata_across_trt
                                   fn_hash                       fn_type
                   fn_name                  fn_call_char
       1:          n_subev                    c(n_subev)
       2:          n_subev                    c(n_subev)
       3:          n_subev                    c(n_subev)
       4:          n_subev                    c(n_subev)
       5:          n_subev                    c(n_subev)
       6:          n_subev                    c(n_subev)
       7:          n_subev                    c(n_subev)
       8:          n_subev                    c(n_subev)
       9:          n_subev                    c(n_subev)
      10:          n_subev                    c(n_subev)
      11:          n_subev                    c(n_subev)
      12:          n_subev                    c(n_subev)
      13:          n_subev                    c(n_subev)
      14:          n_subev                    c(n_subev)
      15:          n_subev                    c(n_subev)
      16:          n_subev                    c(n_subev)
      17:          n_subev                    c(n_subev)
      18:          n_subev                    c(n_subev)
      19: n_subev_trt_diff           c(n_subev_trt_diff)
      20: n_subev_trt_diff           c(n_subev_trt_diff)
      21: n_subev_trt_diff           c(n_subev_trt_diff)
      22: n_subev_trt_diff           c(n_subev_trt_diff)
      23: n_subev_trt_diff           c(n_subev_trt_diff)
      24: n_subev_trt_diff           c(n_subev_trt_diff)
      25: n_subev_trt_diff           c(n_subev_trt_diff)
      26: n_subev_trt_diff           c(n_subev_trt_diff)
      27: n_subev_trt_diff           c(n_subev_trt_diff)
      28:    P-interaction c(contingency2x2_strata_test)
      29:    P-interaction c(contingency2x2_strata_test)
      30:    P-interaction c(contingency2x2_strata_test)
      31:    P-interaction c(contingency2x2_strata_test)
      32:    P-interaction c(contingency2x2_strata_test)
      33:    P-interaction c(contingency2x2_strata_test)
      34:    P-interaction c(contingency2x2_strata_test)
      35:    P-interaction c(contingency2x2_strata_test)
      36:    P-interaction c(contingency2x2_strata_test)
                   fn_name                  fn_call_char
                                             stat_result_id stat_result_label
       1: 1-0001-0001-813b7f4a4a29eecccb80f54451802205-0001                 n
       2: 1-0001-0001-813b7f4a4a29eecccb80f54451802205-0002                 n
       3: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0003                 n
       4: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0004                 n
       5: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0005                 n
       6: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0006                 n
       7: 1-0002-0001-813b7f4a4a29eecccb80f54451802205-0007                 n
       8: 1-0002-0001-813b7f4a4a29eecccb80f54451802205-0008                 n
       9: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0009                 n
      10: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0010                 n
      11: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0011                 n
      12: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0012                 n
      13: 1-0003-0001-813b7f4a4a29eecccb80f54451802205-0013                 n
      14: 1-0003-0001-813b7f4a4a29eecccb80f54451802205-0014                 n
      15: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0015                 n
      16: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0016                 n
      17: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0017                 n
      18: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0018                 n
      19: 1-0001-0001-f60151928d92ca8d670863797256c7c6-0001        n_trt_diff
      20: 1-0001-0002-f60151928d92ca8d670863797256c7c6-0002        n_trt_diff
      21: 1-0001-0002-f60151928d92ca8d670863797256c7c6-0003        n_trt_diff
      22: 1-0002-0001-f60151928d92ca8d670863797256c7c6-0004        n_trt_diff
      23: 1-0002-0002-f60151928d92ca8d670863797256c7c6-0005        n_trt_diff
      24: 1-0002-0002-f60151928d92ca8d670863797256c7c6-0006        n_trt_diff
      25: 1-0003-0001-f60151928d92ca8d670863797256c7c6-0007        n_trt_diff
      26: 1-0003-0002-f60151928d92ca8d670863797256c7c6-0008        n_trt_diff
      27: 1-0003-0002-f60151928d92ca8d670863797256c7c6-0009        n_trt_diff
      28: 1-0001-0002-dc43955ca4ffa21cc694e5987fe454f7-0001 Pval_independency
      29: 1-0001-0002-dc43955ca4ffa21cc694e5987fe454f7-0001          CI_lower
      30: 1-0001-0002-dc43955ca4ffa21cc694e5987fe454f7-0001          CI_upper
      31: 1-0002-0002-dc43955ca4ffa21cc694e5987fe454f7-0002 Pval_independency
      32: 1-0002-0002-dc43955ca4ffa21cc694e5987fe454f7-0002          CI_lower
      33: 1-0002-0002-dc43955ca4ffa21cc694e5987fe454f7-0002          CI_upper
      34: 1-0003-0002-dc43955ca4ffa21cc694e5987fe454f7-0003 Pval_independency
      35: 1-0003-0002-dc43955ca4ffa21cc694e5987fe454f7-0003          CI_lower
      36: 1-0003-0002-dc43955ca4ffa21cc694e5987fe454f7-0003          CI_upper
                                             stat_result_id stat_result_label
                                                               stat_result_description
       1:                                               Number of subjects with events
       2:                                               Number of subjects with events
       3:                                               Number of subjects with events
       4:                                               Number of subjects with events
       5:                                               Number of subjects with events
       6:                                               Number of subjects with events
       7:                                               Number of subjects with events
       8:                                               Number of subjects with events
       9:                                               Number of subjects with events
      10:                                               Number of subjects with events
      11:                                               Number of subjects with events
      12:                                               Number of subjects with events
      13:                                               Number of subjects with events
      14:                                               Number of subjects with events
      15:                                               Number of subjects with events
      16:                                               Number of subjects with events
      17:                                               Number of subjects with events
      18:                                               Number of subjects with events
      19: Absolute difference in number of subjects with events between treatment arms
      20: Absolute difference in number of subjects with events between treatment arms
      21: Absolute difference in number of subjects with events between treatment arms
      22: Absolute difference in number of subjects with events between treatment arms
      23: Absolute difference in number of subjects with events between treatment arms
      24: Absolute difference in number of subjects with events between treatment arms
      25: Absolute difference in number of subjects with events between treatment arms
      26: Absolute difference in number of subjects with events between treatment arms
      27: Absolute difference in number of subjects with events between treatment arms
      28:                    Cochran-mante-haenszel test for odds ratios across strata
      29:                    Cochran-mante-haenszel test for odds ratios across strata
      30:                    Cochran-mante-haenszel test for odds ratios across strata
      31:                    Cochran-mante-haenszel test for odds ratios across strata
      32:                    Cochran-mante-haenszel test for odds ratios across strata
      33:                    Cochran-mante-haenszel test for odds ratios across strata
      34:                    Cochran-mante-haenszel test for odds ratios across strata
      35:                    Cochran-mante-haenszel test for odds ratios across strata
      36:                    Cochran-mante-haenszel test for odds ratios across strata
                                                               stat_result_description
          stat_result_qualifiers stat_result_value
       1:                   <NA>        45.0000000
       2:                   <NA>        46.0000000
       3:                   <NA>        26.0000000
       4:                   <NA>        19.0000000
       5:                   <NA>        18.0000000
       6:                   <NA>        28.0000000
       7:                   <NA>         5.0000000
       8:                   <NA>         4.0000000
       9:                   <NA>         4.0000000
      10:                   <NA>         1.0000000
      11:                   <NA>         3.0000000
      12:                   <NA>         1.0000000
      13:                   <NA>         0.0000000
      14:                   <NA>         1.0000000
      15:                   <NA>         0.0000000
      16:                   <NA>         0.0000000
      17:                   <NA>         0.0000000
      18:                   <NA>         1.0000000
      19:                   <NA>         1.0000000
      20:                   <NA>         8.0000000
      21:                   <NA>         9.0000000
      22:                   <NA>         1.0000000
      23:                   <NA>         1.0000000
      24:                   <NA>         0.0000000
      25:                   <NA>                NA
      26:                   <NA>                NA
      27:                   <NA>                NA
      28:                   <NA>         0.2988316
      29:                   <NA>         0.7781907
      30:                   <NA>         2.8523901
      31:                   <NA>         0.9117548
      32:                   <NA>         0.2753674
      33:                   <NA>         4.2408159
      34:                   <NA>         0.3449651
      35:                   <NA>               NaN
      36:                   <NA>               NaN
          stat_result_qualifiers stat_result_value

# Non-branching targets pipeline works no criteria fn and missing by_* functions

    Code
      ep_stat_nested
    Output
          endpoint_spec_id study_metadata pop_var pop_value treatment_var
       1:                1      <list[0]>   SAFFL         Y        TRT01A
       2:                1      <list[0]>   SAFFL         Y        TRT01A
       3:                1      <list[0]>   SAFFL         Y        TRT01A
       4:                1      <list[0]>   SAFFL         Y        TRT01A
       5:                1      <list[0]>   SAFFL         Y        TRT01A
       6:                1      <list[0]>   SAFFL         Y        TRT01A
       7:                1      <list[0]>   SAFFL         Y        TRT01A
       8:                1      <list[0]>   SAFFL         Y        TRT01A
       9:                1      <list[0]>   SAFFL         Y        TRT01A
      10:                1      <list[0]>   SAFFL         Y        TRT01A
      11:                1      <list[0]>   SAFFL         Y        TRT01A
      12:                1      <list[0]>   SAFFL         Y        TRT01A
      13:                1      <list[0]>   SAFFL         Y        TRT01A
      14:                1      <list[0]>   SAFFL         Y        TRT01A
      15:                1      <list[0]>   SAFFL         Y        TRT01A
      16:                1      <list[0]>   SAFFL         Y        TRT01A
      17:                1      <list[0]>   SAFFL         Y        TRT01A
      18:                1      <list[0]>   SAFFL         Y        TRT01A
              treatment_refval period_var period_value
       1: Xanomeline High Dose    ANL01FL            Y
       2: Xanomeline High Dose    ANL01FL            Y
       3: Xanomeline High Dose    ANL01FL            Y
       4: Xanomeline High Dose    ANL01FL            Y
       5: Xanomeline High Dose    ANL01FL            Y
       6: Xanomeline High Dose    ANL01FL            Y
       7: Xanomeline High Dose    ANL01FL            Y
       8: Xanomeline High Dose    ANL01FL            Y
       9: Xanomeline High Dose    ANL01FL            Y
      10: Xanomeline High Dose    ANL01FL            Y
      11: Xanomeline High Dose    ANL01FL            Y
      12: Xanomeline High Dose    ANL01FL            Y
      13: Xanomeline High Dose    ANL01FL            Y
      14: Xanomeline High Dose    ANL01FL            Y
      15: Xanomeline High Dose    ANL01FL            Y
      16: Xanomeline High Dose    ANL01FL            Y
      17: Xanomeline High Dose    ANL01FL            Y
      18: Xanomeline High Dose    ANL01FL            Y
                                         custom_pop_filter endpoint_filter  group_by
       1: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       2: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       3: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       4: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       5: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       6: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       7: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       8: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
       9: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      10: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      11: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      12: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      13: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      14: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      15: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      16: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      17: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
      18: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA> <list[1]>
          stratify_by only_strata_with_events                key_analysis_data
       1:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       2:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       3:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       4:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       5:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       6:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       7:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       8:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
       9:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      10:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      11:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      12:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      13:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      14:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      15:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      16:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      17:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
      18:  TOTAL_,SEX                   FALSE 7c0c6f888257b34f6374728fd6ea93c0
          endpoint_group_metadata                      endpoint_group_filter
       1:               <list[1]>                            RACE == "WHITE"
       2:               <list[1]>                            RACE == "WHITE"
       3:               <list[1]>                            RACE == "WHITE"
       4:               <list[1]>                            RACE == "WHITE"
       5:               <list[1]>                            RACE == "WHITE"
       6:               <list[1]>                            RACE == "WHITE"
       7:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
       8:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
       9:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      10:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      11:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      12:               <list[1]>        RACE == "BLACK OR AFRICAN AMERICAN"
      13:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      14:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      15:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      16:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      17:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
      18:               <list[1]> RACE == "AMERICAN INDIAN OR ALASKA NATIVE"
          endpoint_id endpoint_label                       event_index
       1:      1-0001              A                   1,2,3,4,5,6,...
       2:      1-0001              A                   1,2,3,4,5,6,...
       3:      1-0001              A                   1,2,3,4,5,6,...
       4:      1-0001              A                   1,2,3,4,5,6,...
       5:      1-0001              A                   1,2,3,4,5,6,...
       6:      1-0001              A                   1,2,3,4,5,6,...
       7:      1-0002              A  670, 671, 672, 673,1057,1058,...
       8:      1-0002              A  670, 671, 672, 673,1057,1058,...
       9:      1-0002              A  670, 671, 672, 673,1057,1058,...
      10:      1-0002              A  670, 671, 672, 673,1057,1058,...
      11:      1-0002              A  670, 671, 672, 673,1057,1058,...
      12:      1-0002              A  670, 671, 672, 673,1057,1058,...
      13:      1-0003              A                   783,784,785,786
      14:      1-0003              A                   783,784,785,786
      15:      1-0003              A                   783,784,785,786
      16:      1-0003              A                   783,784,785,786
      17:      1-0003              A                   783,784,785,786
      18:      1-0003              A                   783,784,785,786
          crit_accept_endpoint strata_var   strata_id crit_accept_by_strata_by_trt
       1:                 TRUE     TOTAL_ 1-0001-0001                         TRUE
       2:                 TRUE     TOTAL_ 1-0001-0001                         TRUE
       3:                 TRUE        SEX 1-0001-0002                         TRUE
       4:                 TRUE        SEX 1-0001-0002                         TRUE
       5:                 TRUE        SEX 1-0001-0002                         TRUE
       6:                 TRUE        SEX 1-0001-0002                         TRUE
       7:                 TRUE     TOTAL_ 1-0002-0001                         TRUE
       8:                 TRUE     TOTAL_ 1-0002-0001                         TRUE
       9:                 TRUE        SEX 1-0002-0002                         TRUE
      10:                 TRUE        SEX 1-0002-0002                         TRUE
      11:                 TRUE        SEX 1-0002-0002                         TRUE
      12:                 TRUE        SEX 1-0002-0002                         TRUE
      13:                 TRUE     TOTAL_ 1-0003-0001                         TRUE
      14:                 TRUE     TOTAL_ 1-0003-0001                         TRUE
      15:                 TRUE        SEX 1-0003-0002                         TRUE
      16:                 TRUE        SEX 1-0003-0002                         TRUE
      17:                 TRUE        SEX 1-0003-0002                         TRUE
      18:                 TRUE        SEX 1-0003-0002                         TRUE
          crit_accept_by_strata_across_trt stat_metadata
       1:                             TRUE     <list[2]>
       2:                             TRUE     <list[2]>
       3:                             TRUE     <list[2]>
       4:                             TRUE     <list[2]>
       5:                             TRUE     <list[2]>
       6:                             TRUE     <list[2]>
       7:                             TRUE     <list[2]>
       8:                             TRUE     <list[2]>
       9:                             TRUE     <list[2]>
      10:                             TRUE     <list[2]>
      11:                             TRUE     <list[2]>
      12:                             TRUE     <list[2]>
      13:                             TRUE     <list[2]>
      14:                             TRUE     <list[2]>
      15:                             TRUE     <list[2]>
      16:                             TRUE     <list[2]>
      17:                             TRUE     <list[2]>
      18:                             TRUE     <list[2]>
                                                   stat_filter
       1:              TOTAL_ == "total" & TRT01A == "Placebo"
       2: TOTAL_ == "total" & TRT01A == "Xanomeline High Dose"
       3:                     SEX == "F" & TRT01A == "Placebo"
       4:                     SEX == "M" & TRT01A == "Placebo"
       5:        SEX == "F" & TRT01A == "Xanomeline High Dose"
       6:        SEX == "M" & TRT01A == "Xanomeline High Dose"
       7:              TOTAL_ == "total" & TRT01A == "Placebo"
       8: TOTAL_ == "total" & TRT01A == "Xanomeline High Dose"
       9:                     SEX == "F" & TRT01A == "Placebo"
      10:                     SEX == "M" & TRT01A == "Placebo"
      11:        SEX == "F" & TRT01A == "Xanomeline High Dose"
      12:        SEX == "M" & TRT01A == "Xanomeline High Dose"
      13:              TOTAL_ == "total" & TRT01A == "Placebo"
      14: TOTAL_ == "total" & TRT01A == "Xanomeline High Dose"
      15:                     SEX == "F" & TRT01A == "Placebo"
      16:                     SEX == "M" & TRT01A == "Placebo"
      17:        SEX == "F" & TRT01A == "Xanomeline High Dose"
      18:        SEX == "M" & TRT01A == "Xanomeline High Dose"
                           cell_index stat_event_exist
       1:             1,2,3,4,5,6,...             TRUE
       2:       88,89,90,91,92,93,...             TRUE
       3:             1,2,3,4,5,6,...             TRUE
       4:       67,68,69,70,71,72,...             TRUE
       5: 134,135,136,137,138,139,...             TRUE
       6:       88,89,90,91,92,93,...             TRUE
       7:             1,2,3,4,5,6,...             TRUE
       8:       88,89,90,91,92,93,...             TRUE
       9:             1,2,3,4,5,6,...             TRUE
      10:       67,68,69,70,71,72,...             TRUE
      11: 134,135,136,137,138,139,...             TRUE
      12:       88,89,90,91,92,93,...             TRUE
      13:             1,2,3,4,5,6,...            FALSE
      14:       88,89,90,91,92,93,...             TRUE
      15:             1,2,3,4,5,6,...            FALSE
      16:       67,68,69,70,71,72,...            FALSE
      17: 134,135,136,137,138,139,...            FALSE
      18:       88,89,90,91,92,93,...             TRUE
                                   fn_hash               fn_type fn_name fn_call_char
       1: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
       2: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
       3: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
       4: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
       5: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
       6: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
       7: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
       8: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
       9: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
      10: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
      11: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
      12: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
      13: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
      14: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
      15: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
      16: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
      17: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
      18: 813b7f4a4a29eecccb80f54451802205 stat_by_strata_by_trt n_subev   c(n_subev)
                                             stat_result_id       stat_result
       1: 1-0001-0001-813b7f4a4a29eecccb80f54451802205-0001 <data.table[1x4]>
       2: 1-0001-0001-813b7f4a4a29eecccb80f54451802205-0002 <data.table[1x4]>
       3: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0003 <data.table[1x4]>
       4: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0004 <data.table[1x4]>
       5: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0005 <data.table[1x4]>
       6: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0006 <data.table[1x4]>
       7: 1-0002-0001-813b7f4a4a29eecccb80f54451802205-0007 <data.table[1x4]>
       8: 1-0002-0001-813b7f4a4a29eecccb80f54451802205-0008 <data.table[1x4]>
       9: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0009 <data.table[1x4]>
      10: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0010 <data.table[1x4]>
      11: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0011 <data.table[1x4]>
      12: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0012 <data.table[1x4]>
      13: 1-0003-0001-813b7f4a4a29eecccb80f54451802205-0013 <data.table[1x4]>
      14: 1-0003-0001-813b7f4a4a29eecccb80f54451802205-0014 <data.table[1x4]>
      15: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0015 <data.table[1x4]>
      16: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0016 <data.table[1x4]>
      17: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0017 <data.table[1x4]>
      18: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0018 <data.table[1x4]>

# branching after prepare for stats step works

    Code
      ep_stat_nested
    Output
          endpoint_spec_id study_metadata pop_var pop_value treatment_var
       1:                1      <list[0]>   SAFFL         Y        TRT01A
       2:                1      <list[0]>   SAFFL         Y        TRT01A
       3:                1      <list[0]>   SAFFL         Y        TRT01A
       4:                1      <list[0]>   SAFFL         Y        TRT01A
       5:                1      <list[0]>   SAFFL         Y        TRT01A
       6:                1      <list[0]>   SAFFL         Y        TRT01A
       7:                1      <list[0]>   SAFFL         Y        TRT01A
       8:                1      <list[0]>   SAFFL         Y        TRT01A
       9:                1      <list[0]>   SAFFL         Y        TRT01A
      10:                1      <list[0]>   SAFFL         Y        TRT01A
      11:                1      <list[0]>   SAFFL         Y        TRT01A
      12:                1      <list[0]>   SAFFL         Y        TRT01A
              treatment_refval period_var period_value
       1: Xanomeline High Dose       <NA>         <NA>
       2: Xanomeline High Dose       <NA>         <NA>
       3: Xanomeline High Dose       <NA>         <NA>
       4: Xanomeline High Dose       <NA>         <NA>
       5: Xanomeline High Dose       <NA>         <NA>
       6: Xanomeline High Dose       <NA>         <NA>
       7: Xanomeline High Dose       <NA>         <NA>
       8: Xanomeline High Dose       <NA>         <NA>
       9: Xanomeline High Dose       <NA>         <NA>
      10: Xanomeline High Dose       <NA>         <NA>
      11: Xanomeline High Dose       <NA>         <NA>
      12: Xanomeline High Dose       <NA>         <NA>
                                         custom_pop_filter endpoint_filter group_by
       1: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
       2: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
       3: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
       4: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
       5: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
       6: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
       7: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
       8: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
       9: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
      10: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
      11: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
      12: TRT01A %in% c('Placebo', 'Xanomeline High Dose')            <NA>     <NA>
          stratify_by only_strata_with_events                key_analysis_data
       1:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
       2:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
       3:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
       4:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
       5:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
       6:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
       7:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
       8:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
       9:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
      10:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
      11:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
      12:  TOTAL_,SEX                   FALSE 120f7ece5a87ecfa6dc88ba536408205
          expand_specification endpoint_group_filter empty endpoint_group_metadata
       1:                   NA                    NA    NA                        
       2:                   NA                    NA    NA                        
       3:                   NA                    NA    NA                        
       4:                   NA                    NA    NA                        
       5:                   NA                    NA    NA                        
       6:                   NA                    NA    NA                        
       7:                   NA                    NA    NA                        
       8:                   NA                    NA    NA                        
       9:                   NA                    NA    NA                        
      10:                   NA                    NA    NA                        
      11:                   NA                    NA    NA                        
      12:                   NA                    NA    NA                        
          endpoint_id endpoint_label     event_index crit_accept_endpoint strata_var
       1:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE     TOTAL_
       2:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE     TOTAL_
       3:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE     TOTAL_
       4:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE     TOTAL_
       5:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE        SEX
       6:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE        SEX
       7:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE        SEX
       8:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE        SEX
       9:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE        SEX
      10:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE        SEX
      11:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE        SEX
      12:      1-0001           <NA> 1,2,3,4,5,6,...                 TRUE        SEX
            strata_id crit_accept_by_strata_by_trt crit_accept_by_strata_across_trt
       1: 1-0001-0001                         TRUE                             TRUE
       2: 1-0001-0001                         TRUE                             TRUE
       3: 1-0001-0001                         TRUE                             TRUE
       4: 1-0001-0001                         TRUE                             TRUE
       5: 1-0001-0002                         TRUE                             TRUE
       6: 1-0001-0002                         TRUE                             TRUE
       7: 1-0001-0002                         TRUE                             TRUE
       8: 1-0001-0002                         TRUE                             TRUE
       9: 1-0001-0002                         TRUE                             TRUE
      10: 1-0001-0002                         TRUE                             TRUE
      11: 1-0001-0002                         TRUE                             TRUE
      12: 1-0001-0002                         TRUE                             TRUE
          stat_metadata                                          stat_filter
       1:     <list[2]>              TOTAL_ == "total" & TRT01A == "Placebo"
       2:     <list[2]>              TOTAL_ == "total" & TRT01A == "Placebo"
       3:     <list[2]> TOTAL_ == "total" & TRT01A == "Xanomeline High Dose"
       4:     <list[2]> TOTAL_ == "total" & TRT01A == "Xanomeline High Dose"
       5:     <list[2]>                     SEX == "F" & TRT01A == "Placebo"
       6:     <list[2]>                     SEX == "F" & TRT01A == "Placebo"
       7:     <list[2]>                     SEX == "M" & TRT01A == "Placebo"
       8:     <list[2]>                     SEX == "M" & TRT01A == "Placebo"
       9:     <list[2]>        SEX == "F" & TRT01A == "Xanomeline High Dose"
      10:     <list[2]>        SEX == "F" & TRT01A == "Xanomeline High Dose"
      11:     <list[2]>        SEX == "M" & TRT01A == "Xanomeline High Dose"
      12:     <list[2]>        SEX == "M" & TRT01A == "Xanomeline High Dose"
                     cell_index stat_event_exist                          fn_hash
       1:       1,2,3,4,5,6,...             TRUE 150a10ab5600d4260be332983e69a451
       2:       1,2,3,4,5,6,...             TRUE afd3cffa8b1c850f902a32f4d7ac19fe
       3:  8, 9,11,12,54,55,...             TRUE 150a10ab5600d4260be332983e69a451
       4:  8, 9,11,12,54,55,...             TRUE afd3cffa8b1c850f902a32f4d7ac19fe
       5:  1, 2, 3,13,14,15,...             TRUE 150a10ab5600d4260be332983e69a451
       6:  1, 2, 3,13,14,15,...             TRUE afd3cffa8b1c850f902a32f4d7ac19fe
       7:  4, 5, 6, 7,45,46,...             TRUE 150a10ab5600d4260be332983e69a451
       8:  4, 5, 6, 7,45,46,...             TRUE afd3cffa8b1c850f902a32f4d7ac19fe
       9: 11,12,54,55,56,57,...             TRUE 150a10ab5600d4260be332983e69a451
      10: 11,12,54,55,56,57,...             TRUE afd3cffa8b1c850f902a32f4d7ac19fe
      11:  8, 9,70,71,72,73,...             TRUE 150a10ab5600d4260be332983e69a451
      12:  8, 9,70,71,72,73,...             TRUE afd3cffa8b1c850f902a32f4d7ac19fe
                        fn_type fn_name fn_call_char
       1: stat_by_strata_by_trt    fn_1   c(n_subev)
       2: stat_by_strata_by_trt    fn_2     c(n_sub)
       3: stat_by_strata_by_trt    fn_1   c(n_subev)
       4: stat_by_strata_by_trt    fn_2     c(n_sub)
       5: stat_by_strata_by_trt    fn_1   c(n_subev)
       6: stat_by_strata_by_trt    fn_2     c(n_sub)
       7: stat_by_strata_by_trt    fn_1   c(n_subev)
       8: stat_by_strata_by_trt    fn_2     c(n_sub)
       9: stat_by_strata_by_trt    fn_1   c(n_subev)
      10: stat_by_strata_by_trt    fn_2     c(n_sub)
      11: stat_by_strata_by_trt    fn_1   c(n_subev)
      12: stat_by_strata_by_trt    fn_2     c(n_sub)
                                             stat_result_id       stat_result
       1: 1-0001-0001-150a10ab5600d4260be332983e69a451-0001 <data.table[1x4]>
       2: 1-0001-0001-afd3cffa8b1c850f902a32f4d7ac19fe-0002 <data.table[1x4]>
       3: 1-0001-0001-150a10ab5600d4260be332983e69a451-0003 <data.table[1x4]>
       4: 1-0001-0001-afd3cffa8b1c850f902a32f4d7ac19fe-0004 <data.table[1x4]>
       5: 1-0001-0002-150a10ab5600d4260be332983e69a451-0005 <data.table[1x4]>
       6: 1-0001-0002-afd3cffa8b1c850f902a32f4d7ac19fe-0006 <data.table[1x4]>
       7: 1-0001-0002-150a10ab5600d4260be332983e69a451-0007 <data.table[1x4]>
       8: 1-0001-0002-afd3cffa8b1c850f902a32f4d7ac19fe-0008 <data.table[1x4]>
       9: 1-0001-0002-150a10ab5600d4260be332983e69a451-0009 <data.table[1x4]>
      10: 1-0001-0002-afd3cffa8b1c850f902a32f4d7ac19fe-0010 <data.table[1x4]>
      11: 1-0001-0002-150a10ab5600d4260be332983e69a451-0011 <data.table[1x4]>
      12: 1-0001-0002-afd3cffa8b1c850f902a32f4d7ac19fe-0012 <data.table[1x4]>
