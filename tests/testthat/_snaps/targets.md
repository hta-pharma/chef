# Non-branching targets pipeline works

    Code
      ep_stat
    Output
          endpoint_spec_id study_metadata pop_var pop_value treatment_var
                     <int>         <list>  <char>    <char>        <char>
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
                        <char>     <char>       <char>
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
                                                    <char>          <char>    <list>
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
          stratify_by                key_analysis_data  empty endpoint_group_metadata
               <list>                           <char> <lgcl>                  <list>
       1:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       2:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       3:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       4:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       5:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       6:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       7:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       8:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       9:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      10:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      11:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      12:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      13:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      14:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      15:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      16:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      17:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      18:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      19:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      20:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      21:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      22:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      23:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      24:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      25:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      26:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      27:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      28:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      29:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      30:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      31:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      32:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      33:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      34:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      35:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      36:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
          stratify_by                key_analysis_data  empty endpoint_group_metadata
                               endpoint_group_filter endpoint_id endpoint_label
                                              <char>      <char>         <char>
       1:                            RACE == "WHITE"      1-0001              A
       2:                            RACE == "WHITE"      1-0001              A
       3:                            RACE == "WHITE"      1-0001              A
       4:                            RACE == "WHITE"      1-0001              A
       5:                            RACE == "WHITE"      1-0001              A
       6:                            RACE == "WHITE"      1-0001              A
       7:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
       8:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
       9:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      10:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      11:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      12:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      13: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      14: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      15: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      16: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      17: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      18: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      19:                            RACE == "WHITE"      1-0001              A
      20:                            RACE == "WHITE"      1-0001              A
      21:                            RACE == "WHITE"      1-0001              A
      22:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      23:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      24:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      25: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      26: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      27: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      28:                            RACE == "WHITE"      1-0001              A
      29:                            RACE == "WHITE"      1-0001              A
      30:                            RACE == "WHITE"      1-0001              A
      31:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      32:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      33:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      34: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      35: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      36: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
                               endpoint_group_filter endpoint_id endpoint_label
                                event_index crit_accept_endpoint strata_var
                                     <list>               <lgcl>     <char>
       1:                   1,2,3,4,5,6,...                 TRUE     TOTAL_
       2:                   1,2,3,4,5,6,...                 TRUE     TOTAL_
       3:                   1,2,3,4,5,6,...                 TRUE        SEX
       4:                   1,2,3,4,5,6,...                 TRUE        SEX
       5:                   1,2,3,4,5,6,...                 TRUE        SEX
       6:                   1,2,3,4,5,6,...                 TRUE        SEX
       7:  670, 671, 672, 673,1057,1058,...                 TRUE     TOTAL_
       8:  670, 671, 672, 673,1057,1058,...                 TRUE     TOTAL_
       9:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      10:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      11:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      12:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      13:                   783,784,785,786                 TRUE     TOTAL_
      14:                   783,784,785,786                 TRUE     TOTAL_
      15:                   783,784,785,786                 TRUE        SEX
      16:                   783,784,785,786                 TRUE        SEX
      17:                   783,784,785,786                 TRUE        SEX
      18:                   783,784,785,786                 TRUE        SEX
      19:                   1,2,3,4,5,6,...                 TRUE     TOTAL_
      20:                   1,2,3,4,5,6,...                 TRUE        SEX
      21:                   1,2,3,4,5,6,...                 TRUE        SEX
      22:  670, 671, 672, 673,1057,1058,...                 TRUE     TOTAL_
      23:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      24:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      25:                   783,784,785,786                 TRUE     TOTAL_
      26:                   783,784,785,786                 TRUE        SEX
      27:                   783,784,785,786                 TRUE        SEX
      28:                   1,2,3,4,5,6,...                 TRUE        SEX
      29:                   1,2,3,4,5,6,...                 TRUE        SEX
      30:                   1,2,3,4,5,6,...                 TRUE        SEX
      31:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      32:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      33:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      34:                   783,784,785,786                 TRUE        SEX
      35:                   783,784,785,786                 TRUE        SEX
      36:                   783,784,785,786                 TRUE        SEX
                                event_index crit_accept_endpoint strata_var
            strata_id crit_accept_by_strata_by_trt crit_accept_by_strata_across_trt
               <char>                       <lgcl>                           <lgcl>
       1: 1-0001-0001                         TRUE                             TRUE
       2: 1-0001-0001                         TRUE                             TRUE
       3: 1-0001-0002                         TRUE                             TRUE
       4: 1-0001-0002                         TRUE                             TRUE
       5: 1-0001-0002                         TRUE                             TRUE
       6: 1-0001-0002                         TRUE                             TRUE
       7: 1-0002-0001                         TRUE                             TRUE
       8: 1-0002-0001                         TRUE                             TRUE
       9: 1-0002-0002                         TRUE                             TRUE
      10: 1-0002-0002                         TRUE                             TRUE
      11: 1-0002-0002                         TRUE                             TRUE
      12: 1-0002-0002                         TRUE                             TRUE
      13: 1-0003-0001                         TRUE                             TRUE
      14: 1-0003-0001                         TRUE                             TRUE
      15: 1-0003-0002                         TRUE                             TRUE
      16: 1-0003-0002                         TRUE                             TRUE
      17: 1-0003-0002                         TRUE                             TRUE
      18: 1-0003-0002                         TRUE                             TRUE
      19: 1-0001-0001                         TRUE                             TRUE
      20: 1-0001-0002                         TRUE                             TRUE
      21: 1-0001-0002                         TRUE                             TRUE
      22: 1-0002-0001                         TRUE                             TRUE
      23: 1-0002-0002                         TRUE                             TRUE
      24: 1-0002-0002                         TRUE                             TRUE
      25: 1-0003-0001                         TRUE                             TRUE
      26: 1-0003-0002                         TRUE                             TRUE
      27: 1-0003-0002                         TRUE                             TRUE
      28: 1-0001-0002                         TRUE                             TRUE
      29: 1-0001-0002                         TRUE                             TRUE
      30: 1-0001-0002                         TRUE                             TRUE
      31: 1-0002-0002                         TRUE                             TRUE
      32: 1-0002-0002                         TRUE                             TRUE
      33: 1-0002-0002                         TRUE                             TRUE
      34: 1-0003-0002                         TRUE                             TRUE
      35: 1-0003-0002                         TRUE                             TRUE
      36: 1-0003-0002                         TRUE                             TRUE
            strata_id crit_accept_by_strata_by_trt crit_accept_by_strata_across_trt
                                   fn_hash                       fn_type
                                    <char>                        <char>
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
                   fn_name                  fn_call_char stat_empty stat_metadata
                    <char>                        <char>     <lgcl>        <list>
       1:          n_subev                    c(n_subev)      FALSE     <list[2]>
       2:          n_subev                    c(n_subev)      FALSE     <list[2]>
       3:          n_subev                    c(n_subev)      FALSE     <list[2]>
       4:          n_subev                    c(n_subev)      FALSE     <list[2]>
       5:          n_subev                    c(n_subev)      FALSE     <list[2]>
       6:          n_subev                    c(n_subev)      FALSE     <list[2]>
       7:          n_subev                    c(n_subev)      FALSE     <list[2]>
       8:          n_subev                    c(n_subev)      FALSE     <list[2]>
       9:          n_subev                    c(n_subev)      FALSE     <list[2]>
      10:          n_subev                    c(n_subev)      FALSE     <list[2]>
      11:          n_subev                    c(n_subev)      FALSE     <list[2]>
      12:          n_subev                    c(n_subev)      FALSE     <list[2]>
      13:          n_subev                    c(n_subev)      FALSE     <list[2]>
      14:          n_subev                    c(n_subev)      FALSE     <list[2]>
      15:          n_subev                    c(n_subev)      FALSE     <list[2]>
      16:          n_subev                    c(n_subev)      FALSE     <list[2]>
      17:          n_subev                    c(n_subev)      FALSE     <list[2]>
      18:          n_subev                    c(n_subev)      FALSE     <list[2]>
      19: n_subev_trt_diff           c(n_subev_trt_diff)      FALSE     <list[1]>
      20: n_subev_trt_diff           c(n_subev_trt_diff)      FALSE     <list[1]>
      21: n_subev_trt_diff           c(n_subev_trt_diff)      FALSE     <list[1]>
      22: n_subev_trt_diff           c(n_subev_trt_diff)      FALSE     <list[1]>
      23: n_subev_trt_diff           c(n_subev_trt_diff)      FALSE     <list[1]>
      24: n_subev_trt_diff           c(n_subev_trt_diff)      FALSE     <list[1]>
      25: n_subev_trt_diff           c(n_subev_trt_diff)      FALSE     <list[1]>
      26: n_subev_trt_diff           c(n_subev_trt_diff)      FALSE     <list[1]>
      27: n_subev_trt_diff           c(n_subev_trt_diff)      FALSE     <list[1]>
      28:    P-interaction c(contingency2x2_strata_test)      FALSE     <list[2]>
      29:    P-interaction c(contingency2x2_strata_test)      FALSE     <list[2]>
      30:    P-interaction c(contingency2x2_strata_test)      FALSE     <list[2]>
      31:    P-interaction c(contingency2x2_strata_test)      FALSE     <list[2]>
      32:    P-interaction c(contingency2x2_strata_test)      FALSE     <list[2]>
      33:    P-interaction c(contingency2x2_strata_test)      FALSE     <list[2]>
      34:    P-interaction c(contingency2x2_strata_test)      FALSE     <list[2]>
      35:    P-interaction c(contingency2x2_strata_test)      FALSE     <list[2]>
      36:    P-interaction c(contingency2x2_strata_test)      FALSE     <list[2]>
                   fn_name                  fn_call_char stat_empty stat_metadata
                                                   stat_filter
                                                        <char>
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
                                             stat_result_id
                                                     <char>
       1: 1-0001-0001-813b7f4a4a29eecccb80f54451802205-0001
       2: 1-0001-0001-813b7f4a4a29eecccb80f54451802205-0002
       3: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0003
       4: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0004
       5: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0005
       6: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0006
       7: 1-0002-0001-813b7f4a4a29eecccb80f54451802205-0007
       8: 1-0002-0001-813b7f4a4a29eecccb80f54451802205-0008
       9: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0009
      10: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0010
      11: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0011
      12: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0012
      13: 1-0003-0001-813b7f4a4a29eecccb80f54451802205-0013
      14: 1-0003-0001-813b7f4a4a29eecccb80f54451802205-0014
      15: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0015
      16: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0016
      17: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0017
      18: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0018
      19: 1-0001-0001-f60151928d92ca8d670863797256c7c6-0001
      20: 1-0001-0002-f60151928d92ca8d670863797256c7c6-0002
      21: 1-0001-0002-f60151928d92ca8d670863797256c7c6-0003
      22: 1-0002-0001-f60151928d92ca8d670863797256c7c6-0004
      23: 1-0002-0002-f60151928d92ca8d670863797256c7c6-0005
      24: 1-0002-0002-f60151928d92ca8d670863797256c7c6-0006
      25: 1-0003-0001-f60151928d92ca8d670863797256c7c6-0007
      26: 1-0003-0002-f60151928d92ca8d670863797256c7c6-0008
      27: 1-0003-0002-f60151928d92ca8d670863797256c7c6-0009
      28: 1-0001-0002-dc43955ca4ffa21cc694e5987fe454f7-0001
      29: 1-0001-0002-dc43955ca4ffa21cc694e5987fe454f7-0001
      30: 1-0001-0002-dc43955ca4ffa21cc694e5987fe454f7-0001
      31: 1-0002-0002-dc43955ca4ffa21cc694e5987fe454f7-0002
      32: 1-0002-0002-dc43955ca4ffa21cc694e5987fe454f7-0002
      33: 1-0002-0002-dc43955ca4ffa21cc694e5987fe454f7-0002
      34: 1-0003-0002-dc43955ca4ffa21cc694e5987fe454f7-0003
      35: 1-0003-0002-dc43955ca4ffa21cc694e5987fe454f7-0003
      36: 1-0003-0002-dc43955ca4ffa21cc694e5987fe454f7-0003
                                             stat_result_id
                           cell_index stat_result_label
                               <list>            <char>
       1:             1,2,3,4,5,6,...                 n
       2:       88,89,90,91,92,93,...                 n
       3:             1,2,3,4,5,6,...                 n
       4:       67,68,69,70,71,72,...                 n
       5: 134,135,136,137,138,139,...                 n
       6:       88,89,90,91,92,93,...                 n
       7:             1,2,3,4,5,6,...                 n
       8:       88,89,90,91,92,93,...                 n
       9:             1,2,3,4,5,6,...                 n
      10:       67,68,69,70,71,72,...                 n
      11: 134,135,136,137,138,139,...                 n
      12:       88,89,90,91,92,93,...                 n
      13:             1,2,3,4,5,6,...                 n
      14:       88,89,90,91,92,93,...                 n
      15:             1,2,3,4,5,6,...                 n
      16:       67,68,69,70,71,72,...                 n
      17: 134,135,136,137,138,139,...                 n
      18:       88,89,90,91,92,93,...                 n
      19:             1,2,3,4,5,6,...        n_trt_diff
      20:             1,2,3,4,5,6,...        n_trt_diff
      21:       67,68,69,70,71,72,...        n_trt_diff
      22:             1,2,3,4,5,6,...        n_trt_diff
      23:             1,2,3,4,5,6,...        n_trt_diff
      24:       67,68,69,70,71,72,...        n_trt_diff
      25:             1,2,3,4,5,6,...        n_trt_diff
      26:             1,2,3,4,5,6,...        n_trt_diff
      27:       67,68,69,70,71,72,...        n_trt_diff
      28:             1,2,3,4,5,6,... Pval_independency
      29:             1,2,3,4,5,6,...          CI_lower
      30:             1,2,3,4,5,6,...          CI_upper
      31:             1,2,3,4,5,6,... Pval_independency
      32:             1,2,3,4,5,6,...          CI_lower
      33:             1,2,3,4,5,6,...          CI_upper
      34:             1,2,3,4,5,6,... Pval_independency
      35:             1,2,3,4,5,6,...          CI_lower
      36:             1,2,3,4,5,6,...          CI_upper
                           cell_index stat_result_label
                                                               stat_result_description
                                                                                <char>
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
                          <char>             <num>
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
                     <int>         <list>  <char>    <char>        <char>
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
                        <char>     <char>       <char>
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
                                                    <char>          <char>    <list>
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
          stratify_by                key_analysis_data  empty endpoint_group_metadata
               <list>                           <char> <lgcl>                  <list>
       1:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       2:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       3:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       4:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       5:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       6:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       7:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       8:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
       9:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      10:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      11:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      12:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      13:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      14:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      15:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      16:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      17:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
      18:  TOTAL_,SEX 7c0c6f888257b34f6374728fd6ea93c0  FALSE               <list[1]>
                               endpoint_group_filter endpoint_id endpoint_label
                                              <char>      <char>         <char>
       1:                            RACE == "WHITE"      1-0001              A
       2:                            RACE == "WHITE"      1-0001              A
       3:                            RACE == "WHITE"      1-0001              A
       4:                            RACE == "WHITE"      1-0001              A
       5:                            RACE == "WHITE"      1-0001              A
       6:                            RACE == "WHITE"      1-0001              A
       7:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
       8:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
       9:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      10:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      11:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      12:        RACE == "BLACK OR AFRICAN AMERICAN"      1-0002              A
      13: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      14: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      15: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      16: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      17: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
      18: RACE == "AMERICAN INDIAN OR ALASKA NATIVE"      1-0003              A
                                event_index crit_accept_endpoint strata_var
                                     <list>               <lgcl>     <char>
       1:                   1,2,3,4,5,6,...                 TRUE     TOTAL_
       2:                   1,2,3,4,5,6,...                 TRUE     TOTAL_
       3:                   1,2,3,4,5,6,...                 TRUE        SEX
       4:                   1,2,3,4,5,6,...                 TRUE        SEX
       5:                   1,2,3,4,5,6,...                 TRUE        SEX
       6:                   1,2,3,4,5,6,...                 TRUE        SEX
       7:  670, 671, 672, 673,1057,1058,...                 TRUE     TOTAL_
       8:  670, 671, 672, 673,1057,1058,...                 TRUE     TOTAL_
       9:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      10:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      11:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      12:  670, 671, 672, 673,1057,1058,...                 TRUE        SEX
      13:                   783,784,785,786                 TRUE     TOTAL_
      14:                   783,784,785,786                 TRUE     TOTAL_
      15:                   783,784,785,786                 TRUE        SEX
      16:                   783,784,785,786                 TRUE        SEX
      17:                   783,784,785,786                 TRUE        SEX
      18:                   783,784,785,786                 TRUE        SEX
            strata_id crit_accept_by_strata_by_trt crit_accept_by_strata_across_trt
               <char>                       <lgcl>                           <lgcl>
       1: 1-0001-0001                         TRUE                             TRUE
       2: 1-0001-0001                         TRUE                             TRUE
       3: 1-0001-0002                         TRUE                             TRUE
       4: 1-0001-0002                         TRUE                             TRUE
       5: 1-0001-0002                         TRUE                             TRUE
       6: 1-0001-0002                         TRUE                             TRUE
       7: 1-0002-0001                         TRUE                             TRUE
       8: 1-0002-0001                         TRUE                             TRUE
       9: 1-0002-0002                         TRUE                             TRUE
      10: 1-0002-0002                         TRUE                             TRUE
      11: 1-0002-0002                         TRUE                             TRUE
      12: 1-0002-0002                         TRUE                             TRUE
      13: 1-0003-0001                         TRUE                             TRUE
      14: 1-0003-0001                         TRUE                             TRUE
      15: 1-0003-0002                         TRUE                             TRUE
      16: 1-0003-0002                         TRUE                             TRUE
      17: 1-0003-0002                         TRUE                             TRUE
      18: 1-0003-0002                         TRUE                             TRUE
                                   fn_hash               fn_type fn_name fn_call_char
                                    <char>                <char>  <char>       <char>
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
          stat_empty stat_metadata
              <lgcl>        <list>
       1:      FALSE     <list[2]>
       2:      FALSE     <list[2]>
       3:      FALSE     <list[2]>
       4:      FALSE     <list[2]>
       5:      FALSE     <list[2]>
       6:      FALSE     <list[2]>
       7:      FALSE     <list[2]>
       8:      FALSE     <list[2]>
       9:      FALSE     <list[2]>
      10:      FALSE     <list[2]>
      11:      FALSE     <list[2]>
      12:      FALSE     <list[2]>
      13:      FALSE     <list[2]>
      14:      FALSE     <list[2]>
      15:      FALSE     <list[2]>
      16:      FALSE     <list[2]>
      17:      FALSE     <list[2]>
      18:      FALSE     <list[2]>
                                                   stat_filter
                                                        <char>
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
                                             stat_result_id
                                                     <char>
       1: 1-0001-0001-813b7f4a4a29eecccb80f54451802205-0001
       2: 1-0001-0001-813b7f4a4a29eecccb80f54451802205-0002
       3: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0003
       4: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0004
       5: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0005
       6: 1-0001-0002-813b7f4a4a29eecccb80f54451802205-0006
       7: 1-0002-0001-813b7f4a4a29eecccb80f54451802205-0007
       8: 1-0002-0001-813b7f4a4a29eecccb80f54451802205-0008
       9: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0009
      10: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0010
      11: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0011
      12: 1-0002-0002-813b7f4a4a29eecccb80f54451802205-0012
      13: 1-0003-0001-813b7f4a4a29eecccb80f54451802205-0013
      14: 1-0003-0001-813b7f4a4a29eecccb80f54451802205-0014
      15: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0015
      16: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0016
      17: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0017
      18: 1-0003-0002-813b7f4a4a29eecccb80f54451802205-0018
                           cell_index       stat_result
                               <list>            <list>
       1:             1,2,3,4,5,6,... <data.table[1x4]>
       2:       88,89,90,91,92,93,... <data.table[1x4]>
       3:             1,2,3,4,5,6,... <data.table[1x4]>
       4:       67,68,69,70,71,72,... <data.table[1x4]>
       5: 134,135,136,137,138,139,... <data.table[1x4]>
       6:       88,89,90,91,92,93,... <data.table[1x4]>
       7:             1,2,3,4,5,6,... <data.table[1x4]>
       8:       88,89,90,91,92,93,... <data.table[1x4]>
       9:             1,2,3,4,5,6,... <data.table[1x4]>
      10:       67,68,69,70,71,72,... <data.table[1x4]>
      11: 134,135,136,137,138,139,... <data.table[1x4]>
      12:       88,89,90,91,92,93,... <data.table[1x4]>
      13:             1,2,3,4,5,6,... <data.table[1x4]>
      14:       88,89,90,91,92,93,... <data.table[1x4]>
      15:             1,2,3,4,5,6,... <data.table[1x4]>
      16:       67,68,69,70,71,72,... <data.table[1x4]>
      17: 134,135,136,137,138,139,... <data.table[1x4]>
      18:       88,89,90,91,92,93,... <data.table[1x4]>

# branching after prepare for stats step works

    Code
      ep_stat_nested
    Output
          endpoint_spec_id study_metadata pop_var pop_value treatment_var
                     <int>         <list>  <char>    <char>        <char>
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
                        <char>     <char>       <char>
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
                                                    <char>          <char>   <char>
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
          stratify_by                key_analysis_data expand_specification
               <list>                           <char>               <lgcl>
       1:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
       2:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
       3:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
       4:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
       5:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
       6:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
       7:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
       8:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
       9:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
      10:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
      11:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
      12:  TOTAL_,SEX 120f7ece5a87ecfa6dc88ba536408205                   NA
          endpoint_group_filter  empty endpoint_group_metadata endpoint_id
                         <lgcl> <lgcl>                  <list>      <char>
       1:                    NA     NA                              1-0001
       2:                    NA     NA                              1-0001
       3:                    NA     NA                              1-0001
       4:                    NA     NA                              1-0001
       5:                    NA     NA                              1-0001
       6:                    NA     NA                              1-0001
       7:                    NA     NA                              1-0001
       8:                    NA     NA                              1-0001
       9:                    NA     NA                              1-0001
      10:                    NA     NA                              1-0001
      11:                    NA     NA                              1-0001
      12:                    NA     NA                              1-0001
          endpoint_label     event_index crit_accept_endpoint strata_var   strata_id
                  <char>          <list>               <lgcl>     <char>      <char>
       1:           <NA> 1,2,3,4,5,6,...                 TRUE     TOTAL_ 1-0001-0001
       2:           <NA> 1,2,3,4,5,6,...                 TRUE     TOTAL_ 1-0001-0001
       3:           <NA> 1,2,3,4,5,6,...                 TRUE     TOTAL_ 1-0001-0001
       4:           <NA> 1,2,3,4,5,6,...                 TRUE     TOTAL_ 1-0001-0001
       5:           <NA> 1,2,3,4,5,6,...                 TRUE        SEX 1-0001-0002
       6:           <NA> 1,2,3,4,5,6,...                 TRUE        SEX 1-0001-0002
       7:           <NA> 1,2,3,4,5,6,...                 TRUE        SEX 1-0001-0002
       8:           <NA> 1,2,3,4,5,6,...                 TRUE        SEX 1-0001-0002
       9:           <NA> 1,2,3,4,5,6,...                 TRUE        SEX 1-0001-0002
      10:           <NA> 1,2,3,4,5,6,...                 TRUE        SEX 1-0001-0002
      11:           <NA> 1,2,3,4,5,6,...                 TRUE        SEX 1-0001-0002
      12:           <NA> 1,2,3,4,5,6,...                 TRUE        SEX 1-0001-0002
          crit_accept_by_strata_by_trt crit_accept_by_strata_across_trt
                                <lgcl>                           <lgcl>
       1:                         TRUE                             TRUE
       2:                         TRUE                             TRUE
       3:                         TRUE                             TRUE
       4:                         TRUE                             TRUE
       5:                         TRUE                             TRUE
       6:                         TRUE                             TRUE
       7:                         TRUE                             TRUE
       8:                         TRUE                             TRUE
       9:                         TRUE                             TRUE
      10:                         TRUE                             TRUE
      11:                         TRUE                             TRUE
      12:                         TRUE                             TRUE
                                   fn_hash               fn_type fn_name fn_call_char
                                    <char>                <char>  <char>       <char>
       1: 150a10ab5600d4260be332983e69a451 stat_by_strata_by_trt    fn_1   c(n_subev)
       2: 150a10ab5600d4260be332983e69a451 stat_by_strata_by_trt    fn_1   c(n_subev)
       3: afd3cffa8b1c850f902a32f4d7ac19fe stat_by_strata_by_trt    fn_2     c(n_sub)
       4: afd3cffa8b1c850f902a32f4d7ac19fe stat_by_strata_by_trt    fn_2     c(n_sub)
       5: 150a10ab5600d4260be332983e69a451 stat_by_strata_by_trt    fn_1   c(n_subev)
       6: 150a10ab5600d4260be332983e69a451 stat_by_strata_by_trt    fn_1   c(n_subev)
       7: 150a10ab5600d4260be332983e69a451 stat_by_strata_by_trt    fn_1   c(n_subev)
       8: 150a10ab5600d4260be332983e69a451 stat_by_strata_by_trt    fn_1   c(n_subev)
       9: afd3cffa8b1c850f902a32f4d7ac19fe stat_by_strata_by_trt    fn_2     c(n_sub)
      10: afd3cffa8b1c850f902a32f4d7ac19fe stat_by_strata_by_trt    fn_2     c(n_sub)
      11: afd3cffa8b1c850f902a32f4d7ac19fe stat_by_strata_by_trt    fn_2     c(n_sub)
      12: afd3cffa8b1c850f902a32f4d7ac19fe stat_by_strata_by_trt    fn_2     c(n_sub)
          stat_empty stat_metadata
              <lgcl>        <list>
       1:      FALSE     <list[2]>
       2:      FALSE     <list[2]>
       3:      FALSE     <list[2]>
       4:      FALSE     <list[2]>
       5:      FALSE     <list[2]>
       6:      FALSE     <list[2]>
       7:      FALSE     <list[2]>
       8:      FALSE     <list[2]>
       9:      FALSE     <list[2]>
      10:      FALSE     <list[2]>
      11:      FALSE     <list[2]>
      12:      FALSE     <list[2]>
                                                   stat_filter
                                                        <char>
       1:              TOTAL_ == "total" & TRT01A == "Placebo"
       2: TOTAL_ == "total" & TRT01A == "Xanomeline High Dose"
       3:              TOTAL_ == "total" & TRT01A == "Placebo"
       4: TOTAL_ == "total" & TRT01A == "Xanomeline High Dose"
       5:                     SEX == "F" & TRT01A == "Placebo"
       6:                     SEX == "M" & TRT01A == "Placebo"
       7:        SEX == "F" & TRT01A == "Xanomeline High Dose"
       8:        SEX == "M" & TRT01A == "Xanomeline High Dose"
       9:                     SEX == "F" & TRT01A == "Placebo"
      10:                     SEX == "M" & TRT01A == "Placebo"
      11:        SEX == "F" & TRT01A == "Xanomeline High Dose"
      12:        SEX == "M" & TRT01A == "Xanomeline High Dose"
                                             stat_result_id            cell_index
                                                     <char>                <list>
       1: 1-0001-0001-150a10ab5600d4260be332983e69a451-0001       1,2,3,4,5,6,...
       2: 1-0001-0001-150a10ab5600d4260be332983e69a451-0002  8, 9,11,12,54,55,...
       3: 1-0001-0001-afd3cffa8b1c850f902a32f4d7ac19fe-0003       1,2,3,4,5,6,...
       4: 1-0001-0001-afd3cffa8b1c850f902a32f4d7ac19fe-0004  8, 9,11,12,54,55,...
       5: 1-0001-0002-150a10ab5600d4260be332983e69a451-0005  1, 2, 3,13,14,15,...
       6: 1-0001-0002-150a10ab5600d4260be332983e69a451-0006  4, 5, 6, 7,45,46,...
       7: 1-0001-0002-150a10ab5600d4260be332983e69a451-0007 11,12,54,55,56,57,...
       8: 1-0001-0002-150a10ab5600d4260be332983e69a451-0008  8, 9,70,71,72,73,...
       9: 1-0001-0002-afd3cffa8b1c850f902a32f4d7ac19fe-0009  1, 2, 3,13,14,15,...
      10: 1-0001-0002-afd3cffa8b1c850f902a32f4d7ac19fe-0010  4, 5, 6, 7,45,46,...
      11: 1-0001-0002-afd3cffa8b1c850f902a32f4d7ac19fe-0011 11,12,54,55,56,57,...
      12: 1-0001-0002-afd3cffa8b1c850f902a32f4d7ac19fe-0012  8, 9,70,71,72,73,...
                stat_result
                     <list>
       1: <data.table[1x4]>
       2: <data.table[1x4]>
       3: <data.table[1x4]>
       4: <data.table[1x4]>
       5: <data.table[1x4]>
       6: <data.table[1x4]>
       7: <data.table[1x4]>
       8: <data.table[1x4]>
       9: <data.table[1x4]>
      10: <data.table[1x4]>
      11: <data.table[1x4]>
      12: <data.table[1x4]>

