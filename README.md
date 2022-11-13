ST558 Project 3 Group F
================
Magaritte Nguyen and Matthew Sookoo
2022-11-12

-   <a href="#introduction" id="toc-introduction">Introduction</a>
-   <a href="#required-packages" id="toc-required-packages">Required
    Packages</a>
-   <a href="#data" id="toc-data">Data</a>
-   <a href="#summarizations" id="toc-summarizations">Summarizations</a>
-   <a href="#modelling" id="toc-modelling">Modelling</a>
    -   <a href="#first-linear-model" id="toc-first-linear-model">First linear
        model.</a>
    -   <a href="#second-linear-model" id="toc-second-linear-model">Second
        linear model</a>
    -   <a href="#random-forest-models-used-days"
        id="toc-random-forest-models-used-days">Random forest models. used
        days</a>
    -   <a href="#and-the-boosted-tree-model-number-of-images-etc"
        id="toc-and-the-boosted-tree-model-number-of-images-etc">and the boosted
        tree model Number of images etc</a>
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

The following packages are used:

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

    ## [1] "C:/Users/Home Pc/Desktop/ST558 Project 3 new/ST558_Project3_GroupF"

``` r
#reassign working directory
#Magaritte's directory
#setwd("D:/ST558/Project 3/ST558_Project3_GroupF")
#Matthew's directory
setwd("C:\\Users\\Home Pc\\Desktop\\ST558 Project 3 new\\ST558_Project3_GroupF\\")

#read in data set .csv file in full
#make sure that this is a relative path used...
OnlineNewsPopularity<-read_csv("OnlineNewsPopularity.csv", show_col_types = FALSE)

#call object OnlineNewsPopularity - our full raw data
OnlineNewsPopularity
```

    ## # A tibble: 39,644 × 61
    ##    url        timed…¹ n_tok…² n_tok…³ n_uni…⁴ n_non…⁵ n_non…⁶ num_h…⁷ num_s…⁸ num_i…⁹ num_v…˟
    ##    <chr>        <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
    ##  1 http://ma…     731      12     219   0.664    1.00   0.815       4       2       1       0
    ##  2 http://ma…     731       9     255   0.605    1.00   0.792       3       1       1       0
    ##  3 http://ma…     731       9     211   0.575    1.00   0.664       3       1       1       0
    ##  4 http://ma…     731       9     531   0.504    1.00   0.666       9       0       1       0
    ##  5 http://ma…     731      13    1072   0.416    1.00   0.541      19      19      20       0
    ##  6 http://ma…     731      10     370   0.560    1.00   0.698       2       2       0       0
    ##  7 http://ma…     731       8     960   0.418    1.00   0.550      21      20      20       0
    ##  8 http://ma…     731      12     989   0.434    1.00   0.572      20      20      20       0
    ##  9 http://ma…     731      11      97   0.670    1.00   0.837       2       0       0       0
    ## 10 http://ma…     731      10     231   0.636    1.00   0.797       4       1       1       1
    ## # … with 39,634 more rows, 50 more variables: average_token_length <dbl>,
    ## #   num_keywords <dbl>, data_channel_is_lifestyle <dbl>,
    ## #   data_channel_is_entertainment <dbl>, data_channel_is_bus <dbl>,
    ## #   data_channel_is_socmed <dbl>, data_channel_is_tech <dbl>, data_channel_is_world <dbl>,
    ## #   kw_min_min <dbl>, kw_max_min <dbl>, kw_avg_min <dbl>, kw_min_max <dbl>,
    ## #   kw_max_max <dbl>, kw_avg_max <dbl>, kw_min_avg <dbl>, kw_max_avg <dbl>,
    ## #   kw_avg_avg <dbl>, self_reference_min_shares <dbl>, self_reference_max_shares <dbl>, …

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
    ##    url        timed…¹ n_tok…² n_tok…³ n_uni…⁴ n_non…⁵ n_non…⁶ num_h…⁷ num_s…⁸ num_i…⁹ num_v…˟
    ##    <chr>        <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
    ##  1 http://ma…     731       8     960   0.418    1.00   0.550      21      20      20       0
    ##  2 http://ma…     731      10     187   0.667    1.00   0.800       7       0       1       0
    ##  3 http://ma…     731      11     103   0.689    1.00   0.806       3       1       1       0
    ##  4 http://ma…     731      10     243   0.619    1.00   0.824       1       1       0       0
    ##  5 http://ma…     731       8     204   0.586    1.00   0.698       7       2       1       0
    ##  6 http://ma…     731      11     315   0.551    1.00   0.702       4       4       1       0
    ##  7 http://ma…     731      10    1190   0.409    1.00   0.561      25      24      20       0
    ##  8 http://ma…     731       6     374   0.641    1.00   0.828       7       0       1       0
    ##  9 http://ma…     730      12     499   0.513    1.00   0.662      14       1       1       0
    ## 10 http://ma…     729      11     223   0.662    1.00   0.826       5       3       0       0
    ## # … with 2,089 more rows, 50 more variables: average_token_length <dbl>, num_keywords <dbl>,
    ## #   data_channel_is_lifestyle <dbl>, data_channel_is_entertainment <dbl>,
    ## #   data_channel_is_bus <dbl>, data_channel_is_socmed <dbl>, data_channel_is_tech <dbl>,
    ## #   data_channel_is_world <dbl>, kw_min_min <dbl>, kw_max_min <dbl>, kw_avg_min <dbl>,
    ## #   kw_min_max <dbl>, kw_max_max <dbl>, kw_avg_max <dbl>, kw_min_avg <dbl>,
    ## #   kw_max_avg <dbl>, kw_avg_avg <dbl>, self_reference_min_shares <dbl>,
    ## #   self_reference_max_shares <dbl>, self_reference_avg_sharess <dbl>, …

# Summarizations

Now split the data set we’ve created into a training and testing set.
Use p = 0.7.

Here, we are splitting our created data, Lifestyle, into a training and
test set with p=0.7. These datasets will be called `LifestyleTrain` and
`LifestyleTest`.

Note: a seed was set for reproduciblility purposes.

``` r
#seed is set for reproducability 
set.seed(123)

#another way to split train and test data below
# #indices to split on
# train <- sample(1:nrow(my_heart), size = nrow(my_heart)*0.70)
# test <- dplyr::setdiff(1:nrow(my_heart), train)
# #subset
# heartTrain <- my_heart[train, ]
# heartTest <- my_heart[test, ]

#indices to split on
LifestyleIndex <- createDataPartition(Lifestyle$shares, p = 0.70, list = FALSE)
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

    ##      url              timedelta     n_tokens_title   n_tokens_content n_unique_tokens 
    ##  Length:1472        Min.   :  9.0   Min.   : 3.000   Min.   :   0.0   Min.   :0.0000  
    ##  Class :character   1st Qu.:200.0   1st Qu.: 8.000   1st Qu.: 315.0   1st Qu.:0.4626  
    ##  Mode  :character   Median :414.0   Median :10.000   Median : 501.5   Median :0.5178  
    ##                     Mean   :404.1   Mean   : 9.762   Mean   : 633.3   Mean   :0.5211  
    ##                     3rd Qu.:613.2   3rd Qu.:11.000   3rd Qu.: 801.5   3rd Qu.:0.5886  
    ##                     Max.   :731.0   Max.   :17.000   Max.   :8474.0   Max.   :0.8248  
    ##  n_non_stop_words n_non_stop_unique_tokens   num_hrefs      num_self_hrefs  
    ##  Min.   :0.0000   Min.   :0.0000           Min.   :  0.00   Min.   : 0.000  
    ##  1st Qu.:1.0000   1st Qu.:0.6292           1st Qu.:  6.00   1st Qu.: 1.000  
    ##  Median :1.0000   Median :0.6829           Median : 10.00   Median : 2.000  
    ##  Mean   :0.9891   Mean   :0.6818           Mean   : 13.61   Mean   : 2.566  
    ##  3rd Qu.:1.0000   3rd Qu.:0.7514           3rd Qu.: 19.00   3rd Qu.: 3.000  
    ##  Max.   :1.0000   Max.   :0.9697           Max.   :145.00   Max.   :27.000  
    ##     num_imgs         num_videos     average_token_length  num_keywords   
    ##  Min.   :  0.000   Min.   : 0.000   Min.   :0.000        Min.   : 3.000  
    ##  1st Qu.:  1.000   1st Qu.: 0.000   1st Qu.:4.449        1st Qu.: 7.000  
    ##  Median :  1.000   Median : 0.000   Median :4.620        Median : 8.000  
    ##  Mean   :  5.058   Mean   : 0.485   Mean   :4.584        Mean   : 8.235  
    ##  3rd Qu.:  8.000   3rd Qu.: 0.000   3rd Qu.:4.791        3rd Qu.:10.000  
    ##  Max.   :111.000   Max.   :50.000   Max.   :5.947        Max.   :10.000  
    ##  data_channel_is_lifestyle data_channel_is_entertainment data_channel_is_bus
    ##  Min.   :1                 Min.   :0                     Min.   :0          
    ##  1st Qu.:1                 1st Qu.:0                     1st Qu.:0          
    ##  Median :1                 Median :0                     Median :0          
    ##  Mean   :1                 Mean   :0                     Mean   :0          
    ##  3rd Qu.:1                 3rd Qu.:0                     3rd Qu.:0          
    ##  Max.   :1                 Max.   :0                     Max.   :0          
    ##  data_channel_is_socmed data_channel_is_tech data_channel_is_world   kw_min_min    
    ##  Min.   :0              Min.   :0            Min.   :0             Min.   : -1.00  
    ##  1st Qu.:0              1st Qu.:0            1st Qu.:0             1st Qu.: -1.00  
    ##  Median :0              Median :0            Median :0             Median :  4.00  
    ##  Mean   :0              Mean   :0            Mean   :0             Mean   : 41.06  
    ##  3rd Qu.:0              3rd Qu.:0            3rd Qu.:0             3rd Qu.:  4.00  
    ##  Max.   :0              Max.   :0            Max.   :0             Max.   :377.00  
    ##    kw_max_min      kw_avg_min        kw_min_max       kw_max_max       kw_avg_max    
    ##  Min.   :    0   Min.   :   -1.0   Min.   :     0   Min.   :     0   Min.   :     0  
    ##  1st Qu.:  488   1st Qu.:  185.5   1st Qu.:     0   1st Qu.:690400   1st Qu.:118866  
    ##  Median :  803   Median :  296.3   Median :     0   Median :843300   Median :182440  
    ##  Mean   : 1580   Mean   :  408.7   Mean   :  7057   Mean   :705830   Mean   :183327  
    ##  3rd Qu.: 1300   3rd Qu.:  444.9   3rd Qu.:  6300   3rd Qu.:843300   3rd Qu.:248253  
    ##  Max.   :80400   Max.   :13744.8   Max.   :208300   Max.   :843300   Max.   :491771  
    ##    kw_min_avg     kw_max_avg      kw_avg_avg    self_reference_min_shares
    ##  Min.   :   0   Min.   :    0   Min.   :    0   Min.   :     0.0         
    ##  1st Qu.:   0   1st Qu.: 4061   1st Qu.: 2638   1st Qu.:   648.8         
    ##  Median :   0   Median : 5034   Median : 3227   Median :  1700.0         
    ##  Mean   :1052   Mean   : 6583   Mean   : 3401   Mean   :  4440.8         
    ##  3rd Qu.:2264   3rd Qu.: 7303   3rd Qu.: 3953   3rd Qu.:  3600.0         
    ##  Max.   :3594   Max.   :95422   Max.   :20378   Max.   :138700.0         
    ##  self_reference_max_shares self_reference_avg_sharess weekday_is_monday weekday_is_tuesday
    ##  Min.   :     0            Min.   :     0.0           Min.   :0.0000    Min.   :0.000     
    ##  1st Qu.:  1000            1st Qu.:   996.8           1st Qu.:0.0000    1st Qu.:0.000     
    ##  Median :  2800            Median :  2485.1           Median :0.0000    Median :0.000     
    ##  Mean   :  8445            Mean   :  6136.0           Mean   :0.1508    Mean   :0.163     
    ##  3rd Qu.:  6800            3rd Qu.:  5400.4           3rd Qu.:0.0000    3rd Qu.:0.000     
    ##  Max.   :690400            Max.   :401450.0           Max.   :1.0000    Max.   :1.000     
    ##  weekday_is_wednesday weekday_is_thursday weekday_is_friday weekday_is_saturday
    ##  Min.   :0.0000       Min.   :0.0000      Min.   :0.0000    Min.   :0.0000     
    ##  1st Qu.:0.0000       1st Qu.:0.0000      1st Qu.:0.0000    1st Qu.:0.0000     
    ##  Median :0.0000       Median :0.0000      Median :0.0000    Median :0.0000     
    ##  Mean   :0.1882       Mean   :0.1651      Mean   :0.1433    Mean   :0.0856     
    ##  3rd Qu.:0.0000       3rd Qu.:0.0000      3rd Qu.:0.0000    3rd Qu.:0.0000     
    ##  Max.   :1.0000       Max.   :1.0000      Max.   :1.0000    Max.   :1.0000     
    ##  weekday_is_sunday   is_weekend         LDA_00            LDA_01            LDA_02       
    ##  Min.   :0.0000    Min.   :0.0000   Min.   :0.01818   Min.   :0.01819   Min.   :0.01819  
    ##  1st Qu.:0.0000    1st Qu.:0.0000   1st Qu.:0.02250   1st Qu.:0.02222   1st Qu.:0.02222  
    ##  Median :0.0000    Median :0.0000   Median :0.02913   Median :0.02507   Median :0.02523  
    ##  Mean   :0.1039    Mean   :0.1895   Mean   :0.17892   Mean   :0.06751   Mean   :0.07769  
    ##  3rd Qu.:0.0000    3rd Qu.:0.0000   3rd Qu.:0.25060   3rd Qu.:0.04001   3rd Qu.:0.06667  
    ##  Max.   :1.0000    Max.   :1.0000   Max.   :0.91980   Max.   :0.68825   Max.   :0.67623  
    ##      LDA_03            LDA_04        global_subjectivity global_sentiment_polarity
    ##  Min.   :0.01820   Min.   :0.02014   Min.   :0.0000      Min.   :-0.30000         
    ##  1st Qu.:0.02260   1st Qu.:0.32329   1st Qu.:0.4265      1st Qu.: 0.09929         
    ##  Median :0.02925   Median :0.56851   Median :0.4780      Median : 0.15023         
    ##  Mean   :0.14188   Mean   :0.53400   Mean   :0.4734      Mean   : 0.15143         
    ##  3rd Qu.:0.19724   3rd Qu.:0.79956   3rd Qu.:0.5273      3rd Qu.: 0.20511         
    ##  Max.   :0.91892   Max.   :0.92707   Max.   :0.7778      Max.   : 0.51389         
    ##  global_rate_positive_words global_rate_negative_words rate_positive_words
    ##  Min.   :0.00000            Min.   :0.00000            Min.   :0.0000     
    ##  1st Qu.:0.03493            1st Qu.:0.01025            1st Qu.:0.6667     
    ##  Median :0.04424            Median :0.01521            Median :0.7399     
    ##  Mean   :0.04457            Mean   :0.01632            Mean   :0.7235     
    ##  3rd Qu.:0.05378            3rd Qu.:0.02094            3rd Qu.:0.8125     
    ##  Max.   :0.10791            Max.   :0.06180            Max.   :1.0000     
    ##  rate_negative_words avg_positive_polarity min_positive_polarity max_positive_polarity
    ##  Min.   :0.0000      Min.   :0.0000        Min.   :0.00000       Min.   :0.0000       
    ##  1st Qu.:0.1852      1st Qu.:0.3358        1st Qu.:0.05000       1st Qu.:0.7000       
    ##  Median :0.2560      Median :0.3836        Median :0.10000       Median :0.9000       
    ##  Mean   :0.2657      Mean   :0.3824        Mean   :0.09207       Mean   :0.8297       
    ##  3rd Qu.:0.3333      3rd Qu.:0.4335        3rd Qu.:0.10000       3rd Qu.:1.0000       
    ##  Max.   :1.0000      Max.   :0.7553        Max.   :0.50000       Max.   :1.0000       
    ##  avg_negative_polarity min_negative_polarity max_negative_polarity title_subjectivity
    ##  Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000       Min.   :0.0000    
    ##  1st Qu.:-0.3250       1st Qu.:-0.7143       1st Qu.:-0.1250       1st Qu.:0.0000    
    ##  Median :-0.2625       Median :-0.5000       Median :-0.1000       Median :0.1389    
    ##  Mean   :-0.2671       Mean   :-0.5633       Mean   :-0.1046       Mean   :0.2928    
    ##  3rd Qu.:-0.2039       3rd Qu.:-0.4000       3rd Qu.:-0.0500       3rd Qu.:0.5000    
    ##  Max.   : 0.0000       Max.   : 0.0000       Max.   : 0.0000       Max.   :1.0000    
    ##  title_sentiment_polarity abs_title_subjectivity abs_title_sentiment_polarity
    ##  Min.   :-1.0000          Min.   :0.0000         Min.   :0.0000              
    ##  1st Qu.: 0.0000          1st Qu.:0.1667         1st Qu.:0.0000              
    ##  Median : 0.0000          Median :0.5000         Median :0.0000              
    ##  Mean   : 0.1101          Mean   :0.3438         Mean   :0.1803              
    ##  3rd Qu.: 0.2143          3rd Qu.:0.5000         3rd Qu.:0.3000              
    ##  Max.   : 1.0000          Max.   :0.5000         Max.   :1.0000              
    ##      shares      
    ##  Min.   :    78  
    ##  1st Qu.:  1100  
    ##  Median :  1700  
    ##  Mean   :  3737  
    ##  3rd Qu.:  3225  
    ##  Max.   :208300

``` r
#check structure of objects
str(LifestyleTrain)
```

    ## tibble [1,472 × 61] (S3: tbl_df/tbl/data.frame)
    ##  $ url                          : chr [1:1472] "http://mashable.com/2013/01/07/crayon-creatures/" "http://mashable.com/2013/01/07/livio-connect-expands/" "http://mashable.com/2013/01/07/omron-fitness-monitors/" "http://mashable.com/2013/01/07/traffic-signals-bugs/" ...
    ##  $ timedelta                    : num [1:1472] 731 731 731 731 729 729 729 729 729 729 ...
    ##  $ n_tokens_title               : num [1:1472] 10 11 10 6 11 7 11 9 10 7 ...
    ##  $ n_tokens_content             : num [1:1472] 187 315 1190 374 223 ...
    ##  $ n_unique_tokens              : num [1:1472] 0.667 0.551 0.409 0.641 0.662 ...
    ##  $ n_non_stop_words             : num [1:1472] 1 1 1 1 1 ...
    ##  $ n_non_stop_unique_tokens     : num [1:1472] 0.8 0.702 0.561 0.828 0.826 ...
    ##  $ num_hrefs                    : num [1:1472] 7 4 25 7 5 24 28 10 2 9 ...
    ##  $ num_self_hrefs               : num [1:1472] 0 4 24 0 3 23 24 5 1 6 ...
    ##  $ num_imgs                     : num [1:1472] 1 1 20 1 0 20 20 1 11 1 ...
    ##  $ num_videos                   : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ average_token_length         : num [1:1472] 4.66 4.38 4.62 4.91 4.55 ...
    ##  $ num_keywords                 : num [1:1472] 7 10 8 8 6 10 10 9 9 10 ...
    ##  $ data_channel_is_lifestyle    : num [1:1472] 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ data_channel_is_entertainment: num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ data_channel_is_bus          : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ data_channel_is_socmed       : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ data_channel_is_tech         : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ data_channel_is_world        : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ kw_min_min                   : num [1:1472] 0 0 0 0 217 217 217 217 217 217 ...
    ##  $ kw_max_min                   : num [1:1472] 0 0 0 0 1900 2600 823 2600 695 2600 ...
    ##  $ kw_avg_min                   : num [1:1472] 0 0 0 0 748 ...
    ##  $ kw_min_max                   : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ kw_max_max                   : num [1:1472] 0 0 0 0 17100 17100 17100 17100 17100 17100 ...
    ##  $ kw_avg_max                   : num [1:1472] 0 0 0 0 4517 ...
    ##  $ kw_min_avg                   : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ kw_max_avg                   : num [1:1472] 0 0 0 0 1953 ...
    ##  $ kw_avg_avg                   : num [1:1472] 0 0 0 0 1207 ...
    ##  $ self_reference_min_shares    : num [1:1472] 0 6200 545 0 6700 543 545 2000 0 1100 ...
    ##  $ self_reference_max_shares    : num [1:1472] 0 6200 16000 0 16700 16000 16000 4900 0 6000 ...
    ##  $ self_reference_avg_sharess   : num [1:1472] 0 6200 3151 0 11700 ...
    ##  $ weekday_is_monday            : num [1:1472] 1 1 1 1 0 0 0 0 0 0 ...
    ##  $ weekday_is_tuesday           : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_wednesday         : num [1:1472] 0 0 0 0 1 1 1 1 1 1 ...
    ##  $ weekday_is_thursday          : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_friday            : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_saturday          : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_sunday            : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ is_weekend                   : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ LDA_00                       : num [1:1472] 0.0286 0.0201 0.025 0.2066 0.0335 ...
    ##  $ LDA_01                       : num [1:1472] 0.0286 0.0206 0.1595 0.1461 0.217 ...
    ##  $ LDA_02                       : num [1:1472] 0.0286 0.0205 0.025 0.276 0.0334 ...
    ##  $ LDA_03                       : num [1:1472] 0.0287 0.1208 0.025 0.0251 0.0335 ...
    ##  $ LDA_04                       : num [1:1472] 0.885 0.818 0.765 0.346 0.683 ...
    ##  $ global_subjectivity          : num [1:1472] 0.477 0.554 0.507 0.399 0.372 ...
    ##  $ global_sentiment_polarity    : num [1:1472] 0.15 0.177 0.244 0.122 0.103 ...
    ##  $ global_rate_positive_words   : num [1:1472] 0.0267 0.0349 0.0639 0.0374 0.0493 ...
    ##  $ global_rate_negative_words   : num [1:1472] 0.0107 0.0127 0.0151 0.0187 0.0179 ...
    ##  $ rate_positive_words          : num [1:1472] 0.714 0.733 0.809 0.667 0.733 ...
    ##  $ rate_negative_words          : num [1:1472] 0.286 0.267 0.191 0.333 0.267 ...
    ##  $ avg_positive_polarity        : num [1:1472] 0.435 0.401 0.403 0.361 0.255 ...
    ##  $ min_positive_polarity        : num [1:1472] 0.2 0.1364 0.0333 0.1 0.1 ...
    ##  $ max_positive_polarity        : num [1:1472] 0.7 0.5 1 0.8 0.5 1 1 0.8 0.6 0.6 ...
    ##  $ avg_negative_polarity        : num [1:1472] -0.263 -0.32 -0.236 -0.13 -0.188 ...
    ##  $ min_negative_polarity        : num [1:1472] -0.4 -0.5 -0.5 -0.2 -0.4 ...
    ##  $ max_negative_polarity        : num [1:1472] -0.125 -0.125 -0.05 -0.05 -0.1 ...
    ##  $ title_subjectivity           : num [1:1472] 0 0.55 0 0 0 ...
    ##  $ title_sentiment_polarity     : num [1:1472] 0 0.35 0 0 0 ...
    ##  $ abs_title_subjectivity       : num [1:1472] 0.5 0.05 0.5 0.5 0.5 ...
    ##  $ abs_title_sentiment_polarity : num [1:1472] 0 0.35 0 0 0 ...
    ##  $ shares                       : num [1:1472] 1900 343 507 552 1900 1100 1200 2300 752 1000 ...

``` r
str(Lifestlye_sumstats_Train)
```

    ##  'table' chr [1:6, 1:61] "Length:1472       " "Class :character  " "Mode  :character  " ...
    ##  - attr(*, "dimnames")=List of 2
    ##   ..$ : chr [1:6] "" "" "" "" ...
    ##   ..$ : chr [1:61] "    url" "  timedelta" "n_tokens_title" "n_tokens_content" ...

``` r
#plots include - scatter plots, correlation plots -- plots for continuous data...
#do we need bar plots?

#A scatter plot with the number of shares on the y-axis and the positive word rate on the x-axis is created below
ggplot(data=LifestyleTrain, aes(y=shares, x=rate_positive_words)) + geom_point()
```

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

# Modelling

The data is already split into 70% training and 30% test. Our main goal
is to predict the number of shares. We will create four models each
using 5-fold cross-validation.

We begin by creating two multiple linear regression models.

A Linear regression model is a supervised learning technique that is
used to predict the value of a variable based on the value of other
variable(s). The variable you want to predict is called the dependent
variable or the response. The variable(s) you are using to predict is
called the independent variable(s) or the predictor(s).

In both linear models we are using the number of shares as our response
variable.

## First linear model.

For the first linear regression model we will model the number of shares
by “weekday_is_thursday” (Was the article published on a Thursday?),
“weekday_is_friday” (Was the article published on a Friday?) and
“is_weekend” (Was the article published on the weekend?). It seems
logical to assume that towards the ending of the week (Thursday -
Weekend) if an article is published it is more likely to be shared than
at the beginning of the week, hence the predictors
“weekday_is_thursday”, “weekday_is_friday” and “is_weekend” was chosen
for our first linear regression model.

``` r
l_m1 <- train(shares ~ weekday_is_thursday +  weekday_is_friday + is_weekend, data = LifestyleTrain, method = "lm", 
preProcess = c("center", "scale"),
trControl = trainControl(method= "cv", number = 5))

test_pred_l_m1 <- predict(l_m1, newdata = LifestyleTest)

postResample(test_pred_l_m1, LifestyleTest$shares)
```

    ##         RMSE     Rsquared          MAE 
    ## 9.089968e+03 4.395535e-04 3.225950e+03

## Second linear model

For the second linear regression model we will model the number of
shares by “num_imgs” (Number of images), “num_videos” (Number of videos)
and “num_hrefs” (Number of links). Pictures and videos in particular can
invoke feelings of happiness and as such articles with more pictures and
videos are more likely to be shared. Also if there is a greater number
of links the greater possibility of the article being viewed and
inherently shared.

For these reasons “num_imgs”, “num_videos” and “num_hrefs” were thought
to be good predictors for the number of shares.

``` r
l_m2 <- train(shares ~ num_imgs + num_videos + num_hrefs, data = LifestyleTrain, method = "lm", 
preProcess = c("center", "scale"),
trControl = trainControl(method= "cv", number = 5))

test_pred_l_m2 <- predict(l_m2, newdata = LifestyleTest)

postResample(test_pred_l_m2, LifestyleTest$shares)
```

    ##         RMSE     Rsquared          MAE 
    ## 9.091598e+03 1.022937e-03 3.180520e+03

## Random forest models. used days

``` r
r_f <- train(shares ~ weekday_is_thursday +  weekday_is_friday + is_weekend, data = LifestyleTrain, method = "rf",
 trControl=trainControl(method = "cv", number = 5),
 preProcess = c("center", "scale"),
 tuneGrid = data.frame(mtry = 1:15))


test_pred_r_f <- predict(r_f, newdata = LifestyleTest)

postResample(test_pred_r_f, LifestyleTest$shares)
```

    ##         RMSE     Rsquared          MAE 
    ## 9.089526e+03 3.027515e-04 3.217605e+03

## and the boosted tree model Number of images etc

``` r
tune1<- c(25, 50, 100, 150, 200)
tune2<- 1:4
tune3<- 0.1
tune4<- 10

boosted <- train(shares ~ num_imgs + num_videos + num_hrefs, data = LifestyleTrain, method = "gbm",
 trControl=trainControl(method = "cv", number = 5),
 preProcess = c("center", "scale"),
 tuneGrid = expand.grid(n.trees = tune1, interaction.depth = tune2, shrinkage = tune3,    n.minobsinnode = tune4))
```

    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 89311003.8156             nan     0.1000 46446.2493
    ##      2 88965502.2927             nan     0.1000 -40223.2649
    ##      3 88867062.7316             nan     0.1000 22454.8379
    ##      4 88821828.6717             nan     0.1000 -1263.6382
    ##      5 88675600.8661             nan     0.1000 -100374.4824
    ##      6 88647404.9461             nan     0.1000 -4987.6156
    ##      7 88496309.9608             nan     0.1000 -161286.2995
    ##      8 88397426.5193             nan     0.1000 -173279.2013
    ##      9 88268828.7440             nan     0.1000 3750.0744
    ##     10 88211319.8893             nan     0.1000 -3393.4955
    ##     20 87963982.6118             nan     0.1000 -22522.4654
    ##     40 87505118.4899             nan     0.1000 -63190.3072
    ##     60 87181851.4657             nan     0.1000 -14504.2578
    ##     80 86966650.4459             nan     0.1000 -45589.4574
    ##    100 86724399.3339             nan     0.1000 -215243.3608
    ##    120 86480307.8665             nan     0.1000 -88249.0239
    ##    140 86269065.9840             nan     0.1000 -56042.4595
    ##    160 86188202.3474             nan     0.1000 -57330.4987
    ##    180 86094412.0872             nan     0.1000 -49348.8455
    ##    200 85947933.3068             nan     0.1000 -71253.2943
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 89248983.4562             nan     0.1000 -9500.6199
    ##      2 88866067.9582             nan     0.1000 177760.6238
    ##      3 88516296.1009             nan     0.1000 117833.2403
    ##      4 88315766.6620             nan     0.1000 59751.9126
    ##      5 88035907.5932             nan     0.1000 -143471.1906
    ##      6 88030316.8262             nan     0.1000 -99938.1288
    ##      7 87702047.9933             nan     0.1000 -121248.0274
    ##      8 87503675.6849             nan     0.1000 22066.7208
    ##      9 87400098.5838             nan     0.1000 -146233.2134
    ##     10 87345872.9211             nan     0.1000 -49045.7479
    ##     20 86644399.9804             nan     0.1000 -127118.0061
    ##     40 85460439.0581             nan     0.1000 -95945.2088
    ##     60 84350766.6464             nan     0.1000 -50599.7083
    ##     80 83785856.0689             nan     0.1000 -177602.8417
    ##    100 83365565.3469             nan     0.1000 -282593.8828
    ##    120 82736093.9467             nan     0.1000 -311698.6726
    ##    140 82374890.1656             nan     0.1000 -194924.5626
    ##    160 81889760.9677             nan     0.1000 -276241.1213
    ##    180 81709861.6743             nan     0.1000 -45484.3603
    ##    200 81355508.7858             nan     0.1000 -107659.1454
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 89022067.7623             nan     0.1000 55829.9067
    ##      2 88715392.2166             nan     0.1000 -56373.8190
    ##      3 88330889.1137             nan     0.1000 228022.9317
    ##      4 88292768.6793             nan     0.1000 -78157.6041
    ##      5 87826935.6172             nan     0.1000 -34078.9682
    ##      6 87322782.8686             nan     0.1000 -250508.4255
    ##      7 87003634.7217             nan     0.1000 138628.9153
    ##      8 86568074.6978             nan     0.1000 19540.2880
    ##      9 86247283.1185             nan     0.1000 -17351.2635
    ##     10 85845906.5255             nan     0.1000 -169743.0797
    ##     20 84278283.0787             nan     0.1000 -62910.5158
    ##     40 83030286.8052             nan     0.1000 -163523.1743
    ##     60 81842432.2517             nan     0.1000 -181274.5974
    ##     80 80892534.4536             nan     0.1000 -192170.9826
    ##    100 80671024.5093             nan     0.1000 -312955.4529
    ##    120 80142629.1505             nan     0.1000 -291854.9710
    ##    140 79245931.8373             nan     0.1000 -505145.0648
    ##    160 78731421.8993             nan     0.1000 -167092.2856
    ##    180 78274062.3741             nan     0.1000 -553764.6060
    ##    200 77945636.8915             nan     0.1000 -176574.9805
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 89493463.7928             nan     0.1000 -29043.2003
    ##      2 88701414.9047             nan     0.1000 8963.0835
    ##      3 88214808.7475             nan     0.1000 108444.2562
    ##      4 87669033.6105             nan     0.1000 -120431.9081
    ##      5 87665592.4638             nan     0.1000 -236418.6800
    ##      6 87617769.2775             nan     0.1000 -105517.8375
    ##      7 87233478.0208             nan     0.1000 -69389.0929
    ##      8 86727775.2329             nan     0.1000 -261410.1245
    ##      9 86598768.1614             nan     0.1000 9340.9939
    ##     10 86118322.5955             nan     0.1000 -84403.2150
    ##     20 84100937.2676             nan     0.1000 5618.2940
    ##     40 81699979.8655             nan     0.1000 -885424.6550
    ##     60 80387820.0691             nan     0.1000 -321790.2424
    ##     80 79698490.7898             nan     0.1000 -215238.4578
    ##    100 78842864.3501             nan     0.1000 -673728.4191
    ##    120 77807760.6516             nan     0.1000 -273219.5992
    ##    140 77159678.1773             nan     0.1000 -301007.6809
    ##    160 76705252.7610             nan     0.1000 -281503.0866
    ##    180 75956307.4398             nan     0.1000 -91073.3168
    ##    200 75678109.2195             nan     0.1000 -323316.4852
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 92916831.1960             nan     0.1000 14819.5773
    ##      2 92564210.3265             nan     0.1000 300525.5887
    ##      3 92493014.9740             nan     0.1000 -11195.0966
    ##      4 92321734.6485             nan     0.1000  134.3909
    ##      5 92031225.7745             nan     0.1000 -8663.1389
    ##      6 91980530.7201             nan     0.1000 32297.9388
    ##      7 91884448.8853             nan     0.1000 81356.0670
    ##      8 91850561.1251             nan     0.1000 -13754.6038
    ##      9 91784733.8232             nan     0.1000 -48221.7431
    ##     10 91758051.6695             nan     0.1000 -119954.4922
    ##     20 91395232.4220             nan     0.1000 -111167.0866
    ##     40 90825046.4786             nan     0.1000 -104315.1639
    ##     60 90469955.1730             nan     0.1000 -264170.5690
    ##     80 90056401.2352             nan     0.1000 -58498.5168
    ##    100 89737651.3703             nan     0.1000 -224939.0974
    ##    120 89461845.3153             nan     0.1000 -296828.7568
    ##    140 89226678.0326             nan     0.1000 -70623.2459
    ##    160 89022170.1180             nan     0.1000 -115586.3303
    ##    180 88872003.4649             nan     0.1000 -56880.7932
    ##    200 88734092.7937             nan     0.1000 -13996.2757
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 92634846.9901             nan     0.1000 179684.8111
    ##      2 92556664.7152             nan     0.1000 43703.1339
    ##      3 92126025.1276             nan     0.1000 -116615.7767
    ##      4 91895231.9095             nan     0.1000 7354.6440
    ##      5 91708475.9440             nan     0.1000 109379.1082
    ##      6 91650988.1927             nan     0.1000 -95320.7001
    ##      7 91614928.6163             nan     0.1000 -73111.2714
    ##      8 91448818.3971             nan     0.1000 -142493.3211
    ##      9 91068816.7617             nan     0.1000 -18110.6440
    ##     10 90977602.7533             nan     0.1000 40431.4646
    ##     20 89817806.2874             nan     0.1000 -170505.3275
    ##     40 88669125.7543             nan     0.1000 -112891.3333
    ##     60 88073103.3577             nan     0.1000 -282802.2407
    ##     80 87295792.1249             nan     0.1000 -10540.8560
    ##    100 86911085.1944             nan     0.1000 -96151.2164
    ##    120 86469586.8791             nan     0.1000 -126459.0106
    ##    140 86274630.8737             nan     0.1000 -183685.2044
    ##    160 85542622.1649             nan     0.1000 -198801.7422
    ##    180 85010566.8901             nan     0.1000 -5464.2978
    ##    200 84634787.4762             nan     0.1000 -128847.4683
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 92530396.7351             nan     0.1000 -41107.3407
    ##      2 91784662.8516             nan     0.1000 -99670.2267
    ##      3 91509273.9029             nan     0.1000 -113764.0442
    ##      4 91067558.6384             nan     0.1000 -283330.5453
    ##      5 90887725.1189             nan     0.1000 11124.1854
    ##      6 90441154.5552             nan     0.1000 -161010.3346
    ##      7 90310905.9301             nan     0.1000 15926.1709
    ##      8 90214013.5878             nan     0.1000 -55103.4536
    ##      9 90136011.5208             nan     0.1000 -242186.0667
    ##     10 90067323.7586             nan     0.1000 -135667.2500
    ##     20 89019435.8011             nan     0.1000 -180160.0492
    ##     40 86441526.8670             nan     0.1000 -154617.7605
    ##     60 85715407.3142             nan     0.1000 -214161.7868
    ##     80 84707084.5517             nan     0.1000 -158859.1539
    ##    100 83706459.9549             nan     0.1000 -256205.4570
    ##    120 82679938.9704             nan     0.1000 -326231.2226
    ##    140 82175346.1273             nan     0.1000 -215907.7351
    ##    160 81551096.4369             nan     0.1000 -110878.1297
    ##    180 81255564.8148             nan     0.1000 -100284.8029
    ##    200 80575865.8995             nan     0.1000 -207883.7041
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 92252735.4166             nan     0.1000 161922.1151
    ##      2 91939511.4377             nan     0.1000 216775.4380
    ##      3 91170571.1491             nan     0.1000 21271.6157
    ##      4 90627126.6402             nan     0.1000 -37540.5474
    ##      5 90034208.6910             nan     0.1000 -528314.1235
    ##      6 89787397.1581             nan     0.1000 -25946.2899
    ##      7 89284266.7128             nan     0.1000 -235896.7084
    ##      8 88887688.1230             nan     0.1000 -639179.9611
    ##      9 88694634.9259             nan     0.1000 -158881.3651
    ##     10 88304393.6143             nan     0.1000 15076.8421
    ##     20 87183319.1455             nan     0.1000 -211791.4969
    ##     40 85103764.3605             nan     0.1000 -446221.6543
    ##     60 83736730.4309             nan     0.1000 -710719.2287
    ##     80 82693171.9599             nan     0.1000 -188876.8643
    ##    100 81452782.9009             nan     0.1000 -185720.4940
    ##    120 80808386.2634             nan     0.1000 -127768.2110
    ##    140 79983136.9827             nan     0.1000 -249010.1637
    ##    160 79385823.4149             nan     0.1000 -634775.9698
    ##    180 78830264.1979             nan     0.1000 -510014.3692
    ##    200 78383496.6583             nan     0.1000 -612338.9149
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 84720686.0479             nan     0.1000 -98104.7969
    ##      2 84514239.9292             nan     0.1000 -67280.2885
    ##      3 84339824.7495             nan     0.1000 -76591.9186
    ##      4 84306581.6578             nan     0.1000 -112424.3738
    ##      5 84280776.7980             nan     0.1000 -66035.0908
    ##      6 84183960.7539             nan     0.1000 -84240.1493
    ##      7 84111339.8100             nan     0.1000 -84601.1578
    ##      8 84064327.5172             nan     0.1000 -78420.3658
    ##      9 84034107.7994             nan     0.1000 -305403.8571
    ##     10 84045061.6502             nan     0.1000 -163242.4828
    ##     20 83846352.7467             nan     0.1000 -99451.3442
    ##     40 83422239.7554             nan     0.1000 -17053.1716
    ##     60 83149397.9126             nan     0.1000 -83675.1461
    ##     80 82955827.2200             nan     0.1000 -309546.6342
    ##    100 82678969.1166             nan     0.1000 -101809.4219
    ##    120 82506935.8901             nan     0.1000 -104750.8100
    ##    140 82284163.9759             nan     0.1000 -95514.5556
    ##    160 82253659.6028             nan     0.1000 -105666.3362
    ##    180 82044486.5600             nan     0.1000 -231278.3014
    ##    200 82014225.8758             nan     0.1000 -172513.7016
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 84731533.7332             nan     0.1000 -10025.3690
    ##      2 84383676.5145             nan     0.1000 182115.0146
    ##      3 84048524.9902             nan     0.1000 -168777.6077
    ##      4 83816630.0358             nan     0.1000 81560.8219
    ##      5 83605220.8123             nan     0.1000 -26328.3550
    ##      6 83512937.3251             nan     0.1000 36270.9312
    ##      7 83326924.9670             nan     0.1000 -23684.5223
    ##      8 83151531.0234             nan     0.1000 -252838.8025
    ##      9 83082480.5507             nan     0.1000 -50277.1889
    ##     10 83053225.6098             nan     0.1000 -109553.8913
    ##     20 82327121.9969             nan     0.1000 -105209.5417
    ##     40 81273928.9661             nan     0.1000 -150072.5720
    ##     60 80623875.6155             nan     0.1000 -185248.2504
    ##     80 79829725.9512             nan     0.1000 -111911.4169
    ##    100 79467817.5494             nan     0.1000 -127428.7011
    ##    120 78992062.3015             nan     0.1000 -308732.9715
    ##    140 78546966.1129             nan     0.1000 -170738.6629
    ##    160 78228273.1620             nan     0.1000 -620545.3830
    ##    180 78066086.1420             nan     0.1000 -81390.3016
    ##    200 77631170.3372             nan     0.1000 -47138.3320
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 84530577.0626             nan     0.1000 -117928.5500
    ##      2 83852208.8475             nan     0.1000 -58567.1787
    ##      3 83600445.3117             nan     0.1000 157822.6377
    ##      4 82952409.0586             nan     0.1000 -193069.8744
    ##      5 82729689.0349             nan     0.1000 -62135.3345
    ##      6 82397910.1676             nan     0.1000 -351648.8223
    ##      7 82290903.8511             nan     0.1000 -212097.1246
    ##      8 82014991.9217             nan     0.1000 -138735.8172
    ##      9 81879608.9395             nan     0.1000 -67702.3737
    ##     10 81858505.6154             nan     0.1000 -137853.5280
    ##     20 80682919.3430             nan     0.1000 -455804.7879
    ##     40 78674936.4784             nan     0.1000 -238953.0833
    ##     60 77639462.9439             nan     0.1000 -223366.2567
    ##     80 77038453.5245             nan     0.1000 -343617.6432
    ##    100 76571771.7493             nan     0.1000 -378432.7224
    ##    120 76197838.7999             nan     0.1000 -402353.6573
    ##    140 75449382.5690             nan     0.1000 -19354.8031
    ##    160 74943284.1847             nan     0.1000 -116384.6759
    ##    180 74556515.3627             nan     0.1000 -123387.1669
    ##    200 74251649.5008             nan     0.1000 -179491.7094
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 84732688.0010             nan     0.1000 -178252.6455
    ##      2 83883875.4003             nan     0.1000 89530.0588
    ##      3 83397862.4986             nan     0.1000 -162548.9470
    ##      4 82831713.0426             nan     0.1000 -66532.1017
    ##      5 82420915.8006             nan     0.1000 -245401.6413
    ##      6 82038276.9987             nan     0.1000 -121785.8681
    ##      7 81734634.6236             nan     0.1000 -100855.4132
    ##      8 81639800.9983             nan     0.1000 -79449.2247
    ##      9 81608245.5135             nan     0.1000 -284723.6480
    ##     10 81545180.6144             nan     0.1000 -114226.5267
    ##     20 79908722.3934             nan     0.1000 -69326.7545
    ##     40 77956719.6860             nan     0.1000 -350259.0446
    ##     60 76818056.4853             nan     0.1000 -424980.7269
    ##     80 75782924.2113             nan     0.1000 -241139.5902
    ##    100 74573703.8824             nan     0.1000 -139153.1157
    ##    120 74071053.7573             nan     0.1000 -405212.7187
    ##    140 73162110.9754             nan     0.1000 -237253.4731
    ##    160 72779061.5206             nan     0.1000 -368602.4775
    ##    180 72372250.7782             nan     0.1000 -362476.1208
    ##    200 72061028.9601             nan     0.1000 -472823.9680
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 50681429.5830             nan     0.1000 55931.9690
    ##      2 50564401.2600             nan     0.1000 33702.6255
    ##      3 50539887.5716             nan     0.1000 -11293.3768
    ##      4 50480405.7433             nan     0.1000 -9053.3967
    ##      5 50359727.7937             nan     0.1000 -4359.7084
    ##      6 50342470.3110             nan     0.1000 -56097.2387
    ##      7 50258831.7704             nan     0.1000 -53037.0125
    ##      8 50154297.3159             nan     0.1000 -90736.6658
    ##      9 50149009.3436             nan     0.1000 -65502.4164
    ##     10 50084896.8868             nan     0.1000 36736.0457
    ##     20 49828310.7518             nan     0.1000 -213301.7129
    ##     40 49542105.7105             nan     0.1000 -44268.4745
    ##     60 49343141.1408             nan     0.1000 -126820.8583
    ##     80 49174840.8771             nan     0.1000 -41374.3722
    ##    100 48951995.8312             nan     0.1000 -42605.4448
    ##    120 48780759.1059             nan     0.1000 -49637.7361
    ##    140 48610604.1788             nan     0.1000 -139548.2872
    ##    160 48487341.4778             nan     0.1000 -31019.1783
    ##    180 48366316.1738             nan     0.1000 -13199.5547
    ##    200 48260755.4747             nan     0.1000 -47669.8346
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 50729027.7895             nan     0.1000 66554.9599
    ##      2 50620380.3579             nan     0.1000 -61101.4666
    ##      3 50461562.9928             nan     0.1000 -70881.4506
    ##      4 50281459.5409             nan     0.1000 -10598.9863
    ##      5 50078450.0202             nan     0.1000 -70008.2684
    ##      6 49949128.7861             nan     0.1000 89175.9460
    ##      7 49827168.8438             nan     0.1000 -20741.5880
    ##      8 49752982.5531             nan     0.1000 -119136.3569
    ##      9 49677202.6955             nan     0.1000 -18288.5387
    ##     10 49603466.0965             nan     0.1000 -12530.2230
    ##     20 48835497.6232             nan     0.1000 -90766.3186
    ##     40 48168958.6205             nan     0.1000 -77742.6812
    ##     60 47628631.4102             nan     0.1000 -38525.9310
    ##     80 47027331.8226             nan     0.1000 -45577.8929
    ##    100 46694947.1041             nan     0.1000 -36314.7117
    ##    120 46476123.6088             nan     0.1000 -59745.1153
    ##    140 46260578.4685             nan     0.1000 -158374.2912
    ##    160 46142619.6515             nan     0.1000 -43134.7649
    ##    180 46007427.1160             nan     0.1000 -28225.8709
    ##    200 45842913.8705             nan     0.1000 -88643.7030
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 50712315.5741             nan     0.1000 29442.4675
    ##      2 50396245.4241             nan     0.1000 233227.3579
    ##      3 50206590.7366             nan     0.1000 32252.0332
    ##      4 50081929.7065             nan     0.1000 18754.9309
    ##      5 49926531.0502             nan     0.1000 22262.9295
    ##      6 49618375.7947             nan     0.1000 48693.4853
    ##      7 49332816.4841             nan     0.1000 -61526.4738
    ##      8 49246600.8439             nan     0.1000 2853.4995
    ##      9 49182739.8269             nan     0.1000 -40419.2744
    ##     10 49063615.6927             nan     0.1000 -55243.4919
    ##     20 48427978.7093             nan     0.1000 -55373.2336
    ##     40 47370665.7512             nan     0.1000 -55713.8496
    ##     60 46767543.9321             nan     0.1000 -171384.1265
    ##     80 46116982.0202             nan     0.1000 -105351.3130
    ##    100 45646637.4256             nan     0.1000 -85859.6060
    ##    120 45178845.5878             nan     0.1000 -63940.6692
    ##    140 44802560.8852             nan     0.1000 -53358.8094
    ##    160 44640605.3233             nan     0.1000 -139432.4644
    ##    180 44383792.5742             nan     0.1000 -141877.1745
    ##    200 43888789.5884             nan     0.1000 -141088.5386
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 50402558.8282             nan     0.1000 88584.2238
    ##      2 50210739.3866             nan     0.1000 -2962.9852
    ##      3 50096360.3045             nan     0.1000 -3533.4859
    ##      4 49923857.1741             nan     0.1000 -103942.2278
    ##      5 49761051.6382             nan     0.1000 -54464.6596
    ##      6 49536917.4380             nan     0.1000 -34700.7174
    ##      7 49142096.0924             nan     0.1000 -55813.3859
    ##      8 48858437.9692             nan     0.1000 -222405.1353
    ##      9 48766541.7388             nan     0.1000 -66497.5212
    ##     10 48712110.6880             nan     0.1000 -117128.2381
    ##     20 47716821.8448             nan     0.1000 -94013.1849
    ##     40 46370272.4303             nan     0.1000 -97222.7954
    ##     60 45765952.8435             nan     0.1000 -149147.1490
    ##     80 45135602.8717             nan     0.1000 -76753.6687
    ##    100 44781226.7214             nan     0.1000 -104763.2121
    ##    120 44286662.7811             nan     0.1000 -192151.0163
    ##    140 43748256.9288             nan     0.1000 -94540.2938
    ##    160 43298011.3349             nan     0.1000 -59817.3349
    ##    180 42972473.5565             nan     0.1000 -181916.5053
    ##    200 42696234.9082             nan     0.1000 -106434.1563
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 67624927.3291             nan     0.1000 15867.9445
    ##      2 67537945.8843             nan     0.1000 35585.5390
    ##      3 67450436.1148             nan     0.1000 -77545.9985
    ##      4 67262839.8885             nan     0.1000 -16201.8384
    ##      5 67144162.3859             nan     0.1000 -23514.4357
    ##      6 67047119.9465             nan     0.1000 -28238.3195
    ##      7 67040789.1983             nan     0.1000 -58631.4051
    ##      8 66989096.0571             nan     0.1000 -151.2836
    ##      9 66967034.3704             nan     0.1000 -112512.5798
    ##     10 66952057.8414             nan     0.1000 -56057.8311
    ##     20 66674437.0969             nan     0.1000 -40033.8022
    ##     40 66463225.4272             nan     0.1000 -18839.4621
    ##     60 66316812.7582             nan     0.1000 -60039.5285
    ##     80 66155807.0834             nan     0.1000 -12461.9174
    ##    100 65992858.7666             nan     0.1000 -62035.7578
    ##    120 65920327.9895             nan     0.1000 -48727.9337
    ##    140 65810856.1928             nan     0.1000 -38642.6434
    ##    160 65703329.7282             nan     0.1000 -59443.2333
    ##    180 65590396.0284             nan     0.1000 -108531.1434
    ##    200 65495262.8836             nan     0.1000 -71552.8268
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 67681969.0971             nan     0.1000 68990.8392
    ##      2 67442411.6005             nan     0.1000 74098.2922
    ##      3 67219025.3723             nan     0.1000 7215.4868
    ##      4 67042985.8768             nan     0.1000 17245.1199
    ##      5 66951799.7848             nan     0.1000 -66185.7376
    ##      6 66835691.4564             nan     0.1000 -39841.1173
    ##      7 66802744.5687             nan     0.1000 -34750.0475
    ##      8 66735659.7170             nan     0.1000 -99807.5404
    ##      9 66691126.0113             nan     0.1000 -71907.4258
    ##     10 66364123.6638             nan     0.1000 -55639.7840
    ##     20 65551595.4549             nan     0.1000 -54940.5785
    ##     40 64712270.4840             nan     0.1000 -497294.3683
    ##     60 64366881.6258             nan     0.1000 -86842.1056
    ##     80 64015083.8063             nan     0.1000 -201074.4343
    ##    100 63746212.6199             nan     0.1000 -107558.2230
    ##    120 63568830.7350             nan     0.1000 -127615.0355
    ##    140 63386630.1158             nan     0.1000 -354930.8360
    ##    160 63200410.9027             nan     0.1000 -176835.8693
    ##    180 63100195.8637             nan     0.1000 -261089.5224
    ##    200 63035133.7092             nan     0.1000 -172289.8882
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 67059087.2546             nan     0.1000 -41541.9145
    ##      2 66942680.8382             nan     0.1000 25559.6849
    ##      3 66613497.9660             nan     0.1000 -21137.3646
    ##      4 66442624.2549             nan     0.1000 -101760.8687
    ##      5 66250936.5748             nan     0.1000 -71073.6051
    ##      6 66168233.3963             nan     0.1000 -16510.2781
    ##      7 65748046.9684             nan     0.1000 -156720.0251
    ##      8 65142195.1803             nan     0.1000 -346137.8321
    ##      9 64999208.9627             nan     0.1000 -142904.8926
    ##     10 64890130.7083             nan     0.1000 -307326.7262
    ##     20 64183517.8760             nan     0.1000 -365023.9212
    ##     40 62814680.3519             nan     0.1000 -55134.9941
    ##     60 62494137.8029             nan     0.1000 -159362.3731
    ##     80 62118845.5738             nan     0.1000 -145563.0262
    ##    100 61482782.4896             nan     0.1000 -309517.3998
    ##    120 60781706.8261             nan     0.1000 -131569.9890
    ##    140 60423538.5502             nan     0.1000 -139517.8996
    ##    160 59981874.4543             nan     0.1000 -390253.5105
    ##    180 59566434.0346             nan     0.1000 -118982.9604
    ##    200 59358331.5307             nan     0.1000 -467684.9114
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 67513571.2335             nan     0.1000 24567.4364
    ##      2 67291715.8570             nan     0.1000 90165.8533
    ##      3 67146006.1059             nan     0.1000 71902.0461
    ##      4 66363723.3009             nan     0.1000 -167388.7264
    ##      5 65841134.6109             nan     0.1000 -277610.8379
    ##      6 65780070.7582             nan     0.1000 -197070.2941
    ##      7 65687971.9716             nan     0.1000 -35725.8698
    ##      8 65313247.0568             nan     0.1000 -174001.9050
    ##      9 64679900.6084             nan     0.1000 -136523.8942
    ##     10 64432330.9853             nan     0.1000 -258061.9814
    ##     20 63389977.6814             nan     0.1000 -68911.5110
    ##     40 61927643.6186             nan     0.1000 -297956.5774
    ##     60 61502179.2834             nan     0.1000 -526156.8337
    ##     80 60437794.6777             nan     0.1000 -166845.3121
    ##    100 59565437.1413             nan     0.1000 -487921.0266
    ##    120 59000233.8162             nan     0.1000 -344017.7649
    ##    140 58502018.8104             nan     0.1000 -240685.5537
    ##    160 58024446.0141             nan     0.1000 -344503.7607
    ##    180 57559111.1726             nan     0.1000 -150904.8858
    ##    200 57263968.9706             nan     0.1000 -327508.6600
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 77121887.7733             nan     0.1000 143436.7397
    ##      2 76995598.2226             nan     0.1000 120145.0674
    ##      3 76828679.3721             nan     0.1000 75003.0043
    ##      4 76685694.5335             nan     0.1000 70421.1634
    ##      5 76572292.0573             nan     0.1000 13567.8001
    ##      6 76534796.5620             nan     0.1000 24428.5336
    ##      7 76425195.2815             nan     0.1000 -109163.7118
    ##      8 76337368.6447             nan     0.1000 38563.8790
    ##      9 76312975.3348             nan     0.1000 -23626.2031
    ##     10 76256087.0828             nan     0.1000 -102277.3642
    ##     20 76007853.2548             nan     0.1000 -123524.6994
    ##     25 75879636.3037             nan     0.1000 -22620.1061

``` r
test_pred_boosted <- predict(boosted, newdata = LifestyleTest)

postResample(test_pred_boosted, LifestyleTest$shares)
```

    ##         RMSE     Rsquared          MAE 
    ## 9.156736e+03 1.572266e-04 3.259582e+03

Next we do a comparison of the four models

The model with the lowest rmse is Random Forest-winner

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
