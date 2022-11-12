ST558 Project 3 Group F
================
Magaritte Nguyen and Matthew Sookoo
2022-11-12

-   <a href="#introduction" id="toc-introduction">Introduction</a>
-   <a href="#required-packages" id="toc-required-packages">Required
    Packages</a>
-   <a href="#data" id="toc-data">Data</a>
-   <a href="#summarizations" id="toc-summarizations">Summarizations</a>
-   <a href="#project-work" id="toc-project-work">Project Work</a>
-   <a href="#repo-setting" id="toc-repo-setting">Repo Setting</a>
-   <a href="#blog" id="toc-blog">Blog</a>
-   <a href="#topic" id="toc-topic">Topic</a>
-   <a href="#report" id="toc-report">Report</a>
-   <a href="#summarizations-1" id="toc-summarizations-1">Summarizations</a>
-   <a href="#modeling" id="toc-modeling">Modeling</a>
-   <a href="#comparison" id="toc-comparison">Comparison</a>
-   <a href="#automation" id="toc-automation">Automation</a>
-   <a href="#submission" id="toc-submission">Submission</a>

<!-- 
############################################################# 
#############################################################
### Project 3 Group F
############################################################# 
############################################################# 
-->
<!-- setup -->

# Introduction

Our goal with this project is to create predictive models and automating
Markdown reports. This dataset summarizes a heterogeneous set of
features about articles published by Mashable (www.mashable.com) over a
period of two years. We will summarize the data and try to predict the
number of shares using linear regression, Random forest and boosting
(will add more later)

-   briefly describes the data and the variables you have to work with
    (just discuss the ones you want to use).

-   Your target variables is the shares variable.

-   mention the purpose of your analysis and the methods you’ll use to
    model the response.

-   You’ll describe those in more detail later.

Data Set Information:

-   The articles were published by Mashable (www.mashable.com) and their
    content as the rights to reproduce it belongs to them. Hence, this
    dataset does not share the original content but some statistics
    associated with it. The original content be publicly accessed and
    retrieved using the provided urls.

-   Acquisition date: January 8, 2015

-   The estimated relative performance values were estimated by the
    authors using a Random Forest classifier and a rolling windows as
    assessment method. See their article for more details on how the
    relative performance values were set.

# Required Packages

To use the functions for interacting with the API, the following
packages are used:

-   `tidyverse`: Tons of useful features for data manipulation and
    visualization!
-   `caret`: Used for predictive modelling.

MORE ADDED LATER AS REQUIRED…

<!-- packages that we are calling via library() function -->

# Data

Firstly, we read in the data using `read_csv()`

``` r
#check working directory
getwd()
```

    ## [1] "D:/ST558/Project 3/ST558_Project3_GroupF"

``` r
#reassign working directory
#Magaritte's directory
setwd("D:/ST558/Project 3/ST558_Project3_GroupF")
#Matthew's directory
#setwd("C:\\Users\\Home Pc\\Desktop\\ST558 Project 3 new\\ST558_Project3_GroupF\\")

#read in data set .csv file in full
#make sure that this is a relative path used...
OnlineNewsPopularity<-read_csv("OnlineNewsPopularity.csv", show_col_types = FALSE)

#call object OnlineNewsPopularity - our full raw data
OnlineNewsPopularity
```

    ## # A tibble: 39,644 × 61
    ##    url   timed…¹ n_tok…² n_tok…³ n_uni…⁴ n_non…⁵ n_non…⁶ num_h…⁷ num_s…⁸ num_i…⁹
    ##    <chr>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
    ##  1 http…     731      12     219   0.664    1.00   0.815       4       2       1
    ##  2 http…     731       9     255   0.605    1.00   0.792       3       1       1
    ##  3 http…     731       9     211   0.575    1.00   0.664       3       1       1
    ##  4 http…     731       9     531   0.504    1.00   0.666       9       0       1
    ##  5 http…     731      13    1072   0.416    1.00   0.541      19      19      20
    ##  6 http…     731      10     370   0.560    1.00   0.698       2       2       0
    ##  7 http…     731       8     960   0.418    1.00   0.550      21      20      20
    ##  8 http…     731      12     989   0.434    1.00   0.572      20      20      20
    ##  9 http…     731      11      97   0.670    1.00   0.837       2       0       0
    ## 10 http…     731      10     231   0.636    1.00   0.797       4       1       1
    ## # … with 39,634 more rows, 51 more variables: num_videos <dbl>,
    ## #   average_token_length <dbl>, num_keywords <dbl>,
    ## #   data_channel_is_lifestyle <dbl>, data_channel_is_entertainment <dbl>,
    ## #   data_channel_is_bus <dbl>, data_channel_is_socmed <dbl>,
    ## #   data_channel_is_tech <dbl>, data_channel_is_world <dbl>, kw_min_min <dbl>,
    ## #   kw_max_min <dbl>, kw_avg_min <dbl>, kw_min_max <dbl>, kw_max_max <dbl>,
    ## #   kw_avg_max <dbl>, kw_min_avg <dbl>, kw_max_avg <dbl>, kw_avg_avg <dbl>, …

We now subset the data for the channel of interest lifestyle

``` r
#subsetting the OnlineNewsPopularity full raw data for the data chennel of interest -- Lifestyle
Lifestyle <- OnlineNewsPopularity %>% 
               filter(data_channel_is_lifestyle == 1)
# %>%  select ( share, var1, var2, var3, ... )
# ! = remove vars -- example below
#select ( ! c(var1, var2, var3, ... ) ) used to remove variables if needed

#calling the Lifestyle object to view
Lifestyle
```

    ## # A tibble: 2,099 × 61
    ##    url   timed…¹ n_tok…² n_tok…³ n_uni…⁴ n_non…⁵ n_non…⁶ num_h…⁷ num_s…⁸ num_i…⁹
    ##    <chr>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
    ##  1 http…     731       8     960   0.418    1.00   0.550      21      20      20
    ##  2 http…     731      10     187   0.667    1.00   0.800       7       0       1
    ##  3 http…     731      11     103   0.689    1.00   0.806       3       1       1
    ##  4 http…     731      10     243   0.619    1.00   0.824       1       1       0
    ##  5 http…     731       8     204   0.586    1.00   0.698       7       2       1
    ##  6 http…     731      11     315   0.551    1.00   0.702       4       4       1
    ##  7 http…     731      10    1190   0.409    1.00   0.561      25      24      20
    ##  8 http…     731       6     374   0.641    1.00   0.828       7       0       1
    ##  9 http…     730      12     499   0.513    1.00   0.662      14       1       1
    ## 10 http…     729      11     223   0.662    1.00   0.826       5       3       0
    ## # … with 2,089 more rows, 51 more variables: num_videos <dbl>,
    ## #   average_token_length <dbl>, num_keywords <dbl>,
    ## #   data_channel_is_lifestyle <dbl>, data_channel_is_entertainment <dbl>,
    ## #   data_channel_is_bus <dbl>, data_channel_is_socmed <dbl>,
    ## #   data_channel_is_tech <dbl>, data_channel_is_world <dbl>, kw_min_min <dbl>,
    ## #   kw_max_min <dbl>, kw_avg_min <dbl>, kw_min_max <dbl>, kw_max_max <dbl>,
    ## #   kw_avg_max <dbl>, kw_min_avg <dbl>, kw_max_avg <dbl>, kw_avg_avg <dbl>, …

# Summarizations

Now split the data set we’ve created into a training and testing set.
Use p = 0.8.

Here, we are splitting our created data, Lifestyle, into a training and
test set with p=0.8. These datasets will be called `LifestyleTrain` and
`LifestyleTest`.

Note: a seed was set for reproduciblility purposes.

``` r
#seed is set for reproducability 
set.seed(123)

#another way to split train and test data below
# #indices to split on
# train <- sample(1:nrow(my_heart), size = nrow(my_heart)*0.80)
# test <- dplyr::setdiff(1:nrow(my_heart), train)
# #subset
# heartTrain <- my_heart[train, ]
# heartTest <- my_heart[test, ]

#indices to split on
LifestyleIndex <- createDataPartition(Lifestyle$shares, p = 0.80, list = FALSE)
#subset
LifestyleTrain <- Lifestyle[ LifestyleIndex, ]
LifestyleTest  <- Lifestyle[-LifestyleIndex, ]
```

``` r
#what question are we trying to answer here? 
#response variable is shares, but what does that mean given certain variables available to us?
#maybe look at days of the week variables?
#figure out what kind of object we want to make to answer our question...
#tibble keeping what kind of vars, matrix?

#need to do some sort of type of EDA in order to see if variables are highly correlated
#here we need to summary statistics via summary() and plots

#this shows the summary stats for each variable in our dataset...
Lifestlye_sumstats_Train <- summary(LifestyleTrain)
#calling Lifestlye_sumstats_Train object to see our summary stats
Lifestlye_sumstats_Train
```

    ##      url              timedelta     n_tokens_title   n_tokens_content
    ##  Length:1681        Min.   :  8.0   Min.   : 3.000   Min.   :   0.0  
    ##  Class :character   1st Qu.:202.0   1st Qu.: 8.000   1st Qu.: 315.0  
    ##  Mode  :character   Median :418.0   Median :10.000   Median : 505.0  
    ##                     Mean   :404.4   Mean   : 9.769   Mean   : 631.9  
    ##                     3rd Qu.:611.0   3rd Qu.:11.000   3rd Qu.: 806.0  
    ##                     Max.   :731.0   Max.   :17.000   Max.   :8474.0  
    ##  n_unique_tokens  n_non_stop_words n_non_stop_unique_tokens   num_hrefs     
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :0.0000           Min.   :  0.00  
    ##  1st Qu.:0.4630   1st Qu.:1.0000   1st Qu.:0.6295           1st Qu.:  6.00  
    ##  Median :0.5186   Median :1.0000   Median :0.6842           Median : 10.00  
    ##  Mean   :0.5231   Mean   :0.9917   Mean   :0.6845           Mean   : 13.48  
    ##  3rd Qu.:0.5894   3rd Qu.:1.0000   3rd Qu.:0.7520           3rd Qu.: 18.00  
    ##  Max.   :0.8382   Max.   :1.0000   Max.   :0.9697           Max.   :145.00  
    ##  num_self_hrefs      num_imgs         num_videos      average_token_length
    ##  Min.   : 0.000   Min.   :  0.000   Min.   : 0.0000   Min.   :0.000       
    ##  1st Qu.: 1.000   1st Qu.:  1.000   1st Qu.: 0.0000   1st Qu.:4.449       
    ##  Median : 2.000   Median :  1.000   Median : 0.0000   Median :4.623       
    ##  Mean   : 2.515   Mean   :  4.897   Mean   : 0.5181   Mean   :4.595       
    ##  3rd Qu.: 3.000   3rd Qu.:  8.000   3rd Qu.: 0.0000   3rd Qu.:4.789       
    ##  Max.   :40.000   Max.   :111.000   Max.   :50.0000   Max.   :5.947       
    ##   num_keywords    data_channel_is_lifestyle data_channel_is_entertainment
    ##  Min.   : 3.000   Min.   :1                 Min.   :0                    
    ##  1st Qu.: 7.000   1st Qu.:1                 1st Qu.:0                    
    ##  Median : 8.000   Median :1                 Median :0                    
    ##  Mean   : 8.218   Mean   :1                 Mean   :0                    
    ##  3rd Qu.:10.000   3rd Qu.:1                 3rd Qu.:0                    
    ##  Max.   :10.000   Max.   :1                 Max.   :0                    
    ##  data_channel_is_bus data_channel_is_socmed data_channel_is_tech
    ##  Min.   :0           Min.   :0              Min.   :0           
    ##  1st Qu.:0           1st Qu.:0              1st Qu.:0           
    ##  Median :0           Median :0              Median :0           
    ##  Mean   :0           Mean   :0              Mean   :0           
    ##  3rd Qu.:0           3rd Qu.:0              3rd Qu.:0           
    ##  Max.   :0           Max.   :0              Max.   :0           
    ##  data_channel_is_world   kw_min_min       kw_max_min      kw_avg_min     
    ##  Min.   :0             Min.   : -1.00   Min.   :    0   Min.   :   -1.0  
    ##  1st Qu.:0             1st Qu.: -1.00   1st Qu.:  486   1st Qu.:  184.6  
    ##  Median :0             Median :  4.00   Median :  806   Median :  298.0  
    ##  Mean   :0             Mean   : 40.56   Mean   : 1564   Mean   :  403.4  
    ##  3rd Qu.:0             3rd Qu.:  4.00   3rd Qu.: 1300   3rd Qu.:  446.8  
    ##  Max.   :0             Max.   :377.00   Max.   :80400   Max.   :13744.8  
    ##    kw_min_max       kw_max_max       kw_avg_max       kw_min_avg  
    ##  Min.   :     0   Min.   :     0   Min.   :     0   Min.   :   0  
    ##  1st Qu.:     0   1st Qu.:690400   1st Qu.:121029   1st Qu.:   0  
    ##  Median :     0   Median :843300   Median :184440   Median :   0  
    ##  Mean   :  7300   Mean   :706251   Mean   :185340   Mean   :1072  
    ##  3rd Qu.:  6400   3rd Qu.:843300   3rd Qu.:250271   3rd Qu.:2259  
    ##  Max.   :208300   Max.   :843300   Max.   :538744   Max.   :3610  
    ##    kw_max_avg      kw_avg_avg    self_reference_min_shares
    ##  Min.   :    0   Min.   :    0   Min.   :     0           
    ##  1st Qu.: 4077   1st Qu.: 2659   1st Qu.:   580           
    ##  Median : 5058   Median : 3238   Median :  1600           
    ##  Mean   : 6726   Mean   : 3430   Mean   :  4352           
    ##  3rd Qu.: 7345   3rd Qu.: 3962   3rd Qu.:  3600           
    ##  Max.   :95422   Max.   :20378   Max.   :138700           
    ##  self_reference_max_shares self_reference_avg_sharess weekday_is_monday
    ##  Min.   :     0            Min.   :     0             Min.   :0.0000   
    ##  1st Qu.:   891            1st Qu.:   883             1st Qu.:0.0000   
    ##  Median :  2700            Median :  2446             Median :0.0000   
    ##  Mean   :  7905            Mean   :  5796             Mean   :0.1428   
    ##  3rd Qu.:  7100            3rd Qu.:  5400             3rd Qu.:0.0000   
    ##  Max.   :690400            Max.   :234000             Max.   :1.0000   
    ##  weekday_is_tuesday weekday_is_wednesday weekday_is_thursday weekday_is_friday
    ##  Min.   :0.0000     Min.   :0.0000       Min.   :0.0000      Min.   :0.0000   
    ##  1st Qu.:0.0000     1st Qu.:0.0000       1st Qu.:0.0000      1st Qu.:0.0000   
    ##  Median :0.0000     Median :0.0000       Median :0.0000      Median :0.0000   
    ##  Mean   :0.1565     Mean   :0.1844       Mean   :0.1725      Mean   :0.1475   
    ##  3rd Qu.:0.0000     3rd Qu.:0.0000       3rd Qu.:0.0000      3rd Qu.:0.0000   
    ##  Max.   :1.0000     Max.   :1.0000       Max.   :1.0000      Max.   :1.0000   
    ##  weekday_is_saturday weekday_is_sunday   is_weekend         LDA_00       
    ##  Min.   :0.00000     Min.   :0.0000    Min.   :0.0000   Min.   :0.01818  
    ##  1st Qu.:0.00000     1st Qu.:0.0000    1st Qu.:0.0000   1st Qu.:0.02249  
    ##  Median :0.00000     Median :0.0000    Median :0.0000   Median :0.02912  
    ##  Mean   :0.08983     Mean   :0.1065    Mean   :0.1963   Mean   :0.17929  
    ##  3rd Qu.:0.00000     3rd Qu.:0.0000    3rd Qu.:0.0000   3rd Qu.:0.25177  
    ##  Max.   :1.00000     Max.   :1.0000    Max.   :1.0000   Max.   :0.91980  
    ##      LDA_01            LDA_02            LDA_03            LDA_04       
    ##  Min.   :0.01819   Min.   :0.01819   Min.   :0.01820   Min.   :0.02014  
    ##  1st Qu.:0.02154   1st Qu.:0.02222   1st Qu.:0.02248   1st Qu.:0.31616  
    ##  Median :0.02508   Median :0.02616   Median :0.03011   Median :0.57070  
    ##  Mean   :0.06554   Mean   :0.07744   Mean   :0.14533   Mean   :0.53240  
    ##  3rd Qu.:0.04001   3rd Qu.:0.05028   3rd Qu.:0.21038   3rd Qu.:0.79956  
    ##  Max.   :0.68825   Max.   :0.67623   Max.   :0.91892   Max.   :0.92707  
    ##  global_subjectivity global_sentiment_polarity global_rate_positive_words
    ##  Min.   :0.0000      Min.   :-0.3727           Min.   :0.00000           
    ##  1st Qu.:0.4276      1st Qu.: 0.1014           1st Qu.:0.03505           
    ##  Median :0.4776      Median : 0.1513           Median :0.04401           
    ##  Mean   :0.4748      Mean   : 0.1523           Mean   :0.04470           
    ##  3rd Qu.:0.5270      3rd Qu.: 0.2056           3rd Qu.:0.05361           
    ##  Max.   :0.8667      Max.   : 0.5139           Max.   :0.10795           
    ##  global_rate_negative_words rate_positive_words rate_negative_words
    ##  Min.   :0.00000            Min.   :0.0000      Min.   :0.0000     
    ##  1st Qu.:0.01025            1st Qu.:0.6633      1st Qu.:0.1852     
    ##  Median :0.01538            Median :0.7419      Median :0.2553     
    ##  Mean   :0.01641            Mean   :0.7251      Mean   :0.2665     
    ##  3rd Qu.:0.02108            3rd Qu.:0.8125      3rd Qu.:0.3333     
    ##  Max.   :0.06180            Max.   :1.0000      Max.   :1.0000     
    ##  avg_positive_polarity min_positive_polarity max_positive_polarity
    ##  Min.   :0.0000        Min.   :0.00000       Min.   :0.0000       
    ##  1st Qu.:0.3359        1st Qu.:0.05000       1st Qu.:0.7000       
    ##  Median :0.3860        Median :0.10000       Median :1.0000       
    ##  Mean   :0.3838        Mean   :0.09375       Mean   :0.8331       
    ##  3rd Qu.:0.4342        3rd Qu.:0.10000       3rd Qu.:1.0000       
    ##  Max.   :0.7553        Max.   :0.50000       Max.   :1.0000       
    ##  avg_negative_polarity min_negative_polarity max_negative_polarity
    ##  Min.   :-1.0000       Min.   :-1.000        Min.   :-1.0000      
    ##  1st Qu.:-0.3204       1st Qu.:-0.700        1st Qu.:-0.1250      
    ##  Median :-0.2593       Median :-0.500        Median :-0.1000      
    ##  Mean   :-0.2637       Mean   :-0.556        Mean   :-0.1028      
    ##  3rd Qu.:-0.2000       3rd Qu.:-0.400        3rd Qu.:-0.0500      
    ##  Max.   : 0.0000       Max.   : 0.000        Max.   : 0.0000      
    ##  title_subjectivity title_sentiment_polarity abs_title_subjectivity
    ##  Min.   :0.000      Min.   :-1.0000          Min.   :0.0000        
    ##  1st Qu.:0.000      1st Qu.: 0.0000          1st Qu.:0.1778        
    ##  Median :0.100      Median : 0.0000          Median :0.5000        
    ##  Mean   :0.287      Mean   : 0.1057          Mean   :0.3482        
    ##  3rd Qu.:0.500      3rd Qu.: 0.2000          3rd Qu.:0.5000        
    ##  Max.   :1.000      Max.   : 1.0000          Max.   :0.5000        
    ##  abs_title_sentiment_polarity     shares      
    ##  Min.   :0.0000               Min.   :    78  
    ##  1st Qu.:0.0000               1st Qu.:  1100  
    ##  Median :0.0000               Median :  1700  
    ##  Mean   :0.1713               Mean   :  3694  
    ##  3rd Qu.:0.2857               3rd Qu.:  3200  
    ##  Max.   :1.0000               Max.   :208300

``` r
#check structure of objects
str(LifestyleTrain)
```

    ## tibble [1,681 × 61] (S3: tbl_df/tbl/data.frame)
    ##  $ url                          : chr [1:1681] "http://mashable.com/2013/01/07/crayon-creatures/" "http://mashable.com/2013/01/07/livio-connect-expands/" "http://mashable.com/2013/01/07/omron-fitness-monitors/" "http://mashable.com/2013/01/07/traffic-signals-bugs/" ...
    ##  $ timedelta                    : num [1:1681] 731 731 731 731 729 729 729 729 729 729 ...
    ##  $ n_tokens_title               : num [1:1681] 10 11 10 6 11 7 11 9 10 7 ...
    ##  $ n_tokens_content             : num [1:1681] 187 315 1190 374 223 ...
    ##  $ n_unique_tokens              : num [1:1681] 0.667 0.551 0.409 0.641 0.662 ...
    ##  $ n_non_stop_words             : num [1:1681] 1 1 1 1 1 ...
    ##  $ n_non_stop_unique_tokens     : num [1:1681] 0.8 0.702 0.561 0.828 0.826 ...
    ##  $ num_hrefs                    : num [1:1681] 7 4 25 7 5 24 28 10 2 9 ...
    ##  $ num_self_hrefs               : num [1:1681] 0 4 24 0 3 23 24 5 1 6 ...
    ##  $ num_imgs                     : num [1:1681] 1 1 20 1 0 20 20 1 11 1 ...
    ##  $ num_videos                   : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ average_token_length         : num [1:1681] 4.66 4.38 4.62 4.91 4.55 ...
    ##  $ num_keywords                 : num [1:1681] 7 10 8 8 6 10 10 9 9 10 ...
    ##  $ data_channel_is_lifestyle    : num [1:1681] 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ data_channel_is_entertainment: num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ data_channel_is_bus          : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ data_channel_is_socmed       : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ data_channel_is_tech         : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ data_channel_is_world        : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ kw_min_min                   : num [1:1681] 0 0 0 0 217 217 217 217 217 217 ...
    ##  $ kw_max_min                   : num [1:1681] 0 0 0 0 1900 2600 823 2600 695 2600 ...
    ##  $ kw_avg_min                   : num [1:1681] 0 0 0 0 748 ...
    ##  $ kw_min_max                   : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ kw_max_max                   : num [1:1681] 0 0 0 0 17100 17100 17100 17100 17100 17100 ...
    ##  $ kw_avg_max                   : num [1:1681] 0 0 0 0 4517 ...
    ##  $ kw_min_avg                   : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ kw_max_avg                   : num [1:1681] 0 0 0 0 1953 ...
    ##  $ kw_avg_avg                   : num [1:1681] 0 0 0 0 1207 ...
    ##  $ self_reference_min_shares    : num [1:1681] 0 6200 545 0 6700 543 545 2000 0 1100 ...
    ##  $ self_reference_max_shares    : num [1:1681] 0 6200 16000 0 16700 16000 16000 4900 0 6000 ...
    ##  $ self_reference_avg_sharess   : num [1:1681] 0 6200 3151 0 11700 ...
    ##  $ weekday_is_monday            : num [1:1681] 1 1 1 1 0 0 0 0 0 0 ...
    ##  $ weekday_is_tuesday           : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_wednesday         : num [1:1681] 0 0 0 0 1 1 1 1 1 1 ...
    ##  $ weekday_is_thursday          : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_friday            : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_saturday          : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_sunday            : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ is_weekend                   : num [1:1681] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ LDA_00                       : num [1:1681] 0.0286 0.0201 0.025 0.2066 0.0335 ...
    ##  $ LDA_01                       : num [1:1681] 0.0286 0.0206 0.1595 0.1461 0.217 ...
    ##  $ LDA_02                       : num [1:1681] 0.0286 0.0205 0.025 0.276 0.0334 ...
    ##  $ LDA_03                       : num [1:1681] 0.0287 0.1208 0.025 0.0251 0.0335 ...
    ##  $ LDA_04                       : num [1:1681] 0.885 0.818 0.765 0.346 0.683 ...
    ##  $ global_subjectivity          : num [1:1681] 0.477 0.554 0.507 0.399 0.372 ...
    ##  $ global_sentiment_polarity    : num [1:1681] 0.15 0.177 0.244 0.122 0.103 ...
    ##  $ global_rate_positive_words   : num [1:1681] 0.0267 0.0349 0.0639 0.0374 0.0493 ...
    ##  $ global_rate_negative_words   : num [1:1681] 0.0107 0.0127 0.0151 0.0187 0.0179 ...
    ##  $ rate_positive_words          : num [1:1681] 0.714 0.733 0.809 0.667 0.733 ...
    ##  $ rate_negative_words          : num [1:1681] 0.286 0.267 0.191 0.333 0.267 ...
    ##  $ avg_positive_polarity        : num [1:1681] 0.435 0.401 0.403 0.361 0.255 ...
    ##  $ min_positive_polarity        : num [1:1681] 0.2 0.1364 0.0333 0.1 0.1 ...
    ##  $ max_positive_polarity        : num [1:1681] 0.7 0.5 1 0.8 0.5 1 1 0.8 0.6 0.6 ...
    ##  $ avg_negative_polarity        : num [1:1681] -0.263 -0.32 -0.236 -0.13 -0.188 ...
    ##  $ min_negative_polarity        : num [1:1681] -0.4 -0.5 -0.5 -0.2 -0.4 ...
    ##  $ max_negative_polarity        : num [1:1681] -0.125 -0.125 -0.05 -0.05 -0.1 ...
    ##  $ title_subjectivity           : num [1:1681] 0 0.55 0 0 0 ...
    ##  $ title_sentiment_polarity     : num [1:1681] 0 0.35 0 0 0 ...
    ##  $ abs_title_subjectivity       : num [1:1681] 0.5 0.05 0.5 0.5 0.5 ...
    ##  $ abs_title_sentiment_polarity : num [1:1681] 0 0.35 0 0 0 ...
    ##  $ shares                       : num [1:1681] 1900 343 507 552 1900 1100 1200 2300 752 1000 ...

``` r
str(Lifestlye_sumstats_Train)
```

    ##  'table' chr [1:6, 1:61] "Length:1681       " "Class :character  " ...
    ##  - attr(*, "dimnames")=List of 2
    ##   ..$ : chr [1:6] "" "" "" "" ...
    ##   ..$ : chr [1:61] "    url" "  timedelta" "n_tokens_title" "n_tokens_content" ...

``` r
#plots include - scatter plots, correlation plots -- plots for continuous data...
#do we need bar plots?

#A scatter plot with the number of shares on the y-axis and the positive word rate on the x-axis is created below
ggplot(data=LifestyleTrain, aes(y=shares, x=rate_positive_words)) + geom_point()
```

![](README_files/figure-gfm/unnamed-chunk-23-1.png)<!-- -->

<!-- # Project Objectives -->
<!-- This is a group project (see the project 3 page for your group member) that involves creating predictive models and automating Markdown reports. Once you’ve completed the project you will also create a blogpost in your blog repo that links to your analyses. -->

# Project Work

The first step is for the first group member to create a github repo and
add the second group member as a collaborator. The second group member
then needs to accept the membership. This gives everyone access to push
changes up to the repository. All project work should be done within
this repo.

Each time you go to work on the project, you should pull down any of the
latest changes using git pull. You should then upload any changes you’ve
made via the usual workflow done previously. There may occasionally be
merge conflicts that have to be dealt with. This can be done with the
Git tab in RStudio. Let us know if you are having issues with conflicts
that you can’t resolve!

# Repo Setting

On your project repo you should go into the settings and enable github
pages (feel free to select a theme too!). This will make it so your repo
can be accessed like your blog (username.github.io/repo-name). Be sure
to choose the master or main branch as the one to use if you have
choices there.

You’ll be automating the creation of documents using R Markdown (one for
each data_channel_is\_\* setting, i.e. type of article in the data set
provided). Each document should be rendered as a github_document from a
single .Rmd file. In the README.md file you should create links to each
of the documents you will create (Lifestyle analysis, Entertainment
analysis, etc.). Links can be made to the sub-documents using relative
paths. For instance, if you have all of the outputted .md files in the
main directory you would just use markdown linking:

-   The analysis for [Lifestyle articles is available
    here](LifestyleAnalysis.html). Note we link to the html file even
    though the file we create is a .md file - github creates the .html
    for us.

In the repo’s README.md file (which doesn’t need to be created from a
.Rmd file, just use the one you initialize into the repo if you want)
give a brief description of the purpose of the repo, a list of R
packages used, links to the generated analyses, and the code used to
create the analyses from a single .Rmd file (i.e. the render() code).

# Blog

Once you’ve completed the project each of you should write a brief blog
post outlining your project and two links to the
username.github.io/repo-name site and the repo itself (the username may
correspond to your partner). You should then also reflect on the process
you went through. Discuss the following:

-   what would you do differently?  
-   what was the most difficult part for you?  
-   what are your big take-aways from this project?

# Topic

What are you actually doing? You’ll read in and analyze an online news
popularity data set. You’ll subset the data by data_channel_is\_\* (one
of six groups). Then you’ll summarize the data and try to predict the
number of shares using predictive models.

1.  Read in the OnlineNewsPopularity.csv data file – subset for
    data_channel_is_lifestyle: Is data channel ‘Lifestyle’?

Here, `read_csv()` is used to read in the OnlineNewsPopularity.csv data
and we are subsetting for the `data_channel_is_lifestyle`: Is data
channel ‘Lifestyle’? variable.

``` r
#install one time thing
#install.packages("caret")

#read in data set .csv file in full
#OnlineNewsPopularity <- readr::read_csv(file="OnlineNewsPopularity.csv", 
#                                        show_col_types = FALSE)
```

``` r
#subsetting the data for`data_channel_is_lifestyle`: Is data channel 'Lifestyle'?
#Lifestyle <- OnlineNewsPopularity %>% 
#              filter( data_channel_is_lifestyle == 1)
```

# Report

Recommendation: At first, consider just using data from a single
data_channel_is\_\* source. Once you have all of the below steps done
for that data, then you can automate it to work with any chosen data
channel. Note: It may be easier to create a single variable representing
the data channel when automating the subsetting (although there are many
ways to do this).

-   All code chunks should be shown unless they are setup code chunks.

<!-- # Introduction section -->
<!-- You should have an introduction section that briefly describes the data and the variables you have to work with (just discuss the ones you want to use). Your target variables is the shares variable. -->
<!-- You should also mention the purpose of your analysis and the methods you’ll use to model the response. You’ll describe those in more detail later. -->
<!-- **This section should be done by the ‘second’ group member.** -->
<!-- # Data -->
<!-- Use a relative path to import the data. Subset the data to work on the data channel of interest. -->
<!-- **This section should be done by whoever can get to it first.** -->

# Summarizations

You should produce some basic (but meaningful) summary statistics and
plots about the training data you are working with (especially as it
relates to your response).

As you will automate this same analysis across other data, you can’t
describe the trends you see in the graph (unless you want to try to
automate that!). You should describe what to look for in the summary
statistics/plots to help the reader understand the summary or graph. Ex:
A scatter plot with the number of shares on the y-axis and the positive
word rate on the x-axis is created:

‘We can inspect the trend of shares as a function of the positive word
rate. If the points show an upward trend, then articles with more
positive words tend to be shared more often. If we see a negative trend
then articles with more positive words tend to be shared less often.’

Each group member is responsible for producing some summary statistics
(means, sds, contingency tables, etc.) and for producing at least three
graphs (each) of the data.

# Modeling

You’ll need to split the data into a training (70% of the data) and test
set (30% of the data). Use set.seed() to make things reproducible.

The goal is to create models for predicting the number of shares in some
way. Each group member should contribute a linear regression model and
an ensemble tree-based model. As we are automating things, describing
the chosen model is tough, so no need to worry about that.

The first group member should fit a random forest model and the second
group member should fit a boosted tree model. Both models should be
chosen using cross-validation.

Prior to the models fit using linear regression, the first group member
should provide a short but thorough explanation of the idea of a linear
regression model.

Prior to each ensemble model, you should provide a short but reasonably
thorough explanation of the ensemble model you are using (so one for
each group member).

# Comparison

All four of the models should be compared on the test set and a winner
declared (this should be automated to be correct across all the created
documents).

This can be done by one group member and the automation done by the
other (see below).

# Automation

Once you’ve completed the above for a particular data channel, adapt the
code so that you can use a parameter in your build process. You should
be able to automatically generate an analysis report for each
data_channel_is\_\* variable - although again, you may want to create a
new variable to help with the subsetting. You’ll end up with six total
outputted documents.

This should be done by the group member that doesn’t automate the
comparison of models part.

# Submission

In the project submission, you should simply put a link to your blog
post (which will have a link to your github pages and github repo).

<!-- # Group Issues -->
<!-- Please notify me ASAP of any group member issues. You should look over your partner’s work/explanations and discuss that with them if you have any issues with what they’ve done. Both group members are graded on all the work done regardless of who was assigned to do it. -->
<!--
Rubric for Grading (total = 100 points)
Item                               Points           Notes
Introduction                       10               Worth either 0, 5, or 10
Data split                          5               Worth either 0 or 5
Summarizations & discussions       20               Worth either 0, 5,. . . , or 20
Modeling, selection, & discussion  35               Worth either 0, 5, . . . , 35
Test set prediction and automation 10               Worth either 0, 5, or 10
Automation                         15               Worth either 0, 5, 10, or 15
Blog post and repo setup           10               Worth either 0, 5, or 10
-->
<!--
Notes on grading:
• For each item in the rubric, your grade will be lowered one level for each each error (syntax, logical, or other) in the code and for each required item that is missing or lacking a description.  
• If your work was not completed and documented using your github repo you will lose 50
points on the project.  
• You should use Good Programming Practices when coding (see wolfware). If you do not follow GPP you can lose up to 40 points on the project.  
• You should use appropriate markdown options/formatting (you can lose up to 20 points) for not doing so.
-->
<!-- code needed to render pdf file  -->
