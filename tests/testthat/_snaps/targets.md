# Base case: targets pipeline works

    Code
      ep_stat$stat_result_value
    Output
       [1] 45.0000000 46.0000000 26.0000000 19.0000000 18.0000000 28.0000000
       [7]  5.0000000  4.0000000  4.0000000  1.0000000  3.0000000  1.0000000
      [13]  0.0000000  1.0000000  0.0000000  0.0000000  0.0000000  1.0000000
      [19]  1.0000000  8.0000000  9.0000000  1.0000000  1.0000000  0.0000000
      [25]         NA         NA         NA  0.2988316  0.7781907  2.8523901
      [31]  0.9117548  0.2753674  4.2408159  0.3449651        NaN        NaN

# targets pipeline works no criteria fn and missing by_* functions

    Code
      ep_stat$stat_result_value
    Output
       [1] 45 46 26 19 18 28  5  4  4  1  3  1  0  1  0  0  0  1

# branching after prepare for stats step works

    Code
      ep_stat$stat_result_value
    Output
       [1] 86 86 72 72 53 53 33 33 35 35 37 37

