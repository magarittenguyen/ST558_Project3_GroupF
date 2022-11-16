ST558 Project 3 Group F: Tech Summary Report
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
data_channel_is_tech: Is data channel ‘Tech’?
<!-- str_to_title("social media") ->> "Social Media" -->

Here, `read_csv()` is used to read in the OnlineNewsPopularity.csv data
and we are subsetting for the data_channel_is_tech: Is data channel
‘Tech’? variable.

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

We now subset the data for the data channel of interest: Tech.

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

    # A tibble: 7,346 × 59
       n_toke…¹ n_tok…² n_uni…³ n_non…⁴ n_non…⁵ num_h…⁶ num_s…⁷ num_i…⁸ num_v…⁹ avera…˟ num_k…˟
          <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
     1       13    1072   0.416    1.00   0.541      19      19      20       0    4.68       7
     2       10     370   0.560    1.00   0.698       2       2       0       0    4.36       9
     3       12     989   0.434    1.00   0.572      20      20      20       0    4.62       9
     4       11      97   0.670    1.00   0.837       2       0       0       0    4.86       7
     5        8    1207   0.411    1.00   0.549      24      24      42       0    4.72       8
     6       13    1248   0.391    1.00   0.523      21      19      20       0    4.69      10
     7       11    1154   0.427    1.00   0.573      20      20      20       0    4.63       7
     8        8     266   0.573    1.00   0.721       5       2       1       0    4.26      10
     9        8     331   0.563    1.00   0.724       5       3       1       0    4.78       9
    10       12    1225   0.385    1.00   0.509      22      22      28       0    4.64       9
    # … with 7,336 more rows, 48 more variables: data_channel_is_lifestyle <dbl>,
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
    7346 

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
     0.0000  0.0000  0.0000  0.1646  0.0000  1.0000 

``` r
# 32. weekday_is_tuesday: Was the article published on a Tuesday?
summary(ChannelTrain$weekday_is_tuesday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.2004  0.0000  1.0000 

``` r
# 33. weekday_is_wednesday: Was the article published on a Wednesday?
summary(ChannelTrain$weekday_is_wednesday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1946  0.0000  1.0000 

``` r
# 34. weekday_is_thursday: Was the article published on a Thursday?
summary(ChannelTrain$weekday_is_thursday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1778  0.0000  1.0000 

``` r
# 35. weekday_is_friday: Was the article published on a Friday?
summary(ChannelTrain$weekday_is_friday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1386  0.0000  1.0000 

``` r
# 36. weekday_is_saturday: Was the article published on a Saturday?
summary(ChannelTrain$weekday_is_saturday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      0.000   0.000   0.000   0.069   0.000   1.000 

``` r
# 37. weekday_is_sunday: Was the article published on a Sunday?
summary(ChannelTrain$weekday_is_sunday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      0.000   0.000   0.000   0.055   0.000   1.000 

``` r
# 38. is_weekend: Was the article published on the weekend? 
summary(ChannelTrain$is_weekend)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      0.000   0.000   0.000   0.124   0.000   1.000 

``` r
# 60. shares: Number of shares (target)
summary(ChannelTrain$shares)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
         36    1100    1700    3132    3000  663600 

``` r
#contigency tables
# example: table (crabs$color, crabs$spine, crabs$y)
# monday is the mot published articels... compare to diff of the week
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_tuesday)
```

       
           0    1
      0 3267 1031
      1  847    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_wednesday)
```

       
           0    1
      0 3297 1001
      1  847    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_thursday)
```

       
           0    1
      0 3383  915
      1  847    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_friday)
```

       
           0    1
      0 3585  713
      1  847    0

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
                        1.514e+03                      5.520e+01  
                 n_tokens_content                n_unique_tokens  
                        1.448e+00                     -3.157e+02  
                 n_non_stop_words       n_non_stop_unique_tokens  
                        2.782e+03                     -1.072e+03  
                        num_hrefs                 num_self_hrefs  
                        8.246e+01                     -1.014e+02  
                         num_imgs                     num_videos  
                       -3.858e+01                      1.332e+02  
             average_token_length                   num_keywords  
                       -3.552e+02                     -3.191e+01  
        data_channel_is_lifestyle  data_channel_is_entertainment  
                               NA                             NA  
              data_channel_is_bus         data_channel_is_socmed  
                               NA                             NA  
             data_channel_is_tech          data_channel_is_world  
                               NA                             NA  
                       kw_min_min                     kw_max_min  
                        4.724e+00                      1.562e-01  
                       kw_avg_min                     kw_min_max  
                       -1.610e+00                     -1.831e-03  
                       kw_max_max                     kw_avg_max  
                        7.889e-04                     -4.094e-03  
                       kw_min_avg                     kw_max_avg  
                       -1.404e-01                     -1.461e-01  
                       kw_avg_avg      self_reference_min_shares  
                        1.381e+00                     -7.069e-03  
        self_reference_max_shares     self_reference_avg_sharess  
                       -5.286e-03                      1.582e-02  
                weekday_is_monday             weekday_is_tuesday  
                       -5.895e+02                     -5.912e+02  
             weekday_is_wednesday            weekday_is_thursday  
                       -1.326e+02                     -8.057e+02  
                weekday_is_friday            weekday_is_saturday  
                       -5.070e+02                     -2.335e+02  
                weekday_is_sunday                     is_weekend  
                               NA                             NA  
                           LDA_00                         LDA_01  
                        2.013e+03                      3.255e+01  
                           LDA_02                         LDA_03  
                        5.005e+01                      2.459e+02  
                           LDA_04            global_subjectivity  
                               NA                      5.906e+02  
        global_sentiment_polarity     global_rate_positive_words  
                        4.768e+02                     -1.878e+04  
       global_rate_negative_words            rate_positive_words  
                        8.114e+03                     -1.230e+03  
              rate_negative_words          avg_positive_polarity  
                               NA                     -9.890e+02  
            min_positive_polarity          max_positive_polarity  
                       -7.232e+02                     -5.821e+01  
            avg_negative_polarity          min_negative_polarity  
                       -1.030e+04                      4.141e+03  
            max_negative_polarity             title_subjectivity  
                        7.037e+03                     -2.377e+01  
         title_sentiment_polarity         abs_title_subjectivity  
                        6.879e+02                     -7.892e+02  
     abs_title_sentiment_polarity  
                       -3.252e+02  

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
       791.770148    340.789950   1630.901485   3166.218235  18372.535932   3223.326087 
                7             8             9            10            11            12 
       437.823295     -6.958111   2614.725133   2066.959660   5020.063505   1316.949949 
               13            14            15            16            17            18 
      8850.428844   2274.318592   1303.157401   5480.348732   1391.559757   2654.196902 
               19            20            21            22            23            24 
      1653.908899   1927.585959   5089.171830   1454.657442   2228.014930   3023.044260 
               25            26            27            28            29            30 
      1621.789165   2110.307017   -104.781545   1561.544173   1511.676651   1177.972891 
               31            32            33            34            35            36 
      1237.150359   1298.678196   3250.968408    -32.084053   2943.569180   1911.127927 
               37            38            39            40            41            42 
      3400.996468   -279.870400    523.319123   -374.328569  -1479.463209  -1989.061423 
               43            44            45            46            47            48 
     -1941.721788  -1308.244429   -722.504932  -1337.432730  -1364.990423    195.944890 
               49            50            51            52            53            54 
       149.715092   1476.075286  -1761.465946     -1.643128    705.861601   3798.819091 
               55            56            57            58            59            60 
     -1348.261490   -221.582627   -957.003399  -1414.484867    567.296883   -611.008069 
               61            62            63            64            65            66 
      2217.699948   -678.448592    109.803254   -957.217291   -305.602413   1457.587293 
               67            68            69            70            71            72 
      -518.364029   -385.270537   5105.075166    709.307772     39.595800    587.655055 
               73            74            75            76            77            78 
       353.841442    322.757943    757.531728    199.678891  -1792.816747   -821.775342 
               79            80            81            82            83            84 
     -1628.671269  -1485.901369   -819.779087   2036.892048    171.611039   -594.131255 
               85            86            87            88            89            90 
     -1052.790008    -93.025931   1326.771048   1302.372380    861.218109  -2178.626275 
               91            92            93            94            95            96 
       582.983490  -1026.523088   1404.355934   -839.596402  -2604.458220  -1194.091650 
               97            98            99           100           101           102 
      -956.554053   -128.713602  -1092.090936   -761.520223   -956.988287  -1756.205233 
              103           104           105           106           107           108 
      1355.096181  -1696.089463    926.735175   1084.201002   -590.841493   1335.745268 
              109           110           111           112           113           114 
      8144.350548   -913.681917   6601.835910  -1659.916260  -3414.405309   -106.397276 
              115           116           117           118           119           120 
     -2747.079096   -526.126572   1370.814120  -1429.270800   2873.347177  -2046.654046 
              121           122           123           124           125           126 
      1126.666725  -2204.846487    -73.381910   2210.630601   -469.554815   1292.070610 
              127           128           129           130           131           132 
      -665.833463   -991.885165  14447.120350   -291.310947    703.881325  -2695.433296 
              133           134           135           136           137           138 
      -815.944743  -1825.815394    653.667255    384.417760  -2330.228473  -2683.571270 
              139           140           141           142           143           144 
     -2182.022703  -2667.858171  -3404.064699   2294.768528  -2018.570278  -3606.302939 
              145           146           147           148           149           150 
      9273.418153    -91.073753  -1174.358075  -1323.072610  -1537.792478    604.058851 
              151           152           153           154           155           156 
     -3369.208572   -500.740633   -465.308362  -2019.421211  -2491.380942  -1403.732581 
              157           158           159           160           161           162 
     -1744.348124     13.666415   1747.238587  -1641.088455     96.121212   1165.004564 
              163           164           165           166           167           168 
        -2.572894    439.835532    164.932246   5157.244268    902.901789  -1106.113189 
              169           170           171           172           173           174 
      -578.575662  -1177.224443    848.885736  -1144.234753  -3819.482633    733.750439 
              175           176           177           178           179           180 
      5066.210172   5581.873479   1012.914744  -3911.461287   -448.860226     28.761117 
              181           182           183           184           185           186 
       -15.977669    307.946069   1529.109407    662.853670  -2682.341208   -885.206716 
              187           188           189           190           191           192 
      3251.853565    723.934665   4021.452815   -389.065089   4030.671342    506.184180 
              193           194           195           196           197           198 
      9265.178263   5180.319267  -2246.847036  -1416.378045  20018.423199   1511.462531 
              199           200           201           202           203           204 
     -2677.375574  -1724.821793  -1708.091035  -1607.711542   2503.860851   -974.650196 
              205           206           207           208           209           210 
     -1036.846509   -975.952894  -1033.738514  -1692.853113  -1936.352859    667.536088 
              211           212           213           214           215           216 
     -3909.819323  -1107.138118  -2648.460141  -2127.026877  -4330.455664   4661.469205 
              217           218           219           220           221           222 
     -1147.586731  -1603.406370  -2644.189870   3342.805239  -4166.668006  -3652.771900 
              223           224           225           226           227           228 
     -1288.556265  36321.086017  -3204.673359  -3053.145348    135.473192  -4317.578365 
              229           230           231           232           233           234 
     -1526.913994   1445.166762  -1732.032946  -1663.881076   2423.109399   2063.388600 
              235           236           237           238           239           240 
     -1225.475103    291.461120    388.077708    396.295918  -1727.474427   2135.782643 
              241           242           243           244           245           246 
      5556.224422  -1541.779092  -1235.461666  -2298.918385   -463.683916   1280.859177 
              247           248           249           250           251           252 
      3445.986101  -1650.985834    577.544059  -3076.293522  -2281.941261  -2251.970816 
              253           254           255           256           257           258 
      4826.540980  -1742.562872   5453.696419   3847.187899  -2111.099118  -1496.608266 
              259           260           261           262           263           264 
       914.905108   -808.237719   3774.619133   1105.403491   -671.781788    480.836988 
              265           266           267           268           269           270 
      1517.709784  -2228.412095  -2074.897626  -1440.427076  -2591.741698  -2060.284799 
              271           272           273           274           275           276 
       682.008771  -1069.228095    987.926308   1250.635618   1135.442190  -1255.737778 
              277           278           279           280           281           282 
     -2060.471069  -1624.021014  -1769.168274  -1583.116093   1749.722606   -333.832542 
              283           284           285           286           287           288 
     -3621.898552  -2269.756337  -1850.421486  -1478.381680  -3452.893095  -1223.317302 
              289           290           291           292           293           294 
     -1340.432751  -3013.366824  -3115.621480    -41.678327  -1682.362854   -395.571404 
              295           296           297           298           299           300 
     -2823.902572    -95.664689  -1138.553799     35.383974  -2880.600747   6924.904430 
              301           302           303           304           305           306 
     -1230.748078  -1914.649672   -792.346002  -3708.886904  -3914.341802  -1317.673829 
              307           308           309           310           311           312 
      5875.275929  -2130.493154  -1128.657891  -1733.727442  -4031.385322  -1956.228845 
              313           314           315           316           317           318 
      -868.107262  -1220.211963   -863.075150  -2574.842472    560.008723  -2126.024819 
              319           320           321           322           323           324 
     -1329.959873    353.653467  -1086.224583    -58.528994   -841.004651    396.100279 
              325           326           327           328           329           330 
      -341.514920    926.653037   3766.884563  12170.019427  -1108.393883  -2130.801133 
              331           332           333           334           335           336 
      -467.593002   -366.634335  38957.293678  -3315.665825  -2148.507175  -1807.526688 
              337           338           339           340           341           342 
      -377.927976  -1546.704168    254.945487   1860.274830   3765.876452  -2153.821537 
              343           344           345           346           347           348 
     -1207.317646   1255.202869  -2478.375817  -3042.867494  -1880.392392   -228.578986 
              349           350           351           352           353           354 
       231.819293   1991.869764  -1288.122285  -1454.339761  -2719.538280  -1839.573353 
              355           356           357           358           359           360 
     -2532.029820  -4598.141902  -2118.219557  -1465.890154   -959.326845    233.888507 
              361           362           363           364           365           366 
     -1695.186997  -3067.638905   -633.489320  -1432.713947  -3577.048626   -659.116664 
              367           368           369           370           371           372 
     -3015.185715 -15024.466757  -2244.875543  -1340.985096   -758.624257   3460.246376 
              373           374           375           376           377           378 
       129.417694   2914.318804   1915.631542  -1327.574320  -3903.912814   5031.230321 
              379           380           381           382           383           384 
      -626.529460   -676.471570  -1898.895637  -3158.771274    928.055490   -469.354733 
              385           386           387           388           389           390 
     -1471.447253  -1646.383864  -1160.281340     63.679170  -4695.040741  -2260.063765 
              391           392           393           394           395           396 
     -1191.250244  -1234.584876   1520.663935  -1584.456253    587.105127  -1853.824578 
              397           398           399           400           401           402 
      1658.609971  -2298.230657   5460.498455  -1757.391106   6498.027968   8336.787983 
              403           404           405           406           407           408 
      -887.626726  -3235.676197  13100.946812   -358.981289  -3489.892748  -1514.216581 
              409           410           411           412           413           414 
      -154.760309   -391.771212   -639.760909   -911.681486  -1222.302623  -2647.457070 
              415           416           417           418           419           420 
     -1850.724711   -260.145063   -512.614610  -1505.982253   -740.628285  -3574.367426 
              421           422           423           424           425           426 
      1914.060711    202.267316  -2716.199766     26.781393   -472.086862  15894.079351 
              427           428           429           430           431           432 
     -2228.404323   4494.950971  -2249.142397   -820.148156  -3244.585958  -1714.692203 
              433           434           435           436           437           438 
     -1527.844923  12753.317146  -3034.149750  -2589.392591   4319.440360  -2799.333248 
              439           440           441           442           443           444 
     -1835.102045  -3160.062725  -3087.150369  -3020.810419    701.595462  -2070.175939 
              445           446           447           448           449           450 
      1103.274068  -2069.526844  -2467.663326  -1598.817262  -1427.543248  -1880.549945 
              451           452           453           454           455           456 
      -734.684874   1143.572632   -226.976381  -3240.060685  -1063.789634  -2076.857631 
              457           458           459           460           461           462 
     -1140.867058  -2511.356471  -1790.575302  -2134.829736  -4194.634206    206.694111 
              463           464           465           466           467           468 
     -2602.033232   3121.803400   -991.487416  -1452.368730  -2519.572455   1065.384862 
              469           470           471           472           473           474 
      -566.161072  -4050.132483  -2781.379364  -1373.609944  -1445.760666   2354.996345 
              475           476           477           478           479           480 
     -1516.043841  -1647.574566   -121.230953   1371.761410   3419.268629  -2213.958844 
              481           482           483           484           485           486 
     -2961.553518  -1225.223902  -1242.137073  -8157.609202    236.936418   1017.979889 
              487           488           489           490           491           492 
     -2935.863145   5298.816319  -1561.489770  -1368.992788    454.771677  -1035.787509 
              493           494           495           496           497           498 
      -678.592431  -1343.232594  38773.770295   7605.297968  -2999.117729  -1527.880992 
              499           500           501           502           503           504 
     -3047.316722   1963.078977   -111.979269  -1190.064351  -1275.752065  -1853.894409 
              505           506           507           508           509           510 
     -1472.644079   -279.844238  -3008.646314   -641.853720   1146.337463  -2656.736138 
              511           512           513           514           515           516 
      1378.816335  -1984.840840  -5195.753135  -2211.134103   3752.144163  -2802.648939 
              517           518           519           520           521           522 
     -2153.116848   4230.909010  -3714.356727  -1941.326614  -2553.275364  -2336.856265 
              523           524           525           526           527           528 
     -2740.718428   1679.899888   1427.030156  -2238.753087  23613.198148    478.687908 
              529           530           531           532           533           534 
     -2669.189903  -1191.372459   3956.031411   1045.494790  -4343.889235    451.673566 
              535           536           537           538           539           540 
     -1621.637165   1593.904210  -1735.370822   -736.362115  -2113.343121  -2638.349273 
              541           542           543           544           545           546 
     13549.854230   1025.288439   -365.052901  -1894.035970  -3779.300576  -1310.924150 
              547           548           549           550           551           552 
      -297.449503  -1255.948235   -512.168295  -1576.102434  -1056.564659  -1987.398713 
              553           554           555           556           557           558 
     -2187.350425  -1791.179900  -2064.110827   -634.783683   -838.100571   7626.908532 
              559           560           561           562           563           564 
     -3880.010732  -2609.222971  -1695.797918  -3360.197034    350.703559   1005.337169 
              565           566           567           568           569           570 
        87.440035  -1857.091486  -1984.792148  24473.758729  -2203.491328    -42.288196 
              571           572           573           574           575           576 
     -2041.285024    -60.143805   -808.451461   1130.618995  -2274.502320  -2850.271534 
              577           578           579           580           581           582 
     -1436.780023  -2395.686666   -355.037859  -2287.683051  -1921.535342  -1197.071911 
              583           584           585           586           587           588 
     -7278.824682  -2532.855663  -2102.018202  -1116.577948  -1350.587610  -1091.338293 
              589           590           591           592           593           594 
     -2445.503715  -2123.516692  -1727.569120  -1492.060179  -1465.324515  -1477.849072 
              595           596           597           598           599           600 
      -532.360972    348.334829   -744.360065   3528.373051     92.030777  -2008.393856 
              601           602           603           604           605           606 
     -1671.549618  -1262.294333  -1914.978453    395.918648     -6.724957   -431.851578 
              607           608           609           610           611           612 
      -630.580368  -1354.390365  -2898.418303   -380.657820   6879.285573  -1965.053804 
              613           614           615           616           617           618 
     -3013.008969  -1314.407775   -980.166733   -565.372680  -1340.735107   5442.663605 
              619           620           621           622           623           624 
     28092.299586  -1989.826538  -1477.674366   8400.265490  23511.296379    160.353028 
              625           626           627           628           629           630 
     -3471.038927  -2062.847565  -2314.495449  16416.903597  -1948.423250  -3032.580797 
              631           632           633           634           635           636 
       253.821412  -2315.036093   -999.231392    -26.137122  -1450.513744  -1844.584590 
              637           638           639           640           641           642 
     -2035.799554    959.692655  -2570.630373   -502.868254  -3761.885730    373.362492 
              643           644           645           646           647           648 
      -171.181771  -1509.124112    931.490256   -685.404673  -3876.990741    382.748917 
              649           650           651           652           653           654 
       871.695670  -1795.454876  -3362.845500   3421.259999    135.542013   -992.262830 
              655           656           657           658           659           660 
     -2528.237123  -1625.832684  -3545.033507  -1655.654449   -582.031779    457.034201 
              661           662           663           664           665           666 
     10734.032593  21514.596320   2792.176141  -1750.422958  -4200.082763   -493.113591 
              667           668           669           670           671           672 
     -2007.264283   -874.217403  -2388.693168  -2088.304344  -2455.225589   -741.828461 
              673           674           675           676           677           678 
      -237.275619  -2449.165651   -671.889978   6910.823908  -6020.899317   -538.584368 
              679           680           681           682           683           684 
      -987.169581  -5444.273160  -3225.860158  -3374.239750  -2520.272905   5892.621300 
              685           686           687           688           689           690 
     -2230.792621   1222.834385  -1193.438225    -68.841933  -3228.392913  -2999.076098 
              691           692           693           694           695           696 
      -379.019141  -2727.391991  -4283.772361  -1858.159799  -3529.021267  -1797.080013 
              697           698           699           700           701           702 
      -928.250754  -2070.458219  -4246.077559  -2799.264252   -994.014886   1028.782375 
              703           704           705           706           707           708 
     -1292.933843   7383.027338  -1132.640590   -658.352124  10521.762979   -473.350537 
              709           710           711           712           713           714 
     -1305.936958   -415.071232  -1363.617932   -427.072389  -3333.412051  -2142.008366 
              715           716           717           718           719           720 
     -2271.346795  30458.232966  -1013.642630   -259.519625  -2334.953166   -624.075943 
              721           722           723           724           725           726 
     -2125.226954   -319.763328  -1935.842703  -2404.287241  -1496.097304  -3151.474924 
              727           728           729           730           731           732 
     -3042.025325  -1307.149025  -1308.066635  -1373.811793   -968.708524  -2609.499322 
              733           734           735           736           737           738 
      1181.239983  -1837.161984  -2610.413243  -2638.982270  -2384.356467  11107.887464 
              739           740           741           742           743           744 
      1672.655952  -1397.426331  -4384.165520  -1262.471233    346.176110   -986.017380 
              745           746           747           748           749           750 
     -2136.118798   -227.845330  -2379.224721  -2240.380283  -1726.213117    871.580353 
              751           752           753           754           755           756 
     -1594.234896   -802.625808  -1666.218598     19.251561  -2116.623800  -1305.845463 
              757           758           759           760           761           762 
     -1846.986846    744.398448  -3157.647652   2282.644584  -2046.289419    656.377884 
              763           764           765           766           767           768 
      5889.655148  -1788.824940  -1520.575509    438.203366  -2814.580185  -1672.320245 
              769           770           771           772           773           774 
       610.282245  -2739.312830  -3147.074617  -2775.843269  -3087.993378  -1685.024376 
              775           776           777           778           779           780 
      8800.337444   -883.333157  -2513.528859   7309.062604   -735.518526  -2687.010807 
              781           782           783           784           785           786 
     65187.389838  -1520.643682  -2999.646967  -1845.864113   5299.104598  -1894.902210 
              787           788           789           790           791           792 
     -1055.777116  -2237.569096  12009.781286  -2310.728052   1444.209145   2767.056890 
              793           794           795           796           797           798 
      5777.196472    177.230052   2148.544192    194.845743    418.187581  -3556.646609 
              799           800           801           802           803           804 
     17119.186420  -2437.083809  -4222.842929  -1002.117778  -1729.673130   2717.506473 
              805           806           807           808           809           810 
       466.371736  -3263.826124  -2567.451204    550.324869    -87.965020  -2310.262812 
              811           812           813           814           815           816 
     -1442.212626   -121.686517  33935.778409  30070.770023   -560.296028  -3810.229062 
              817           818           819           820           821           822 
       857.632379   -467.163186  -2081.947404  10377.390211   -900.066658   2289.268898 
              823           824           825           826           827           828 
      5535.627846   -536.508277  -3947.145147     60.432263    137.751430  -3339.270200 
              829           830           831           832           833           834 
      -343.109690  -2273.170377  -2662.259453  -1179.081113  -2983.576081   7902.187182 
              835           836           837           838           839           840 
     -2158.254234  17528.361338    402.267917   1236.624940  -1592.567339   1002.112312 
              841           842           843           844           845           846 
      1449.170089  -2670.733974   9945.872591  -3098.284871  -2019.815149   2758.013611 
              847           848           849           850           851           852 
     25083.217132    545.333137  -3449.064219   1244.859204  -2710.311020  -9244.434489 
              853           854           855           856           857           858 
     -1188.618813  -1944.584381  -1106.229148   2381.470239  -5112.486057  -1401.735421 
              859           860           861           862           863           864 
      -834.646433   5499.969508    -33.719103    541.745428  -1347.041985  -1491.363048 
              865           866           867           868           869           870 
     -2718.729955  -3706.502668  -1837.849764  -1633.636246  -1740.734587  23271.452263 
              871           872           873           874           875           876 
     -2974.839810   -634.343276   -153.954890  -2715.148549  -4759.514138  -2234.640364 
              877           878           879           880           881           882 
      1606.613492  -1035.822207  -4030.185003  -2817.812078  -1474.040265  -3064.008784 
              883           884           885           886           887           888 
     -2251.880035  -2661.190638   -725.962589  -3009.037570   -278.559796  -2968.243042 
              889           890           891           892           893           894 
     -1108.494256  -1150.668120  17470.630701  -3299.478279    587.233409  -2806.891739 
              895           896           897           898           899           900 
      -527.950685    -38.050170  -1967.049822  -1590.976172  29169.416648  -1073.102460 
              901           902           903           904           905           906 
       826.765348  -1022.819561  -1780.225935   -962.023064  -2172.242456    111.398697 
              907           908           909           910           911           912 
     -1589.767382   -345.120870  -1343.832198    500.845241  -1589.077470    891.148680 
              913           914           915           916           917           918 
     -2228.491822  -4023.950340  -3625.959192  -1198.115880  -3197.150298  -2368.494492 
              919           920           921           922           923           924 
     -2492.422807   -249.652847  -3212.860672    761.584834   -833.705016  13603.345111 
              925           926           927           928           929           930 
     -2496.723514   1260.429790   -562.318078  -1209.306514   -863.024356  -2044.179029 
              931           932           933           934           935           936 
     -2628.959418   3987.444326  -4003.141228  -1495.984536  -1730.198323   3188.897401 
              937           938           939           940           941           942 
     -1202.733225   -388.134358   1895.058339   1505.158388  -2289.796163  -2426.339610 
              943           944           945           946           947           948 
      -161.125954  -1707.120251  -3894.476713  -1661.827107  -3331.261467  -2682.298370 
              949           950           951           952           953           954 
     -2733.289448   -905.768875  -2005.915024   -261.252362  -1367.707531  -2894.804578 
              955           956           957           958           959           960 
     -1659.564935  -4644.636183  -1289.478676  -3250.777070  -3217.144575   1046.328239 
              961           962           963           964           965           966 
       928.994944  17759.914682  -3173.459848  -2402.543773  16106.791089  -3040.461875 
              967           968           969           970           971           972 
      -540.777637  -1824.975160    485.593354  -1876.551630   -704.923476  -2575.288216 
              973           974           975           976           977           978 
     -2364.847449  -1322.737291   -836.285163  -1642.126526  -1435.760501   2178.336000 
              979           980           981           982           983           984 
      5646.133961   -997.889340  15876.116180  -3106.976351  -1338.980374  -1436.053674 
              985           986           987           988           989           990 
      -837.505696    641.530320   6472.142034   -625.492044  -3748.118346   1856.580304 
              991           992           993           994           995           996 
      -527.071447  21240.990661  -4043.065509   5011.995234  -3908.375515  -4202.499374 
              997           998           999          1000 
     -1747.438699     11.308294  -3066.439349  -2231.882495 
     [ reached getOption("max.print") -- omitted 6346 entries ]

``` r
#summary stats for vars of interest - 
plot(fit_Channel)
```

![](data:image/png;base64,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)<!-- -->![](data:image/png;base64,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)<!-- -->![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAqAAAAHgCAMAAABNUi8GAAAA51BMVEUAAAAAAA0AACgAADIAADoAAEkAAGYAKjoAMZAAOjoAOmYAOpAAZrYNAAANIHsXAAAXZtsoADooAGY6AAA6ACo6ADo6AGY6Ojo6OmY6OpA6kLY6kNtJADpJAGZRMQBRvP9YAA1YADpmAABmABdmAChmADpmAElmAGZmOgBmOpBmWABmZmZmkJBmtrZmtv+QMgCQOgCQOjqQZgCQkGaQnWaQtv+QvJCQ29uQ2/+cZgC2ZgC225C2/7a2///bkDrbtmbb25Db/7bb/9vb///fU2v/nDr/tmb/vFH/22b/25D//7b//9v///9QNlViAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAbZklEQVR4nO2diYLjOlZABTTNQIW16IFHWAPNsL1QwwBTZOjMQA2BpPT/34NlW9ZiObHlJbfic97rVOJ4keWTq8WWrTSAYNS9EwBwDQQF0SAoiAZBQTQICqJBUBANgoJoEBREg6AgGgQF0SAoiAZBQTQICqJBUBANgoJoEBREg6AgGgQF0SAoiAZBQTQICqJBUBANgoJoEBREg6AgGgQF0SAoiAZBQTQICqJBUBANgoJoEBREg6AgGgQF0SAoiAZBQTQICqJBUBANgoJoEBREg6AgGgQF0SAoiAZBQTQICqJBUBANgoJoEBREg6AgGgQF0SAoiAZBQTQICqJBUBANgoJoEBREg6AgGgQF0SDoQC47pdTnb8lv9tGUw9PbrdWd9onlwIGgwzgpY9Ph02v7qxxBkfMWCDqMw8a8vr9s2l8h6Bwg6CACM49FYW8+Hoq/+1o2M21rZ3CCnuzkcJnzs1JP/1VKWs9x2X2/K9cGFQg6jFOpV8mxKOcvu20ZVKv3+/Lv+dka2ghqKgaX3Sa9TCm2neOyK6YeUzWIlYKgAzFBr2wjGc8Ml6+vZmopWjXtZNtQVtD3l3Lyp9fUMuW/cA7zDVQg6HDeX1QZKJ1FJ1UGwP2pDH3NN1bQakLxmlqm/NfMUYZTaqYOBM3i8Pnb+UtdDhfVys8/q6KhqUgq1dQhQ0GL71PLeIKWMRhBAxB0EDYEFqHSvi3/1sX16ZMTsGjydEZQfxki6FUQdBC2FV9UM219sqxxVm2cfWRWZx3UXyaugyJoAIIO46SMdCfTI2Ta2oWwVSAsJthWvOvGT7fiw2W2cSseQQMQdCDlqc7KwLpP82g+H+rgd/RPhB6qGum23Q9qlylmiftBETQAQUE0CAqiQVAQDYKCaBAURIOgIBoEBdFMLKgC6MW9BJ12dfCoICiIBkFBNAgKokFQEA2CgmgQ9AF5fymvwzeX8x3Lrpp9/ekDgqAPyNFc1Pz1VR+r66BPT2/lNdLlpwE9iyJA0Mfj/Md/V4TM79705UflsOdC1fKTGcJs8v1D5T2CPhzvP/7pix9BjxvdCFpl+0fKfAR9OI7bsg562ZWjoqrAaYdBIeidVgcNRbA0gpqR9dWY0FLTopH0Jz9G0Bm2CwOp2u1b42UZPA/2BlBljZQ66H1WBz5+BH3/sRlYWtZIN+Y7WvF3WR34lHXQUzXouYyi5afbd3GWCIKCaBAURIOgIBoEBdEgKIgGQUE0CAqiQVAQDYKCaBAURIOgIJqZBD0otXl/Ud3P6kNQ6MU8gppLuQ/mFuv2aRXjVgfrZRZBy2elVI8COnZcQ4Og0ItZBK2el1IOcz2Fg12H37QM1g0RFEQzcx20ejDa2NXBeqEVD6KhHxREg6AgGgQF0SAoiAZBQTQICqJBUBANgoJoEBREg6AgGgQF0SAoiAZBQTQICqJBUBANgoJoEBREg6AgGgQF0SAoiAZBQTQICqJBUBANgoJoEBREg6AgGgQF0SAoiAZBQTQICqJBUBANgoJo+gs6rVIICr0YJqgKWGS7sG6IoCCaDEHNw7mOSnU8vmPq7cK6yRD08PR2ft7ow2aR7cK6GS6oeUrXSe3jR3TNtV1YN3mCHgo5jwgK85NTxG8uu6e3y26zyHZh3WQ1ktSn1/eXzTLbhXVDNxOIBkFBNAMFLYr3BhpJMD9EUBANgoJo8lrxFPGwEHmnOo8bfX7uehT8tNuFdZNzJmmrT09v+jjqahEEhV7kneo8//Bb+W+B7cK6GS7o+8tWX76+IigsQUYd1FwlcthSxMMS5HQzHTamJT+qEY+g0A/6QUE0OY0kTnXCYmRH0HEX1CMo9CO/iGdMEixAvqCMSYIFyBf06pgkM2jp/KzUp9ex24V1ky3o1TFJpZ9fXqvTTuO2C+smvxV/pZ/enK6v66hd3fkICr2YpR/UxE1zRlS3aqrT3NgJ1sM8HfUmeh435h0RFEYxz5iky+7ztzKEnrpaSQgKvciIoCdlCu9O9exMJZvR24V1k3O53ab8y9VMsAB5Fywb6KiHBci7YNlwIILC/GTVQU0IPV6vg062XVg3Od1MZVN+3A2WERT6wQXLIBoEBdEgKIhm8JmkLUM+YEGIoCAaBAXR8CAvEA0P8gLR8CAvEA0P8gLR8CAvEA0P8gLR0M0EokFQEE3m5XZPb4ftMtuFdZNzwfKn16NpJI0yFEGhF3lDPsyAObqZYAHy+kGNoHTUwwLkR1AGzcECZNdBj4onzcH8ZA+aGzeoE0GhH/SDgmjyb9yw0HZh3eTf+mah7cK6yWkkjXsAzcDtwrrhQV4gGhpJIBoEBdEgKIgGQUE0CAqiQVAQzTyPoZlwu7Bu5noMzWTbhXXDY2hANDyGBkTDY2hANDyGBkTDY2hANPSDgmgQFETDrW9ANNz6BkTDrW9ANNz6BkTDrW9ANNz6BkTDrW9ANPSDgmhyGkmb8i+NJFiArBs3lGoiKCxAjqDf70wFFEFhAbL6Qd9f1BZBYQkyr6g/qqefIyjMT+6Qj/Nzj1Gd5+fOvlIEhV5kj0m67LoF7TE4GUGhF/P0g1Yjk4mgMJqZOurNA7tTgrrIOmRtsF4G31lk2/MGtodPr0RQGM18pzqPaougMJYZz8Wfn38TQWEkc9487P2l+5I8BIVecPMwEA03DwPRcPMwEA03DwPRcPMwEA03DwPRMCYJRJNfB11ou7Bu8lvxC20X1k1OI4nHccNiZI3q5DlJsBQ0kkA0CAqiyRDUlvFrLeLPz8qcqijvM92MHjyNzA/oIEPQw9PbcXPtavlJtyuIaqDK5eurPn95fX/Z6yIbzKfj09v5h9/MJ5icnEbSVp/MHZbXdi5eVf9Om+LvYX/50TddaHn+7k2btwVGUpiavH5QcyzGHY+PJ6jyXou4WZr59bWOoGYiEXQO8s4klcXcagUtK6Gnp/9+Ub/yF1WNvKjt/O9vUwmdg4w6qHl6wmG7uiJeVYOmi/D5N8/b85d//+4/9pe//sEv/vDL6+nT75tIevnLH4y7gAYS5HQzHTbNPRjn364clKr+/Y8JmIfv//bPvhWFyOk3TEPpH/amxD/8ASF0cugH7U0VP1XZfXH5+tN//p1/Ub/6WrTn9enX//Rff+uviKCzgKC9qSuhx7IT+Pf0//2uevrFd28npX7tz4sKTzENP2dgzmHHk2xXDq6VVD5lr27G208mktJKmh6GHfen7gitz1Fc/r4StPpkeoZLXWFaGHY8gOpUkj2HdtibKFp/IoLOBMOOB1NVQvd1T4b9dBr96Kg23ASQYcdDWdIZW6VYNQw7HsSSzvjnVtcLw46HsKgzCGqgH3QICLo4GYK+v6yzH1Qv7Qx1UJ13wfKKR3Uu6wyt+NwLlhfcrjBwZmG4cQOIJv9M0kLbhXWT3Q+61HY/DrdLf+oHw+HOItlEut1uP9Eqz4B+0Fwi3W73QNGvmQOCZhLrhqDzkCHo2u8sUoGgy5DTUb/WO4sEtHSjDjoLeR31q7yzSERLN1rxc5DXUb/GO4u0QLclyLtgeY13FoG7kFEHXemdReAu5HQzPeKdRSivhUI/aIlqnxjCWBFkNJLq0d+PNKqz8rPYxUbLpbuE+D10kC/o8aEEVd6rfVny0uRFt/aRGCrowd36ZtR1y3c4GleCVPVVPYN7u1giOcnUSX4EXWi7k3HVuPK+dboRtPqIoAJYTSPpugP1rRXreVRjaZ8VT5AzCNrJYEHPz1s9wX1ehAmqq/ZRHWW98r7XeqcxFD9TDBW0vEbEXFP/0S4WuRWk/GrogIA2VeyjFd/B4EbSRtcDj8t38293MoYEqf7zUjjPzEBByzHH1bA58f2gcVAaEqR699oj6MwMFnRvR8ZLF3TCat21VVF7nJccQavqp/CLRQaHNncSKQ6XNzsABiYNBpBTBy3vvHh9ePyxerpV9/kmcYIGJ5FU6yvC5J0YKujp0+tlZ2Ln1Ts0GYUvu43+MIK6k0iJ5bpWRexcgMH9oKfy1qDn52sFfHUT5vcXMzDkXoIObLUHfaCpEBqvauGToatlljNJ9vZNZnhdKKg7k99/bbn034gK/9cuW2xkba3KUxrmZJigKqBzXnsb+6LGer8IOoDKNNWug3YqGPn8UfiAlZJZImhTsHdfeC8qo8Io6Y6iij4HS7QElX/0P2LIn0fQohVfFfLvLx9B0ObIJW63ZK9sSi2gAj/1vfZqyGUD0nL+JgMEnTRACMsm1+Tx99Nq2GWoivy8z271/mU8uKDaVkGX3e6CKPvAbd9QdxFza+ZuQZd+mlK//Hx8Qet3U2i6QDfT0DTWegbFvV1JalVh5FLR62IeDNDuseug8edxjs6eTz0Phhsp14xLchcvt1r1zSK6LYbSbUuXYMjW5LfjWuQKOnZP586onodNuX/1/56sja6tllMsY/XWHxG6cAj9cN71Jk/Q8T/Eewka2hZETt20kJrhx8peZp9YcccW1LVawTx8wLjYnxxBp8iPOwjqjenw5woHeuhmeLwKv2+Hx2TkquZNfQNZZEXQDyBoouqo29qGsdOre9b/1WG0o4KZaC3W3z50TFuWzCJ+ue3mb6Gj0z0OoU3nkld6O2WrhVRUdDc1VK1SGYOd05HbSFpsu5Nu0O85qicr1dQ8VRP/dBNSbXHvBWRnalBfdVvJ2DlCbhfrErQd9GoBbRPen+quiVGurG+Wa6qp4anQdquqb+IwNIlgQSeOKn64C4Ry12Y5t5rQ2ZTyzbdBTdVrY9UbyUk1FYNu5Ao6eVRRTZwMymQrbtOSt5PD0t9vKnl1gaDX/qZpHfY+tqDjAo1YQec4aK5c9iYor77pWuFN4W+VVk1DygruIm9fQbt+cw8t6MhAsyZBg7aP9tx0r26+4CunpRM2XcJfS3T3tw9cB/V/+FnLTz7jRKubXlBXaCsv+jWTnIrV3AG6UdHFVttECmsMQZrD0u3KLk1c3xZEWLe/PmsqE8QKOkcdVAdyuvql30x3TSFls8yPlbZ22qwkSmOQybGu3mvfJH90b9v9H92z6lTmyBV08qPjlc5+oR5M8cKlsg2lVpeT0iqIwd0b1Lpl6CA/B84vkJ5DC39ZkZhTsKBTE/S/+0r6k21Dyp/Daw/5orpqacfm2hFz2G/uVpPrI4RXr1EZ8ssA3bm3qxK0FSsbQV0cDUrwIL66oOoa+N2CqqZ4y0+w96pbQkoNr53JbCkZLee9tib32e6wZC68un7bbLvpn8aM7I37oFRsuLaVVu0dlSBujmu/RodsdIV2GbqETCjZuWQ8tfeGJ2ThnE0X1EGB7fnnze6664MqQVhjdXmrVNOWajY7ItU69NPPtjsKem2vBgjZb72PLqhqqokqDpGtiBl1kqbnippZ3s6oZjt6Kn+8QyZH0O4YWTB5sh5cUKte/V5HfrWFjVRtzaW9kOrWXL/6fSodBVZ2SG0d+WnroD0TdrPQRtBhW2mU1NrrZuqMos5PHU1oddw3/+u0oMlDPkaq1rJ9nOr7g+hOWN/W9u015fHgguq6aLc+Kb8ztIvg+7pt5bXb60na6z+xzawbh2dceMmIvv1ssSuu5xzc2g4Tll9IpBM3+YxTrm7szirdCoe3/WxmasKtNTthsEuoH6yv7vRy9cZ+26vbiPpKwd1aq7ryeVpECzp61/1TRvUf3Sqwuyuc6e/9Jr9Nng2hgaAtWVVi6lWjx+276tMR67Vv+qYknHHmX51kQbN3PYxs11pEV6Jpj0DrVW+rjQUJTvy86mB1o6mj7E9pDNdPJHhFuK0353baImjWuj1Dw9K6Uuq2fLGJYavJrcW1lVQoqPdB+T+YYJ9Suxhaf2NXbf2jnQd1/bteTXenuXIryosG3usMPKCg0WKhV632+Bhcz5W2jTGdEDT4wUSJa6XVVXljqxOtkWrrcSYluievVSytyUFKBkAdtNesXV3afrhsAs5YL6Pu/aZftK7i+sV+lB4bUX2ZnYDa+uZtzOVCmB2qmbf6FMqoAu965N2IQKgSEXwyRAvaf9ejUt15Egs5Wfx0xXzTYKo3bYNqGDydt2FKvFqps9XXMy16teYrMdLVQXsybyDMRq6gQ36XYZCqtWnqnhMEzeueBi3merJXT232JrF0s7yrLrg1e70CVtCo4G4MTtRCm2X7ZuKcgTAbsYIG1brE151dHZ4jTWGaauNMQONT1xp9L8P2WrgW+6sKo6f9HCqpAuNTddCHQqqgTrnknNEXKUFdkaviYnWwiHmL9V6PdtXa+k0QJ/0qQNOEapZJh77UtA+JaEG9WJFa2jdUeX3mfvVuCs2mqyHo+KM/IXDSzqF9Ab0p6XwJMugxDJUvqGtixksr77Nyx+zWmSBBRD1BZlJcU43ySvludmra+gEvQTIl49c6+YwTrc61gRPRIIqs9YF19dY4OEkiGSi9V0di35XrJ9VNyylRwPfL40mZKWiLFdSW2nF/oXKdNdZM1y6q5xLHL1NWtgmaU1oFxbvNNauodi37dmbeQdC5NilX0HIue3yaeOre1H3k1aunqJTQ2SWlbr3xPrk9S3ZihtUY3a3F8nXQVQqqvBAZNJtccV5Nsy32VBV0UfpFSr+DwU6x03WzK911S/dVpxbJxedkDYLGmVodpObwVZPsF81hdR3a9rCOlGwoPctv5QdPnewRvZrHyivZw3yU0Vx//DpoO/NtAa4966ovnI3tHvhFBO0tZUCT8iDV2u2jtrvXlTut75Iz34V5UiJH0FYZoZx/3p+wL0ZrvWTMzLKy3aXgNQDdlKBRLqHZIwPJgtrA6cWctIrt/plpydMyRHta1hOU+2253okOFRF0shlzV5cQNCnaVfumVDMzXKbToN31I3aK9koI5XYfQQPkCJpqAATHu1WBS5kwgaEThMsEycS6ekxcuifL+BX6KUnQdAPAa6YHh3ryeucU5XiCpqfMD6K26uK6Jbzd71BRxbnTK5vFNKFykSRoYi7brxm2et2Rn4B5vFThD8lr8sVOtn1UgVVqhGMPEHalCxq1JSYMnLOI6UkZ9n95pxb8Hl37+7ueUbl5/wgVV9mCek0IX4Bmag6zRcwk7W4IHQVNlez1dP4OyK10JiPonNtVQSGp6jJfa1e168lMVcw2wQkt7b3zw2hbymBS3FhC0AlnnH117iiXn7oJzkEuEzAbwhMM3ts6zan8UP6H+nWcY9RB599uclnVRKGUindy0uGfi23653tkh0p8GueYohU/5XY7PLvNvUyMsb1JrnHufko9siMl6AM4NgpRgg5eRyXFYqfibxKeJbKOqqGCPkLRPBUfWdC6ancHQbu36J/lcvt5e28jJdW6w6bHTIK+v1TH6fO3SVbXjfIa+vfFtc5bDZ4+O6tQMsk8gh7Vtnpzsm9Gre4aqmnML2Rp02nkPtWCNn4qv1mEeaOYRdD3l0bL49Pb6NX1YQE9m54jrVLVCu06wObYwbUyi6CX3d6+PYWFfHA8JyV5tmlqO5U7rRXsij3ZPkHXJYQ8SgTVLr5N0WjyzltFZ7KUK76jVrpS4XSYgrnqoHUInb8O2l5zRgyNnNZOMnfm0l+/v6nEziiqnZMxUyv+squOa0f8XCLCeLbZz+5vbF1r0eDvre2MTSp086H7QeHxQVAQDYKCaBAURIOgIBoEBdEgKIgGQUE0dxMUoBd3EnQaRCRKRCJIhYwMiBCRKBGJIBUyMiBCRKJEJIJUyMiACBGJEpEIUiEjAyJEJEpEIkiFjAyIEJEoEYkgFTIyIEJEokQkglTIyIAIEYkSkQhSISMDIkQkSkQiSIWMDADoAEFBNAgKokFQEA2CgmgQFESDoCAaBAXRICiIBkFBNAgKokFQEA2CgmjkCXpS6tPr8putbn268RPQfjMz5x9+S2930ZRUqZCQHwZxgp6KXT/dwdDzl9coAe03M3PZlXf+v5KAJVJSp0JAfpRIE7S6D/5hs/iG7WMhmgS038ydgur5U1cSsERK6lQIyI8KaYKen81t8I+dTwqbjeMmSkD7zbwJOKltKcWVBCyQEpuK++dHjThBy5LltLyghz8qqlxbLwHtN7OnoRK0OwHLpKRav4T8MEgTtKrbLF8JvezMgyEOW5eA9pvZE1Ee9CsJWCYlZSpE5IcBQYOtf/6GoF5svHN+GKQJercivtr6854i3lv/nfPDIE7QezWSqq1/eb1no0BAI0mHgt43PwzSBL1XN1OV68WxuWe3yklAN1PwM7lzfhikCXq3jvoyw4tGwT07pk8SOuptK36j754fBnGC6uN9TnXqg1LVo0ibBLTfzExduF5JwBIpqVMhID8M8gQF8EBQEA2CgmgQFESDoCAaBAXRICiIBkFBNAgKokFQEA2CgmgQFESDoCAaBAXRICiIBkFBNAgKokFQEA2CgmgQFESDoCAaBAXRICiIBkFBNAgKokFQEA2CgmgQNBNz6yLD/rLba32q/4V03GGrXAL6gaCZHMwtsi1GuYR2CDoeBM0EQZcBQTNpBC10Oz9XxX0x6Vg9G6O6ReFPSkHre8EW7+s7GhZLlI6WL3aBch2I2wJBM/EFdRH0WGh4fi6EO3z+pk/VXTTfXzbV/OaesGYGX1C7QGnxCUNbIGgmSUEvOxMMT/Y+7of6fq+FrMU3l6+vVTj1BG0WuNdjI8SDoJnUrfh9IOjJlunuZt5ae9+YBw0GgjYL1E/IhBgEzSQZQU+27+noC2ru936o6qeffxZG0GaBoiJAHTQFgmaSFtQ224MIWnz6z+LLstiPiviwnX+40/PLJIOgmXTUQesYWD9LqBbusvtH02YqnyNni/htXbL7QZP+pzYImkkk6LZqIJVKmkBo3pyaZ2Ec1MYGT2Xm3L+/PL0Vhfq+WaB5vguEIGgmgaCFgU9vB9sPWj3OuukH1bb/qHx6SyFjpbRS39t+0Cq03unxO8JBUBANgoJoEBREg6AgGgQF0SAoiAZBQTQImkH7jM/7y777ywEr/kpPaASCZtB28Li58uUATv51+qARNIuWg/6EUYJ6kRhKEDSDcpTH9zultmagxr6+eKketHHZ/VM1sRnh8fUn5mRmv7EdR0JoCIJmUApqrggpxSv+mcEcdtDGZVdfK+JGeBjpeo7t4HqRCATNoBS0vF7OXjS3tZeAat1cSedGeGy1To7tMBcpF/Ke/82turpODxoQNINS0Prq4+aqTjtoww3YdCM8tE6O7TiV10GpcADzduGdEQ6CZhALWoW9etCGG7DpRnho3XdsB4JGIGgGyQhaUl/tGczhRVDtZutcNYIGIGgGbUG37ptmuJE3wiPufOruiqIOGoGgGcSClg12O2jDj6B2hIfWfcd20IqPQNAMWoKevEEbfh20GeGhb4/tqG5AQj9oBIJOwWTDMRnXGYOgk+Cdix8F5+JjEHQSJjqHztVMLRAURIOgIJr/B8pWRu0XSmRXAAAAAElFTkSuQmCC)<!-- -->![](data:image/png;base64,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)<!-- -->

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
      var_names               shares
      <chr>                    <dbl>
    1 shares                1       
    2 weekday_is_monday    -0.0125  
    3 weekday_is_tuesday   -0.0105  
    4 weekday_is_wednesday  0.0157  
    5 weekday_is_thursday  -0.0169  
    6 weekday_is_friday    -0.000938
    7 weekday_is_saturday   0.0167  
    8 weekday_is_sunday     0.0228  

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

     n_tokens_title  n_tokens_content n_unique_tokens  n_non_stop_words
     Min.   : 4.00   Min.   :   0.0   Min.   :0.0000   Min.   :0.0000  
     1st Qu.: 9.00   1st Qu.: 255.0   1st Qu.:0.4574   1st Qu.:1.0000  
     Median :10.00   Median : 406.0   Median :0.5330   Median :1.0000  
     Mean   :10.17   Mean   : 574.5   Mean   :0.5304   Mean   :0.9973  
     3rd Qu.:12.00   3rd Qu.: 738.0   3rd Qu.:0.6010   3rd Qu.:1.0000  
     Max.   :20.00   Max.   :4979.0   Max.   :0.9143   Max.   :1.0000  
     n_non_stop_unique_tokens   num_hrefs       num_self_hrefs       num_imgs     
     Min.   :0.0000           Min.   :  0.000   Min.   :  0.000   Min.   : 0.000  
     1st Qu.:0.6162           1st Qu.:  5.000   1st Qu.:  2.000   1st Qu.: 1.000  
     Median :0.6881           Median :  7.000   Median :  3.000   Median : 1.000  
     Mean   :0.6821           Mean   :  9.503   Mean   :  4.635   Mean   : 4.432  
     3rd Qu.:0.7553           3rd Qu.: 11.000   3rd Qu.:  6.000   3rd Qu.: 6.000  
     Max.   :1.0000           Max.   :120.000   Max.   :116.000   Max.   :65.000  
       num_videos     average_token_length  num_keywords    data_channel_is_lifestyle
     Min.   : 0.000   Min.   :0.000        Min.   : 2.000   Min.   :0                
     1st Qu.: 0.000   1st Qu.:4.424        1st Qu.: 7.000   1st Qu.:0                
     Median : 0.000   Median :4.593        Median : 8.000   Median :0                
     Mean   : 0.454   Mean   :4.585        Mean   : 7.775   Mean   :0                
     3rd Qu.: 1.000   3rd Qu.:4.759        3rd Qu.: 9.000   3rd Qu.:0                
     Max.   :73.000   Max.   :5.857        Max.   :10.000   Max.   :0                
     data_channel_is_entertainment data_channel_is_bus data_channel_is_socmed
     Min.   :0                     Min.   :0           Min.   :0             
     1st Qu.:0                     1st Qu.:0           1st Qu.:0             
     Median :0                     Median :0           Median :0             
     Mean   :0                     Mean   :0           Mean   :0             
     3rd Qu.:0                     3rd Qu.:0           3rd Qu.:0             
     Max.   :0                     Max.   :0           Max.   :0             
     data_channel_is_tech data_channel_is_world   kw_min_min       kw_max_min    
     Min.   :1            Min.   :0             Min.   : -1.00   Min.   :     0  
     1st Qu.:1            1st Qu.:0             1st Qu.: -1.00   1st Qu.:   480  
     Median :1            Median :0             Median :  0.00   Median :   725  
     Mean   :1            Mean   :0             Mean   : 29.58   Mean   :  1152  
     3rd Qu.:1            3rd Qu.:0             3rd Qu.:  4.00   3rd Qu.:  1100  
     Max.   :1            Max.   :0             Max.   :217.00   Max.   :102200  
       kw_avg_min        kw_min_max       kw_max_max       kw_avg_max       kw_min_avg  
     Min.   :   -1.0   Min.   :     0   Min.   :     0   Min.   :     0   Min.   :   0  
     1st Qu.:  161.8   1st Qu.:     0   1st Qu.:690400   1st Qu.:140030   1st Qu.:   0  
     Median :  254.7   Median :  1100   Median :843300   Median :186667   Median : 853  
     Mean   :  317.2   Mean   :  7396   Mean   :738324   Mean   :213153   Mean   :1007  
     3rd Qu.:  370.8   3rd Qu.:  5700   3rd Qu.:843300   3rd Qu.:285078   3rd Qu.:1973  
     Max.   :14716.9   Max.   :663600   Max.   :843300   Max.   :753450   Max.   :3347  
       kw_max_avg       kw_avg_avg    self_reference_min_shares self_reference_max_shares
     Min.   :     0   Min.   :    0   Min.   :     0            Min.   :     0           
     1st Qu.:  3437   1st Qu.: 2347   1st Qu.:   787            1st Qu.:  1700           
     Median :  3738   Median : 2702   Median :  1400            Median :  4100           
     Mean   :  4588   Mean   : 2748   Mean   :  4437            Mean   : 11822           
     3rd Qu.:  4705   3rd Qu.: 3083   3rd Qu.:  2800            3rd Qu.:  8500           
     Max.   :102200   Max.   :19429   Max.   :663600            Max.   :663600           
     self_reference_avg_sharess weekday_is_monday weekday_is_tuesday weekday_is_wednesday
     Min.   :     0             Min.   :0.0000    Min.   :0.0000     Min.   :0.0000      
     1st Qu.:  1500             1st Qu.:0.0000    1st Qu.:0.0000     1st Qu.:0.0000      
     Median :  2800             Median :0.0000    Median :0.0000     Median :0.0000      
     Mean   :  7208             Mean   :0.1646    Mean   :0.2004     Mean   :0.1946      
     3rd Qu.:  5362             3rd Qu.:0.0000    3rd Qu.:0.0000     3rd Qu.:0.0000      
     Max.   :663600             Max.   :1.0000    Max.   :1.0000     Max.   :1.0000      
     weekday_is_thursday weekday_is_friday weekday_is_saturday weekday_is_sunday
     Min.   :0.0000      Min.   :0.0000    Min.   :0.000       Min.   :0.000    
     1st Qu.:0.0000      1st Qu.:0.0000    1st Qu.:0.000       1st Qu.:0.000    
     Median :0.0000      Median :0.0000    Median :0.000       Median :0.000    
     Mean   :0.1778      Mean   :0.1386    Mean   :0.069       Mean   :0.055    
     3rd Qu.:0.0000      3rd Qu.:0.0000    3rd Qu.:0.000       3rd Qu.:0.000    
     Max.   :1.0000      Max.   :1.0000    Max.   :1.000       Max.   :1.000    
       is_weekend        LDA_00            LDA_01            LDA_02            LDA_03       
     Min.   :0.000   Min.   :0.01819   Min.   :0.01819   Min.   :0.01818   Min.   :0.01818  
     1st Qu.:0.000   1st Qu.:0.02230   1st Qu.:0.02224   1st Qu.:0.02500   1st Qu.:0.02223  
     Median :0.000   Median :0.02860   Median :0.02857   Median :0.03334   Median :0.02857  
     Mean   :0.124   Mean   :0.07364   Mean   :0.06500   Mean   :0.11086   Mean   :0.06140  
     3rd Qu.:0.000   3rd Qu.:0.04007   3rd Qu.:0.04000   3rd Qu.:0.15724   3rd Qu.:0.04000  
     Max.   :1.000   Max.   :0.80735   Max.   :0.72201   Max.   :0.82213   Max.   :0.74237  
         LDA_04        global_subjectivity global_sentiment_polarity
     Min.   :0.02007   Min.   :0.0000      Min.   :-0.33912         
     1st Qu.:0.54599   1st Qu.:0.4150      1st Qu.: 0.09815         
     Median :0.73332   Median :0.4596      Median : 0.14517         
     Mean   :0.68910   Mean   :0.4569      Mean   : 0.14578         
     3rd Qu.:0.86658   3rd Qu.:0.5030      3rd Qu.: 0.19090         
     Max.   :0.92719   Max.   :0.7693      Max.   : 0.65000         
     global_rate_positive_words global_rate_negative_words rate_positive_words
     Min.   :0.00000            Min.   :0.000000           Min.   :0.0000     
     1st Qu.:0.03306            1st Qu.:0.008696           1st Qu.:0.6667     
     Median :0.04190            Median :0.013582           Median :0.7527     
     Mean   :0.04288            Mean   :0.014411           Mean   :0.7470     
     3rd Qu.:0.05204            3rd Qu.:0.018913           3rd Qu.:0.8333     
     Max.   :0.10714            Max.   :0.082803           Max.   :1.0000     
     rate_negative_words avg_positive_polarity min_positive_polarity max_positive_polarity
     Min.   :0.0000      Min.   :0.0000        Min.   :0.00000       Min.   :0.0000       
     1st Qu.:0.1667      1st Qu.:0.3155        1st Qu.:0.06250       1st Qu.:0.6000       
     Median :0.2453      Median :0.3566        Median :0.10000       Median :0.8000       
     Mean   :0.2503      Mean   :0.3575        Mean   :0.09912       Mean   :0.7724       
     3rd Qu.:0.3293      3rd Qu.:0.4014        3rd Qu.:0.10000       3rd Qu.:1.0000       
     Max.   :1.0000      Max.   :1.0000        Max.   :1.00000       Max.   :1.0000       
     avg_negative_polarity min_negative_polarity max_negative_polarity title_subjectivity
     Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000       Min.   :0.0000    
     1st Qu.:-0.2838       1st Qu.:-0.6000       1st Qu.:-0.1250       1st Qu.:0.0000    
     Median :-0.2222       Median :-0.4333       Median :-0.1000       Median :0.0500    
     Mean   :-0.2287       Mean   :-0.4512       Mean   :-0.1028       Mean   :0.2521    
     3rd Qu.:-0.1667       3rd Qu.:-0.2500       3rd Qu.:-0.0500       3rd Qu.:0.4667    
     Max.   : 0.0000       Max.   : 0.0000       Max.   : 0.0000       Max.   :1.0000    
     title_sentiment_polarity abs_title_subjectivity abs_title_sentiment_polarity
     Min.   :-1.00000         Min.   :0.0000         Min.   :0.0000              
     1st Qu.: 0.00000         1st Qu.:0.1667         1st Qu.:0.0000              
     Median : 0.00000         Median :0.5000         Median :0.0000              
     Mean   : 0.08602         Mean   :0.3471         Mean   :0.1356              
     3rd Qu.: 0.15000         3rd Qu.:0.5000         3rd Qu.:0.2000              
     Max.   : 1.00000         Max.   :0.5000         Max.   :1.0000              
         shares      
     Min.   :    36  
     1st Qu.:  1100  
     Median :  1700  
     Mean   :  3132  
     3rd Qu.:  3000  
     Max.   :663600  

``` r
#check structure of objects
str(ChannelTrain)
```

    tibble [5,145 × 59] (S3: tbl_df/tbl/data.frame)
     $ n_tokens_title               : num [1:5145] 13 10 11 8 13 11 8 8 10 14 ...
     $ n_tokens_content             : num [1:5145] 1072 370 97 1207 1248 ...
     $ n_unique_tokens              : num [1:5145] 0.416 0.56 0.67 0.411 0.391 ...
     $ n_non_stop_words             : num [1:5145] 1 1 1 1 1 ...
     $ n_non_stop_unique_tokens     : num [1:5145] 0.541 0.698 0.837 0.549 0.523 ...
     $ num_hrefs                    : num [1:5145] 19 2 2 24 21 20 5 5 2 0 ...
     $ num_self_hrefs               : num [1:5145] 19 2 0 24 19 20 2 3 2 0 ...
     $ num_imgs                     : num [1:5145] 20 0 0 42 20 20 1 1 19 14 ...
     $ num_videos                   : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ average_token_length         : num [1:5145] 4.68 4.36 4.86 4.72 4.69 ...
     $ num_keywords                 : num [1:5145] 7 9 7 8 10 7 10 9 7 9 ...
     $ data_channel_is_lifestyle    : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_entertainment: num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_bus          : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_socmed       : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_tech         : num [1:5145] 1 1 1 1 1 1 1 1 1 1 ...
     $ data_channel_is_world        : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_min_min                   : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_max_min                   : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_avg_min                   : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_min_max                   : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_max_max                   : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_avg_max                   : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_min_avg                   : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_max_avg                   : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_avg_avg                   : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ self_reference_min_shares    : num [1:5145] 545 8500 0 545 545 545 924 2500 0 0 ...
     $ self_reference_max_shares    : num [1:5145] 16000 8500 0 16000 16000 16000 924 2500 0 0 ...
     $ self_reference_avg_sharess   : num [1:5145] 3151 8500 0 2830 3151 ...
     $ weekday_is_monday            : num [1:5145] 1 1 1 1 1 1 1 1 1 1 ...
     $ weekday_is_tuesday           : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_wednesday         : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_thursday          : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_friday            : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_saturday          : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_sunday            : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ is_weekend                   : num [1:5145] 0 0 0 0 0 0 0 0 0 0 ...
     $ LDA_00                       : num [1:5145] 0.0286 0.0222 0.4583 0.025 0.0201 ...
     $ LDA_01                       : num [1:5145] 0.0288 0.3067 0.029 0.0252 0.02 ...
     $ LDA_02                       : num [1:5145] 0.0286 0.0222 0.0287 0.025 0.02 ...
     $ LDA_03                       : num [1:5145] 0.0286 0.0222 0.0297 0.025 0.02 ...
     $ LDA_04                       : num [1:5145] 0.885 0.627 0.454 0.9 0.92 ...
     $ global_subjectivity          : num [1:5145] 0.514 0.437 0.539 0.539 0.507 ...
     $ global_sentiment_polarity    : num [1:5145] 0.281 0.0712 0.1611 0.2883 0.2904 ...
     $ global_rate_positive_words   : num [1:5145] 0.0746 0.0297 0.0309 0.0696 0.0681 ...
     $ global_rate_negative_words   : num [1:5145] 0.0121 0.027 0.0206 0.0116 0.0112 ...
     $ rate_positive_words          : num [1:5145] 0.86 0.524 0.6 0.857 0.859 ...
     $ rate_negative_words          : num [1:5145] 0.14 0.476 0.4 0.143 0.141 ...
     $ avg_positive_polarity        : num [1:5145] 0.411 0.351 0.567 0.427 0.408 ...
     $ min_positive_polarity        : num [1:5145] 0.0333 0.1364 0.4 0.1 0.1 ...
     $ max_positive_polarity        : num [1:5145] 1 0.6 0.8 1 1 1 0.35 1 0.6 1 ...
     $ avg_negative_polarity        : num [1:5145] -0.22 -0.195 -0.125 -0.227 -0.207 ...
     $ min_negative_polarity        : num [1:5145] -0.5 -0.4 -0.125 -0.5 -0.5 -0.5 -0.2 -0.5 -0.8 -0.4 ...
     $ max_negative_polarity        : num [1:5145] -0.05 -0.1 -0.125 -0.05 -0.05 ...
     $ title_subjectivity           : num [1:5145] 0.455 0.643 0.125 0.5 0 ...
     $ title_sentiment_polarity     : num [1:5145] 0.136 0.214 0 0 0 ...
     $ abs_title_subjectivity       : num [1:5145] 0.0455 0.1429 0.375 0 0.5 ...
     $ abs_title_sentiment_polarity : num [1:5145] 0.136 0.214 0 0 0 ...
     $ shares                       : num [1:5145] 505 855 3600 17100 2800 445 783 1500 3900 480 ...

``` r
str(Lifestlye_sumstats_Train)
```

     'table' chr [1:6, 1:59] "Min.   : 4.00  " "1st Qu.: 9.00  " "Median :10.00  " ...
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
    4.200607e+03 4.024111e-03 2.237754e+03 

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
    4.178216e+03 5.040144e-03 2.239993e+03 

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
    4.309556e+03 4.589173e-03 2.224270e+03 

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
         1 132161217.9546             nan     0.1000 73962.8806
         2 131798884.8134             nan     0.1000 85479.5130
         3 131646765.3058             nan     0.1000 44408.5266
         4 131380343.4288             nan     0.1000 101011.2539
         5 131179357.2829             nan     0.1000 19697.7362
         6 130955255.6026             nan     0.1000 35784.8101
         7 130722318.7563             nan     0.1000 -129237.1085
         8 130610380.8699             nan     0.1000 -45924.8252
         9 130448938.6309             nan     0.1000 31785.1228
        10 130411643.5388             nan     0.1000 40093.7991
        20 130136438.8266             nan     0.1000 -54053.4466
        40 129721272.1948             nan     0.1000 -64271.1136
        60 129463492.0414             nan     0.1000 -41514.5814
        80 129081477.1254             nan     0.1000 -176075.2651
       100 128702629.1027             nan     0.1000 -178215.2094
       120 128346838.2847             nan     0.1000 -123662.1505
       140 127897466.3492             nan     0.1000 -201620.6590
       160 127826640.7252             nan     0.1000 -137488.5151
       180 127607818.8296             nan     0.1000 -92642.6772
       200 127525462.7447             nan     0.1000 -169933.7801

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 130066664.4884             nan     0.1000 79832.6268
         2 129904352.1388             nan     0.1000 46002.4810
         3 128171738.9355             nan     0.1000 -111004.2456
         4 128094898.0857             nan     0.1000 48341.9505
         5 128019902.2031             nan     0.1000 32250.4783
         6 127961492.9819             nan     0.1000 48047.4623
         7 126705292.7234             nan     0.1000 -472949.8517
         8 126604425.1079             nan     0.1000 55071.2688
         9 126643266.0403             nan     0.1000 -159418.0744
        10 125679979.0891             nan     0.1000 -493428.2474
        20 118885235.3516             nan     0.1000 -272316.5443
        40 114073196.4706             nan     0.1000 -1201100.2808
        60 111380822.1027             nan     0.1000 -127949.8161
        80 109865540.5722             nan     0.1000 -1544788.6560
       100 106277823.8110             nan     0.1000 -345660.9930
       120 105619686.1475             nan     0.1000 -824874.8727
       140 104539195.4702             nan     0.1000 -858402.7011
       160 102333218.5202             nan     0.1000 -286966.9608
       180 96836535.4501             nan     0.1000 -501562.4642
       200 94898386.0302             nan     0.1000 -70150.2794

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 131959115.5324             nan     0.1000 374879.7120
         2 131578590.1828             nan     0.1000 397361.8595
         3 129331024.8688             nan     0.1000 160514.5301
         4 127368902.5194             nan     0.1000 -179798.1232
         5 125758833.7845             nan     0.1000 -643567.5106
         6 124698941.6358             nan     0.1000 -768061.8981
         7 124689236.8713             nan     0.1000 -107009.9133
         8 122693817.2567             nan     0.1000 -188022.0532
         9 122968485.1242             nan     0.1000 -909876.9660
        10 123196115.2727             nan     0.1000 -852857.8366
        20 118732208.0492             nan     0.1000 -73263.7038
        40 111338462.6381             nan     0.1000 -487994.6445
        60 107802083.7660             nan     0.1000 -949533.0677
        80 105130091.5500             nan     0.1000 -249720.3776
       100 97633457.6572             nan     0.1000 -655940.0353
       120 92426268.9675             nan     0.1000 -243016.9849
       140 90251959.6574             nan     0.1000 -749773.7274
       160 85711360.1962             nan     0.1000 -9056.4223
       180 82324170.8401             nan     0.1000 -224846.5997
       200 81447581.9524             nan     0.1000 -514556.0961

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 130023291.3640             nan     0.1000 205498.1574
         2 129757211.9111             nan     0.1000 283041.2379
         3 128067468.9580             nan     0.1000 -150200.9109
         4 127980015.8310             nan     0.1000 7984.7047
         5 127989477.0513             nan     0.1000 -82146.1039
         6 126568140.0689             nan     0.1000 -306174.8179
         7 126488626.6734             nan     0.1000 -10227.0013
         8 126771502.3582             nan     0.1000 -789070.9848
         9 124959771.2404             nan     0.1000 -386132.8412
        10 124980146.5025             nan     0.1000 -261163.8581
        20 119781673.5856             nan     0.1000 -368810.9172
        40 109849828.3861             nan     0.1000 -118834.7403
        60 99489882.2503             nan     0.1000 -784750.6020
        80 95526548.1083             nan     0.1000 -157491.1694
       100 88662335.1363             nan     0.1000 -256435.0642
       120 83169736.6108             nan     0.1000 -214042.3339
       140 82861790.3732             nan     0.1000 -899111.3082
       160 80134596.5396             nan     0.1000 -933017.7193
       180 76216996.1419             nan     0.1000 -1257207.8798
       200 70376526.8359             nan     0.1000 -465406.9551

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 131357726.8792             nan     0.1000 144194.6909
         2 131065027.5841             nan     0.1000 44261.0011
         3 130965180.4218             nan     0.1000 123012.0386
         4 130895974.2132             nan     0.1000 -40695.9533
         5 130689594.7407             nan     0.1000 -40036.4293
         6 130622567.7837             nan     0.1000 91802.2664
         7 130544025.7532             nan     0.1000 94666.6201
         8 130356711.4111             nan     0.1000 32317.1305
         9 130326181.7349             nan     0.1000 8745.0459
        10 130321095.3365             nan     0.1000 -28787.5244
        20 129644044.6914             nan     0.1000 40359.1192
        40 129059436.4271             nan     0.1000 -20553.6937
        60 128390593.0667             nan     0.1000 38195.9501
        80 128160431.8583             nan     0.1000 -157327.3297
       100 127872815.0977             nan     0.1000 31869.0433
       120 127634813.1639             nan     0.1000 -189321.2015
       140 127382142.1491             nan     0.1000 -199675.6227
       160 127149848.7430             nan     0.1000 -58564.7815
       180 126683993.3529             nan     0.1000 -97077.3650
       200 126414849.9783             nan     0.1000 -127308.6010

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 131560412.9068             nan     0.1000 85996.2440
         2 131431537.8294             nan     0.1000 135540.0718
         3 129360533.5784             nan     0.1000 -177553.4172
         4 127818147.8004             nan     0.1000 -380824.9195
         5 127758070.3961             nan     0.1000 -7597.1621
         6 127661464.7339             nan     0.1000 23359.3134
         7 125880618.5770             nan     0.1000 -168790.1040
         8 124837624.8875             nan     0.1000 -684610.7774
         9 124783324.5894             nan     0.1000 -17856.6359
        10 124108039.1955             nan     0.1000 -977839.8563
        20 121840192.1574             nan     0.1000 -35210.5349
        40 116080212.5101             nan     0.1000 -1264345.7490
        60 114473582.1435             nan     0.1000 -626834.4113
        80 112540488.0061             nan     0.1000 -656852.7391
       100 108942450.0349             nan     0.1000 -477955.0825
       120 107356503.7493             nan     0.1000 -629432.5528
       140 106125139.7782             nan     0.1000 -492388.7362
       160 104077877.8195             nan     0.1000 -143587.5628
       180 100584932.7530             nan     0.1000 -999143.0944
       200 98781951.9920             nan     0.1000 -1165511.9274

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 131501124.8405             nan     0.1000 117485.8281
         2 131276868.3129             nan     0.1000 -13405.8272
         3 131146577.7768             nan     0.1000 144646.1777
         4 130995450.4264             nan     0.1000 106413.2730
         5 129093859.8463             nan     0.1000 -39575.6521
         6 129058214.4203             nan     0.1000 21785.3643
         7 126824505.4362             nan     0.1000 -310455.0792
         8 126766236.9869             nan     0.1000 -69691.5135
         9 126631941.3933             nan     0.1000 43403.3960
        10 125239758.2400             nan     0.1000 -243184.7042
        20 121088789.2367             nan     0.1000 -1135168.1284
        40 110344691.7127             nan     0.1000 -187424.7543
        60 101445154.4345             nan     0.1000 77158.0629
        80 95820377.7770             nan     0.1000 -382389.0325
       100 91797240.2600             nan     0.1000 -543024.6544
       120 84244112.9435             nan     0.1000 70519.0246
       140 80534636.3093             nan     0.1000 -472486.1285
       160 79093048.2654             nan     0.1000 -292200.5949
       180 77281207.5320             nan     0.1000 -998665.3268
       200 73449839.9397             nan     0.1000 -243710.9887

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 129548245.5225             nan     0.1000 17694.2059
         2 127719888.4798             nan     0.1000 -58562.2837
         3 126035345.2472             nan     0.1000 -399778.6391
         4 124356108.3307             nan     0.1000 -37119.0556
         5 124235184.1517             nan     0.1000 96808.6425
         6 122720970.1179             nan     0.1000 -511894.0200
         7 121347835.3406             nan     0.1000 -531959.1979
         8 121550191.2005             nan     0.1000 -676505.2421
         9 121763177.7553             nan     0.1000 -702480.3732
        10 121705385.7609             nan     0.1000 -20272.5341
        20 118627237.3477             nan     0.1000 -740254.0661
        40 112773349.8949             nan     0.1000 -663131.4840
        60 101020526.6707             nan     0.1000 -958718.7893
        80 94307706.4920             nan     0.1000 -377241.3061
       100 86120149.2032             nan     0.1000 -434480.1939
       120 81881792.0264             nan     0.1000 -346514.4322
       140 79272211.0778             nan     0.1000 -427771.9423
       160 76506465.2557             nan     0.1000 -819899.8495
       180 73273015.6506             nan     0.1000 -196889.6399
       200 69970057.1537             nan     0.1000 -174385.1083

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 130439675.7968             nan     0.1000 270079.0842
         2 130367042.5479             nan     0.1000 10766.5069
         3 130280164.2348             nan     0.1000 -5278.0571
         4 130186478.6391             nan     0.1000 118328.6265
         5 129868515.9499             nan     0.1000 -48414.6241
         6 129843081.0136             nan     0.1000 3881.0586
         7 129627119.4225             nan     0.1000 -27883.7394
         8 129562231.6977             nan     0.1000 85271.6322
         9 129456797.8307             nan     0.1000 116586.0880
        10 129420144.3663             nan     0.1000 -16396.4845
        20 128666689.6843             nan     0.1000 -98595.2614
        40 128157780.0944             nan     0.1000 59072.9242
        60 127573977.8065             nan     0.1000 -5180.6959
        80 127280993.4348             nan     0.1000 -127408.2065
       100 126849526.9826             nan     0.1000 -99181.3441
       120 126717795.5845             nan     0.1000 -256908.3031
       140 126344396.2337             nan     0.1000 -124698.6882
       160 126107699.1694             nan     0.1000 -98725.2740
       180 125958189.7991             nan     0.1000 -66487.1329
       200 125844721.4223             nan     0.1000 -85278.4859

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 130646791.6176             nan     0.1000 251286.5980
         2 128484387.1654             nan     0.1000 5088.7345
         3 126497170.4903             nan     0.1000 -192671.9550
         4 126405803.9444             nan     0.1000 110569.7554
         5 124832287.3640             nan     0.1000 -335914.5834
         6 123813387.3968             nan     0.1000 -722557.1282
         7 121915239.0851             nan     0.1000 -136588.8437
         8 121265129.1458             nan     0.1000 -1459937.6427
         9 121241764.0575             nan     0.1000 -53607.6004
        10 119859606.5619             nan     0.1000 -709844.2538
        20 116874927.9414             nan     0.1000 -678546.3224
        40 113958467.4364             nan     0.1000 -863314.9511
        60 111847907.2242             nan     0.1000 -482399.3046
        80 108045468.7674             nan     0.1000 -412970.3639
       100 105620336.5282             nan     0.1000 -280736.2717
       120 102170987.2371             nan     0.1000 -249517.4506
       140 100118419.8416             nan     0.1000 349102.0852
       160 99380361.0051             nan     0.1000 -490505.1614
       180 97713195.3661             nan     0.1000 -198394.9247
       200 95881254.2445             nan     0.1000 -283354.1015

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 128587204.0433             nan     0.1000 -25965.9782
         2 128474132.4328             nan     0.1000 63542.3174
         3 128225174.8963             nan     0.1000 127592.4515
         4 126794569.3922             nan     0.1000 -219067.1147
         5 126985237.0501             nan     0.1000 -662073.9428
         6 127027852.1910             nan     0.1000 -191019.8477
         7 125282832.2175             nan     0.1000 152489.7818
         8 123230453.9825             nan     0.1000 -51565.1377
         9 121879808.2341             nan     0.1000 -226465.0783
        10 121832222.4964             nan     0.1000 -54655.9179
        20 113122234.0611             nan     0.1000 -883756.4566
        40 106893865.5415             nan     0.1000 -456365.0560
        60 98863213.7726             nan     0.1000 -99130.0191
        80 92052996.7440             nan     0.1000 -387085.8779
       100 88384224.2925             nan     0.1000 -826361.4784
       120 83110671.6518             nan     0.1000 -493297.4643
       140 78550879.8889             nan     0.1000 -210673.9571
       160 76390903.2739             nan     0.1000 -186878.2156
       180 73603796.8387             nan     0.1000 -221265.5664
       200 69790724.0367             nan     0.1000 -234956.4104

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 128581277.6242             nan     0.1000 86776.0787
         2 128420283.7359             nan     0.1000 138249.5923
         3 128276699.5569             nan     0.1000 86916.9151
         4 128113178.5273             nan     0.1000 29612.9823
         5 126098619.2013             nan     0.1000 -224163.1870
         6 124796032.4099             nan     0.1000 -366270.4758
         7 124988573.1433             nan     0.1000 -543915.3156
         8 124961075.3487             nan     0.1000 -8346.3210
         9 123493060.1668             nan     0.1000 -364990.3751
        10 122270987.6153             nan     0.1000 -866513.6815
        20 112866303.5696             nan     0.1000 -264070.7795
        40 107975544.5640             nan     0.1000 -756156.8827
        60 101100099.1092             nan     0.1000 -780659.2718
        80 93213007.6467             nan     0.1000 -422614.8875
       100 87819139.0672             nan     0.1000 -67967.0050
       120 83669677.0815             nan     0.1000 -501165.4515
       140 80098042.9224             nan     0.1000 -740480.3327
       160 76838331.7168             nan     0.1000 -953040.3365
       180 71347150.0457             nan     0.1000 -551941.7181
       200 66923057.6042             nan     0.1000 -8903.2409

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 21696268.7370             nan     0.1000 83045.3349
         2 21633861.7304             nan     0.1000 52990.8212
         3 21546258.6694             nan     0.1000 32969.1406
         4 21491320.0106             nan     0.1000 -11634.9529
         5 21418994.5233             nan     0.1000 -8862.4766
         6 21384921.9789             nan     0.1000 37076.1235
         7 21338135.1911             nan     0.1000 19035.2389
         8 21274129.1756             nan     0.1000 -29088.2917
         9 21240037.1089             nan     0.1000 7986.1030
        10 21208658.4644             nan     0.1000 28428.5081
        20 21014031.0284             nan     0.1000 -7159.6087
        40 20898556.4955             nan     0.1000 -10286.0003
        60 20816307.4700             nan     0.1000 -8107.3432
        80 20782122.7997             nan     0.1000 -55128.2399
       100 20719606.5749             nan     0.1000 -33464.0664
       120 20684592.6405             nan     0.1000 -14429.9843
       140 20647911.1658             nan     0.1000 -30618.2678
       160 20598285.5252             nan     0.1000 -45132.5771
       180 20571690.0330             nan     0.1000 -73521.7409
       200 20575553.5731             nan     0.1000 -36732.0875

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 21595978.1594             nan     0.1000 72388.2755
         2 21549446.2766             nan     0.1000 56197.5931
         3 21393042.8053             nan     0.1000 49883.8836
         4 21291938.7763             nan     0.1000 6386.5184
         5 21254452.1414             nan     0.1000 22943.9965
         6 21128711.8898             nan     0.1000 52397.7312
         7 21034963.8483             nan     0.1000 57415.3126
         8 20962388.4308             nan     0.1000 -30946.9842
         9 20926658.0835             nan     0.1000 41484.1485
        10 20848471.4958             nan     0.1000 31139.2953
        20 20524891.1468             nan     0.1000 -47736.6089
        40 20285128.3170             nan     0.1000 -10106.3774
        60 19995580.9656             nan     0.1000 -15441.6395
        80 19874953.4231             nan     0.1000 -31030.6081
       100 19751638.7541             nan     0.1000 -64439.4988
       120 19609701.7713             nan     0.1000 -39990.8784
       140 19512116.8732             nan     0.1000 -23722.0733
       160 19387056.4707             nan     0.1000 -31587.2691
       180 19325131.4505             nan     0.1000 -26500.9957
       200 19273903.2407             nan     0.1000 -5670.6321

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 21514356.1280             nan     0.1000 177265.5552
         2 21328907.8095             nan     0.1000 107278.8773
         3 21158140.8125             nan     0.1000 55123.5846
         4 21052453.7054             nan     0.1000 11048.1880
         5 20946896.8947             nan     0.1000 44275.1129
         6 20882135.4021             nan     0.1000 35656.2979
         7 20695834.4630             nan     0.1000 127820.8906
         8 20641150.7301             nan     0.1000 24035.7925
         9 20600342.1049             nan     0.1000 36452.6662
        10 20528534.9955             nan     0.1000 -4051.7262
        20 20156942.2599             nan     0.1000 -34577.3515
        40 19727075.1177             nan     0.1000 -80361.8657
        60 19507158.7481             nan     0.1000 -37182.3700
        80 19295693.8106             nan     0.1000 -53583.7857
       100 19080821.2769             nan     0.1000 -3777.8807
       120 18892032.3642             nan     0.1000 -37353.2798
       140 18716520.5094             nan     0.1000 -10095.5938
       160 18446329.3424             nan     0.1000 -6380.5467
       180 18320140.5667             nan     0.1000 -60919.1823
       200 18117854.7758             nan     0.1000 -19446.0020

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 21572800.8487             nan     0.1000 84179.3298
         2 21344278.9023             nan     0.1000 105000.1785
         3 21213464.2560             nan     0.1000 18455.8489
         4 21029195.3933             nan     0.1000 111516.4949
         5 20958465.8599             nan     0.1000 -14413.6546
         6 20814236.3748             nan     0.1000 105649.1301
         7 20720330.3239             nan     0.1000 56889.2995
         8 20574412.9762             nan     0.1000  -83.7909
         9 20480802.4683             nan     0.1000 -36668.6502
        10 20412046.5494             nan     0.1000 -12844.1951
        20 19989859.8207             nan     0.1000 -89017.4403
        40 19379221.9691             nan     0.1000 -50685.7606
        60 18955820.3473             nan     0.1000 -91005.0584
        80 18679129.0780             nan     0.1000 -64300.7696
       100 18466426.1239             nan     0.1000 -56149.3084
       120 18202260.8958             nan     0.1000 -43050.5085
       140 17971838.4207             nan     0.1000 -34036.3892
       160 17762661.3661             nan     0.1000 -44751.8579
       180 17528247.1634             nan     0.1000 -14221.8576
       200 17299484.5936             nan     0.1000 -20016.1083

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 127728283.8911             nan     0.1000 71020.8411
         2 127407417.3763             nan     0.1000 37729.0026
         3 127335364.7330             nan     0.1000 87685.2309
         4 127280063.8291             nan     0.1000 75809.3835
         5 127046186.5318             nan     0.1000 36843.8076
         6 126853748.2595             nan     0.1000 -61472.9252
         7 126720844.2031             nan     0.1000 -33303.9015
         8 126567120.6919             nan     0.1000 76320.2480
         9 126409855.7409             nan     0.1000 -21682.3676
        10 126445312.5430             nan     0.1000 -114760.8165
        20 125901584.2557             nan     0.1000 -108972.5357
        40 125174408.3729             nan     0.1000 12017.7454
        60 124723004.9175             nan     0.1000 32610.0910
        80 124357573.9590             nan     0.1000 -87510.9654
       100 124137773.2614             nan     0.1000 -140446.8480
       120 123759958.6532             nan     0.1000 -164577.4427
       140 123411291.5094             nan     0.1000 27648.3516
       160 123258197.4141             nan     0.1000 -130881.1209
       180 123200751.7385             nan     0.1000 -115228.8922
       200 123185519.7938             nan     0.1000 -156989.3321

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 125675334.1882             nan     0.1000 -45083.2978
         2 125608176.9931             nan     0.1000 39710.1847
         3 123801170.1349             nan     0.1000 -701283.8771
         4 123845879.1893             nan     0.1000 -163355.4087
         5 124130255.0443             nan     0.1000 -768464.6961
         6 122350170.7464             nan     0.1000 -248146.8990
         7 121084311.8664             nan     0.1000 -387946.9517
         8 120167497.0590             nan     0.1000 -938700.9520
         9 118680649.0400             nan     0.1000 -141009.7708
        10 117573014.1726             nan     0.1000 -205611.4903
        20 116280930.9014             nan     0.1000 -906023.5558
        40 108420573.5971             nan     0.1000 -132403.5044
        60 107660548.7300             nan     0.1000 -641916.9697
        80 103451985.8548             nan     0.1000 -1035517.8049
       100 101553661.6111             nan     0.1000 -350227.3157
       120 101100043.4341             nan     0.1000 -920850.2789
       140 100152915.6113             nan     0.1000 -684786.0441
       160 98644465.6973             nan     0.1000 -453129.4766
       180 97156565.8388             nan     0.1000 95411.9443
       200 95833542.9524             nan     0.1000 -618688.9726

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 127565429.8891             nan     0.1000 171465.4355
         2 127183796.2110             nan     0.1000 577094.4158
         3 124866090.6327             nan     0.1000 -109698.9276
         4 123075315.9786             nan     0.1000 -117773.1054
         5 121534730.5035             nan     0.1000 -232956.9294
         6 121717208.1283             nan     0.1000 -493439.8263
         7 119919810.8513             nan     0.1000 -294434.9023
         8 120070195.0709             nan     0.1000 -459127.6418
         9 120214715.6435             nan     0.1000 -354078.0760
        10 119340955.0215             nan     0.1000 -128989.9557
        20 115368424.5745             nan     0.1000 -751725.9919
        40 110711006.0211             nan     0.1000 -1204495.2780
        60 106058523.8023             nan     0.1000 -563878.3264
        80 100784037.7543             nan     0.1000 -489730.6288
       100 96966500.4686             nan     0.1000 -432847.5484
       120 94647342.5542             nan     0.1000 -1036200.9689
       140 89662239.9749             nan     0.1000 -248316.1859
       160 85692303.0281             nan     0.1000 -200671.6012
       180 80446650.4896             nan     0.1000 -104922.0639
       200 77716750.4387             nan     0.1000 -787416.4407

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 127409421.8906             nan     0.1000 590558.4451
         2 127292150.9361             nan     0.1000 59282.8332
         3 125136630.4085             nan     0.1000 -102595.1555
         4 125103025.3418             nan     0.1000 13398.7951
         5 125172919.6798             nan     0.1000 -233883.4943
         6 125092640.4766             nan     0.1000 75644.1552
         7 123435561.4420             nan     0.1000 -131898.7788
         8 123300869.7422             nan     0.1000 9628.8751
         9 121789423.2775             nan     0.1000 -773779.2401
        10 121715556.2397             nan     0.1000  792.4314
        20 115540581.1046             nan     0.1000 -149488.0227
        40 110329431.8236             nan     0.1000 -443052.8406
        60 106742763.1675             nan     0.1000 -1009982.8669
        80 94976347.4179             nan     0.1000 -1029033.3397
       100 90288977.2031             nan     0.1000 -590347.1391
       120 84031533.4396             nan     0.1000 -535672.1850
       140 80199664.0437             nan     0.1000 -756203.8635
       160 76608272.6002             nan     0.1000 -210292.8960
       180 75031862.7990             nan     0.1000 -209193.2508
       200 72728428.9546             nan     0.1000 -219700.6159

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 108773125.6185             nan     0.1000 11833.0238
         2 108440646.9355             nan     0.1000 62533.5326
         3 108387480.6695             nan     0.1000 21461.1230
         4 108305877.9452             nan     0.1000 87712.9453
         5 108082022.2335             nan     0.1000 23415.9868
         6 108042573.3231             nan     0.1000 55919.6107
         7 107918408.2188             nan     0.1000 10553.6389
         8 107867479.7753             nan     0.1000 58579.3819
         9 107852493.8311             nan     0.1000 -26319.8030
        10 107837113.4211             nan     0.1000 -27978.3610
        20 107312579.0388             nan     0.1000 -109147.0767
        25 107179843.5353             nan     0.1000 -24086.8671

``` r
test_pred_boosted <- predict(boosted, newdata = ChannelTest)
m4 <- postResample(test_pred_boosted, ChannelTest$shares)
m4
```

            RMSE     Rsquared          MAE 
    4.176166e+03 9.051662e-03 2.208733e+03 

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
    1 First linear regression  4201. 0.00402
    2 Second linear regression 4178. 0.00504
    3 Random Forest            4310. 0.00459
    4 Boosting                 4176. 0.00905

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
      model     RMSE      R2
      <chr>    <dbl>   <dbl>
    1 Boosting 4176. 0.00905

When comparing all 4 of our models, we are looking for the smallest
value of RMSE to tell us which model is the best. In this situation, we
can say that the smallest RMSE is 4176.1662246 and this comes from the
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
