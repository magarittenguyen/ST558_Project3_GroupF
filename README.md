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
    -   <a href="#random-forest-model" id="toc-random-forest-model">Random
        forest model</a>
    -   <a href="#boosted-tree-model" id="toc-boosted-tree-model">Boosted tree
        model</a>
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
features about articles published by Mashable (www.mashable.com) in a
period of two years. We will summarize the data and try to predict the
number of shares using linear regression, Random forest and boosting
(will add more later)

This dataset summarizes a heterogeneous set of features about articles
published by Mashable in a period of two years. The goal is to predict
the number of shares in social networks (popularity).

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
# ./ stays in the same file directory
OnlineNewsPopularity<-read_csv("./OnlineNewsPopularity.csv", show_col_types = FALSE)

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
#subsetting the OnlineNewsPopularity full raw data for the data channel of interest -- Lifestyle
Lifestyle <- OnlineNewsPopularity %>% 
               filter(data_channel_is_lifestyle == 1) %>%
               # removing non-predictive variables per dataset description
               # remove all data_channel_is_* variables because we already filtered on them and we do not want them included in the model!
               select( ! c(url, timedelta, starts_with("data_channel_is_" ) ) )

#tidyverse way of looking at the dataset -- similar to str()
#glimpse(Lifestyle)

#calling the Lifestyle object to view
Lifestyle
```

    ## # A tibble: 2,099 × 53
    ##    n_tokens…¹ n_tok…² n_uni…³ n_non…⁴ n_non…⁵ num_h…⁶ num_s…⁷ num_i…⁸ num_v…⁹ avera…˟ num_k…˟
    ##         <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
    ##  1          8     960   0.418    1.00   0.550      21      20      20       0    4.65      10
    ##  2         10     187   0.667    1.00   0.800       7       0       1       0    4.66       7
    ##  3         11     103   0.689    1.00   0.806       3       1       1       0    4.84       6
    ##  4         10     243   0.619    1.00   0.824       1       1       0       0    4.38      10
    ##  5          8     204   0.586    1.00   0.698       7       2       1       0    4.67       8
    ##  6         11     315   0.551    1.00   0.702       4       4       1       0    4.38      10
    ##  7         10    1190   0.409    1.00   0.561      25      24      20       0    4.62       8
    ##  8          6     374   0.641    1.00   0.828       7       0       1       0    4.91       8
    ##  9         12     499   0.513    1.00   0.662      14       1       1       0    5.08      10
    ## 10         11     223   0.662    1.00   0.826       5       3       0       0    4.55       6
    ## # … with 2,089 more rows, 42 more variables: kw_min_min <dbl>, kw_max_min <dbl>,
    ## #   kw_avg_min <dbl>, kw_min_max <dbl>, kw_max_max <dbl>, kw_avg_max <dbl>,
    ## #   kw_min_avg <dbl>, kw_max_avg <dbl>, kw_avg_avg <dbl>, self_reference_min_shares <dbl>,
    ## #   self_reference_max_shares <dbl>, self_reference_avg_sharess <dbl>,
    ## #   weekday_is_monday <dbl>, weekday_is_tuesday <dbl>, weekday_is_wednesday <dbl>,
    ## #   weekday_is_thursday <dbl>, weekday_is_friday <dbl>, weekday_is_saturday <dbl>,
    ## #   weekday_is_sunday <dbl>, is_weekend <dbl>, LDA_00 <dbl>, LDA_01 <dbl>, LDA_02 <dbl>, …

# Summarizations

\<\<\<\<\<\<\< HEAD Now split the data set we’ve created into a training
and testing set. Use p = 0.7.

Here, we are splitting our created data, Lifestyle, into a training and
test set with p = 0.7. These datasets will be called `LifestyleTrain`
and `LifestyleTest`.

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

    ##  n_tokens_title   n_tokens_content n_unique_tokens  n_non_stop_words
    ##  Min.   : 3.000   Min.   :   0.0   Min.   :0.0000   Min.   :0.0000  
    ##  1st Qu.: 8.000   1st Qu.: 315.0   1st Qu.:0.4626   1st Qu.:1.0000  
    ##  Median :10.000   Median : 501.5   Median :0.5178   Median :1.0000  
    ##  Mean   : 9.762   Mean   : 633.3   Mean   :0.5211   Mean   :0.9891  
    ##  3rd Qu.:11.000   3rd Qu.: 801.5   3rd Qu.:0.5886   3rd Qu.:1.0000  
    ##  Max.   :17.000   Max.   :8474.0   Max.   :0.8248   Max.   :1.0000  
    ##  n_non_stop_unique_tokens   num_hrefs      num_self_hrefs      num_imgs      
    ##  Min.   :0.0000           Min.   :  0.00   Min.   : 0.000   Min.   :  0.000  
    ##  1st Qu.:0.6292           1st Qu.:  6.00   1st Qu.: 1.000   1st Qu.:  1.000  
    ##  Median :0.6829           Median : 10.00   Median : 2.000   Median :  1.000  
    ##  Mean   :0.6818           Mean   : 13.61   Mean   : 2.566   Mean   :  5.058  
    ##  3rd Qu.:0.7514           3rd Qu.: 19.00   3rd Qu.: 3.000   3rd Qu.:  8.000  
    ##  Max.   :0.9697           Max.   :145.00   Max.   :27.000   Max.   :111.000  
    ##    num_videos     average_token_length  num_keywords      kw_min_min       kw_max_min   
    ##  Min.   : 0.000   Min.   :0.000        Min.   : 3.000   Min.   : -1.00   Min.   :    0  
    ##  1st Qu.: 0.000   1st Qu.:4.449        1st Qu.: 7.000   1st Qu.: -1.00   1st Qu.:  488  
    ##  Median : 0.000   Median :4.620        Median : 8.000   Median :  4.00   Median :  803  
    ##  Mean   : 0.485   Mean   :4.584        Mean   : 8.235   Mean   : 41.06   Mean   : 1580  
    ##  3rd Qu.: 0.000   3rd Qu.:4.791        3rd Qu.:10.000   3rd Qu.:  4.00   3rd Qu.: 1300  
    ##  Max.   :50.000   Max.   :5.947        Max.   :10.000   Max.   :377.00   Max.   :80400  
    ##    kw_avg_min        kw_min_max       kw_max_max       kw_avg_max       kw_min_avg  
    ##  Min.   :   -1.0   Min.   :     0   Min.   :     0   Min.   :     0   Min.   :   0  
    ##  1st Qu.:  185.5   1st Qu.:     0   1st Qu.:690400   1st Qu.:118866   1st Qu.:   0  
    ##  Median :  296.3   Median :     0   Median :843300   Median :182440   Median :   0  
    ##  Mean   :  408.7   Mean   :  7057   Mean   :705830   Mean   :183327   Mean   :1052  
    ##  3rd Qu.:  444.9   3rd Qu.:  6300   3rd Qu.:843300   3rd Qu.:248253   3rd Qu.:2264  
    ##  Max.   :13744.8   Max.   :208300   Max.   :843300   Max.   :491771   Max.   :3594  
    ##    kw_max_avg      kw_avg_avg    self_reference_min_shares self_reference_max_shares
    ##  Min.   :    0   Min.   :    0   Min.   :     0.0          Min.   :     0           
    ##  1st Qu.: 4061   1st Qu.: 2638   1st Qu.:   648.8          1st Qu.:  1000           
    ##  Median : 5034   Median : 3227   Median :  1700.0          Median :  2800           
    ##  Mean   : 6583   Mean   : 3401   Mean   :  4440.8          Mean   :  8445           
    ##  3rd Qu.: 7303   3rd Qu.: 3953   3rd Qu.:  3600.0          3rd Qu.:  6800           
    ##  Max.   :95422   Max.   :20378   Max.   :138700.0          Max.   :690400           
    ##  self_reference_avg_sharess weekday_is_monday weekday_is_tuesday weekday_is_wednesday
    ##  Min.   :     0.0           Min.   :0.0000    Min.   :0.000      Min.   :0.0000      
    ##  1st Qu.:   996.8           1st Qu.:0.0000    1st Qu.:0.000      1st Qu.:0.0000      
    ##  Median :  2485.1           Median :0.0000    Median :0.000      Median :0.0000      
    ##  Mean   :  6136.0           Mean   :0.1508    Mean   :0.163      Mean   :0.1882      
    ##  3rd Qu.:  5400.4           3rd Qu.:0.0000    3rd Qu.:0.000      3rd Qu.:0.0000      
    ##  Max.   :401450.0           Max.   :1.0000    Max.   :1.000      Max.   :1.0000      
    ##  weekday_is_thursday weekday_is_friday weekday_is_saturday weekday_is_sunday
    ##  Min.   :0.0000      Min.   :0.0000    Min.   :0.0000      Min.   :0.0000   
    ##  1st Qu.:0.0000      1st Qu.:0.0000    1st Qu.:0.0000      1st Qu.:0.0000   
    ##  Median :0.0000      Median :0.0000    Median :0.0000      Median :0.0000   
    ##  Mean   :0.1651      Mean   :0.1433    Mean   :0.0856      Mean   :0.1039   
    ##  3rd Qu.:0.0000      3rd Qu.:0.0000    3rd Qu.:0.0000      3rd Qu.:0.0000   
    ##  Max.   :1.0000      Max.   :1.0000    Max.   :1.0000      Max.   :1.0000   
    ##    is_weekend         LDA_00            LDA_01            LDA_02            LDA_03       
    ##  Min.   :0.0000   Min.   :0.01818   Min.   :0.01819   Min.   :0.01819   Min.   :0.01820  
    ##  1st Qu.:0.0000   1st Qu.:0.02250   1st Qu.:0.02222   1st Qu.:0.02222   1st Qu.:0.02260  
    ##  Median :0.0000   Median :0.02913   Median :0.02507   Median :0.02523   Median :0.02925  
    ##  Mean   :0.1895   Mean   :0.17892   Mean   :0.06751   Mean   :0.07769   Mean   :0.14188  
    ##  3rd Qu.:0.0000   3rd Qu.:0.25060   3rd Qu.:0.04001   3rd Qu.:0.06667   3rd Qu.:0.19724  
    ##  Max.   :1.0000   Max.   :0.91980   Max.   :0.68825   Max.   :0.67623   Max.   :0.91892  
    ##      LDA_04        global_subjectivity global_sentiment_polarity global_rate_positive_words
    ##  Min.   :0.02014   Min.   :0.0000      Min.   :-0.30000          Min.   :0.00000           
    ##  1st Qu.:0.32329   1st Qu.:0.4265      1st Qu.: 0.09929          1st Qu.:0.03493           
    ##  Median :0.56851   Median :0.4780      Median : 0.15023          Median :0.04424           
    ##  Mean   :0.53400   Mean   :0.4734      Mean   : 0.15143          Mean   :0.04457           
    ##  3rd Qu.:0.79956   3rd Qu.:0.5273      3rd Qu.: 0.20511          3rd Qu.:0.05378           
    ##  Max.   :0.92707   Max.   :0.7778      Max.   : 0.51389          Max.   :0.10791           
    ##  global_rate_negative_words rate_positive_words rate_negative_words avg_positive_polarity
    ##  Min.   :0.00000            Min.   :0.0000      Min.   :0.0000      Min.   :0.0000       
    ##  1st Qu.:0.01025            1st Qu.:0.6667      1st Qu.:0.1852      1st Qu.:0.3358       
    ##  Median :0.01521            Median :0.7399      Median :0.2560      Median :0.3836       
    ##  Mean   :0.01632            Mean   :0.7235      Mean   :0.2657      Mean   :0.3824       
    ##  3rd Qu.:0.02094            3rd Qu.:0.8125      3rd Qu.:0.3333      3rd Qu.:0.4335       
    ##  Max.   :0.06180            Max.   :1.0000      Max.   :1.0000      Max.   :0.7553       
    ##  min_positive_polarity max_positive_polarity avg_negative_polarity min_negative_polarity
    ##  Min.   :0.00000       Min.   :0.0000        Min.   :-1.0000       Min.   :-1.0000      
    ##  1st Qu.:0.05000       1st Qu.:0.7000        1st Qu.:-0.3250       1st Qu.:-0.7143      
    ##  Median :0.10000       Median :0.9000        Median :-0.2625       Median :-0.5000      
    ##  Mean   :0.09207       Mean   :0.8297        Mean   :-0.2671       Mean   :-0.5633      
    ##  3rd Qu.:0.10000       3rd Qu.:1.0000        3rd Qu.:-0.2039       3rd Qu.:-0.4000      
    ##  Max.   :0.50000       Max.   :1.0000        Max.   : 0.0000       Max.   : 0.0000      
    ##  max_negative_polarity title_subjectivity title_sentiment_polarity abs_title_subjectivity
    ##  Min.   :-1.0000       Min.   :0.0000     Min.   :-1.0000          Min.   :0.0000        
    ##  1st Qu.:-0.1250       1st Qu.:0.0000     1st Qu.: 0.0000          1st Qu.:0.1667        
    ##  Median :-0.1000       Median :0.1389     Median : 0.0000          Median :0.5000        
    ##  Mean   :-0.1046       Mean   :0.2928     Mean   : 0.1101          Mean   :0.3438        
    ##  3rd Qu.:-0.0500       3rd Qu.:0.5000     3rd Qu.: 0.2143          3rd Qu.:0.5000        
    ##  Max.   : 0.0000       Max.   :1.0000     Max.   : 1.0000          Max.   :0.5000        
    ##  abs_title_sentiment_polarity     shares      
    ##  Min.   :0.0000               Min.   :    78  
    ##  1st Qu.:0.0000               1st Qu.:  1100  
    ##  Median :0.0000               Median :  1700  
    ##  Mean   :0.1803               Mean   :  3737  
    ##  3rd Qu.:0.3000               3rd Qu.:  3225  
    ##  Max.   :1.0000               Max.   :208300

``` r
#check structure of objects
str(LifestyleTrain)
```

    ## tibble [1,472 × 53] (S3: tbl_df/tbl/data.frame)
    ##  $ n_tokens_title              : num [1:1472] 10 11 10 6 11 7 11 9 10 7 ...
    ##  $ n_tokens_content            : num [1:1472] 187 315 1190 374 223 ...
    ##  $ n_unique_tokens             : num [1:1472] 0.667 0.551 0.409 0.641 0.662 ...
    ##  $ n_non_stop_words            : num [1:1472] 1 1 1 1 1 ...
    ##  $ n_non_stop_unique_tokens    : num [1:1472] 0.8 0.702 0.561 0.828 0.826 ...
    ##  $ num_hrefs                   : num [1:1472] 7 4 25 7 5 24 28 10 2 9 ...
    ##  $ num_self_hrefs              : num [1:1472] 0 4 24 0 3 23 24 5 1 6 ...
    ##  $ num_imgs                    : num [1:1472] 1 1 20 1 0 20 20 1 11 1 ...
    ##  $ num_videos                  : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ average_token_length        : num [1:1472] 4.66 4.38 4.62 4.91 4.55 ...
    ##  $ num_keywords                : num [1:1472] 7 10 8 8 6 10 10 9 9 10 ...
    ##  $ kw_min_min                  : num [1:1472] 0 0 0 0 217 217 217 217 217 217 ...
    ##  $ kw_max_min                  : num [1:1472] 0 0 0 0 1900 2600 823 2600 695 2600 ...
    ##  $ kw_avg_min                  : num [1:1472] 0 0 0 0 748 ...
    ##  $ kw_min_max                  : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ kw_max_max                  : num [1:1472] 0 0 0 0 17100 17100 17100 17100 17100 17100 ...
    ##  $ kw_avg_max                  : num [1:1472] 0 0 0 0 4517 ...
    ##  $ kw_min_avg                  : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ kw_max_avg                  : num [1:1472] 0 0 0 0 1953 ...
    ##  $ kw_avg_avg                  : num [1:1472] 0 0 0 0 1207 ...
    ##  $ self_reference_min_shares   : num [1:1472] 0 6200 545 0 6700 543 545 2000 0 1100 ...
    ##  $ self_reference_max_shares   : num [1:1472] 0 6200 16000 0 16700 16000 16000 4900 0 6000 ...
    ##  $ self_reference_avg_sharess  : num [1:1472] 0 6200 3151 0 11700 ...
    ##  $ weekday_is_monday           : num [1:1472] 1 1 1 1 0 0 0 0 0 0 ...
    ##  $ weekday_is_tuesday          : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_wednesday        : num [1:1472] 0 0 0 0 1 1 1 1 1 1 ...
    ##  $ weekday_is_thursday         : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_friday           : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_saturday         : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ weekday_is_sunday           : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ is_weekend                  : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ LDA_00                      : num [1:1472] 0.0286 0.0201 0.025 0.2066 0.0335 ...
    ##  $ LDA_01                      : num [1:1472] 0.0286 0.0206 0.1595 0.1461 0.217 ...
    ##  $ LDA_02                      : num [1:1472] 0.0286 0.0205 0.025 0.276 0.0334 ...
    ##  $ LDA_03                      : num [1:1472] 0.0287 0.1208 0.025 0.0251 0.0335 ...
    ##  $ LDA_04                      : num [1:1472] 0.885 0.818 0.765 0.346 0.683 ...
    ##  $ global_subjectivity         : num [1:1472] 0.477 0.554 0.507 0.399 0.372 ...
    ##  $ global_sentiment_polarity   : num [1:1472] 0.15 0.177 0.244 0.122 0.103 ...
    ##  $ global_rate_positive_words  : num [1:1472] 0.0267 0.0349 0.0639 0.0374 0.0493 ...
    ##  $ global_rate_negative_words  : num [1:1472] 0.0107 0.0127 0.0151 0.0187 0.0179 ...
    ##  $ rate_positive_words         : num [1:1472] 0.714 0.733 0.809 0.667 0.733 ...
    ##  $ rate_negative_words         : num [1:1472] 0.286 0.267 0.191 0.333 0.267 ...
    ##  $ avg_positive_polarity       : num [1:1472] 0.435 0.401 0.403 0.361 0.255 ...
    ##  $ min_positive_polarity       : num [1:1472] 0.2 0.1364 0.0333 0.1 0.1 ...
    ##  $ max_positive_polarity       : num [1:1472] 0.7 0.5 1 0.8 0.5 1 1 0.8 0.6 0.6 ...
    ##  $ avg_negative_polarity       : num [1:1472] -0.263 -0.32 -0.236 -0.13 -0.188 ...
    ##  $ min_negative_polarity       : num [1:1472] -0.4 -0.5 -0.5 -0.2 -0.4 ...
    ##  $ max_negative_polarity       : num [1:1472] -0.125 -0.125 -0.05 -0.05 -0.1 ...
    ##  $ title_subjectivity          : num [1:1472] 0 0.55 0 0 0 ...
    ##  $ title_sentiment_polarity    : num [1:1472] 0 0.35 0 0 0 ...
    ##  $ abs_title_subjectivity      : num [1:1472] 0.5 0.05 0.5 0.5 0.5 ...
    ##  $ abs_title_sentiment_polarity: num [1:1472] 0 0.35 0 0 0 ...
    ##  $ shares                      : num [1:1472] 1900 343 507 552 1900 1100 1200 2300 752 1000 ...

``` r
str(Lifestlye_sumstats_Train)
```

    ##  'table' chr [1:6, 1:53] "Min.   : 3.000  " "1st Qu.: 8.000  " "Median :10.000  " ...
    ##  - attr(*, "dimnames")=List of 2
    ##   ..$ : chr [1:6] "" "" "" "" ...
    ##   ..$ : chr [1:53] "n_tokens_title" "n_tokens_content" "n_unique_tokens" "n_non_stop_words" ...

``` r
#plots include - scatter plots, correlation plots -- plots for continuous data...
#do we need bar plots?

#A scatter plot with the number of shares on the y-axis and the positive word rate on the x-axis is created below
ggplot(data=LifestyleTrain, aes(y=shares, x=rate_positive_words)) + geom_point()
```

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

# Modelling

The data is already split into 70% training and 30% test. Our main goal
is to predict the number of shares. This will be our response variable.
We will create four models each using 5-fold cross-validation. Two
models will be multiple linear regression models, one will be a random
forest model and the final model will be a boosted tree model

A Linear regression model is a supervised learning technique that is
used to predict the value of a variable based on the value of other
variable(s). The variable you want to predict is called the dependent
variable or the response. The variable(s) you are using to predict is
called the independent variable(s) or the predictor(s).

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

## Random forest model

As stated in the the first linear regression model we will model the
number of shares by “weekday_is_thursday” (Was the article published on
a Thursday?), “weekday_is_friday” (Was the article published on a
Friday?) and “is_weekend” (Was the article published on the weekend?).
Therefore the predictors are “weekday_is_thursday”, “weekday_is_friday”
and “is_weekend”.

The idea behind the random forest model is the same as bagging but we
use a random subset of predictors for each bootstrap sample tree fit
(indicated by “mtry”). More specifically, it involves creating a
boothstrap sample (same size with replacement), training the tree on
this sample (no pruning necessary), repeating the process a large number
of times and the final prediction is the average of those predictions.
Finding the average of predictions decreases variance which improves
predictions but unfortunately we lose interpretability.

``` r
r_f <- train(shares ~ weekday_is_thursday +  weekday_is_friday + is_weekend, data = LifestyleTrain, method = "rf",
 trControl=trainControl(method = "cv", number = 5),
 preProcess = c("center", "scale"),
 tuneGrid = data.frame(mtry = 1:3))


test_pred_r_f <- predict(r_f, newdata = LifestyleTest)

postResample(test_pred_r_f, LifestyleTest$shares)
```

    ##         RMSE     Rsquared          MAE 
    ## 9.089925e+03 3.784394e-04 3.240467e+03

## Boosted tree model

As stated in the second linear regression model we will model the number
of shares by “num_imgs” (Number of images), “num_videos” (Number of
videos) and “num_hrefs” (Number of links).

The idea behind the boosting tree model is to train our tree slowly in a
sequential manner so each tree that is created will be based on the
previous one with predictions updated.

will explain tuneGrid later

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
    ##      1 51209529.6034             nan     0.1000 34265.6547
    ##      2 50988575.2815             nan     0.1000 178033.1676
    ##      3 50945928.8421             nan     0.1000 22301.6237
    ##      4 50937145.7421             nan     0.1000 -37722.3944
    ##      5 50569893.2337             nan     0.1000 37474.1772
    ##      6 50499353.5715             nan     0.1000 -3754.2704
    ##      7 50233927.9064             nan     0.1000 -47357.4467
    ##      8 50130375.4363             nan     0.1000 102635.3160
    ##      9 50152475.2961             nan     0.1000 -129140.1070
    ##     10 50098621.6833             nan     0.1000 7017.0016
    ##     20 49646423.5669             nan     0.1000 -7247.4121
    ##     40 49373676.5889             nan     0.1000 -55966.6716
    ##     60 49125497.2777             nan     0.1000 -118467.9652
    ##     80 48783251.4920             nan     0.1000 -142283.4001
    ##    100 48591573.4711             nan     0.1000 -179897.4563
    ##    120 48396533.5640             nan     0.1000 -48918.9452
    ##    140 48369070.1405             nan     0.1000 -50470.6845
    ##    160 48185140.9078             nan     0.1000 -68298.3258
    ##    180 48158292.7633             nan     0.1000 -104227.4035
    ##    200 48070084.0169             nan     0.1000 -57719.6495
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 51086379.0429             nan     0.1000 177273.2382
    ##      2 50967699.8761             nan     0.1000 -10305.4179
    ##      3 50544578.0596             nan     0.1000 -19212.7541
    ##      4 50390112.8765             nan     0.1000 127449.1910
    ##      5 50222553.3921             nan     0.1000 -20589.1819
    ##      6 50117031.4238             nan     0.1000 -23907.9280
    ##      7 50013476.2800             nan     0.1000 73539.8937
    ##      8 49799052.5711             nan     0.1000 28640.6202
    ##      9 49688891.2714             nan     0.1000 66175.3967
    ##     10 49600136.7382             nan     0.1000 -64178.0911
    ##     20 49136760.1602             nan     0.1000 -110266.2730
    ##     40 48412511.1086             nan     0.1000 -87758.5869
    ##     60 47840861.1699             nan     0.1000 -20405.8957
    ##     80 47473816.2021             nan     0.1000 -221284.7496
    ##    100 47274566.4816             nan     0.1000 -16205.1610
    ##    120 46985099.5757             nan     0.1000 -210359.7287
    ##    140 46682142.1661             nan     0.1000 -83932.2359
    ##    160 46514710.4445             nan     0.1000 -139555.7450
    ##    180 46161628.7419             nan     0.1000 -13144.6570
    ##    200 46074625.3679             nan     0.1000 -134293.4852
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 51143908.6166             nan     0.1000 26079.0864
    ##      2 50967123.4919             nan     0.1000 47769.8255
    ##      3 50775329.9616             nan     0.1000 -12238.8360
    ##      4 50585213.8677             nan     0.1000 200235.8250
    ##      5 50289361.2592             nan     0.1000 -67279.8191
    ##      6 50149671.8002             nan     0.1000 66712.0545
    ##      7 49678727.2769             nan     0.1000 -88374.4737
    ##      8 49592885.6378             nan     0.1000 10184.1056
    ##      9 49408774.7749             nan     0.1000 -4301.6762
    ##     10 49333169.5381             nan     0.1000 -149685.5508
    ##     20 48630537.4609             nan     0.1000 -219537.5657
    ##     40 47546229.1707             nan     0.1000 -407179.0036
    ##     60 46732635.0496             nan     0.1000 -173951.8244
    ##     80 45985798.3377             nan     0.1000 -75752.4409
    ##    100 45571798.2699             nan     0.1000 -17426.3405
    ##    120 45227016.5969             nan     0.1000 -39480.7077
    ##    140 44915177.5851             nan     0.1000 -48244.7049
    ##    160 44689047.4806             nan     0.1000 -94793.1933
    ##    180 44501152.1033             nan     0.1000 -254312.3615
    ##    200 44200537.1051             nan     0.1000 -132179.9593
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 51113223.5232             nan     0.1000 100231.0779
    ##      2 50762666.1198             nan     0.1000 179534.6794
    ##      3 50599805.7439             nan     0.1000 86120.2120
    ##      4 50357235.7812             nan     0.1000 116100.4837
    ##      5 50238463.7870             nan     0.1000 -54155.1020
    ##      6 49794666.9462             nan     0.1000 52925.4321
    ##      7 49509458.9251             nan     0.1000 -160484.0325
    ##      8 49264277.9873             nan     0.1000 -54813.3198
    ##      9 49183272.9535             nan     0.1000 -68718.8256
    ##     10 48940849.3872             nan     0.1000 -199073.0535
    ##     20 47618151.9393             nan     0.1000 -21589.3466
    ##     40 46642440.6014             nan     0.1000 -126115.6089
    ##     60 46222751.1990             nan     0.1000 -179054.9076
    ##     80 45765418.5981             nan     0.1000 -261773.7292
    ##    100 44885451.5529             nan     0.1000 -369721.4482
    ##    120 44519639.1514             nan     0.1000 -331332.8399
    ##    140 43979213.5834             nan     0.1000 -91383.7419
    ##    160 43802144.6020             nan     0.1000 -60735.9354
    ##    180 43473578.0427             nan     0.1000 -283508.0036
    ##    200 43250255.0350             nan     0.1000 -198985.1651
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 89718948.6368             nan     0.1000 -7426.9807
    ##      2 89547413.6823             nan     0.1000 197811.6766
    ##      3 89040309.7871             nan     0.1000 -121031.7046
    ##      4 88892681.3188             nan     0.1000 110808.1921
    ##      5 88793120.9254             nan     0.1000 -2333.0167
    ##      6 88747095.4828             nan     0.1000 -81250.2102
    ##      7 88669173.3183             nan     0.1000 56196.6617
    ##      8 88532962.0483             nan     0.1000 -47299.0030
    ##      9 88458512.6886             nan     0.1000 -43204.1889
    ##     10 88454203.1975             nan     0.1000 -95732.1844
    ##     20 88097216.0705             nan     0.1000 -224267.1231
    ##     40 87645368.3118             nan     0.1000 -153194.0927
    ##     60 87298358.2910             nan     0.1000 -156587.9636
    ##     80 87162762.2494             nan     0.1000 -228027.6471
    ##    100 86859319.6056             nan     0.1000 -65251.2817
    ##    120 86565854.0004             nan     0.1000 -18676.5277
    ##    140 86401027.8049             nan     0.1000 -128354.1032
    ##    160 86252513.9881             nan     0.1000 -46409.9998
    ##    180 85949908.4517             nan     0.1000 -95454.3388
    ##    200 85825097.2386             nan     0.1000 -252624.3162
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 89709353.3501             nan     0.1000 188678.8225
    ##      2 89334972.4115             nan     0.1000 265820.8041
    ##      3 89065651.2832             nan     0.1000 164978.2319
    ##      4 88786400.8065             nan     0.1000 -139449.4851
    ##      5 88132117.1540             nan     0.1000 -267454.2187
    ##      6 87868152.0376             nan     0.1000 90400.9542
    ##      7 87568386.6604             nan     0.1000 -202423.7812
    ##      8 87369653.0723             nan     0.1000 -173891.3584
    ##      9 87117030.2337             nan     0.1000 -255520.3488
    ##     10 86965327.4821             nan     0.1000 -80933.0301
    ##     20 86274915.1714             nan     0.1000 -85993.1685
    ##     40 85335344.9086             nan     0.1000 -364445.3511
    ##     60 84146361.0741             nan     0.1000 -178641.7185
    ##     80 83316607.2826             nan     0.1000 -215756.5302
    ##    100 82576477.4316             nan     0.1000 -108012.6724
    ##    120 82087117.9771             nan     0.1000 -154562.6196
    ##    140 81639145.3917             nan     0.1000 -96715.4521
    ##    160 81386574.2605             nan     0.1000 -236035.3632
    ##    180 81129442.6372             nan     0.1000 -104516.6020
    ##    200 80809923.7748             nan     0.1000 -89193.0042
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 89708331.4465             nan     0.1000 24720.7050
    ##      2 89216876.8356             nan     0.1000 -127985.3263
    ##      3 89061884.9005             nan     0.1000 74517.9927
    ##      4 88399557.8064             nan     0.1000 -96521.6333
    ##      5 87967894.5208             nan     0.1000 -82706.7175
    ##      6 87843754.2753             nan     0.1000 -62857.3352
    ##      7 87754506.8385             nan     0.1000  326.9353
    ##      8 87197389.1950             nan     0.1000 -45505.9854
    ##      9 86770494.9054             nan     0.1000 -26756.0975
    ##     10 86605458.2068             nan     0.1000 89574.8153
    ##     20 84654897.3237             nan     0.1000 -158898.6965
    ##     40 82512700.6627             nan     0.1000 -342761.3451
    ##     60 81229794.6621             nan     0.1000 -167611.2433
    ##     80 80420357.6582             nan     0.1000 -172361.3985
    ##    100 79377329.0534             nan     0.1000 -153634.2222
    ##    120 78547281.5176             nan     0.1000 -280140.0714
    ##    140 77963217.9175             nan     0.1000 -133393.6190
    ##    160 77523402.8126             nan     0.1000 -211749.9651
    ##    180 77001660.1561             nan     0.1000 -532673.6404
    ##    200 76487460.9297             nan     0.1000 -177758.7923
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 88785442.5223             nan     0.1000 -143165.8944
    ##      2 88556239.5683             nan     0.1000 -134948.8598
    ##      3 87733921.9498             nan     0.1000 -241284.5172
    ##      4 87063652.2728             nan     0.1000 -292384.5599
    ##      5 86584792.7262             nan     0.1000 -55893.0545
    ##      6 85900126.0909             nan     0.1000 -193079.1416
    ##      7 85615894.5922             nan     0.1000 -207439.9440
    ##      8 85205149.6128             nan     0.1000 -491571.7145
    ##      9 84769084.5475             nan     0.1000 -623833.5942
    ##     10 84772170.3007             nan     0.1000 -275581.3659
    ##     20 82779404.3706             nan     0.1000 -365358.3064
    ##     40 80995445.7742             nan     0.1000 -369321.4928
    ##     60 79530898.7587             nan     0.1000 -208591.0926
    ##     80 78475488.7023             nan     0.1000 -220688.3640
    ##    100 77528435.0961             nan     0.1000 -277028.0984
    ##    120 76402080.9140             nan     0.1000 -605723.4928
    ##    140 75850387.3908             nan     0.1000 -248909.0439
    ##    160 75189097.7760             nan     0.1000 -640870.5342
    ##    180 74826671.7054             nan     0.1000 -485624.6633
    ##    200 74377838.7873             nan     0.1000 -235759.5581
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 89613525.5593             nan     0.1000 50479.2389
    ##      2 89502609.5314             nan     0.1000 -42940.3095
    ##      3 89354718.1416             nan     0.1000 94346.6700
    ##      4 89286406.3223             nan     0.1000 61045.6473
    ##      5 89109987.2253             nan     0.1000 -43986.8217
    ##      6 89012199.0695             nan     0.1000 -52364.4026
    ##      7 88803707.1707             nan     0.1000 -79679.3312
    ##      8 88781860.2166             nan     0.1000 -53528.3401
    ##      9 88645196.8892             nan     0.1000 -102933.6798
    ##     10 88515988.9700             nan     0.1000 -253160.9440
    ##     20 88290893.5636             nan     0.1000 -69603.8969
    ##     40 87886517.8041             nan     0.1000 -97692.0891
    ##     60 87508929.9173             nan     0.1000 -103341.2742
    ##     80 87269580.9332             nan     0.1000 -43547.9776
    ##    100 87188106.2388             nan     0.1000 -40257.5150
    ##    120 86916811.2915             nan     0.1000 -110544.1431
    ##    140 86825888.9964             nan     0.1000 -68411.0725
    ##    160 86666196.0975             nan     0.1000 -123792.7126
    ##    180 86490157.2872             nan     0.1000 -104121.1738
    ##    200 86275863.3290             nan     0.1000 -291547.5484
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 89583226.9435             nan     0.1000 155281.8188
    ##      2 88999514.4288             nan     0.1000 -40357.7879
    ##      3 88666670.8522             nan     0.1000 217763.2172
    ##      4 88457826.5119             nan     0.1000 -30602.5924
    ##      5 88306693.9498             nan     0.1000 -1700.4681
    ##      6 87972991.5797             nan     0.1000 -167734.1684
    ##      7 87809896.7057             nan     0.1000 -108431.3383
    ##      8 87667716.6353             nan     0.1000 -116047.0109
    ##      9 87581526.9082             nan     0.1000 -157681.6663
    ##     10 87410947.1964             nan     0.1000 -251049.8320
    ##     20 86471194.1455             nan     0.1000 -380298.2922
    ##     40 85634377.5671             nan     0.1000 -4612.3509
    ##     60 84953641.9979             nan     0.1000 -165416.8626
    ##     80 84323108.0573             nan     0.1000 -207318.2094
    ##    100 83531264.2146             nan     0.1000 -98446.9760
    ##    120 83228360.0012             nan     0.1000 -221342.3663
    ##    140 82764841.0561             nan     0.1000 -143776.8673
    ##    160 82264399.9643             nan     0.1000 -372373.7296
    ##    180 81925434.2622             nan     0.1000 -390529.8372
    ##    200 81450117.7207             nan     0.1000 -99027.2368
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 89571395.9292             nan     0.1000 -23913.2480
    ##      2 89101710.2406             nan     0.1000 134172.9253
    ##      3 88550846.7382             nan     0.1000 -139088.6990
    ##      4 87982097.0271             nan     0.1000 -97462.8341
    ##      5 87656987.8004             nan     0.1000 -145969.3019
    ##      6 87480906.5483             nan     0.1000 -11483.3558
    ##      7 87487564.6745             nan     0.1000 -245109.6885
    ##      8 87435383.4351             nan     0.1000 -25513.2042
    ##      9 87215386.8902             nan     0.1000 -128624.0323
    ##     10 86689751.5433             nan     0.1000 -273051.2769
    ##     20 85045952.2885             nan     0.1000 -107533.9893
    ##     40 83568635.6170             nan     0.1000 -29349.9918
    ##     60 82403124.3007             nan     0.1000 -321200.1389
    ##     80 81417492.8468             nan     0.1000 -150028.0446
    ##    100 80511195.4075             nan     0.1000 -145991.1304
    ##    120 80125034.6376             nan     0.1000 -184347.9346
    ##    140 79751111.8119             nan     0.1000 -285226.3380
    ##    160 79194920.9965             nan     0.1000 -180960.6222
    ##    180 78844770.1530             nan     0.1000 -178585.8306
    ##    200 78436320.1442             nan     0.1000 -180501.9366
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 89081741.6537             nan     0.1000 46988.5363
    ##      2 88595289.3333             nan     0.1000 108757.0412
    ##      3 87958215.4864             nan     0.1000 -152344.7357
    ##      4 87689317.5467             nan     0.1000 -155473.8202
    ##      5 87243207.7321             nan     0.1000 -293158.3103
    ##      6 86668770.5214             nan     0.1000 -309404.8850
    ##      7 86338955.4676             nan     0.1000 173252.0189
    ##      8 86243993.4140             nan     0.1000 -55365.8108
    ##      9 86043864.4808             nan     0.1000 -217049.6343
    ##     10 85890453.4470             nan     0.1000 -309744.6273
    ##     20 83742113.7881             nan     0.1000 -260357.8312
    ##     40 81350262.9277             nan     0.1000 -119868.7846
    ##     60 80626232.1636             nan     0.1000 -299242.4678
    ##     80 79521751.8444             nan     0.1000 -509158.9413
    ##    100 78620302.0289             nan     0.1000 -716222.9983
    ##    120 77900346.1154             nan     0.1000 -386126.6806
    ##    140 77121477.2293             nan     0.1000 -318941.4691
    ##    160 76743302.2481             nan     0.1000 -437026.5337
    ##    180 76179871.6062             nan     0.1000 -147793.2070
    ##    200 75548901.2458             nan     0.1000 -414477.1261
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 67829323.0572             nan     0.1000 -15043.7345
    ##      2 67759170.1844             nan     0.1000 13954.2160
    ##      3 67662083.8938             nan     0.1000  851.2020
    ##      4 67600618.3254             nan     0.1000    2.1684
    ##      5 67536053.1559             nan     0.1000 -29684.8535
    ##      6 67491288.8393             nan     0.1000 -19215.6280
    ##      7 67440935.9119             nan     0.1000 16353.4828
    ##      8 67396583.8286             nan     0.1000 -88872.9801
    ##      9 67374466.3455             nan     0.1000 -53742.3141
    ##     10 67328021.0160             nan     0.1000 -37575.8970
    ##     20 67092886.1001             nan     0.1000 -15551.9565
    ##     40 66865103.5598             nan     0.1000 -21356.8797
    ##     60 66675576.7477             nan     0.1000 -77053.4810
    ##     80 66497102.3590             nan     0.1000 -25638.9803
    ##    100 66383593.1563             nan     0.1000 -72466.6075
    ##    120 66265232.3564             nan     0.1000 -31712.8531
    ##    140 66210334.3377             nan     0.1000 -69308.3452
    ##    160 66042899.4106             nan     0.1000 -61566.0114
    ##    180 65963420.1141             nan     0.1000 -38854.5027
    ##    200 65937966.4242             nan     0.1000 -55412.9356
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 67695716.3865             nan     0.1000 -85056.0205
    ##      2 67619325.7635             nan     0.1000 18627.4762
    ##      3 67541026.0649             nan     0.1000 37614.9094
    ##      4 67432382.9504             nan     0.1000 -5222.7161
    ##      5 67179258.5102             nan     0.1000 -193560.1903
    ##      6 67102429.3564             nan     0.1000 -29097.7073
    ##      7 67048011.4634             nan     0.1000 -97700.7871
    ##      8 66917177.2741             nan     0.1000 -220519.1812
    ##      9 66863090.7612             nan     0.1000 -58724.2480
    ##     10 66441773.5150             nan     0.1000 -66767.3230
    ##     20 65687578.2592             nan     0.1000 -108032.3703
    ##     40 64997411.0821             nan     0.1000 -56651.0556
    ##     60 64709521.5814             nan     0.1000 -127237.4746
    ##     80 64275500.3677             nan     0.1000 -86297.6410
    ##    100 63912928.7795             nan     0.1000 -218593.9007
    ##    120 63628778.3154             nan     0.1000 -203837.0563
    ##    140 63550230.3770             nan     0.1000 -211872.3372
    ##    160 63402151.4947             nan     0.1000 -137121.4319
    ##    180 63280204.6229             nan     0.1000 -70144.5901
    ##    200 63058807.6385             nan     0.1000 -82499.0879
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 67276666.9686             nan     0.1000 -18520.7449
    ##      2 67142242.5311             nan     0.1000 18724.6984
    ##      3 67036875.7352             nan     0.1000 9240.5849
    ##      4 66525050.0321             nan     0.1000 -370078.3031
    ##      5 66099074.5208             nan     0.1000 -335155.4887
    ##      6 65672448.9085             nan     0.1000 -4686.4495
    ##      7 65513507.2877             nan     0.1000 31468.8345
    ##      8 65170254.1576             nan     0.1000 -292063.7247
    ##      9 64967168.0445             nan     0.1000 -198060.9394
    ##     10 64843647.6127             nan     0.1000 -57378.0106
    ##     20 63911471.8726             nan     0.1000 -64832.3114
    ##     40 63106953.5604             nan     0.1000 -498254.3648
    ##     60 62302207.7944             nan     0.1000 -97099.6392
    ##     80 61830336.4438             nan     0.1000 -112622.3151
    ##    100 61409616.9845             nan     0.1000 -195643.0976
    ##    120 61143571.5819             nan     0.1000 -137044.3907
    ##    140 60763428.7491             nan     0.1000 -239913.4906
    ##    160 60481278.7561             nan     0.1000 -116281.0580
    ##    180 60139370.7445             nan     0.1000 -66843.0893
    ##    200 59877572.5874             nan     0.1000 -81445.7768
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 67223954.4299             nan     0.1000 8040.4835
    ##      2 66875902.9945             nan     0.1000 -79843.0405
    ##      3 66354332.8358             nan     0.1000 -252051.7799
    ##      4 65855360.4738             nan     0.1000 -195996.0060
    ##      5 65528512.6911             nan     0.1000 -105298.9659
    ##      6 65372308.0784             nan     0.1000 -16834.6936
    ##      7 65176452.0599             nan     0.1000 -78194.4452
    ##      8 65086077.1181             nan     0.1000 -50949.2623
    ##      9 64841710.1617             nan     0.1000 -571982.8144
    ##     10 64564378.8451             nan     0.1000 39569.8357
    ##     20 63481795.7738             nan     0.1000 -145137.0956
    ##     40 61988491.2003             nan     0.1000 -268557.1921
    ##     60 61362820.6458             nan     0.1000 -261907.1870
    ##     80 60311075.1300             nan     0.1000 -283993.4732
    ##    100 59788418.0154             nan     0.1000 -504787.6890
    ##    120 58861931.1732             nan     0.1000 -189857.0829
    ##    140 58379925.2923             nan     0.1000 -356996.0499
    ##    160 57936554.7781             nan     0.1000 -239954.1306
    ##    180 57488211.1451             nan     0.1000 -152994.8861
    ##    200 57186617.8265             nan     0.1000 -145898.5416
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 87087548.7764             nan     0.1000 88254.1613
    ##      2 87050471.4046             nan     0.1000 -84414.2113
    ##      3 86874931.6891             nan     0.1000 122971.3054
    ##      4 86762088.2993             nan     0.1000 103265.6465
    ##      5 86425195.8004             nan     0.1000 -34779.1982
    ##      6 86279718.5247             nan     0.1000 -37219.0768
    ##      7 86128845.0955             nan     0.1000 97486.2131
    ##      8 86090834.1871             nan     0.1000 -18326.4168
    ##      9 86039472.3546             nan     0.1000 19903.1747
    ##     10 85999255.5273             nan     0.1000 13008.8356
    ##     20 85573223.3393             nan     0.1000 -239624.6888
    ##     40 85274694.6213             nan     0.1000 3754.4749
    ##     60 85087429.5798             nan     0.1000 -45763.5658
    ##     80 84802619.3331             nan     0.1000 -119371.8095
    ##    100 84590024.5140             nan     0.1000 -27773.7194
    ##    120 84212751.0353             nan     0.1000 -63785.2562
    ##    140 84055062.9040             nan     0.1000 -207222.7968
    ##    160 83810218.9047             nan     0.1000 -73347.0526
    ##    180 83725219.2544             nan     0.1000 -316967.7851
    ##    200 83658592.2831             nan     0.1000 -103347.4709
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 87258381.0163             nan     0.1000 -8152.0195
    ##      2 86789976.8544             nan     0.1000 21948.1434
    ##      3 86376478.1683             nan     0.1000 -58141.6982
    ##      4 86102403.2629             nan     0.1000 206196.6143
    ##      5 85646008.6110             nan     0.1000 -43278.4256
    ##      6 85406738.3001             nan     0.1000 -247959.5854
    ##      7 85094227.3303             nan     0.1000 49297.5599
    ##      8 84950753.7364             nan     0.1000 94979.5674
    ##      9 84808409.5808             nan     0.1000 34919.6977
    ##     10 84641712.4909             nan     0.1000 1085.7967
    ##     20 83665219.4475             nan     0.1000 -297390.5782
    ##     40 82648965.1420             nan     0.1000 -586894.7439
    ##     60 82303408.4796             nan     0.1000 -277008.7068
    ##     80 81904941.4301             nan     0.1000 -187019.3201
    ##    100 81477554.8483             nan     0.1000 -134384.9958
    ##    120 81068663.4681             nan     0.1000 -355927.8551
    ##    140 80727204.3647             nan     0.1000 -91230.9970
    ##    160 80325440.2058             nan     0.1000 -341664.5038
    ##    180 80033361.6701             nan     0.1000 -57485.4339
    ##    200 79928855.9768             nan     0.1000 -179269.4718
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 86742421.8245             nan     0.1000 -134719.1296
    ##      2 85976703.4630             nan     0.1000 162209.8989
    ##      3 85740619.7297             nan     0.1000 -24093.8651
    ##      4 85085742.2271             nan     0.1000 -406587.4937
    ##      5 84666498.7930             nan     0.1000 84815.3511
    ##      6 84423829.0376             nan     0.1000 137907.2857
    ##      7 84060656.1493             nan     0.1000 -102775.7511
    ##      8 83534269.4458             nan     0.1000 261397.0654
    ##      9 83355204.5985             nan     0.1000 -72111.7057
    ##     10 83151952.5586             nan     0.1000 -169644.4349
    ##     20 81591498.2563             nan     0.1000 -68301.5893
    ##     40 80540392.4519             nan     0.1000 -138828.4776
    ##     60 79913731.4024             nan     0.1000 -230854.1240
    ##     80 79092600.9249             nan     0.1000 -101328.9609
    ##    100 78529895.1657             nan     0.1000 -448168.6937
    ##    120 77663612.5433             nan     0.1000 -114409.6457
    ##    140 77290266.0725             nan     0.1000 -220304.9426
    ##    160 76752764.1609             nan     0.1000 -285577.7015
    ##    180 76263409.5563             nan     0.1000 -300328.0866
    ##    200 75982036.2458             nan     0.1000 -349971.0948
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 87093824.5614             nan     0.1000 282595.1963
    ##      2 86453759.9578             nan     0.1000 -6843.1022
    ##      3 85586761.9242             nan     0.1000 -431607.8832
    ##      4 85365214.5046             nan     0.1000 71396.5578
    ##      5 84661925.5973             nan     0.1000 -76188.8374
    ##      6 84230004.1412             nan     0.1000 -202863.7421
    ##      7 83709251.7904             nan     0.1000 -142848.7822
    ##      8 83301206.5929             nan     0.1000 -420381.7036
    ##      9 83113519.7181             nan     0.1000 -153622.3299
    ##     10 82952783.7547             nan     0.1000 -312876.0748
    ##     20 81059499.2319             nan     0.1000 -273676.6979
    ##     40 78901389.9694             nan     0.1000 -145250.0513
    ##     60 77726947.2456             nan     0.1000 -542959.9224
    ##     80 76614094.4558             nan     0.1000 -339590.1944
    ##    100 76045947.5458             nan     0.1000 -271600.6658
    ##    120 75374254.6111             nan     0.1000 -419956.8646
    ##    140 74789660.9059             nan     0.1000 -193762.2252
    ##    160 74146838.0597             nan     0.1000 -302248.5659
    ##    180 73511846.3914             nan     0.1000 -195556.6022
    ##    200 73350947.3553             nan     0.1000 -331820.1378
    ## 
    ## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
    ##      1 77141416.0923             nan     0.1000 148398.6962
    ##      2 76997464.8276             nan     0.1000 53263.3670
    ##      3 76803739.9807             nan     0.1000 28956.4303
    ##      4 76637559.7465             nan     0.1000 -35923.2960
    ##      5 76607725.9939             nan     0.1000 9955.0864
    ##      6 76502256.0747             nan     0.1000 -49734.0348
    ##      7 76407890.9280             nan     0.1000 -39452.5168
    ##      8 76356111.2393             nan     0.1000 -48632.4274
    ##      9 76324804.1277             nan     0.1000 -8065.8766
    ##     10 76331990.5743             nan     0.1000 -86704.5338
    ##     20 76028991.2600             nan     0.1000 -200712.6922
    ##     25 75983543.3166             nan     0.1000 -210722.3931

``` r
test_pred_boosted <- predict(boosted, newdata = LifestyleTest)

postResample(test_pred_boosted, LifestyleTest$shares)
```

    ##         RMSE     Rsquared          MAE 
    ## 9.142495e+03 6.335908e-04 3.236725e+03

Next we do a comparison of the four models

The model with the lowest rmse is Random Forest-winner

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
