ST558 Project 3 Group F: Social Media Summary Report
================
Magaritte Nguyen & Matthew Sookoo
2022-11-12

-   <a href="#introduction" id="toc-introduction">Introduction</a>
    -   <a href="#more-about-the-variables"
        id="toc-more-about-the-variables">More about the variables</a>
        -   <a href="#response-variable" id="toc-response-variable">Response
            variable</a>
        -   <a href="#independent-or-predictor-variables"
            id="toc-independent-or-predictor-variables">Independent or predictor
            variables</a>
-   <a href="#required-packages" id="toc-required-packages">Required
    Packages</a>
-   <a href="#data" id="toc-data">Data</a>
    -   <a href="#reading-in-the-data" id="toc-reading-in-the-data">Reading in
        the data</a>
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
-   <a href="#comaprison" id="toc-comaprison">Comaprison</a>
-   <a href="#blog" id="toc-blog">Blog</a>
-   <a href="#summarizations-1" id="toc-summarizations-1">Summarizations</a>
-   <a href="#modeling" id="toc-modeling">Modeling</a>
-   <a href="#comparison" id="toc-comparison">Comparison</a>
-   <a href="#automation" id="toc-automation">Automation</a>
-   <a href="#submission" id="toc-submission">Submission</a>

<!-- testing automation form yaml header -->
<!-- it works -->
<!-- 
############################################################# 
#############################################################
### Project 3 Group F
############################################################# 
############################################################# 
-->
<!-- setup -->

# Introduction

Our goal with this project is to take the data about articles published
by Mashable (www.mashable.com) and create predictive models for the
number of shares in social networks (popularity) then automating our
Markdown reports. This dataset summarizes a heterogeneous set of
features in a period of two years.

The way we will summarize the data and try to predict the number of
shares is via linear regression, random forest, and boosting (will add
more later)

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

Our goal with this project is to create predictive models and automating
Markdown reports. We are using this [Online News Popularity Data
Set](https://archive.ics.uci.edu/ml/datasets/Online+News+Popularity).

This dataset summarizes a heterogeneous set of features about articles
published by [Mashable](http://www.mashable.com) in a period of two
years.

## More about the variables

The data contains 39644 observations and 61 variables (58 predictive
attributes, 2 non-predictive, 1 goal field) and we are interested in the
number of shares of the online news. We only mention the one we use in
our project.

### Response variable

-   “shares” (Number of shares (target))

### Independent or predictor variables

-   “data_channel_is\_\*” (Lifestyle, Entertainment, Business, Social
    Media, Tech, World)

-   “n_tokens_title” (Number of words in the title),

-   “n_tokens_content” (Number of words in the content)

-   “num_imgs” (Number of images)

-   “num_videos” (Number of videos)

-   “is_weekend” (Was the article published on the weekend?)

-   “num_hrefs” (Number of links)

-   “weekday_is_monday” (Was the article published on a Monday?)

-   “weekday_is_tuesday” (Was the article published on a Tuesday?)

-   “weekday_is_wednesday” {Was the article published on a Wednesday?)

-   “weekday_is_thursday” (Was the article published on a Thursday?)

-   “weekday_is_friday” (Was the article published on a Friday?)

-   “self_reference_avg_sharess” (Avg. shares of referenced articles in
    Mashable)

# Required Packages

The following packages are used for our data manipulation, prediction,
etc.:

-   `tidyverse`: Tons of useful features for data manipulation and
    visualization!
-   `caret`: Used for predictive modelling.
-   `shiny`
-   `rmarkdown`

MORE ADDED LATER AS REQUIRED…

<!-- packages that we installed and are calling via library() function -->

# Data

## Reading in the data

Read in the OnlineNewsPopularity.csv data file – subset for
data_channel_is_socmed: Is data channel ‘Social Media’?
<!-- str_to_title("social media") ->> "Social Media" -->

Here, `read_csv()` is used to read in the OnlineNewsPopularity.csv data
and we are subsetting for the data_channel_is_socmed: Is data channel
‘Social Media’? variable.

Firstly, we read in the data using `read_csv()`.

``` r
#check working directory
getwd()
```

    [1] "D:/ST558/Project 3/ST558_Project3_GroupF"

``` r
#reassign working directory
#Magaritte's directory
#setwd("D:/ST558/Project 3/ST558_Project3_GroupF")
#Matthew's directory
#setwd("C:\\Users\\Home Pc\\Desktop\\ST558 Project 3 new\\ST558_Project3_GroupF\\")
#read in data set .csv file in full
#make sure that this is a relative path used...
# ./ stays in the same file directory
OnlineNewsPopularity<-read_csv("./OnlineNewsPopularity.csv", show_col_types = FALSE)
#call object OnlineNewsPopularity - our full raw data
OnlineNewsPopularity
```

    # A tibble: 39,644 × 61
       url      timed…¹ n_tok…² n_tok…³ n_uni…⁴ n_non…⁵ n_non…⁶ num_h…⁷ num_s…⁸ num_i…⁹ num_v…˟
       <chr>      <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
     1 http://…     731      12     219   0.664    1.00   0.815       4       2       1       0
     2 http://…     731       9     255   0.605    1.00   0.792       3       1       1       0
     3 http://…     731       9     211   0.575    1.00   0.664       3       1       1       0
     4 http://…     731       9     531   0.504    1.00   0.666       9       0       1       0
     5 http://…     731      13    1072   0.416    1.00   0.541      19      19      20       0
     6 http://…     731      10     370   0.560    1.00   0.698       2       2       0       0
     7 http://…     731       8     960   0.418    1.00   0.550      21      20      20       0
     8 http://…     731      12     989   0.434    1.00   0.572      20      20      20       0
     9 http://…     731      11      97   0.670    1.00   0.837       2       0       0       0
    10 http://…     731      10     231   0.636    1.00   0.797       4       1       1       1
    # … with 39,634 more rows, 50 more variables: average_token_length <dbl>,
    #   num_keywords <dbl>, data_channel_is_lifestyle <dbl>,
    #   data_channel_is_entertainment <dbl>, data_channel_is_bus <dbl>,
    #   data_channel_is_socmed <dbl>, data_channel_is_tech <dbl>, data_channel_is_world <dbl>,
    #   kw_min_min <dbl>, kw_max_min <dbl>, kw_avg_min <dbl>, kw_min_max <dbl>,
    #   kw_max_max <dbl>, kw_avg_max <dbl>, kw_min_avg <dbl>, kw_max_avg <dbl>,
    #   kw_avg_avg <dbl>, self_reference_min_shares <dbl>, self_reference_max_shares <dbl>, …

We now subset the data for the data channel of interest: Social Media.

``` r
#subsetting the OnlineNewsPopularity full raw data for the data channel of interest -- Lifestyle
Channel <- OnlineNewsPopularity %>% 
               #filter(data_channel_is_lifestyle == 1) %>%
               filter(get(params$channel) == 1) %>%
               # removing non-predictive variables per dataset description
               # remove all data_channel_is_* variables because we already filtered on them and we do not want them included in the model!
               #select( ! c(url, timedelta, starts_with("data_channel_is_" ) ) )
                select( ! c(url, timedelta ) )
#tidyverse way of looking at the dataset -- similar to str()
#glimpse(Channel)
#calling the Channel object to view
Channel
```

    # A tibble: 2,323 × 59
       n_toke…¹ n_tok…² n_uni…³ n_non…⁴ n_non…⁵ num_h…⁶ num_s…⁷ num_i…⁸ num_v…⁹ avera…˟ num_k…˟
          <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
     1        8     257   0.568    1.00   0.671       9       7       0       1    4.64       9
     2        8     218   0.663    1.00   0.688      14       3      11       0    4.44      10
     3        9    1226   0.410    1.00   0.617      10      10       1       1    4.39       7
     4       10    1121   0.451    1.00   0.629      15      11       1       0    4.79       6
     5        9     168   0.778    1.00   0.865       6       4      11       0    4.68       9
     6        9     100   0.760    1.00   0.803       3       2       1       0    4.45       6
     7       10    1596   0.420    1.00   0.632      19      10       8       0    4.63       6
     8        7     518   0.486    1.00   0.654      11       1       1       0    4.79       7
     9        8     358   0.503    1.00   0.687       4       4       1       0    4.25       4
    10        6     358   0.622    1.00   0.777      24       6       1       0    5.39       8
    # … with 2,313 more rows, 48 more variables: data_channel_is_lifestyle <dbl>,
    #   data_channel_is_entertainment <dbl>, data_channel_is_bus <dbl>,
    #   data_channel_is_socmed <dbl>, data_channel_is_tech <dbl>, data_channel_is_world <dbl>,
    #   kw_min_min <dbl>, kw_max_min <dbl>, kw_avg_min <dbl>, kw_min_max <dbl>,
    #   kw_max_max <dbl>, kw_avg_max <dbl>, kw_min_avg <dbl>, kw_max_avg <dbl>,
    #   kw_avg_avg <dbl>, self_reference_min_shares <dbl>, self_reference_max_shares <dbl>,
    #   self_reference_avg_sharess <dbl>, weekday_is_monday <dbl>, weekday_is_tuesday <dbl>, …

``` r
#testing
#correct - we expect 2099 vars
table(Channel[[params$channel]])
```


       1 
    2323 

# Summarizations

Now split the data set we’ve created into a training and testing set.
Use p = 0.7.

Here, we are splitting our created data, Channel, into a training and
test set with p = 0.7. These datasets will be called `ChannelTrain` and
`ChannelTest`.

Note: A seed was set for reproducibility purposes.

``` r
#seed is set for reproducibility 
set.seed(123)
#another way to split train and test data below
# #indices to split on
# train <- sample(1:nrow(my_heart), size = nrow(my_heart)*0.70)
# test <- dplyr::setdiff(1:nrow(my_heart), train)
# #subset
# heartTrain <- my_heart[train, ]
# heartTest <- my_heart[test, ]
#indices to split on
ChannelIndex <- createDataPartition(Channel$shares, p = 0.70, list = FALSE)
#subset
ChannelTrain <- Channel[ ChannelIndex, ]
ChannelTest  <- Channel[-ChannelIndex, ]
```

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

Whenever you start thinking about fitting a regression model, the first
think you want to do is data exploration (EDA - exploratory data
analysis). Best think you can do is create scatter plots for each
explanatory variable against the response variable. Scatter plots give
us useful visualizations. we will look at how to fit the line in R
(overlay), then predict a response using that line.

``` r
#this shows the summary stats for each variable in our dataset...
# 31. weekday_is_monday: Was the article published on a Monday?
summary(ChannelTrain$weekday_is_monday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1529  0.0000  1.0000 

``` r
# 32. weekday_is_tuesday: Was the article published on a Tuesday?
summary(ChannelTrain$weekday_is_tuesday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      0.000   0.000   0.000   0.191   0.000   1.000 

``` r
# 33. weekday_is_wednesday: Was the article published on a Wednesday?
summary(ChannelTrain$weekday_is_wednesday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1849  0.0000  1.0000 

``` r
# 34. weekday_is_thursday: Was the article published on a Thursday?
summary(ChannelTrain$weekday_is_thursday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.2045  0.0000  1.0000 

``` r
# 35. weekday_is_friday: Was the article published on a Friday?
summary(ChannelTrain$weekday_is_friday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1357  0.0000  1.0000 

``` r
# 36. weekday_is_saturday: Was the article published on a Saturday?
summary(ChannelTrain$weekday_is_saturday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.00000 0.00000 0.00000 0.07617 0.00000 1.00000 

``` r
# 37. weekday_is_sunday: Was the article published on a Sunday?
summary(ChannelTrain$weekday_is_sunday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.00000 0.00000 0.00000 0.05467 0.00000 1.00000 

``` r
# 38. is_weekend: Was the article published on the weekend? 
summary(ChannelTrain$is_weekend)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1308  0.0000  1.0000 

``` r
# 60. shares: Number of shares (target)
summary(ChannelTrain$shares)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
          8    1400    2100    3793    3800  122800 

``` r
#contigency tables
# example: table (crabs$color, crabs$spine, crabs$y)
# monday is the mot published articels... compare to diff of the week
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_tuesday)
```

       
           0    1
      0 1068  311
      1  249    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_wednesday)
```

       
           0    1
      0 1078  301
      1  249    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_thursday)
```

       
           0    1
      0 1046  333
      1  249    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_friday)
```

       
           0    1
      0 1158  221
      1  249    0

``` r
#sum stats for all 61 vars - not helpful...
#Lifestlye_sumstats_Train <- summary(ChannelTrain)
#calling Lifestlye_sumstats_Train object to see our summary stats
#Lifestlye_sumstats_Train
#check structure of objects
#str(ChannelTrain)
#str(Lifestlye_sumstats_Train)
#plots include - scatter plots, correlation plots -- plots for continuous data...
#do we need bar plots?
#data for descriptive plots:
plot_data_weekday_weekend <- ChannelTrain %>%
                               mutate ( weekday = case_when(
                                          weekday_is_monday    == 1 ~ "Monday"   ,
                                          weekday_is_tuesday   == 1 ~ "Tuesday"  ,
                                          weekday_is_wednesday == 1 ~ "Wednesday",
                                          weekday_is_thursday  == 1 ~ "Thursday" ,
                                          weekday_is_friday    == 1 ~ "Friday"   ,
                                          weekday_is_saturday  == 1 ~ "Saturday" ,
                                          weekday_is_sunday    == 1 ~ "Sunday"   ,
                                          TRUE ~ NA_character_
                                      ),
                                        weekday = factor(
                                          x = weekday,
                                          levels = c("Monday", "Tuesday", "Wednesday",
                                                     "Thursday", "Friday", "Saturday",
                                                     "Sunday"),
                                          ordered = TRUE
                                          ) )
#A scatter plot with the number of shares on the y-axis and the positive word rate on the x-axis is created below
ggplot(data=plot_data_weekday_weekend, 
            aes(y=shares, x=weekday)) + 
            labs(x="Articles Published on Certain Days of the Week", y="Shares") +
            geom_boxplot() + scale_y_log10() +
            geom_point(aes(color=weekday), position="jitter") 
```

![](data:image/png;base64,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)<!-- -->

``` r
# when we take the log of the data, we can see easier... Poisson...
# plot scatter after boxplot because we want to see where the majority of the dots are...
#total articles published is actually higher Monday and fewer on the weekend. but boxplots look like they are lower on the weekdays because more articles are published but less shares are occurring...
#plots - scatter plot with boxplot overlayed
# 31. weekday_is_monday: Was the article published on a Monday?
#this one doesnt work bc we need levels...
#ggplot(data=ChannelTrain, aes(y=shares, x=weekday_is_monday)) + geom_point()
# the y - axis is using a log axis not a linear axis, but the plots are more easily interpretable /  visually more ituitive with this transformation.
ggplot(data=ChannelTrain %>% 
              mutate(weekday_fctr = factor(x=weekday_is_monday,  
              levels=c(0,1), labels = c("No", "Yes"))), 
            aes(y=shares, x=weekday_fctr)) + 
            labs(x="Articles Published on Monday", y="Shares", color = "Published") +
            geom_boxplot() + scale_y_log10() +
            geom_point(aes(color=weekday_fctr), position="jitter", alpha=0.4) 
```

![](data:image/png;base64,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)<!-- -->

``` r
# 32. weekday_is_tuesday: Was the article published on a Tuesday
ggplot(data=ChannelTrain %>% 
              mutate(weekday_fctr = factor(x=weekday_is_tuesday,  
              levels=c(0,1), labels = c("No", "Yes"))), 
            aes(y=shares, x=weekday_fctr)) + 
            labs(x="Articles Published on Tuesday", y="Shares", color = "Published") +
            geom_boxplot() + scale_y_log10() +
            geom_point(aes(color=weekday_fctr), position="jitter", alpha=0.4) 
```

![](data:image/png;base64,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)<!-- -->

``` r
# 33. weekday_is_wednesday: Was the article published on a Wednesday?
ggplot(data=ChannelTrain %>% 
              mutate(weekday_fctr = factor(x=weekday_is_wednesday,  
              levels=c(0,1), labels = c("No", "Yes"))), 
            aes(y=shares, x=weekday_fctr)) + 
            labs(x="Articles Published on Wednesday", y="Shares", color = "Published") +
            geom_boxplot() + scale_y_log10() +
            geom_point(aes(color=weekday_fctr), position="jitter", alpha=0.4) 
```

![](data:image/png;base64,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)<!-- -->

``` r
# 34. weekday_is_thursday: Was the article published on a Thursday?
ggplot(data=ChannelTrain %>% 
              mutate(weekday_fctr = factor(x=weekday_is_thursday,  
              levels=c(0,1), labels = c("No", "Yes"))), 
            aes(y=shares, x=weekday_fctr)) + 
            labs(x="Articles Published on Thursday", y="Shares", color = "Published") +
            geom_boxplot() + scale_y_log10() +
            geom_point(aes(color=weekday_fctr), position="jitter", alpha=0.4) 
```

![](data:image/png;base64,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)<!-- -->

``` r
# 35. weekday_is_friday: Was the article published on a Friday?
ggplot(data=ChannelTrain %>% 
              mutate(weekday_fctr = factor(x=weekday_is_friday,  
              levels=c(0,1), labels = c("No", "Yes"))), 
            aes(y=shares, x=weekday_fctr)) + 
            labs(x="Articles Published on Friday", y="Shares", color = "Published") +
            geom_boxplot() + scale_y_log10() +
            geom_point(aes(color=weekday_fctr), position="jitter", alpha=0.4) 
```

![](data:image/png;base64,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)<!-- -->

``` r
# 36. weekday_is_saturday: Was the article published on a Saturday?
ggplot(data=ChannelTrain %>% 
              mutate(weekday_fctr = factor(x=weekday_is_saturday,  
              levels=c(0,1), labels = c("No", "Yes"))), 
            aes(y=shares, x=weekday_fctr)) + 
            labs(x="Articles Published on Saturday", y="Shares", color = "Published") +
            geom_boxplot() + scale_y_log10() +
            geom_point(aes(color=weekday_fctr), position="jitter", alpha=0.4) 
```

![](data:image/png;base64,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)<!-- -->

``` r
# 37. weekday_is_sunday: Was the article published on a Sunday?
ggplot(data=ChannelTrain %>% 
              mutate(weekday_fctr = factor(x=weekday_is_sunday,  
              levels=c(0,1), labels = c("No", "Yes"))), 
            aes(y=shares, x=weekday_fctr)) + 
            labs(x="Articles Published on Sunday", y="Shares", color = "Published") +
            geom_boxplot() + scale_y_log10() +
            geom_point(aes(color=weekday_fctr), position="jitter", alpha=0.4) 
```

![](data:image/png;base64,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)<!-- -->

``` r
# # 38. is_weekend: Was the article published on the weekend? 
# ggplot(data=ChannelTrain %>% 
#               mutate(weekday_fctr = factor(x=is_weekend,  
#               levels=c(0,1), labels = c("No", "Yes"))), 
#             aes(y=shares, x=weekday_fctr)) + 
#             labs(x="Articles Published on Monday", y="Shares", color = "Published") +
#             geom_boxplot() + scale_y_log10() +
#             geom_point(aes(color=weekday_fctr), position="jitter") 
# i can make conclusions based on summary() median, min, max, bc i trasfomred for visibility
```

The y - axis is using a log axis not a linear axis, but the plots are
more easily interpretable / visually more intuitive with this
transformation.The general shape of the plots is correct.

We can inspect the trend of shares as a function of the different days
of the week that the articles are published.

If you see a presence of outliers, this may cause the mean to shift in
that direction, but the meidan will not be effected as much. If you see
that the median is not centered within the box, then there is a presence
of skewness in that particular direction. Also, if you see that there
are more observations / dots on one graph while comparing publication
(Yes/No), this is meaningful within the plot itself and also across the
different days of the week.

<!-- might use this later dont delete yet -->

``` r
#what question are we trying to answer here? 
# how to predict shares given the variables you have...
#fitting the model
fit_Channel <- lm(shares ~ . , data = Channel)
#call fit_Lifestyle object - remember this is an lm object
fit_Channel
```


    Call:
    lm(formula = shares ~ ., data = Channel)

    Coefficients:
                      (Intercept)                 n_tokens_title  
                        7.045e+02                     -1.202e+01  
                 n_tokens_content                n_unique_tokens  
                        3.745e-02                     -3.601e+03  
                 n_non_stop_words       n_non_stop_unique_tokens  
                        2.385e+03                     -1.960e+03  
                        num_hrefs                 num_self_hrefs  
                       -1.637e+01                     -3.736e+01  
                         num_imgs                     num_videos  
                       -3.643e+01                      5.339e+01  
             average_token_length                   num_keywords  
                       -5.439e+01                      9.191e+01  
        data_channel_is_lifestyle  data_channel_is_entertainment  
                               NA                             NA  
              data_channel_is_bus         data_channel_is_socmed  
                               NA                             NA  
             data_channel_is_tech          data_channel_is_world  
                               NA                             NA  
                       kw_min_min                     kw_max_min  
                        2.973e+00                     -3.012e-01  
                       kw_avg_min                     kw_min_max  
                        1.011e+00                     -9.314e-04  
                       kw_max_max                     kw_avg_max  
                        1.415e-04                     -1.769e-03  
                       kw_min_avg                     kw_max_avg  
                        2.807e-02                     -1.440e-01  
                       kw_avg_avg      self_reference_min_shares  
                        1.219e+00                      1.883e-02  
        self_reference_max_shares     self_reference_avg_sharess  
                        2.684e-03                     -6.242e-04  
                weekday_is_monday             weekday_is_tuesday  
                       -2.334e+02                     -7.195e+02  
             weekday_is_wednesday            weekday_is_thursday  
                       -8.582e+02                     -1.184e+03  
                weekday_is_friday            weekday_is_saturday  
                       -2.859e+02                     -8.476e+02  
                weekday_is_sunday                     is_weekend  
                               NA                             NA  
                           LDA_00                         LDA_01  
                        4.589e+02                     -2.349e+03  
                           LDA_02                         LDA_03  
                       -1.153e+03                     -1.361e+03  
                           LDA_04            global_subjectivity  
                               NA                     -2.193e+02  
        global_sentiment_polarity     global_rate_positive_words  
                        6.613e+02                     -2.924e+03  
       global_rate_negative_words            rate_positive_words  
                        3.304e+03                      1.954e+03  
              rate_negative_words          avg_positive_polarity  
                        2.921e+03                     -7.604e+02  
            min_positive_polarity          max_positive_polarity  
                       -2.164e+03                     -1.067e+03  
            avg_negative_polarity          min_negative_polarity  
                        3.127e+03                     -2.365e+03  
            max_negative_polarity             title_subjectivity  
                       -1.696e+03                      5.796e+02  
         title_sentiment_polarity         abs_title_subjectivity  
                       -5.530e+02                      7.828e+02  
     abs_title_sentiment_polarity  
                        1.593e+03  

``` r
# check fit_Lifestyle attributes
attributes(fit_Channel)
```

    $names
     [1] "coefficients"  "residuals"     "effects"       "rank"          "fitted.values"
     [6] "assign"        "qr"            "df.residual"   "xlevels"       "call"         
    [11] "terms"         "model"        

    $class
    [1] "lm"

``` r
fit_Channel[["residuals"]]
```

                1             2             3             4             5             6 
    -2.406988e+02  1.366195e+03  3.384900e+03  4.387193e+02  2.004244e+03  8.502232e+03 
                7             8             9            10            11            12 
    -1.622405e+03 -2.196522e+03  1.243353e+04 -7.883710e+02  6.038791e+03 -1.171147e+02 
               13            14            15            16            17            18 
     9.847076e+03 -1.072855e+03  1.648383e+03 -2.203439e+03 -2.136876e+03  3.262609e+03 
               19            20            21            22            23            24 
    -2.076546e+03 -1.764857e+03 -9.290621e+02  4.235908e+03  7.259151e+02 -1.705461e+03 
               25            26            27            28            29            30 
    -3.537554e+03  2.864887e+03 -1.275879e+03 -4.013122e+03 -1.380701e+03  1.234311e+04 
               31            32            33            34            35            36 
    -2.765549e+03  5.009105e+04 -1.147679e+03  3.179012e+02 -3.254976e+03  2.728138e+03 
               37            38            39            40            41            42 
    -7.171778e+02  7.418363e+01 -3.377882e+03 -1.515879e+03 -2.071135e+03  3.548782e+02 
               43            44            45            46            47            48 
    -2.107833e+03 -9.958297e+02 -4.702809e+02  2.434229e+03 -4.130261e+03 -1.576363e+03 
               49            50            51            52            53            54 
    -1.602000e+03 -3.721283e+02 -2.115679e+03 -6.927909e+02  1.696772e+03 -2.813244e+03 
               55            56            57            58            59            60 
    -2.128157e+03 -1.472538e+03 -1.981500e+03 -2.577764e+03 -1.859327e+03 -1.294928e+03 
               61            62            63            64            65            66 
    -1.226262e+03 -3.022862e+03  4.365914e+03 -1.031206e+03 -2.147947e+03  1.408990e+02 
               67            68            69            70            71            72 
    -7.396699e+01  1.091082e+03  4.605642e+02 -3.638327e+02 -2.545031e+03 -2.700919e+03 
               73            74            75            76            77            78 
    -2.137772e+03 -1.204701e+01  4.045272e+02  1.531723e+03 -2.887462e+03 -3.284041e+03 
               79            80            81            82            83            84 
    -2.587440e+03 -3.162147e+03 -2.810669e+03  1.319953e+03 -1.262684e+03 -4.906568e+03 
               85            86            87            88            89            90 
     6.505966e+02 -4.248110e+02 -2.442265e+03 -3.856262e+03  2.135055e+03 -2.934984e+03 
               91            92            93            94            95            96 
     8.939346e+02 -5.326013e+02 -2.849698e+03 -1.644646e+03 -2.644373e+03 -2.277323e+03 
               97            98            99           100           101           102 
    -3.613676e+03 -2.377880e+03 -3.790339e+03 -1.833260e+03 -9.171531e+02 -3.371186e+03 
              103           104           105           106           107           108 
    -3.011110e+03  2.391868e+04 -1.913483e+03 -3.792796e+03 -9.391860e+01 -1.380286e+02 
              109           110           111           112           113           114 
     4.305060e+03 -1.427268e+03  2.390040e+03 -3.752673e+03 -1.187177e+03 -6.449794e+02 
              115           116           117           118           119           120 
    -2.205567e+03 -1.381761e+03 -1.713951e+03 -7.471682e+02 -6.878908e+02 -5.143548e+03 
              121           122           123           124           125           126 
    -3.240681e+03 -2.021314e+03 -1.108595e+03 -2.327177e+03  2.647651e+03  1.200681e+03 
              127           128           129           130           131           132 
     1.260021e+04  8.404185e+03  9.328836e+01 -2.340141e+03 -3.773005e+03 -2.651608e+03 
              133           134           135           136           137           138 
    -1.287213e+03 -1.509524e+03 -2.576342e+03  1.199337e+03 -7.147350e+03 -3.885592e+03 
              139           140           141           142           143           144 
    -2.680406e+03  4.499943e+03 -4.292619e+02 -2.641001e+03 -1.445205e+03 -5.610764e+02 
              145           146           147           148           149           150 
    -2.032902e+03 -1.838061e+03 -4.430719e+01 -5.422797e+02  4.479854e+03 -3.564652e+03 
              151           152           153           154           155           156 
    -3.701932e+03  6.627604e+01 -2.945299e+02 -1.691103e+02 -1.153412e+03 -3.549039e+02 
              157           158           159           160           161           162 
    -2.960600e+03 -2.498991e+03  5.184426e+02 -1.174255e+03 -6.134905e+02  8.811852e+02 
              163           164           165           166           167           168 
    -1.465685e+03  1.716135e+03 -4.042012e+03 -2.612504e+03 -1.312464e+03 -3.177548e+03 
              169           170           171           172           173           174 
    -3.843999e+03  2.510429e+03 -2.848950e+03  1.730558e+03 -2.568983e+02 -2.792577e+03 
              175           176           177           178           179           180 
    -1.811264e+03 -3.797921e+03  5.053805e+02 -3.947748e+03  1.680976e+03 -3.119793e+03 
              181           182           183           184           185           186 
    -2.111617e+03 -6.050214e+01 -2.409772e+03 -1.385584e+03  1.151164e+04 -2.284482e+03 
              187           188           189           190           191           192 
    -2.869542e+03 -4.010158e+02 -1.749257e+03 -2.086479e+03 -1.651067e+03  4.406813e+03 
              193           194           195           196           197           198 
     2.591667e+03 -1.118924e+03 -1.399279e+03  1.943500e+02 -1.046825e+02  3.074750e+03 
              199           200           201           202           203           204 
    -1.417193e+02 -3.800907e+03 -5.210944e+03  2.831948e+04 -3.724809e+03 -3.794124e+03 
              205           206           207           208           209           210 
    -1.050420e+03 -2.773209e+03  6.572338e+02 -2.281356e+03 -5.200946e+03 -2.814188e+03 
              211           212           213           214           215           216 
    -1.958497e+02 -2.273671e+03 -3.084056e+03 -4.584975e+03  6.617958e+03  1.176118e+04 
              217           218           219           220           221           222 
    -5.513655e+02 -1.486238e+03 -1.013259e+03 -7.331170e+02 -1.181582e+03 -7.799163e+02 
              223           224           225           226           227           228 
    -3.783876e+03 -1.415317e+03 -1.702155e+03  8.898911e+02 -1.658370e+03 -2.615988e+02 
              229           230           231           232           233           234 
     2.459505e+03 -4.915355e+02 -1.579513e+03 -2.796885e+03  5.192658e+04 -4.776623e+03 
              235           236           237           238           239           240 
    -1.037397e+03 -2.211945e+03 -3.917791e+03 -3.742384e+03 -1.615971e+03 -1.726776e+03 
              241           242           243           244           245           246 
    -3.970404e+02 -3.181074e+03  2.356508e+04  6.852059e+03  8.279913e+02 -1.609268e+03 
              247           248           249           250           251           252 
    -1.599110e+02 -1.829895e+03  1.411290e+04 -1.483820e+03  2.262445e+03 -1.834839e+03 
              253           254           255           256           257           258 
     2.361295e+03  4.959463e+02  6.292397e+02 -1.523870e+03 -2.204180e+03 -1.202365e+03 
              259           260           261           262           263           264 
    -3.319452e+03 -1.629382e+03  5.458905e+03  3.164408e+02  5.795268e+01  1.526783e+04 
              265           266           267           268           269           270 
    -1.529788e+03  8.017403e+03 -2.888670e+03  8.328064e+02 -2.766626e+02  8.472213e+02 
              271           272           273           274           275           276 
    -2.145606e+03  2.313001e+02 -7.017084e+02 -1.794737e+03 -1.265410e+03 -1.251289e+03 
              277           278           279           280           281           282 
     4.988461e+03 -1.743046e+03  7.621744e+02 -2.016559e+03  5.926618e+03  2.501773e+03 
              283           284           285           286           287           288 
     1.827563e+03  1.321354e+03 -4.872262e+02  9.307043e+03 -1.335245e+03 -5.546826e+03 
              289           290           291           292           293           294 
    -3.308275e+03 -2.957040e+03 -9.650566e+02  1.510466e+03 -2.658480e+03 -1.970720e+03 
              295           296           297           298           299           300 
    -2.637385e+02  6.931796e+02 -2.770434e+02  3.534828e+02 -6.534739e+02  1.827345e+02 
              301           302           303           304           305           306 
    -1.885187e+03 -6.429720e+03  1.111503e+04 -1.097750e+02 -1.223337e+03 -4.759998e+03 
              307           308           309           310           311           312 
     3.858575e+03 -3.301947e+03 -2.013626e+03 -4.566730e+03 -9.268046e+02 -8.597534e+02 
              313           314           315           316           317           318 
    -1.413123e+03 -3.712684e+03 -6.153763e+02 -8.974111e+02 -3.122228e+03 -1.950922e+03 
              319           320           321           322           323           324 
     3.177080e+03  9.005142e+02  1.635394e+02 -1.190727e+03  2.983839e+03 -2.367304e+03 
              325           326           327           328           329           330 
    -2.353008e+03 -1.965131e+02 -4.543813e+03  3.888147e+01 -1.696677e+03  1.479348e+03 
              331           332           333           334           335           336 
     7.300670e+02  1.932757e+02 -2.197576e+03 -3.595898e+02  3.135084e+02  1.788256e+03 
              337           338           339           340           341           342 
    -2.665748e+03 -1.166456e+03  4.248066e+03 -5.158804e+03 -3.666797e+03  1.454867e+03 
              343           344           345           346           347           348 
    -2.103663e+03 -1.402184e+03  1.236739e+04 -6.261568e+02 -5.816160e+02  3.693075e+03 
              349           350           351           352           353           354 
     1.571997e+03  2.084981e+02 -2.616673e+01  2.637105e+03  1.598522e+04 -5.837489e+02 
              355           356           357           358           359           360 
     5.066520e+02 -1.353352e+03  5.841123e+02 -3.573370e+03 -2.566493e+03 -2.556189e+03 
              361           362           363           364           365           366 
     1.014449e+04 -3.335740e+03  2.338229e+03  1.444766e+03 -2.132300e+03 -2.300860e+03 
              367           368           369           370           371           372 
     6.383997e+02 -7.645274e+02 -1.601292e+03 -5.828103e+03 -2.004547e+03 -7.835164e+01 
              373           374           375           376           377           378 
    -2.091508e+03  2.955907e+02 -2.286539e+03  6.324381e+03  2.731897e+03 -2.472631e+03 
              379           380           381           382           383           384 
     3.892410e+02 -5.443734e+03 -2.428167e+03  4.072832e+03 -2.953445e+03 -4.581804e+03 
              385           386           387           388           389           390 
    -2.578815e+03 -3.486043e+03  1.081236e+04 -3.110025e+03 -7.919252e+02  6.939276e+03 
              391           392           393           394           395           396 
    -4.355064e+03 -3.456220e+03  8.975572e+02 -2.260908e+03  3.753654e+03  1.861403e+03 
              397           398           399           400           401           402 
    -5.717005e+02 -2.166237e+03 -4.368165e+02 -2.506674e+03 -1.041774e+03  4.392296e+02 
              403           404           405           406           407           408 
     9.354004e+02 -3.347616e+03  7.654802e+02  1.688348e+03 -2.361530e+03 -2.978537e+03 
              409           410           411           412           413           414 
    -3.328096e+02 -8.290107e+02 -1.349910e+03 -1.623471e+03  9.756358e+01 -7.512815e+02 
              415           416           417           418           419           420 
     1.103976e+04 -4.637475e+03 -1.354005e+03  5.265538e+02  9.520431e+02 -3.622998e+02 
              421           422           423           424           425           426 
     2.476426e+02  3.424840e+03 -1.118590e+03  2.898112e+03 -3.304239e+03 -1.908072e+03 
              427           428           429           430           431           432 
    -1.898169e+03 -1.687614e+02  1.558792e+03 -1.237619e+03  6.054470e+03 -1.596843e+03 
              433           434           435           436           437           438 
    -2.155949e+03 -1.957608e+03 -3.166981e+03 -9.087529e+02 -8.317436e+01  2.154950e+03 
              439           440           441           442           443           444 
    -1.440324e+03 -1.607353e+03  1.828516e+03 -2.741828e+03  1.024741e+04 -2.836025e+03 
              445           446           447           448           449           450 
     8.867868e+03  4.734713e+02 -1.789489e+03 -6.823935e+01 -1.831966e+03  5.565290e+02 
              451           452           453           454           455           456 
    -1.931129e+03  6.289110e+02 -1.024069e+03 -6.929867e+02 -1.618919e+03  6.653572e+02 
              457           458           459           460           461           462 
    -2.575197e+03 -2.996241e+02 -1.518359e+03 -7.281789e+02 -2.082697e+03 -3.806450e+03 
              463           464           465           466           467           468 
    -1.014452e+03  1.105169e+03  2.596762e+03  1.051628e+04 -2.883362e+03  5.810923e+02 
              469           470           471           472           473           474 
    -1.017209e+03  1.883599e+03  2.271974e+03 -1.374007e+03  8.421319e+03 -3.667640e+03 
              475           476           477           478           479           480 
    -4.365530e+03 -1.867649e+03 -1.701721e+03  3.638707e+03  5.759529e+03 -8.706313e+02 
              481           482           483           484           485           486 
     4.828499e+02 -2.892491e+03  9.784267e+03  2.058768e+03  3.923156e+02  1.232013e+02 
              487           488           489           490           491           492 
    -7.379048e+02 -1.230140e+03  2.536983e+02  3.447074e+02 -2.815580e+03 -2.014377e+03 
              493           494           495           496           497           498 
    -1.209751e+03  3.222343e+03  2.288788e+01 -5.539592e+02 -6.358952e+02 -7.389463e+02 
              499           500           501           502           503           504 
    -1.778648e+03 -3.110605e+03 -1.311495e+03 -2.241224e+02  1.847497e+03 -2.362063e+03 
              505           506           507           508           509           510 
     1.221428e+03 -3.624144e+02 -8.443728e+02  5.969308e+02 -4.972718e+02 -2.281408e+03 
              511           512           513           514           515           516 
    -9.958938e+02 -2.070326e+03 -1.803868e+03 -1.873023e+03 -7.778375e+02  3.284896e+02 
              517           518           519           520           521           522 
    -7.699243e+02 -8.179214e+02 -1.849641e+03  1.409164e+03  1.187513e+03  6.991257e+03 
              523           524           525           526           527           528 
    -2.298075e+03 -1.837889e+03  5.549908e+02 -2.802939e+03 -1.365850e+03  3.287268e+03 
              529           530           531           532           533           534 
     6.112735e+02  4.875102e+03 -1.268769e+03 -1.487744e+04  5.154593e+02  2.526764e+03 
              535           536           537           538           539           540 
    -1.612312e+03 -6.993277e+02 -4.562219e+02 -2.226694e+03 -4.908426e+02 -2.532826e+03 
              541           542           543           544           545           546 
    -6.569281e+02 -3.329130e+02 -1.579168e+03 -2.116310e+02 -4.277017e+03 -4.713549e+01 
              547           548           549           550           551           552 
    -3.453073e+02 -9.621795e+02 -4.091371e+03 -7.685083e+02 -1.983509e+03 -1.793324e+03 
              553           554           555           556           557           558 
    -2.159111e+03 -2.317764e+03 -8.361327e+02 -1.874204e+03 -2.477704e+03  1.610691e+03 
              559           560           561           562           563           564 
    -1.533185e+03  1.701840e+03 -2.427522e+03 -1.225781e+03 -2.136457e+03 -3.215641e+03 
              565           566           567           568           569           570 
     2.290994e+04  2.950377e+01  6.784402e+02  1.192903e+02  7.373085e+02 -3.237028e+01 
              571           572           573           574           575           576 
     4.854613e+03 -9.362840e+02 -6.921852e+02 -5.616068e+02 -3.927891e+03 -1.856229e+03 
              577           578           579           580           581           582 
    -3.963310e+03 -1.826329e+03 -1.358597e+03  5.577520e+02  2.299977e+03  2.678362e+03 
              583           584           585           586           587           588 
    -1.719430e+03 -3.411126e+03 -1.085318e+03  7.484897e+03  3.718663e+02 -2.067862e+03 
              589           590           591           592           593           594 
    -2.857801e+02  2.034191e+03  1.403858e+03 -2.114375e+03 -6.945714e+02  2.648247e+03 
              595           596           597           598           599           600 
    -2.813199e+03  1.250674e+02  3.279465e+02 -7.511050e+02 -4.272652e+03  2.015062e+04 
              601           602           603           604           605           606 
     6.433956e+03 -1.742491e+03 -3.964631e+03  1.824174e+02 -1.937161e+03 -1.767463e+03 
              607           608           609           610           611           612 
     3.635488e+03 -1.660407e+03 -1.610467e+03  7.517368e+01  7.653867e+03  1.037495e+04 
              613           614           615           616           617           618 
    -1.929306e+03 -2.479837e+03 -1.890794e+03  8.637417e+02 -1.216497e+02 -2.507790e+03 
              619           620           621           622           623           624 
    -2.030515e+03  1.195996e+04 -3.488588e+03  1.425060e+03 -1.287765e+03  4.206288e+02 
              625           626           627           628           629           630 
    -3.459200e+03 -2.997762e+03 -1.948259e+03 -2.403388e+03 -3.188817e+03  4.217809e+03 
              631           632           633           634           635           636 
    -3.006542e+03 -2.602825e+03 -1.427491e+03 -2.337743e+02  1.193817e+03 -2.140970e+03 
              637           638           639           640           641           642 
    -1.925753e+03 -2.758465e+03 -1.156134e+03 -2.830092e+03 -4.026687e+02  4.288984e+02 
              643           644           645           646           647           648 
    -3.718631e+03 -8.215979e+02  2.623980e+04  8.606637e+01 -3.068895e+03  2.312254e+03 
              649           650           651           652           653           654 
     7.121323e+02 -2.467561e+03 -2.568133e+03 -5.779206e+02 -1.840090e+03 -1.572940e+03 
              655           656           657           658           659           660 
    -1.213458e+03 -2.051681e+03  5.288138e+04 -2.281505e+03  1.098791e+03 -1.116420e+03 
              661           662           663           664           665           666 
     8.258261e+00 -1.244535e+03  3.809583e+02  3.475177e+03 -1.790137e+03  1.107347e+03 
              667           668           669           670           671           672 
    -1.946629e+03  9.981353e+02 -1.386071e+03 -3.305556e+03 -3.231145e+03 -1.370035e+03 
              673           674           675           676           677           678 
    -1.830139e+03 -7.808751e+02 -4.843408e+02 -3.651781e+03  1.524091e+04  1.642578e+03 
              679           680           681           682           683           684 
    -5.730750e+02 -3.689439e+03  2.655429e+02 -9.798884e+02 -1.154723e+03  4.533233e+02 
              685           686           687           688           689           690 
    -1.602070e+03 -6.636255e+02 -2.537756e+03 -1.098213e+03 -6.013873e+02 -1.990465e+03 
              691           692           693           694           695           696 
    -4.845660e+03 -2.021859e+03 -5.902703e+02 -6.168803e+02  1.561574e+03 -1.821900e+03 
              697           698           699           700           701           702 
    -1.278528e+03 -2.926180e+03  9.966519e+02 -1.020815e+03 -2.066447e+02  5.071169e+02 
              703           704           705           706           707           708 
     3.248529e+03 -3.338107e+03 -1.659859e+03 -1.478223e+03  2.076619e+03 -2.544624e+03 
              709           710           711           712           713           714 
    -3.244605e+03 -3.627791e+03 -1.621509e+03 -4.122640e+03 -2.321283e+02  4.051303e+03 
              715           716           717           718           719           720 
    -3.170022e+03 -1.380909e+03  2.170550e+03  1.385125e+03 -2.006813e+03 -9.932042e+02 
              721           722           723           724           725           726 
    -4.481653e+02 -3.378632e+03 -1.803199e+03  6.685023e+02 -1.537770e+03 -1.372947e+03 
              727           728           729           730           731           732 
    -2.590165e+03 -1.798514e+03 -3.069617e+03 -2.699184e+03 -1.037914e+03 -5.178830e+02 
              733           734           735           736           737           738 
     5.472769e+01  1.286787e+03 -2.195678e+03 -2.654850e+03 -5.088623e+01  1.361230e+03 
              739           740           741           742           743           744 
    -4.505067e+03 -1.341498e+02  3.175199e+03 -2.806848e+02  1.940299e+03  2.079617e+03 
              745           746           747           748           749           750 
     1.806114e+03 -1.613608e+03  1.993163e+03  3.249059e+03  3.265240e+02 -1.110548e+03 
              751           752           753           754           755           756 
     4.336588e+03 -1.564430e+03 -1.659531e+03  9.774826e+02 -1.701360e+03  8.869990e+01 
              757           758           759           760           761           762 
    -5.868790e+02 -2.884877e+03  7.074356e+01  1.341558e+02  2.545190e+03  7.975271e+02 
              763           764           765           766           767           768 
    -6.075639e+01 -1.403158e+02  2.696588e+04  5.618517e+03 -1.357540e+03 -2.552790e+03 
              769           770           771           772           773           774 
    -1.363956e+03 -1.766318e+03 -1.044610e+02 -1.351326e+03 -1.619524e+03  2.437257e+02 
              775           776           777           778           779           780 
     1.323501e+03 -6.561365e+02 -1.272314e+03 -4.627658e+02  1.875229e+03 -2.029949e+03 
              781           782           783           784           785           786 
    -7.657778e+02 -1.573718e+03 -2.552398e+03 -1.678177e+03 -2.428361e+03  4.286503e+02 
              787           788           789           790           791           792 
    -3.296740e+03 -1.862673e+02  2.591300e+03  1.718381e+03 -7.202867e+02 -4.885617e+02 
              793           794           795           796           797           798 
    -3.183269e+03  8.458167e+02  4.793546e+03 -1.856564e+03  7.275790e+02  2.223001e+04 
              799           800           801           802           803           804 
    -3.986304e+03 -1.984778e+03 -2.249865e+03  4.675890e+02 -4.515109e+03 -1.934383e+03 
              805           806           807           808           809           810 
     7.734933e+01 -1.978953e+02 -1.526705e+03  5.804685e+02 -2.311501e+03 -3.718973e+02 
              811           812           813           814           815           816 
    -2.388334e+03 -1.810864e+03  5.664979e+03 -2.325143e+03 -1.310926e+03  1.363907e+02 
              817           818           819           820           821           822 
    -7.337383e+02 -1.116461e+02  1.107140e+04  1.310533e+04 -3.522790e+03 -1.935950e+03 
              823           824           825           826           827           828 
     2.529778e+03 -2.315042e+03 -1.414676e+03 -5.509386e+02  9.894216e+03  2.683792e+03 
              829           830           831           832           833           834 
    -3.663414e+03 -7.593337e+02  1.907051e+02 -1.381555e+03 -1.482709e+03 -1.289445e+03 
              835           836           837           838           839           840 
     3.678093e+03 -2.567866e+03 -3.610934e+03 -1.157631e+03 -1.721479e+03 -3.112483e+03 
              841           842           843           844           845           846 
    -1.896517e+03 -8.344889e+02 -1.994012e+03  3.161913e+02 -3.504714e+03  9.672192e+01 
              847           848           849           850           851           852 
    -8.496315e+02 -2.402356e+03 -2.659801e+03 -4.387755e+03  3.862127e+03 -6.240434e+02 
              853           854           855           856           857           858 
    -2.562092e+03  1.228404e+03 -1.676268e+03 -8.279313e+02 -2.580392e+03 -5.430853e+02 
              859           860           861           862           863           864 
     5.867875e+03 -4.780509e+03 -7.835835e+02 -1.415547e+03 -7.796229e+02  1.478027e+02 
              865           866           867           868           869           870 
     4.485630e+04 -3.218454e+03 -2.080582e+03 -1.558455e+03 -8.057923e+02 -3.301472e+03 
              871           872           873           874           875           876 
    -1.587017e+03  7.259401e+03 -2.694741e+03 -2.314440e+01 -3.963507e+03  4.745932e+04 
              877           878           879           880           881           882 
    -1.701559e+02 -3.977304e+03 -1.736570e+03 -3.414920e+03  1.595238e+03  8.193760e+01 
              883           884           885           886           887           888 
    -1.121295e+03  2.491748e+03  5.149848e+02 -2.859699e+03 -2.201390e+03 -2.223027e+03 
              889           890           891           892           893           894 
    -7.374343e-02 -6.771561e+02 -2.274113e+03 -2.138538e+03 -9.350970e+02  1.339575e+03 
              895           896           897           898           899           900 
    -2.577665e+03 -5.640363e+03 -2.036638e+02 -9.947752e+02 -9.862444e+02 -1.349446e+03 
              901           902           903           904           905           906 
     4.309780e+01 -1.845890e+03 -1.884142e+03  5.853889e+03  4.345845e+02 -4.093552e+02 
              907           908           909           910           911           912 
    -9.993742e+02  1.148200e+03 -1.272188e+03 -1.239826e+03 -2.002743e+03 -1.580802e+03 
              913           914           915           916           917           918 
    -2.583057e+02  5.785758e+02  4.869176e+03 -3.885028e+03  2.140112e+03 -1.303311e+03 
              919           920           921           922           923           924 
    -8.162062e+02 -1.665359e+03  1.934378e+03 -8.754820e+02 -2.958880e+03 -8.640298e+02 
              925           926           927           928           929           930 
    -1.774450e+03 -2.838213e+03 -2.801814e+03  5.278566e+03 -1.090188e+03 -4.387463e+03 
              931           932           933           934           935           936 
    -6.238269e+02 -1.234008e+03  1.616039e+03 -1.272998e+02  1.303177e+03 -1.342347e+03 
              937           938           939           940           941           942 
    -1.506212e+03 -1.945287e+03 -7.246475e+02  5.094357e+02 -2.872186e+02 -6.795280e+02 
              943           944           945           946           947           948 
    -9.115093e+01  1.654058e+04  2.707018e+03  4.772654e+03 -2.300271e+03 -1.118733e+03 
              949           950           951           952           953           954 
    -1.236769e+03  3.945544e+01 -1.185325e+03  3.286346e+03 -7.622127e+02 -1.081224e+03 
              955           956           957           958           959           960 
     8.473588e+02  1.500641e+03  5.993163e+03  5.645234e+03  3.661088e+03 -1.237767e+03 
              961           962           963           964           965           966 
    -9.096047e+02 -5.813072e+02 -1.072688e+03  8.095984e+03 -5.199980e+02 -1.565981e+03 
              967           968           969           970           971           972 
     3.450389e+02  2.249191e+03 -3.185596e+03  2.080588e+03 -1.856016e+02  4.460159e+02 
              973           974           975           976           977           978 
     1.091221e+04  3.602775e+03  5.049414e+03 -3.635539e+03  5.690260e+03 -1.576322e+03 
              979           980           981           982           983           984 
    -6.341029e+02 -3.134363e+03 -2.887204e+03 -2.105567e+03 -2.027766e+03 -6.915378e+01 
              985           986           987           988           989           990 
     4.698237e+03 -9.196691e+02 -1.826561e+02 -6.639461e+02 -3.955280e+03 -2.113628e+03 
              991           992           993           994           995           996 
     1.809394e+02 -3.422531e+03 -3.033343e+02 -2.702337e+03  2.369461e+02 -3.878891e+02 
              997           998           999          1000 
    -9.127809e+02 -5.291678e+03  8.892600e+03 -1.334845e+03 
     [ reached getOption("max.print") -- omitted 1323 entries ]

``` r
#summary stats for vars of interest - 
plot(fit_Channel)
```

![](data:image/png;base64,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)<!-- -->![](data:image/png;base64,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)<!-- -->![](data:image/png;base64,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)<!-- -->![](data:image/png;base64,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)<!-- -->

``` r
ggplot(data=fit_Channel, aes(y=shares, x=rate_positive_words)) + geom_point()
```

![](data:image/png;base64,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)<!-- -->

``` r
#EDA
#starting point... correlation - shares vs. each var
#every pairwise combo
Channel_corr <- cor(x=Channel %>% 
                          select (shares, starts_with("weekday_is_") ) )
# cor_mat <- cor(data %>% select(RentedBikeCount, Temperature, Humidity, WindSpeed,
# Hour, Visibility, DewPointTemp,
# Rainfall, Snowfall), method = "pearson")
# corrplot(cor_mat, hc.order = TRUE,
# type = "lower",
# tl.pos = "lt",
# title = "Correlation Coefficients for Bike Rental Data",
# subtitle = "Correlation Coefficients for Bike Rental Data",
# mar=c(0,0,2,0)
# )
#call Channel_corr object to look at correlation between vars and shares response var
#drop to keep in matrix and not turn into a vector
shares_corr <- Channel_corr[ ,"shares", drop=FALSE]
#shares_corr <- Channel_corr[ ,"shares"]
is(shares_corr) #matrix with the drop=TRUE option
```

    [1] "matrix"    "array"     "mMatrix"   "structure" "vector"   

``` r
#convert to tibble
#shares_corr_tibble <- as_tibble(shares_corr)
shares_corr_tibble <- bind_cols( var_names = rownames(shares_corr), shares_corr ) 
#call shares_corr_tibble object that has correlations with shares and vars...
shares_corr_tibble
```

    # A tibble: 8 × 2
      var_names              shares
      <chr>                   <dbl>
    1 shares                1      
    2 weekday_is_monday     0.0284 
    3 weekday_is_tuesday   -0.0113 
    4 weekday_is_wednesday -0.0102 
    5 weekday_is_thursday  -0.0485 
    6 weekday_is_friday     0.0284 
    7 weekday_is_saturday  -0.00633
    8 weekday_is_sunday     0.0406 

``` r
# condition on +/- 0.9 to see what we should remove as a predictor for the model
# call shares_corr_tibble object
#shares_corr_tibble #this currently does not have row names...
rownames(shares_corr)
```

    [1] "shares"               "weekday_is_monday"    "weekday_is_tuesday"  
    [4] "weekday_is_wednesday" "weekday_is_thursday"  "weekday_is_friday"   
    [7] "weekday_is_saturday"  "weekday_is_sunday"   

``` r
#checking structure and type of object
#str(Channel_corr)
#is(Channel_corr)
#finds highly correlated variables and you can set a cutoff (default is +/ 0.9)
#convert to tibble because using drylr chaining / piping
corr_vars <- as_tibble ( Channel_corr[ ,"shares"] ) %>%
             filter ( abs(value) >= 0.9 )
#dont need this anymore...
#corr_vars <- findCorrelation(x=Can_corr, cutoff = +/- 0.9, verbose = TRUE, names = TRUE)
#call corr_vars object
#corr_vars
#columns that are highly correlated and should be removed from the model
#5 13 22
# [1] "n_non_stop_unique_tokens"  "kw_max_min" "self_reference_max_shares"
#response variable is shares, but what does that mean given certain variables available to us?
#maybe look at days of the week variables?
#figure out what kind of object we want to make to answer our question...
#tibble keeping what kind of vars, matrix?
#need to do some sort of type of EDA in order to see if variables are highly correlated
#here we need to summary statistics via summary() and plots
#this shows the summary stats for each variable in our dataset...
Lifestlye_sumstats_Train <- summary(ChannelTrain)
#calling Lifestlye_sumstats_Train object to see our summary stats
Lifestlye_sumstats_Train
```

     n_tokens_title   n_tokens_content n_unique_tokens  n_non_stop_words
     Min.   : 4.000   Min.   :   0.0   Min.   :0.0000   Min.   :0.0000  
     1st Qu.: 8.000   1st Qu.: 252.8   1st Qu.:0.4639   1st Qu.:1.0000  
     Median : 9.000   Median : 432.5   Median :0.5352   Median :1.0000  
     Mean   : 9.639   Mean   : 606.3   Mean   :0.5340   Mean   :0.9939  
     3rd Qu.:11.000   3rd Qu.: 755.2   3rd Qu.:0.6056   3rd Qu.:1.0000  
     Max.   :18.000   Max.   :4878.0   Max.   :0.9714   Max.   :1.0000  
     n_non_stop_unique_tokens   num_hrefs      num_self_hrefs      num_imgs     
     Min.   :0.0000           Min.   :  0.00   Min.   : 0.000   Min.   : 0.000  
     1st Qu.:0.6180           1st Qu.:  5.00   1st Qu.: 2.000   1st Qu.: 1.000  
     Median :0.6827           Median :  8.00   Median : 3.000   Median : 1.000  
     Mean   :0.6813           Mean   : 12.92   Mean   : 4.484   Mean   : 4.192  
     3rd Qu.:0.7538           3rd Qu.: 14.00   3rd Qu.: 5.000   3rd Qu.: 3.000  
     Max.   :1.0000           Max.   :171.00   Max.   :74.000   Max.   :62.000  
       num_videos     average_token_length  num_keywords    data_channel_is_lifestyle
     Min.   : 0.000   Min.   :0.000        Min.   : 1.000   Min.   :0                
     1st Qu.: 0.000   1st Qu.:4.492        1st Qu.: 5.000   1st Qu.:0                
     Median : 0.000   Median :4.657        Median : 7.000   Median :0                
     Mean   : 1.144   Mean   :4.632        Mean   : 6.539   Mean   :0                
     3rd Qu.: 1.000   3rd Qu.:4.812        3rd Qu.: 8.000   3rd Qu.:0                
     Max.   :73.000   Max.   :5.774        Max.   :10.000   Max.   :0                
     data_channel_is_entertainment data_channel_is_bus data_channel_is_socmed
     Min.   :0                     Min.   :0           Min.   :1             
     1st Qu.:0                     1st Qu.:0           1st Qu.:1             
     Median :0                     Median :0           Median :1             
     Mean   :0                     Mean   :0           Mean   :1             
     3rd Qu.:0                     3rd Qu.:0           3rd Qu.:1             
     Max.   :0                     Max.   :0           Max.   :1             
     data_channel_is_tech data_channel_is_world   kw_min_min       kw_max_min    
     Min.   :0            Min.   :0             Min.   : -1.00   Min.   :     0  
     1st Qu.:0            1st Qu.:0             1st Qu.: -1.00   1st Qu.:   430  
     Median :0            Median :0             Median :  4.00   Median :   676  
     Mean   :0            Mean   :0             Mean   : 36.22   Mean   :  1217  
     3rd Qu.:0            3rd Qu.:0             3rd Qu.:  4.00   3rd Qu.:  1200  
     Max.   :0            Max.   :0             Max.   :217.00   Max.   :158900  
       kw_avg_min        kw_min_max       kw_max_max       kw_avg_max       kw_min_avg  
     Min.   :   -1.0   Min.   :     0   Min.   :     0   Min.   :     0   Min.   :   0  
     1st Qu.:  177.0   1st Qu.:     0   1st Qu.:690400   1st Qu.:143469   1st Qu.:   0  
     Median :  301.2   Median :  2000   Median :843300   Median :198104   Median :1341  
     Mean   :  394.1   Mean   : 27267   Mean   :717853   Mean   :225141   Mean   :1310  
     3rd Qu.:  434.0   3rd Qu.:  9825   3rd Qu.:843300   3rd Qu.:282944   3rd Qu.:2519  
     Max.   :39979.0   Max.   :843300   Max.   :843300   Max.   :843300   Max.   :3607  
       kw_max_avg       kw_avg_avg    self_reference_min_shares self_reference_max_shares
     Min.   :     0   Min.   :    0   Min.   :     0.0          Min.   :     0           
     1st Qu.:  3863   1st Qu.: 2656   1st Qu.:   741.2          1st Qu.:  1600           
     Median :  4389   Median : 3169   Median :  1600.0          Median :  4200           
     Mean   :  5323   Mean   : 3215   Mean   :  5475.2          Mean   : 14770           
     3rd Qu.:  5455   3rd Qu.: 3619   3rd Qu.:  3400.0          3rd Qu.: 12600           
     Max.   :158900   Max.   :33953   Max.   :690400.0          Max.   :690400           
     self_reference_avg_sharess weekday_is_monday weekday_is_tuesday weekday_is_wednesday
     Min.   :     0             Min.   :0.0000    Min.   :0.000      Min.   :0.0000      
     1st Qu.:  1400             1st Qu.:0.0000    1st Qu.:0.000      1st Qu.:0.0000      
     Median :  3200             Median :0.0000    Median :0.000      Median :0.0000      
     Mean   :  8566             Mean   :0.1529    Mean   :0.191      Mean   :0.1849      
     3rd Qu.:  7365             3rd Qu.:0.0000    3rd Qu.:0.000      3rd Qu.:0.0000      
     Max.   :690400             Max.   :1.0000    Max.   :1.000      Max.   :1.0000      
     weekday_is_thursday weekday_is_friday weekday_is_saturday weekday_is_sunday
     Min.   :0.0000      Min.   :0.0000    Min.   :0.00000     Min.   :0.00000  
     1st Qu.:0.0000      1st Qu.:0.0000    1st Qu.:0.00000     1st Qu.:0.00000  
     Median :0.0000      Median :0.0000    Median :0.00000     Median :0.00000  
     Mean   :0.2045      Mean   :0.1357    Mean   :0.07617     Mean   :0.05467  
     3rd Qu.:0.0000      3rd Qu.:0.0000    3rd Qu.:0.00000     3rd Qu.:0.00000  
     Max.   :1.0000      Max.   :1.0000    Max.   :1.00000     Max.   :1.00000  
       is_weekend         LDA_00            LDA_01            LDA_02            LDA_03       
     Min.   :0.0000   Min.   :0.01818   Min.   :0.01818   Min.   :0.01818   Min.   :0.01843  
     1st Qu.:0.0000   1st Qu.:0.16212   1st Qu.:0.02508   1st Qu.:0.02896   1st Qu.:0.02874  
     Median :0.0000   Median :0.38373   Median :0.03337   Median :0.05042   Median :0.04049  
     Mean   :0.1308   Mean   :0.39829   Mean   :0.07542   Mean   :0.19315   Mean   :0.17824  
     3rd Qu.:0.0000   3rd Qu.:0.62129   3rd Qu.:0.05001   3rd Qu.:0.28817   3rd Qu.:0.26108  
     Max.   :1.0000   Max.   :0.92699   Max.   :0.86666   Max.   :0.91962   Max.   :0.91894  
         LDA_04        global_subjectivity global_sentiment_polarity
     Min.   :0.01818   Min.   :0.0000      Min.   :-0.37500         
     1st Qu.:0.02910   1st Qu.:0.4061      1st Qu.: 0.08816         
     Median :0.05000   Median :0.4609      Median : 0.13931         
     Mean   :0.15489   Mean   :0.4585      Mean   : 0.14333         
     3rd Qu.:0.23047   3rd Qu.:0.5159      3rd Qu.: 0.19404         
     Max.   :0.91961   Max.   :0.9222      Max.   : 0.56667         
     global_rate_positive_words global_rate_negative_words rate_positive_words
     Min.   :0.00000            Min.   :0.000000           Min.   :0.0000     
     1st Qu.:0.03487            1st Qu.:0.009479           1st Qu.:0.6667     
     Median :0.04591            Median :0.014540           Median :0.7500     
     Mean   :0.04669            Mean   :0.015803           Mean   :0.7420     
     3rd Qu.:0.05680            3rd Qu.:0.020566           3rd Qu.:0.8333     
     Max.   :0.15549            Max.   :0.139831           Max.   :1.0000     
     rate_negative_words avg_positive_polarity min_positive_polarity max_positive_polarity
     Min.   :0.0000      Min.   :0.0000        Min.   :0.00000       Min.   :0.000        
     1st Qu.:0.1667      1st Qu.:0.3030        1st Qu.:0.03333       1st Qu.:0.600        
     Median :0.2500      Median :0.3558        Median :0.05000       Median :0.800        
     Mean   :0.2512      Mean   :0.3560        Mean   :0.07724       Mean   :0.783        
     3rd Qu.:0.3333      3rd Qu.:0.4123        3rd Qu.:0.10000       3rd Qu.:1.000        
     Max.   :1.0000      Max.   :0.8333        Max.   :0.60000       Max.   :1.000        
     avg_negative_polarity min_negative_polarity max_negative_polarity title_subjectivity
     Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000       Min.   :0.00000   
     1st Qu.:-0.3175       1st Qu.:-0.8000       1st Qu.:-0.1250       1st Qu.:0.00000   
     Median :-0.2484       Median :-0.5000       Median :-0.1000       Median :0.06667   
     Mean   :-0.2581       Mean   :-0.5212       Mean   :-0.1118       Mean   :0.26393   
     3rd Qu.:-0.1833       3rd Qu.:-0.3000       3rd Qu.:-0.0500       3rd Qu.:0.46786   
     Max.   : 0.0000       Max.   : 0.0000       Max.   : 0.0000       Max.   :1.00000   
     title_sentiment_polarity abs_title_subjectivity abs_title_sentiment_polarity
     Min.   :-1.00000         Min.   :0.0000         Min.   :0.00000             
     1st Qu.: 0.00000         1st Qu.:0.1872         1st Qu.:0.00000             
     Median : 0.00000         Median :0.5000         Median :0.01111             
     Mean   : 0.09286         Mean   :0.3498         Mean   :0.15533             
     3rd Qu.: 0.14659         3rd Qu.:0.5000         3rd Qu.:0.23750             
     Max.   : 1.00000         Max.   :0.5000         Max.   :1.00000             
         shares      
     Min.   :     8  
     1st Qu.:  1400  
     Median :  2100  
     Mean   :  3793  
     3rd Qu.:  3800  
     Max.   :122800  

``` r
#check structure of objects
str(ChannelTrain)
```

    tibble [1,628 × 59] (S3: tbl_df/tbl/data.frame)
     $ n_tokens_title               : num [1:1628] 8 8 6 10 8 12 8 11 9 11 ...
     $ n_tokens_content             : num [1:1628] 257 358 358 205 701 596 263 372 912 403 ...
     $ n_unique_tokens              : num [1:1628] 0.568 0.503 0.622 0.636 0.499 ...
     $ n_non_stop_words             : num [1:1628] 1 1 1 1 1 ...
     $ n_non_stop_unique_tokens     : num [1:1628] 0.671 0.687 0.777 0.812 0.661 ...
     $ num_hrefs                    : num [1:1628] 9 4 24 3 8 28 14 3 5 4 ...
     $ num_self_hrefs               : num [1:1628] 7 4 6 1 8 28 3 2 5 2 ...
     $ num_imgs                     : num [1:1628] 0 1 1 1 12 9 11 1 1 0 ...
     $ num_videos                   : num [1:1628] 1 0 0 0 0 0 0 0 0 1 ...
     $ average_token_length         : num [1:1628] 4.64 4.25 5.39 4.37 4.69 ...
     $ num_keywords                 : num [1:1628] 9 4 8 5 7 8 10 4 6 6 ...
     $ data_channel_is_lifestyle    : num [1:1628] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_entertainment: num [1:1628] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_bus          : num [1:1628] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_socmed       : num [1:1628] 1 1 1 1 1 1 1 1 1 1 ...
     $ data_channel_is_tech         : num [1:1628] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_world        : num [1:1628] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_min_min                   : num [1:1628] 0 217 217 217 217 217 217 217 217 217 ...
     $ kw_max_min                   : num [1:1628] 0 1900 737 690 2600 1700 690 690 862 862 ...
     $ kw_avg_min                   : num [1:1628] 0 936 526 445 905 ...
     $ kw_min_max                   : num [1:1628] 0 0 0 0 0 0 0 6400 0 0 ...
     $ kw_max_max                   : num [1:1628] 0 28000 28000 37400 37400 37400 37400 37400 39400 39400 ...
     $ kw_avg_max                   : num [1:1628] 0 10725 6550 11400 15771 ...
     $ kw_min_avg                   : num [1:1628] 0 0 0 0 0 ...
     $ kw_max_avg                   : num [1:1628] 0 3800 3784 3596 4156 ...
     $ kw_avg_avg                   : num [1:1628] 0 2210 1398 1455 2621 ...
     $ self_reference_min_shares    : num [1:1628] 1300 4500 1600 0 3300 1300 1200 1100 4100 8900 ...
     $ self_reference_max_shares    : num [1:1628] 2500 15300 1600 0 5200 18200 3400 1100 8900 8900 ...
     $ self_reference_avg_sharess   : num [1:1628] 1775 10400 1600 0 4350 ...
     $ weekday_is_monday            : num [1:1628] 1 0 0 1 1 1 1 1 0 0 ...
     $ weekday_is_tuesday           : num [1:1628] 0 0 0 0 0 0 0 0 1 1 ...
     $ weekday_is_wednesday         : num [1:1628] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_thursday          : num [1:1628] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_friday            : num [1:1628] 0 1 1 0 0 0 0 0 0 0 ...
     $ weekday_is_saturday          : num [1:1628] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_sunday            : num [1:1628] 0 0 0 0 0 0 0 0 0 0 ...
     $ is_weekend                   : num [1:1628] 0 0 0 0 0 0 0 0 0 0 ...
     $ LDA_00                       : num [1:1628] 0.439 0.8 0.189 0.628 0.16 ...
     $ LDA_01                       : num [1:1628] 0.0225 0.05 0.025 0.0401 0.0286 ...
     $ LDA_02                       : num [1:1628] 0.0224 0.0502 0.3192 0.2498 0.0288 ...
     $ LDA_03                       : num [1:1628] 0.0233 0.0501 0.0254 0.0401 0.5892 ...
     $ LDA_04                       : num [1:1628] 0.4926 0.05 0.441 0.0419 0.1938 ...
     $ global_subjectivity          : num [1:1628] 0.4 0.504 0.493 0.385 0.497 ...
     $ global_sentiment_polarity    : num [1:1628] 0.00741 0.06507 0.18971 0.22114 0.18359 ...
     $ global_rate_positive_words   : num [1:1628] 0.0311 0.0391 0.0559 0.0244 0.0585 ...
     $ global_rate_negative_words   : num [1:1628] 0.02724 0.01955 0.02514 0.00488 0.01141 ...
     $ rate_positive_words          : num [1:1628] 0.533 0.667 0.69 0.833 0.837 ...
     $ rate_negative_words          : num [1:1628] 0.467 0.333 0.31 0.167 0.163 ...
     $ avg_positive_polarity        : num [1:1628] 0.36 0.248 0.414 0.467 0.375 ...
     $ min_positive_polarity        : num [1:1628] 0.0333 0.0333 0.1 0.1364 0.0333 ...
     $ max_positive_polarity        : num [1:1628] 0.6 0.55 0.8 0.8 1 1 1 0.7 1 0.5 ...
     $ avg_negative_polarity        : num [1:1628] -0.393 -0.207 -0.257 -0.125 -0.264 ...
     $ min_negative_polarity        : num [1:1628] -0.5 -0.7 -0.5 -0.125 -0.5 -1 -1 -0.3 -1 -0.65 ...
     $ max_negative_polarity        : num [1:1628] -0.125 -0.125 -0.05 -0.125 -0.0714 ...
     $ title_subjectivity           : num [1:1628] 0.667 0 0.333 0 0 ...
     $ title_sentiment_polarity     : num [1:1628] -0.5 0 0.25 0 0 ...
     $ abs_title_subjectivity       : num [1:1628] 0.167 0.5 0.167 0.5 0.5 ...
     $ abs_title_sentiment_polarity : num [1:1628] 0.5 0 0.25 0 0 ...
     $ shares                       : num [1:1628] 2600 18200 1600 992 4900 1400 1100 1200 5400 3800 ...

``` r
str(Lifestlye_sumstats_Train)
```

     'table' chr [1:6, 1:59] "Min.   : 4.000  " "1st Qu.: 8.000  " "Median : 9.000  " ...
     - attr(*, "dimnames")=List of 2
      ..$ : chr [1:6] "" "" "" "" ...
      ..$ : chr [1:59] "n_tokens_title" "n_tokens_content" "n_unique_tokens" "n_non_stop_words" ...

``` r
#plots include - scatter plots, correlation plots -- plots for continuous data...
#do we need bar plots?
#A scatter plot with the number of shares on the y-axis and the positive word rate on the x-axis is created below
ggplot(data=ChannelTrain, aes(y=shares, x=rate_positive_words)) + geom_point()
```

![](data:image/png;base64,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)<!-- -->
<!-- You’ll be automating the creation of documents using R Markdown (one for each data_channel_is_* setting, i.e. type of article in the data set provided). Each document should be rendered as a github_document from a single .Rmd file. In the README.md file you should create links to each of the documents you will create (Lifestyle analysis, Entertainment analysis, etc.). Links can be made to the sub-documents using relative -->
<!-- paths. For instance, if you have all of the outputted .md files in the main directory you would just use markdown linking: -->

<!-- - The analysis for [Lifestyle articles is available here](LifestyleAnalysis.html). Note we -->
<!-- link to the html file even though the file we create is a .md file - github creates the .html for us. -->
<!-- In the repo’s README.md file (which doesn’t need to be created from a .Rmd file, just use the one you initialize into the repo if you want) give a brief description of the purpose of the repo, a list of R packages used, links to the generated analyses, and the code used to create the analyses from a single .Rmd file (i.e. the render() code). -->

# Modelling

The data is already split into 70% training and 30% test. Our main goal
is to predict the number of shares. This will be our response variable.
We will create four models each using 5-fold cross-validation.

Two models (first linear and random forest) will be multiple linear
regression models, one will be a random forest model and the final model
will be a boosted tree model.

A Linear regression model is a supervised learning technique that is
used to predict the value of a variable based on the value of other
variable(s). The variable you want to predict is called the dependent
variable or the response. The variable(s) you are using to predict is
called the independent variable(s) or the predictor(s).

## First linear model.

We model the number of shares by the selected independent variables

-   “n_tokens_title” (Number of words in the title),

-   “n_tokens_content” (Number of words in the content)

-   “num_imgs” (Number of images)

-   “num_videos” (Number of videos)

-   “is_weekend” (Was the article published on the weekend?)

``` r
#linear regression model 1
l_m1 <- train(shares ~ n_tokens_title +  n_tokens_content + num_imgs + num_videos + 
                       is_weekend, 
              data = ChannelTrain, 
              method = "lm", 
              preProcess = c("center", "scale"),
              trControl = trainControl(method= "cv", number = 5))
#l_m1
#predicting on the ChannelTest data with linear regression model 1
test_pred_l_m1 <- predict(l_m1, newdata = ChannelTest)
#finding the best model - more explicit
m1 <- postResample(test_pred_l_m1, ChannelTest$shares)
m1
```

            RMSE     Rsquared          MAE 
    3.489128e+03 1.102404e-03 2.381287e+03 

## Second linear model

We model the number of shares by the selected independent variables

-   “num_hrefs” (Number of links)

-   “weekday_is_monday” (Was the article published on a Monday?)

-   “weekday_is_tuesday” (Was the article published on a Tuesday?)

-   “weekday_is_wednesday” {Was the article published on a Wednesday?)

-   “weekday_is_thursday” (Was the article published on a Thursday?)

-   “weekday_is_friday” (Was the article published on a Friday?)

-   “self_reference_avg_sharess” (Avg. shares of referenced articles in
    Mashable)

``` r
#linear regression model 2
l_m2 <- train(shares ~ num_hrefs + weekday_is_monday + weekday_is_tuesday +
                       weekday_is_wednesday + weekday_is_thursday + weekday_is_friday +
                       self_reference_avg_sharess,
              data = ChannelTrain, 
              method = "lm", 
              preProcess = c("center", "scale"),
              trControl = trainControl(method= "cv", number = 5))
#predictions based on linear model 2 for the ChannelTest data
test_pred_l_m2 <- predict(l_m2, newdata = ChannelTest)
#best model chosen - RMSE reported explicity
#goal is to compare RMSE and see which one is the lowest!
m2 <- postResample(test_pred_l_m2, ChannelTest$shares)
m2
```

            RMSE     Rsquared          MAE 
    3.467027e+03 1.123714e-02 2.363882e+03 

## Random forest model

The idea behind the random forest model is the same as bagging but we
use a random subset of predictors for each bootstrap sample tree fit
(indicated by “mtry”). More specifically, it involves creating a
boothstrap sample (same size with replacement), training the tree on
this sample (no pruning necessary), repeating the process a large number
of times and the final prediction is the average of those predictions.
Finding the average of predictions decreases variance which improves
predictions but unfortunately we lose interpretability.

For our random forest We model the number of shares by the selected
independent variables

-   “n_tokens_title” (Number of words in the title),

-   “n_tokens_content” (Number of words in the content)

-   “num_imgs” (Number of images)

-   “num_videos” (Number of videos)

-   “is_weekend” (Was the article published on the weekend?)

``` r
r_f <- train(shares ~ n_tokens_title +  n_tokens_content + num_imgs + num_videos + 
                      is_weekend , data = ChannelTrain, method = "rf",
  
             trControl=trainControl(method = "cv", number = 5),
             preProcess = c("center", "scale"),
             tuneGrid = data.frame(mtry = 1:3))
test_pred_r_f <- predict(r_f, newdata = ChannelTest)
m3 <- postResample(test_pred_r_f, ChannelTest$shares)
m3
```

            RMSE     Rsquared          MAE 
    3.464870e+03 1.415801e-02 2.327054e+03 

``` r
#bootstrapping will take some time...
```

## Boosted tree model

The idea behind the boosting tree model is to train our tree slowly in a
sequential manner so each tree that is created will be based on the
previous one with predictions updated.

For our boosting tree we model the number of shares by the selected
independent variables

-   “num_hrefs” (Number of links)

-   “weekday_is_monday” (Was the article published on a Monday?)

-   “weekday_is_tuesday” (Was the article published on a Tuesday?)

-   “weekday_is_wednesday” {Was the article published on a Wednesday?)

-   “weekday_is_thursday” (Was the article published on a Thursday?)

-   “weekday_is_friday” (Was the article published on a Friday?)

-   “self_reference_avg_sharess” (Avg. shares of referenced articles in
    Mashable)

Additionally we choose to use all combinations of the tuning parameters
n.trees = c(25, 50, 100, 150, 200), interaction.depth = 1:4, shrinkage =
0.1 and n.minobsinnode = 10.

``` r
tune1<- c(25, 50, 100, 150, 200)
tune2<- 1:4
tune3<- 0.1
tune4<- 10

boosted <- train(shares ~ num_hrefs + weekday_is_monday + weekday_is_tuesday + 
                          weekday_is_wednesday + weekday_is_thursday + weekday_is_friday
                          + self_reference_avg_sharess, 
                 data = ChannelTrain, method = "gbm",
                 trControl=trainControl(method = "cv", number = 5),
                 preProcess = c("center", "scale"),
                 tuneGrid = expand.grid(n.trees = tune1, interaction.depth = tune2, 
                 shrinkage = tune3,    n.minobsinnode = tune4))
```

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41294007.8272             nan     0.1000 223634.8503
         2 41097753.7581             nan     0.1000 106812.7568
         3 40988780.5060             nan     0.1000 73961.0075
         4 40897915.1992             nan     0.1000 37792.2151
         5 40748144.5306             nan     0.1000 112951.9242
         6 40612076.0423             nan     0.1000 68782.1481
         7 40577814.5262             nan     0.1000 -11150.9860
         8 40466254.9698             nan     0.1000 -43559.3972
         9 40381441.4744             nan     0.1000 -6727.8447
        10 40342953.1933             nan     0.1000 -26868.4290
        20 40015458.1387             nan     0.1000 5726.0914
        40 39653386.8944             nan     0.1000 -33421.2098
        60 39291459.0963             nan     0.1000 -14790.7566
        80 39034359.2202             nan     0.1000 -43878.5000
       100 38884268.3242             nan     0.1000 -130216.7640
       120 38653529.5450             nan     0.1000 -92106.6310
       140 38554171.6741             nan     0.1000 -111334.0249
       160 38432878.2183             nan     0.1000 -42776.6095
       180 38258399.5680             nan     0.1000 -38085.7093
       200 38129074.9321             nan     0.1000 -33732.7690

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41522350.8086             nan     0.1000 102809.6307
         2 41198296.9790             nan     0.1000 206635.5634
         3 40886958.1435             nan     0.1000 108062.7421
         4 40764580.4671             nan     0.1000 -15493.6991
         5 40627453.4229             nan     0.1000 5162.6493
         6 40478071.1371             nan     0.1000 -25813.7471
         7 40297679.8039             nan     0.1000 -38784.0901
         8 40238394.8835             nan     0.1000 -1017.2251
         9 40158947.3730             nan     0.1000 20576.0273
        10 39995465.4825             nan     0.1000 82479.4011
        20 39251261.5573             nan     0.1000 28153.1252
        40 38347140.0432             nan     0.1000 -28295.0527
        60 37561033.4042             nan     0.1000 -103499.3155
        80 37141375.8623             nan     0.1000 -94225.2690
       100 36669819.8348             nan     0.1000 -91353.1264
       120 36130667.5357             nan     0.1000 -14034.2284
       140 35804169.8843             nan     0.1000 -98296.6849
       160 35410005.5472             nan     0.1000 -22979.7989
       180 35117047.8282             nan     0.1000 -82521.0448
       200 34838307.1724             nan     0.1000 -36562.1933

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41404106.1064             nan     0.1000 218191.2064
         2 41023181.4359             nan     0.1000 257619.7729
         3 40665545.5158             nan     0.1000 58819.4079
         4 40457823.3583             nan     0.1000 111918.6266
         5 40265266.1366             nan     0.1000 68842.1665
         6 40029575.3803             nan     0.1000 39203.8426
         7 39899327.7864             nan     0.1000 80817.4652
         8 39827234.6544             nan     0.1000 -20840.9965
         9 39677432.1499             nan     0.1000 -27116.4147
        10 39539994.0347             nan     0.1000 1346.1428
        20 38256833.6501             nan     0.1000 -136946.9566
        40 36895460.7179             nan     0.1000 -43167.9590
        60 36065183.2426             nan     0.1000 -198200.4403
        80 35331814.1452             nan     0.1000 -149143.2025
       100 34991409.8527             nan     0.1000 -148809.8521
       120 34622569.3183             nan     0.1000 -115267.4801
       140 34023248.9768             nan     0.1000 -151402.5295
       160 33569665.4545             nan     0.1000 -249631.1957
       180 33258771.5797             nan     0.1000 -111484.3073
       200 32977992.5053             nan     0.1000 -123072.8706

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41350467.5822             nan     0.1000 92281.1065
         2 40831510.7014             nan     0.1000 70569.3764
         3 40503182.0912             nan     0.1000 141513.5576
         4 40162180.9801             nan     0.1000 34234.9637
         5 40057924.8250             nan     0.1000 -28279.5231
         6 39895585.3865             nan     0.1000 89823.1406
         7 39667103.9406             nan     0.1000 64111.9883
         8 39552146.7001             nan     0.1000 -64864.9058
         9 39393075.9600             nan     0.1000 -249546.5792
        10 39207528.1602             nan     0.1000 -11886.9722
        20 37890725.4412             nan     0.1000 -208645.3258
        40 36439618.2663             nan     0.1000 -289851.5048
        60 35431090.3206             nan     0.1000 -142888.3689
        80 34608497.7125             nan     0.1000 -88435.3076
       100 34027635.8678             nan     0.1000 -205953.2628
       120 33411351.5306             nan     0.1000 -97123.6511
       140 32680307.8419             nan     0.1000 -200945.5218
       160 32146554.0084             nan     0.1000 -124617.3825
       180 31738927.0325             nan     0.1000 -110982.0428
       200 31270373.5167             nan     0.1000 -97673.2402

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 39509608.5937             nan     0.1000 165432.3314
         2 39385528.9626             nan     0.1000 128039.5220
         3 39261233.5427             nan     0.1000 65696.3954
         4 39090627.9517             nan     0.1000 -34383.1503
         5 39013448.4616             nan     0.1000 72903.0955
         6 38978257.9315             nan     0.1000 21917.2546
         7 38922363.8993             nan     0.1000 11071.3735
         8 38851907.9749             nan     0.1000 45083.3619
         9 38772642.0858             nan     0.1000 -3116.3072
        10 38751331.2168             nan     0.1000 -44139.6458
        20 38470936.2041             nan     0.1000 -28515.2806
        40 38238519.3400             nan     0.1000 -38481.9419
        60 38115831.4909             nan     0.1000 -27687.2205
        80 37917184.2630             nan     0.1000 -26783.6492
       100 37785632.0624             nan     0.1000 -12085.2970
       120 37690625.2361             nan     0.1000 -15262.2908
       140 37607235.3486             nan     0.1000 -43663.0803
       160 37493291.8759             nan     0.1000 -34328.5610
       180 37392621.4879             nan     0.1000 -19762.8991
       200 37292190.0408             nan     0.1000 -30835.1852

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 39565541.0542             nan     0.1000 170597.4984
         2 39394059.6464             nan     0.1000 120792.7135
         3 39093676.7181             nan     0.1000 76452.8351
         4 38828354.1970             nan     0.1000 -42873.0988
         5 38756067.9344             nan     0.1000 -20091.5497
         6 38620568.7175             nan     0.1000 31958.8977
         7 38499585.0701             nan     0.1000 92061.0588
         8 38438806.7700             nan     0.1000 -21210.6084
         9 38362436.3040             nan     0.1000 -13095.6940
        10 38307289.7597             nan     0.1000 1416.9584
        20 37805815.4742             nan     0.1000 -131292.6696
        40 36950412.0031             nan     0.1000 -13512.5112
        60 36340164.2982             nan     0.1000 -71206.3272
        80 35832202.9175             nan     0.1000 -47150.6747
       100 35553868.1488             nan     0.1000 -87537.0455
       120 35202575.4925             nan     0.1000 -36871.3261
       140 34980010.7893             nan     0.1000 -63605.8046
       160 34710415.5340             nan     0.1000 -44352.6666
       180 34508738.6740             nan     0.1000 -83354.9115
       200 34265284.8465             nan     0.1000 -85547.6842

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 39320684.5841             nan     0.1000 37310.2173
         2 39077562.0909             nan     0.1000 27621.6548
         3 38910989.2814             nan     0.1000 8294.1381
         4 38622531.6160             nan     0.1000 -77915.7424
         5 38440604.3336             nan     0.1000 -96139.0497
         6 38219474.5639             nan     0.1000 33981.9160
         7 38117080.0440             nan     0.1000 -27045.0080
         8 37868062.3249             nan     0.1000 -55855.1183
         9 37740920.8335             nan     0.1000 -116999.5631
        10 37623025.7425             nan     0.1000 -39707.1865
        20 36778605.1971             nan     0.1000 -67271.0390
        40 35505930.6335             nan     0.1000 -68803.5996
        60 34833345.8224             nan     0.1000 -51105.7580
        80 34193784.1683             nan     0.1000 -97712.5740
       100 33855721.2021             nan     0.1000 -169674.1263
       120 33456451.0234             nan     0.1000 -91451.0570
       140 33034585.4309             nan     0.1000 -139430.4772
       160 32833797.7237             nan     0.1000 -33447.7069
       180 32449164.8127             nan     0.1000 -74869.6300
       200 32143898.9149             nan     0.1000 -59722.7903

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 39491495.6331             nan     0.1000 195979.8942
         2 39146979.4720             nan     0.1000 241824.7940
         3 38958166.1664             nan     0.1000 38885.9550
         4 38671473.7976             nan     0.1000 103175.9076
         5 38562486.2952             nan     0.1000 -42309.1722
         6 38330124.4893             nan     0.1000 -45686.7110
         7 38031696.3164             nan     0.1000 -638.3677
         8 37882205.9591             nan     0.1000 -83358.3603
         9 37808849.0889             nan     0.1000 -171362.5334
        10 37665208.0229             nan     0.1000 36878.9317
        20 36510253.7326             nan     0.1000 -70964.3314
        40 35355925.3751             nan     0.1000 -156223.8681
        60 34322038.2887             nan     0.1000 -135161.8206
        80 33528271.3766             nan     0.1000 -61375.4362
       100 32771349.4771             nan     0.1000 -82264.1408
       120 32347805.3827             nan     0.1000 -308674.9403
       140 31773659.0617             nan     0.1000 -75337.9297
       160 31428882.7098             nan     0.1000 -235771.8842
       180 31181977.0161             nan     0.1000 -103237.8838
       200 30661093.0810             nan     0.1000 -141227.7897

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41208670.4672             nan     0.1000 244058.9530
         2 41045006.8581             nan     0.1000 181266.5006
         3 40780901.7663             nan     0.1000 42265.5108
         4 40643911.9623             nan     0.1000 118208.1214
         5 40528300.8514             nan     0.1000 72474.1328
         6 40411369.6621             nan     0.1000 111790.4745
         7 40374109.8780             nan     0.1000 -99664.4653
         8 40223373.0198             nan     0.1000 -59353.7696
         9 40136938.8755             nan     0.1000 36890.4669
        10 40069646.7880             nan     0.1000 -19591.3986
        20 39762454.0627             nan     0.1000 -14927.8188
        40 39420911.5642             nan     0.1000 -18643.1305
        60 39209420.4824             nan     0.1000 -21777.7913
        80 39076309.1318             nan     0.1000 -46304.7744
       100 38925976.5281             nan     0.1000 -71371.7267
       120 38798398.7501             nan     0.1000 -49160.9476
       140 38673612.9407             nan     0.1000 -50164.3276
       160 38532536.1628             nan     0.1000 -42019.2924
       180 38433035.4559             nan     0.1000 -43641.8473
       200 38346384.0712             nan     0.1000 -48233.5384

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41073067.2875             nan     0.1000 -8447.5402
         2 40837235.7191             nan     0.1000 87383.2926
         3 40664340.9734             nan     0.1000 38762.9487
         4 40428660.9643             nan     0.1000 -25257.0882
         5 40226893.5661             nan     0.1000 111228.5679
         6 40115299.2165             nan     0.1000 56157.5887
         7 40027702.2635             nan     0.1000 11435.2287
         8 39919089.7247             nan     0.1000 36340.7333
         9 39760200.6105             nan     0.1000 104665.0952
        10 39687783.0659             nan     0.1000 -24706.1730
        20 38965700.9176             nan     0.1000 -157174.1154
        40 38103891.5114             nan     0.1000 -13950.8891
        60 37299480.6908             nan     0.1000 -39287.6455
        80 36792925.9268             nan     0.1000 -57920.0128
       100 36338138.1996             nan     0.1000 -161418.3874
       120 35984172.6825             nan     0.1000 -113733.3426
       140 35742517.7873             nan     0.1000 -63978.6635
       160 35403010.1240             nan     0.1000 1177.5526
       180 35160661.3653             nan     0.1000 -54384.4947
       200 34891119.7711             nan     0.1000 -21005.0812

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41169275.7533             nan     0.1000 197817.9778
         2 40857102.7380             nan     0.1000 193046.1384
         3 40606958.1264             nan     0.1000 2301.8237
         4 40389779.1664             nan     0.1000 57667.3726
         5 40128024.7603             nan     0.1000 9219.2316
         6 39836660.5487             nan     0.1000 -18622.9962
         7 39725300.7908             nan     0.1000 -9406.7268
         8 39594431.4940             nan     0.1000 -49635.9294
         9 39437041.4472             nan     0.1000 14129.5383
        10 39374412.0854             nan     0.1000 -105224.4124
        20 38666598.2197             nan     0.1000 -49028.0646
        40 37430040.2867             nan     0.1000 -125425.6998
        60 36514020.8346             nan     0.1000 -14575.2676
        80 35537048.5109             nan     0.1000 -144943.6968
       100 34800696.3250             nan     0.1000 -45824.0183
       120 34392692.5991             nan     0.1000 -50332.8819
       140 33999575.9333             nan     0.1000 -91378.4431
       160 33521765.5208             nan     0.1000 -312503.5301
       180 33069171.9510             nan     0.1000 -78922.6259
       200 32602631.8026             nan     0.1000 -151687.1881

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41076059.3196             nan     0.1000 318067.6765
         2 40703665.8102             nan     0.1000 64878.9683
         3 40437883.8123             nan     0.1000 193224.6970
         4 40240633.7333             nan     0.1000 47663.6425
         5 40025167.7733             nan     0.1000 14409.7848
         6 39774736.5354             nan     0.1000 -114560.3569
         7 39611489.8674             nan     0.1000 68714.5468
         8 39451844.3910             nan     0.1000 104542.2324
         9 39287319.3178             nan     0.1000 11652.0136
        10 39115430.2077             nan     0.1000 -122938.3171
        20 37759745.2241             nan     0.1000 -108473.9388
        40 35891489.7667             nan     0.1000 -60775.8574
        60 35030644.4263             nan     0.1000 -62464.9195
        80 34434957.8571             nan     0.1000 -163749.4036
       100 33758550.4086             nan     0.1000 -189027.9017
       120 33079716.0292             nan     0.1000 -351337.4176
       140 32461375.3135             nan     0.1000 -156400.0643
       160 31969487.8265             nan     0.1000 -118786.4353
       180 31592075.6397             nan     0.1000 -38434.6813
       200 31134068.4463             nan     0.1000 -111140.1387

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 43127072.8872             nan     0.1000 259117.0218
         2 42943913.3542             nan     0.1000 192684.8991
         3 42747531.3141             nan     0.1000 181530.1972
         4 42632434.4577             nan     0.1000 144001.0652
         5 42531499.6160             nan     0.1000 40567.4950
         6 42453974.4119             nan     0.1000 89768.6819
         7 42296915.7483             nan     0.1000 91880.9623
         8 42177404.0785             nan     0.1000 28108.4328
         9 42097125.3368             nan     0.1000 49572.9116
        10 42022191.3899             nan     0.1000 50915.7331
        20 41647915.6942             nan     0.1000 -32306.9312
        40 41414956.5493             nan     0.1000 -37049.9410
        60 41097237.4798             nan     0.1000 -48399.1171
        80 40858293.9970             nan     0.1000 -39676.8342
       100 40610267.9219             nan     0.1000 -82973.5116
       120 40443101.7047             nan     0.1000 -21625.8278
       140 40307231.0656             nan     0.1000 -38118.6641
       160 40168828.1689             nan     0.1000 -25276.1583
       180 40022873.8502             nan     0.1000 -79023.0119
       200 39889911.1199             nan     0.1000 -22898.5021

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 43263226.1583             nan     0.1000 213232.9574
         2 42933584.8757             nan     0.1000 103404.2118
         3 42596442.7009             nan     0.1000 283439.1498
         4 42344143.4604             nan     0.1000 210516.9042
         5 42128287.3255             nan     0.1000 181980.3874
         6 41935723.9927             nan     0.1000 -2951.4434
         7 41749515.1938             nan     0.1000 90000.7061
         8 41655070.7442             nan     0.1000 7697.4771
         9 41491177.8315             nan     0.1000 87533.0033
        10 41333292.2744             nan     0.1000 -70188.2756
        20 40655187.5382             nan     0.1000 -156431.6747
        40 39809318.3055             nan     0.1000 -121132.6881
        60 39174655.4995             nan     0.1000 -78472.4054
        80 38723319.0199             nan     0.1000 -112464.9142
       100 38248893.3166             nan     0.1000 -68275.5958
       120 37798246.0850             nan     0.1000 -76215.4584
       140 37354129.0060             nan     0.1000 -121593.3186
       160 36935310.0464             nan     0.1000 -88308.7772
       180 36665348.6247             nan     0.1000 -67642.2923
       200 36375605.2564             nan     0.1000 -132142.2758

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 43110600.7851             nan     0.1000 365415.0884
         2 42709137.5447             nan     0.1000 39227.7241
         3 42247234.2098             nan     0.1000 64865.8981
         4 41975572.2442             nan     0.1000 -87971.1112
         5 41858224.7105             nan     0.1000 35042.8228
         6 41783495.6491             nan     0.1000 30697.4882
         7 41521449.6767             nan     0.1000 -202839.6091
         8 41341306.3069             nan     0.1000 62654.2034
         9 41198625.5528             nan     0.1000 -2321.1419
        10 41049623.0982             nan     0.1000 -8205.9690
        20 39853252.6738             nan     0.1000 -193510.5429
        40 38661571.0094             nan     0.1000 -71501.9018
        60 37565749.5616             nan     0.1000 -46781.2088
        80 36917555.1240             nan     0.1000 -106840.7623
       100 36312511.2511             nan     0.1000 -63410.4517
       120 35711898.3639             nan     0.1000 -56239.2542
       140 35277043.8533             nan     0.1000 -68120.2275
       160 34900564.9570             nan     0.1000 -76458.5953
       180 34360822.3677             nan     0.1000 -47799.1027
       200 33962036.7201             nan     0.1000 -44063.9905

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 42909893.3709             nan     0.1000 279932.2830
         2 42475202.9862             nan     0.1000 76600.5116
         3 42019239.2994             nan     0.1000 28296.3000
         4 41746310.0176             nan     0.1000 26266.9032
         5 41386859.4581             nan     0.1000 -47152.0535
         6 41089823.8379             nan     0.1000 -66726.9094
         7 40895497.1381             nan     0.1000 -156120.2885
         8 40742173.5266             nan     0.1000 -2981.7881
         9 40579739.9691             nan     0.1000 -138101.0406
        10 40448485.8309             nan     0.1000 14795.8247
        20 39431161.7615             nan     0.1000 -31125.6760
        40 38250409.9765             nan     0.1000 -44921.3740
        60 36822362.2199             nan     0.1000 -225076.6081
        80 35848830.4007             nan     0.1000 -187206.8971
       100 35005219.6347             nan     0.1000 -129008.2645
       120 34275048.7046             nan     0.1000 -114740.1927
       140 33563375.4925             nan     0.1000 -57334.0929
       160 32937674.2798             nan     0.1000 -154318.8431
       180 32433896.8090             nan     0.1000 1961.4268
       200 31929947.6967             nan     0.1000 -119264.2313

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 25603355.2720             nan     0.1000 245275.9117
         2 25428334.4603             nan     0.1000 11312.1881
         3 25194117.8390             nan     0.1000 199991.3460
         4 25022109.3907             nan     0.1000 107438.1331
         5 24800618.7488             nan     0.1000 -2815.8204
         6 24679089.7794             nan     0.1000 2641.9544
         7 24570672.5467             nan     0.1000 52303.4539
         8 24549376.4093             nan     0.1000 -5047.1246
         9 24499149.4862             nan     0.1000 48572.3102
        10 24427859.9392             nan     0.1000 56653.6118
        20 24183514.4483             nan     0.1000 -66258.7441
        40 23773186.1272             nan     0.1000 -48974.1104
        60 23531750.6662             nan     0.1000 -20462.1133
        80 23295079.3609             nan     0.1000 -78099.2325
       100 23170828.8990             nan     0.1000 -22258.0574
       120 23055079.4894             nan     0.1000 -33847.6972
       140 22912964.1937             nan     0.1000 -35691.6519
       160 22695301.7031             nan     0.1000 -53448.0606
       180 22569588.7208             nan     0.1000 -19185.8618
       200 22501298.5552             nan     0.1000 -45267.1503

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 25599207.6611             nan     0.1000 179774.7912
         2 25155679.1272             nan     0.1000 118251.1608
         3 24957127.2316             nan     0.1000 137193.6505
         4 24694069.0587             nan     0.1000 143473.2929
         5 24518317.7597             nan     0.1000 71972.3473
         6 24450487.5330             nan     0.1000 16960.6354
         7 24353273.3196             nan     0.1000 81632.2767
         8 24107330.7960             nan     0.1000 -49340.2853
         9 24001168.2839             nan     0.1000 73256.9553
        10 23952672.7991             nan     0.1000 -14708.9040
        20 23218976.2914             nan     0.1000 -51390.4191
        40 22613888.6132             nan     0.1000 -52470.5858
        60 22014748.4614             nan     0.1000 -107321.2329
        80 21624996.6250             nan     0.1000 -83349.5018
       100 21278347.5596             nan     0.1000 -83592.4055
       120 20924493.4369             nan     0.1000 -73814.3393
       140 20639038.9543             nan     0.1000 -42052.8195
       160 20287233.7732             nan     0.1000 -25650.4470
       180 20007456.1990             nan     0.1000 -94461.8789
       200 19741394.3552             nan     0.1000 -43655.5366

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 25340384.2808             nan     0.1000 143410.9538
         2 25167221.6487             nan     0.1000 86149.8089
         3 24944757.9563             nan     0.1000 107006.5302
         4 24830570.0894             nan     0.1000 119908.0520
         5 24530714.7669             nan     0.1000 64591.8504
         6 24307141.3215             nan     0.1000 65641.1228
         7 24093358.2104             nan     0.1000 -4086.2874
         8 23967437.7821             nan     0.1000 100708.5693
         9 23858644.4424             nan     0.1000 28927.5495
        10 23827772.2654             nan     0.1000 -53956.9245
        20 23017584.7894             nan     0.1000 -41793.6216
        40 22014573.9555             nan     0.1000 -89929.5774
        60 21462723.7372             nan     0.1000 -113242.2929
        80 20944923.5336             nan     0.1000 -71649.1269
       100 20419114.4502             nan     0.1000 -8966.3125
       120 19969818.5024             nan     0.1000 -78242.9344
       140 19517139.4789             nan     0.1000 -40512.7811
       160 19150934.6877             nan     0.1000 -49352.6817
       180 18744966.2377             nan     0.1000 -28964.7058
       200 18444295.0556             nan     0.1000 -150600.7538

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 25331907.7702             nan     0.1000 124562.9850
         2 24894565.3502             nan     0.1000 203576.2097
         3 24649535.4035             nan     0.1000 85030.1495
         4 24486133.6374             nan     0.1000 28909.1249
         5 24329821.4350             nan     0.1000 63548.6580
         6 24017585.5806             nan     0.1000 55399.1609
         7 23810088.0432             nan     0.1000 -89021.9839
         8 23621268.1586             nan     0.1000 -98387.1632
         9 23529800.0511             nan     0.1000 46317.3225
        10 23375223.0912             nan     0.1000 -8902.8160
        20 22717395.0040             nan     0.1000 -66138.2142
        40 21582106.1619             nan     0.1000 -122127.0055
        60 20911707.4050             nan     0.1000 -66032.7496
        80 20234224.7714             nan     0.1000 -117305.6576
       100 19633795.3107             nan     0.1000 -125111.3005
       120 19135458.8249             nan     0.1000 -74272.0734
       140 18617229.1373             nan     0.1000 -142018.5774
       160 18181608.4617             nan     0.1000 -47331.9408
       180 17720519.9599             nan     0.1000 -140236.5022
       200 17368265.3555             nan     0.1000 -52372.4287

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 38260089.3666             nan     0.1000 202270.5297
         2 38087737.8398             nan     0.1000 185002.4066
         3 37879215.0396             nan     0.1000 126426.1569
         4 37733228.1564             nan     0.1000 104782.2047
         5 37607828.7458             nan     0.1000 94630.2869
         6 37497877.0097             nan     0.1000 42415.5074
         7 37404234.0564             nan     0.1000 82676.3229
         8 37399516.5142             nan     0.1000 -24997.1007
         9 37319104.2759             nan     0.1000 71963.6423
        10 37296047.1397             nan     0.1000 16461.6887
        20 36965293.4198             nan     0.1000 -64676.7131
        25 36893604.5690             nan     0.1000 -50295.3948

``` r
test_pred_boosted <- predict(boosted, newdata = ChannelTest)
m4 <- postResample(test_pred_boosted, ChannelTest$shares)
m4
```

            RMSE     Rsquared          MAE 
    3.457764e+03 2.313775e-02 2.343574e+03 

Next we do a comparison of the four models

# Comaprison

The `postResample()` function was used to calculate useful statistics
such as rmse and R squared values for each one of the four models. We
summarize them in the tibble below.

``` r
lm1 <- tibble(model = c("First linear regression"), RMSE = c(m1[[1]]), R2 = c(m1[[2]]))
lm2 <- tibble(model = c("Second linear regression"), RMSE = c(m2[[1]]), R2 = c(m2[[2]]))
rf <- tibble(model = c("Random Forest"), RMSE = c(m3[[1]]), R2 = c(m3[[2]]))
Bos <- tibble(model = c("Boosting"), RMSE = c(m4[[1]]), R2 = c(m4[[2]]))
RMSE_table <- rbind(lm1, lm2, rf, Bos)
RMSE_table
```

    # A tibble: 4 × 3
      model                     RMSE      R2
      <chr>                    <dbl>   <dbl>
    1 First linear regression  3489. 0.00110
    2 Second linear regression 3467. 0.0112 
    3 Random Forest            3465. 0.0142 
    4 Boosting                 3458. 0.0231 

RMSE is a metric that tells us how far apart the predicted values are
from the observed values in a dataset, on average. The lower the RMSE,
the better a model fits a dataset.

R2 is a metric that tells us the proportion of the variance in the
response variable of a regression model that can be explained by the
predictor variables. This value ranges from 0 to 1. The higher the R2
value, the better a model fits a dataset.

From the table above the First linear regession model has the lowest
RMSE and the hightest R2 and is therefore our winner.

``` r
#pick the smallest RMSE for the best model...
final_result <- RMSE_table %>%
                filter ( min(RMSE) == RMSE )
final_result
```

    # A tibble: 1 × 3
      model     RMSE     R2
      <chr>    <dbl>  <dbl>
    1 Boosting 3458. 0.0231

When comparing all 4 of our models, we are looking for the smallest
value of RMSE to tell us which model is the best. In this situation, we
can say that the smallest RMSE is 3457.7643075 and this comes from the
Boosting model.

<!-- # Project Work -->
<!-- The first step is for the first group member to create a github repo and add the second group member as a collaborator. The second group member then needs to accept the membership. This gives everyone access to push changes up to the repository. All project work should be done within this repo. -->
<!-- Each time you go to work on the project, you should pull down any of the latest changes using git pull. You should then upload any changes you’ve made via the usual workflow done previously. There may occasionally be merge conflicts that have to be dealt with. This can be done with the Git tab in RStudio. Let us know if you are having issues with conflicts that you can’t resolve! -->
<!-- # Repo Setting -->
<!-- On your project repo you should go into the settings and enable github pages (feel free to select a theme too!). This will make it so your repo can be accessed like your blog (username.github.io/repo-name). Be sure to choose the master or main branch as the one to use if you have choices there. -->
<!-- You’ll be automating the creation of documents using R Markdown (one for each data_channel_is_* setting, i.e. type of article in the data set provided). Each document should be rendered as a github_document from a single .Rmd file. In the README.md file you should create links to each of the documents you will create (Lifestyle analysis, Entertainment analysis, etc.). Links can be made to the sub-documents using relative -->
<!-- paths. For instance, if you have all of the outputted .md files in the main directory you would just use markdown linking: -->
<!-- - The analysis for [Lifestyle articles is available here](LifestyleAnalysis.html). Note we -->
<!-- link to the html file even though the file we create is a .md file - github creates the .html for us. -->
<!-- In the repo’s README.md file (which doesn’t need to be created from a .Rmd file, just use the one you initialize into the repo if you want) give a brief description of the purpose of the repo, a list of R packages used, links to the generated analyses, and the code used to create the analyses from a single .Rmd file (i.e. the render() code). -->

# Blog

Once you’ve completed the project each of you should write a brief blog
post outlining your project and two links to the
username.github.io/repo-name site and the repo itself (the username may
correspond to your partner). You should then also reflect on the process
you went through. Discuss the following:

-   what would you do differently?  
-   what was the most difficult part for you?  
-   what are your big take-aways from this project?

<!-- # Topic -->
<!-- What are you actually doing? You’ll read in and analyze an online news popularity data set. You’ll subset the data by data_channel_is_* (one of six groups). Then you’ll summarize the data and try to predict the number of shares using predictive models. -->
<!-- 1. Read in the OnlineNewsPopularity.csv data file -- subset for data_channel_is_lifestyle: Is data channel 'Lifestyle'? -->
<!-- Here, `read_csv()` is used to read in the OnlineNewsPopularity.csv data and we are subsetting for the `data_channel_is_lifestyle`: Is data channel 'Lifestyle'? variable.  -->
<!-- ``` {r, echo=TRUE, eval=TRUE} -->
<!-- #install one time thing -->
<!-- #install.packages("caret") -->
<!-- #read in data set .csv file in full -->
<!-- #OnlineNewsPopularity <- readr::read_csv(file="OnlineNewsPopularity.csv",  -->
<!-- #                                        show_col_types = FALSE) -->
<!-- ``` -->
<!-- ``` {r, echo=TRUE, eval=TRUE} -->
<!-- #subsetting the data for`data_channel_is_lifestyle`: Is data channel 'Lifestyle'? -->
<!-- #Lifestyle <- OnlineNewsPopularity %>%  -->
<!-- #              filter( data_channel_is_lifestyle == 1) -->
<!-- ``` -->
<!-- # Report -->
<!-- Recommendation: At first, consider just using data from a single data_channel_is_* source. Once you have all of the below steps done for that data, then you can automate it to work with any chosen data channel. Note: It may be easier to create a single variable representing the data channel when automating the subsetting (although there are many ways to do this).   -->
<!-- - All code chunks should be shown unless they are setup code chunks.   -->
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

<!-- Once you’ve completed the above for a particular data channel, adapt the code so that you can use a parameter in your build process. You should be able to automatically generate an analysis report for each data_channel_is_* variable - although again, you may want to create a new variable to help with the subsetting. You’ll end up with six total outputted documents. -->
<!-- This should be done by the group member that doesn’t automate the comparison of models part. -->

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
<!-- code needed to render pdf file -->
