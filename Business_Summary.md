ST558 Project 3 Group F: Business Summary Report
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
data_channel_is_bus: Is data channel ‘Business’?
<!-- str_to_title("social media") ->> "Social Media" -->

Here, `read_csv()` is used to read in the OnlineNewsPopularity.csv data
and we are subsetting for the data_channel_is_bus: Is data channel
‘Business’? variable.

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

We now subset the data for the data channel of interest: Business.

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

    # A tibble: 6,258 × 59
       n_toke…¹ n_tok…² n_uni…³ n_non…⁴ n_non…⁵ num_h…⁶ num_s…⁷ num_i…⁸ num_v…⁹ avera…˟ num_k…˟
          <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
     1        9     255   0.605    1.00   0.792       3       1       1       0    4.91       4
     2        9     211   0.575    1.00   0.664       3       1       1       0    4.39       6
     3        8     397   0.625    1.00   0.806      11       0       1       0    5.45       6
     4       13     244   0.560    1.00   0.680       3       2       1       0    4.42       4
     5       11     723   0.491    1.00   0.642      18       1       1       0    5.23       6
     6        8     708   0.482    1.00   0.688       8       3       1       1    4.62       7
     7       10     142   0.655    1.00   0.792       2       1       1       0    4.27       5
     8       12     444   0.601    1.00   0.755       9       8      23       0    4.81      10
     9        6     109   0.667    1.00   0.737       3       2       1       0    4.73       6
    10       13     306   0.535    1.00   0.705       3       2       1       0    4.58      10
    # … with 6,248 more rows, 48 more variables: data_channel_is_lifestyle <dbl>,
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
    6258 

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
     0.0000  0.0000  0.0000  0.1807  0.0000  1.0000 

``` r
# 32. weekday_is_tuesday: Was the article published on a Tuesday?
summary(ChannelTrain$weekday_is_tuesday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1899  0.0000  1.0000 

``` r
# 33. weekday_is_wednesday: Was the article published on a Wednesday?
summary(ChannelTrain$weekday_is_wednesday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.2013  0.0000  1.0000 

``` r
# 34. weekday_is_thursday: Was the article published on a Thursday?
summary(ChannelTrain$weekday_is_thursday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1956  0.0000  1.0000 

``` r
# 35. weekday_is_friday: Was the article published on a Friday?
summary(ChannelTrain$weekday_is_friday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1378  0.0000  1.0000 

``` r
# 36. weekday_is_saturday: Was the article published on a Saturday?
summary(ChannelTrain$weekday_is_saturday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.00000 0.00000 0.00000 0.03811 0.00000 1.00000 

``` r
# 37. weekday_is_sunday: Was the article published on a Sunday?
summary(ChannelTrain$weekday_is_sunday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.0566  0.0000  1.0000 

``` r
# 38. is_weekend: Was the article published on the weekend? 
summary(ChannelTrain$is_weekend)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.00000 0.00000 0.00000 0.09471 0.00000 1.00000 

``` r
# 60. shares: Number of shares (target)
summary(ChannelTrain$shares)
```

        Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
         1.0    952.2   1400.0   3146.5   2500.0 690400.0 

``` r
#contigency tables
# example: table (crabs$color, crabs$spine, crabs$y)
# monday is the mot published articels... compare to diff of the week
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_tuesday)
```

       
           0    1
      0 2758  832
      1  792    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_wednesday)
```

       
           0    1
      0 2708  882
      1  792    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_thursday)
```

       
           0    1
      0 2733  857
      1  792    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_friday)
```

       
           0    1
      0 2986  604
      1  792    0

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

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAqAAAAHgCAMAAABNUi8GAAABjFBMVEUAAAAAADoAAGYAOpAAZrYBu8ABvcIBvsMBwMUCuL0CwMUEtLkEwMUHrbEHwMUHwcYLoaULwcYMwscTjZATw8cUxMkfa20fxckhx8wzMzMzycw3zdE6AAA6ADo6AGY6OpA6kNtNTU1NTW5NTY5NbqtNjshVz9JX0tVc1tlmAABmADpmAGZmOpBmZmZmkJBmtrZmtv9uTU1uTW5uTY5ubqtuq+SCTkqN2duOTU2OTW6OTY6ObquOyP+QOgCQOjqQkDqQkGaQtpCQ27aQ2/+R3uCZ5eerbk2rbm6rbo6ryKur5P+xXli2ZgC2tma225C22/+2/9u2///Ijk3IyI7I///NaGDbkDrb/7bb/9vb///ebmXkq27k///ocWjr6+vuc2rwvLnydGvy8vLzoJv0dWz0wL31j4n2dWz2hX72op33dWz3d273eG/3eXH3e3P3f3f5d275eG/5enH5fHT5gHj5h4D5k436p6L8yMX/tmb/yI7/25D/27b/29v/5Kv//7b//8j//9v//+T///9Ni/biAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAgAElEQVR4nO2di2Nbx5Xe5dh68CWSICGApNe1nISBs21Xu4mlxLXbpFlmG8t9xLXUWjYpqtBCNwRwL/EiZbv1i/94z3dm5r5wgcEFB8Bccj7ZJHEfAwzww5lzzrxuXDg5Wawbi34BTk7j5AB1sloOUCer5QB1sloOUCer5QB1slomAD2yRfa8klnKmloaQEcvB2jhZE0tDaCjlwO0cLKmlgbQ0csBWjhZU0sD6OjlAC2crKmlAXT0coAWTtbU0gA6ejlACydramkAHb0coIWTNbU0gI5eDtDCyZpaGkBHL9eT5GS1nAUtnKyppQF09HKAFk7W1NIAOno5QAsna2ppAB29HKCFkzW1NICOXg7QwsmaWhpARy8HaOFkTS0NoKOXA7RwsqaWBtDR6+oAWq8/3tlZ9IuYhyx5vx2g+VQ/fvjwehBqx/t9dF0ArdfrRt4tB+jcZQAdvRYNaP34+NgIoQ7QucsAOnpdGUCP6o+JTwfoHGUAHb2uDqBHOzsO0LnKADp6LRpQYz7oERNqqiib5QDNq0W/UaHseSWzlDW1NICOXg7QwsmaWhpARy8HaOFkTS0NoKOXA7RwsqaWBtDRywFaOFlTSwPo6OUALZysqaUBdPRygBZO1tTSADp6OUALJ2tqaQAdvRyghZM1tTSAjl4O0MLJmloaQEcvB2jhZE0tDaCjlwO0cLKmlgbQ0csBWjhZU0sD6OjlAC2crKmlAXT0coAWTtbU0gA6ejlACydramkAHb2sANTQoGU3YHm+MoCOXjYAamjaxzWZ8jF5Jff392f6Sgygo5cDtGCavJb7jx49mimhBtDRywFaMDlA8+vSNXU+6ORygObXLN+EXLLnlcxQzgfNrZm+C3lkzyuZpayppQF09HKAFk7W1NIAOno5QAsna2ppAB29HKCFkzW1NICOXg7QwsmaWhpARy8HaOFkTS0NoKOXA7RwsqaWBtDRywFaOFlTSwPo6OUALZysqaUBdPRygBZO1tTSADp6OUALJ2tqaQAdvRyghZM1tTSAjl4O0MLJmloaQEcvB2jhZE0tDaCjV/EBjQaTXovxoA7Q/FrouxQNx78eI+odoPm10HfJAbowGUBHr2sEqMEdmRYqB2heLfZtCrnTAGpwT7vFygGaV4t+o6QcoHOWAXT0coAWTra83w7QvNLESM4HNSwD6Oh1lQC156ObqayppQF09HKAFk7W1NIAOnoVANCJm+brkQZ1gObWbN+GiYMbl6ifswygo9dYQL/7zefpQz/87v4vvrq4+PL+/fs/Vydn+zY4QFNygCp9EzGo9NOfP7r48pcXF599FDs4s3eAG3cHaEoOUKnP3vsLLCjZTOb0hw8/Fz/Irv70L5/ELrxsRUc5mRLNSX1QB+icNWs2Wfom/rMP2GYKQL/77VcXP/z+E4L2/n02ooDiki/h/PXr1+f5TpxnHd4x8FqcbJMWUMIRbH5zH/rgm18woN/90ycXkRW95BdxZBs+6sSI486CzllzwHMSQGEs3/skaUH5bOiHXrKeo53MEY27A9QOzZpNlh7QD2WgFPdB+YApQHP3QTpA7dAsuQw1kQ+Khl3opz+zR4oDP/2X+aSZMjSC6OvBpwM00ncyin8vitmjPGh08FK1NDiEo+CATrhitz21nCGWkRbdk2RwEFzBm/gJ9zywqJYG0NHLAWqLHKCZcoDaovyAznoXD50MoKPXogF1PmioyXiLAJ35Pkg6GUBHr4UDalL2vJLZyQGaX4t8kxKy55XMTg7Q/FrM2zPsGxS8iZ9QUS2dDzqhFvLuDEdXBQ+SJpY17YQBdPRygBZODtC8mt9bEmvWHaALlwF09CoUoAkoh3xQB+icZQAdvYoL6JBmAaiNiz04QPNqbu/I3AG1crkcB2heze8tGWvQcgOqN48O0HEygI5exQJ0rPICOpa+et0jfB2g42QAHb0WAOil/brR45WNAVo/btQbdNZCH3TCSs4hi28AHb3mD2iMi9xzPfj6UWDNAlD7NGEt59EPagAdvRYJaJyQSVhV8+QnAXSi8uLXJG9wgE4gA+joZQmgEzl7OQDN7TymbxA+qIVygOZXznqFtmpKQCfxQS8NqL1yPmhuTV3DiLTJ+Bjfbl8TQF0Un1smKmsiXI7bltzlWRivj5ADNK8W/UYpXbojqRiQWvN+G0BHrysE6KW7OgvSzNvyfjtAc2o0oBNaxmIAmvNbOMNgyQA6el0HQCcFrxCApmqp42+W6SYD6OhVKEAnj+ITd6TAG11KEXzQZC21/E0C6LRG1gA6ehUJUI2FywBU3JG8rxB2crTMAzq1kTWAjl6FBDTb0o0ENNWnea0AncA8OkDHKdUFPraNJbQa3ui+ztGAJsq/UoCaiIEcoGOUan0bjcYQO/GJcl5juMkOlfrohPuZGgJybOcQujwyP6/F+aCjlWTNI3a8cVdk+ZShkoBmXVQ/bjRk+QWm1JasyRUGdFQffAag0mgmL5/EB810Pxv1ujDRudfFt0gO0LzKW7GR40CHm/j0uMxx+GQBmgLRa8jCcu8sYo8mbeJnP5zJADp6LRrQ1Jk0fyouGnNJKAmouiAzBRrmAQoL6KQdunMYEGoAHb3sAjS8ImPIqPZe8dHhAm/kML6o4PG729krB2h+5a6Zzs8bM20pM/YR14SANhpZLsSkHfKW+6AO0PwyXvMxZizjlDqUCegkZRZLzgfNLeM1HzvfcsjCJQHFbKKs268MoC6Kzy3zVR8331IHaHhNVpJ+0ue0WQ7QvJqmcpPjoB/qkfBBR16pecbiWFgHaF5NUTfNBM2sS7MeJZSYNEfKR5wDNLcMoKPXYgGdhIpJAa0/fhwCioR8pic6+lm8rMjKnMyFLOb74qeVAXT0sh3QOit5YPgSLvHhw8fKB+UuzQzrzKOZsox2ukPAtENqLukzg0Ump5UBdPRarA86xqOUD4YuGCZWsZ4GdPhJRxvWUT1OppQJ6FRW1QGaX5eo4+iYPOuROJBKc2YBmj1qibm1B9DprKoDNL+M1npaQMkHfUZeqDyW2VU6BtC8OSmdhoxjhrWcEtCtrS0HaD6ZqvAkM9wyOorUJc+ePHn4OF1kcjQpDOtE7uUlfdCJ2JsO0K179+5tTfWijMsAOnpZBOjYwZ7RVWkfNDzx5PHjJ2MBHaZ9Vrn5ydibygd1gOaXofpq5sRpb88CNLNTKfmEw0P86pd4FUIzHKnhAM0vQ/UNnckoxMl1+8MnT56NWFlkhN+Jw6MG9F3ODTU/UiMskXzQRb6OmAygo5dFgIama0SSSKfHjx+PiG9ja+YO5bDC8aPhQGfx/bCsZym0ybmi+Fku23AdAB3R8o4GdKwTOWZtpqyB9NKZ9RoNjrqia8TTXxdAL+GNGEBHr0UCOooBnjmUBe/Q+I/E4zEfnVrQe3hNZ9hLP9nUy4lLl46gKpWK/Mvk5HUHaH7lrVjUmI6aGJQ51GN4oGcK0MdhHnS4xCHHMnbESwJqyHZWCEtBqJGQSUGeL1E/2boilem+QAbQ0WsRa9RrZ65lnsuYy5FMTD1++HAoD5ouLj3hWYwRSa3xYCb7ZBhQpdGATmmn6VVO+foMoKPXIgEdR0ImoEOz4bgANZd4EkDjhwThDW9G23nMBND9/a1RgE7/LNPeaQAdvRYDaGoq8cgxSvEpxKP6QMOYKqsnacwTiFLggWZktUwYUaM+qCzo0aN7Ww7QvMpbseGxl5LZUVM4hzPqsSIUoPXjJ0+eDT3V+KQ77g2C4aSBZSF8qEkAneLbMOUXyAA6ei1m2nG6A1IsIOKl+zqTgCYLUEa4jjyRJ449FIkjz4uuo3Op4CoxJhQ3jwN0YROVspkZB6i8ZR47eEkZQEevxQMqBmlGgA5H2sNOQSLklqcAKErwYws8sYVsJIMrFbaHj/xGatNDQfRCdzsehdkYH1Rz5wxkAB29TACaX+fn5+rPQX9wfnZ+Pjh7/Xrw+vXr84tz/pm8jk+fx+4Pr4ldfX7+GI96dNNAXUcl989en8XuxiWDs7Oz8+gZYq8mvOKcX0z8tcxVtYODg1rmGY7ip7pTnq+NO2ufFt3VWW94gR/Iht3zVHusW1Ake8DnTj1lQVU/USxQjy4Zv/pNdkf91Mrp5o22g9o86PhnMmlgDaCj16IBBZ4M6FGY6fRSafoohM/sXYod2zmK+6AyD8DUx+MrElbRS/oZXjQCPwS04Xu+N8WwFaUYKrm5GI3ZpQbU71d20y/E9cVnSzDjtf2WHxwnAK2HKymLS7jj0/Pqkb85yvYlPjm5lmPS5zxST5S0juHCpLHEqOe36VkvsSd3HEqThusyfD7a3d9NvhDX1ZktrxFgdHsQtJttIoitnCcBlTG9pBRxji+X/haLhWZPqqdHiY9OQpcANJlXjfKf8Cx8EY6p9UjrILWAgI41iPQydiv76UMO0GGR60n/6vWm7wetuieCbW7cw/4dRWOD7FggwWzUGevINiYy941ncZioda77osH2omxA7I7YmBSPXkIgx46EgAa+LwAVXkLuOiY+eoMDM8d7oGN5yzjrAM2UBNTzfb/lqWxQmF0SLqIyl0G7Lampe5yzjNnGOKCN+pOY4+oFntdWHe0qX59ItMbR9cjPEFyqznk8T9vnXFNjyqZ+RqOFLwFo5tw954NmiLDzAmrF261Wuz4MaBB4yuGs+/SA/vNCh5QMaoPOx4bFyRZbACqn3jW8duAnuu8T8blKdiYHrtRFQMUPQgM7NaCX0RhsLgOovvQcMoCOXotbuIGaVaLI9zjHlIi04wuDcLNOgAovVMRRdITT+mrkexhZPYzwOyZfoO6HaYHwWZVrIIeeJAeuRL2m6gr+Yz6AJqAZx9kQoMk7J2DPkEdsAB29FjxgOQiiTz7KbTbQQKtrgGPbayvXkEMp4Ko6Ro/J3srOzsd11QkE9oNGLPCKnrSeGP6Z7OAnQx2E2JL7Icz4lD5oXGOwkackNMlHmSWkAR2N2yhyHaDjlOhqb0T5pJhLCUoaUerJD7yG74XtubRsElBA5cvLd0SJbDXp+oZMTaU3skl0YsZfDj1Tg51RiAr1Wg14Ipe3nZXd3XT0rBSO8eDf8UfxYcT7XIL4ezSgqa9BMkqL5xSoMAfoCNVjHUWR+xjF5iwv6h7n1DsBSwFL7OYwIc/OLIlN6A7K8OTYkDCZGuuaCseNgD8vfDmqgW+0m+228hfaAeEZtL2pJvAltb+7X6nsZhutbECPKpXNWEpof3d7s7IvoYrt1JkcHpI2jA5QqVy1ykicC9dPpoXCi+IXoBkXSVEJMRpd5o5CKIBFBpOO74j4Xt4dbYoU7x1KZFQTcRPd3Gr5fltkYr0WRVmBHOqUe1BT0pZFgA439RFelUrCggIiBXVlv7K9OQRoeoDdSEBxwQyysgbQ0WtxgKaCIq8h00LikJzldpS0fKrHB79bxJoftAK/7ZMP4MNp3VEZUnYZ4pNDFYeNhs99UtR0S0D5DgFo0PZbQavt10WW3m+2EZE1vPT3Ra8UAfuPdre3EwYyfm0Cr8gHTQK6v3lXPRgCdNTjpEPrfNAJJfvCyb4FcowymUEKyomndjtASy7a2yAIc53CBCJckRYUgUvTQ3DvtVuEETr06cROPPRJrP8gBoYijQqz6OHPdiMJqEjL0rOKxwjfPBkdXRZQwMF8jBtUPNQgV6J+8332YeXZkYCOCsXGRVyXkQF09FrMeNAGLBnBwLkin4dl0F9BM2hS5MyzgD0AHB9TxC5lmFf3PLTGLbqP2IwAjS87Gs1hqofT39vtpt+E1cUdjVjnkhg0Tb4sPX9D5L1iSajca52MHM4pQ/XhHsf0PYLnkKM4UWkf9GjkY82rGX3HZDKAjl7zb+JlCI0AuX1MfPltGXeTFxo0myJ76bX8IAYom78Gcws3tU7uYbPZbrSOqYFHht8XYf/jhAtLBpEjeYUrzHar3QTZQSPpg4bZgbocvSxLkAabTXw+Ezrig1dhTdR6Z0M4rqSRiXoqVkX6o8pQjf4IrzWfDKCj17wBDWlp+c0mGTMymUQabJd3RKwKQBtes9VkmxjmzwVSauR9g7yBlt/y2FWFX9oIGn7de8iuradyocgRqYH6xFogACWy4e8qdzeWu2e/lx/Lns+wT9VMskkK83xDQHWIVHaHov/RgO7u74+PziMLnn72lMWeSAbQ0WshgPJEohZByAatTaaQPdKG3yZgyQdF1MPBCt9Rr4v2mY1hCGhA/2IZTHYUnsAJ4D5UMBoQhe0YoA1k4fHFYNrqYet/FI+hOARr+WLsiHRQcZt3+WSTlHAvt2WiR9d3nsHcLADlP/LaUwPo6LUYQPGr3QrQQJMpJIYAE7FFDiJbLWr5W4GwZ75YVz6eHsLDFjmJflRoBCgFTSrM4Uw7z5rjO9t0D57OixIEZBsDn0eI4LfsH4Cv4fPoO+VgeF7YszW5RrbyzMLuJQHNLD3D3GY895DhrFQqDtBQsuOQ+OFIxWuTAeWRdwCU1KTGlfgkWxrwnHUP0FB4LdtytOuJcfMiKyAGmzxDXtQPWiJZ3yD6yQ2lZ0EzjXiKHpExFGNQRJdpG2ERNfcYt+SLEVYCUDElBE+S6pCdVCMzSikWVIA/qpTIrQwXvxlR+tEEbXTKB2VhhYlNB6iSHDLHsPnMAtpR+ptjH+LL42Eebe7AhNvo1QW/7LnSvUGyYzwceeTxgGXyHpvNlvBBgzbKRnFEKFxdz4dzgBaeYyb6dlBjzoP5GFB4B7iYMG95YVY/ygbk0uihl7nS5rH4Jlw+THdPTvESKM4HlSIWWn60iZGkQMTOAlA4gDyCiAEliBpePQYoRVL1IGgJg1qPx/n80RFnQVv4AxwmNRpo1H062iToYZHpKdqcxIJn2WxjSD+el+kN2CXgb4scOAVg08ugTKSh7HiqtzF32jwO6ERTiybFLVqjJ6cMoKPXvAGFe4koOjbjvXEsOhTh7DXRL8TtLAhqELkcnrOLiuEfPPLOp7gKjTM7B8KpFd2asC0IwCNAKf5qspFky+rDp23DkYCD20Kav01hWsDHmuywErtBK5ATS9hgN6Za73nYUI5ul3MDOtHMjcxk69ArhKI1evLJADp6zR/QBiGBBWcClYYESGCQI6CGz614XQ4kEWYsgKsoupJgBok0pACI0NAWC0wBKPKl5G/iGEHX5tx7k4ptoYuI/VWvhcMN7lwNKGJvkd9Ll7boNWC0CJUuYnaZPsAQvGkj+HSX54hEemU8SFKKo53R7kP8CRIT5LRdV9PIADp6zb2JR2AUsLHiIJzTlpyxFEnOho9GOZBGC4QEYnJlOEQpoHYZySm0zn5sVJ4AtE7XN9FLiVQA2cO6h2lPZIdbQZvDfzKlLe5+Qud7gFGjKIaQJ5eiXUdyttkMk0r4fsBMTzv3eMLx7RNNXkpa0ExAE8cru9tRb0DW63CAZkqMP2rCCoZD5hlLJHMQUNO5liSETjTbbfSIB+EyyLjUI0K9FiHVFkkkmWNnH5QIbnF0hWH3ZIrJp2215CwRkXHnQAzX41ayll4TJxG5txpNTuS32mIonhgX6l9icvxEfqAuYkqOqtvfEpYyPfgz5lHAJIcDVI6GVgAdOSg6pwygo9f8++KJIPQDUdDSiOZRklnjhhf2kwBqisVGiAzuPGd3VMxfE6NMfFxMrbxH7mID9lEkVx/XBaBkCxscrjdgRP12s+GJ/n5exsRTEzswnk4OBmCSycloSvnoVBWuKr4fl1i9Ia2Qq4z4/CjDcwzpCnOY99JDmsMIXF2C5GklPM8jo7JGhl52yIgBdPSaO6AEEFKfZKo43VMXDXuDGm1kPtHTSXYMgCBNBGzJBIY95MiG+mjEKZZqEm8YW4JmXAwWPX54TA4q+to9bpfZTtLfQdsTI5mQ9+ShTGIWvswpsb9LTwSb2hZ8EtRevYUIH6OcGtOMCI2UHcnHk+rxkH53OzG0OUaX8EEVoBhivxuRK34IZzYENGrfE6PzTaWoDKCj1/zTTHAO29TIttCzyZMzMJSJgndYxTZMnoeoBvxwThOWTW280UAQH9RbHCbRf3QH+ZieANRrPGlw92lLDJYSuVGRABVTmxuidRcdBTDGgUJPTIwH8m32Psg4e/Tbb8nJeZdYpCkMX5ID7jK6iNgI7m5vbu9GRlYMDEWyPmlBcf92CtBKouzIVI8GNBFU5banBtDRawFBUotsICIRRgHRCyAgswrcEN8QkjyomQClmIVnHKsJnA2KZmDeiGW6HOYVZQA7JvAxHePBdLLHHsPwPZ4JV2cLirhfDJLnkzyiSU6QQydTIL1jgN+igkA7XeQjS3VJQJUhDBOYw4DuE5i4cJua+Gjp8E26bVOMBo35oKKLafNRNqDptECGDzq8lugUdtUAOnrNPc1En36rjZHJ5GxSKA4z2EL+RxlQpIY48jluUGNNNi8I1/kSHfhk5GBZ2QcVwztbTdHjE7wAW+Q6BLDMyNgjTuekkxg/RWEZxvHxoBFyb7n/VCzUgFiejHWd/Nc2Q4+R9VwWzCyS+EYA3Qwnz4V9mOHIt90K/UNsU1EWVFlPkTAKIdtRpVYkh8oHHc1Y2rPNGJfqABWCj9hUxg+goUFt8wyNgActeUCEh7IjQdSoyxF1vNAcekYpimrBiz0OmFOilUpiU9ioP2MHMkD0wyPkMRWESFbdQuRHAGY8PZY08fkinvuB5UvIr8WAKh951hYhLMYDEN7CiF/OBxWA7m5HZjMdSktA451EodkVGc14X/ywWYyVOfwgvWhYZZu/BIlxqdq8/pAMoKPXvAElAyYcS8TsoBOgttDDg855TGdvkpfZFAM10LEjl/mghraFdUjIQW3zoJKWmIPZ5CaZF8jzg5M2x15sRtGuI4DHmHs5PR4dVU3+TtAXBB1RvFKo7HcP0KPEU5j5OxPAHcW4gHqbC82basoY7I72PeEc8vEI0P3KNtvU+OYLAsJkz+ZO6tbUBL3MscjCfwgfbZNd5ogrVnBG96lGBtDRa+4WlAe8tbgVFSEz+iLJfDbBCg+0g+XinCgAO5bZdY6v2wEZYF92QQY8RaTFrTo15hiv9IJTqKLU44BnZfrIBKCZ9+GZEmoB+5hNOBkU6rd4fjEIRrjFw6XxpaFTPuYdey0MxGu12nLEyaSKPuwUjQBjNxWlKxOmGuxEj31lPwqwZHEpQONZo8ispnBLuryV7c3KduzJhj3SiWQAHb3mHyRhV4024hByAtvMlyc6QJttXjOBYhIPhKDF5yXv0M0k0z9ohD0BaBNtscf+Apk6ROMN/wSmkU0gteR1sE6/yVTWA6xOAjj9tirJ5x5QDCXx5Wg/2YWEJw+aHudPyZByrJYTUNV0Ei/b29vJZjcdHQ0FzzGAJT6Ptrc3owOVLWU2Uwl89lhlcj7dpidmgxCf7E3IL4Bi2QHKEgsxNHkYETosmwHPRoIrKYYpeR5T2z4WfeHU7gYtwaFAEbbVRz7JV6E8cYXcUeA/R9gtr8TidG1enQzNNMYxY0wIAJYXoHeJUKcLGjyliWjmsc4ecqJUHlnbdgu+b5vc4uY0gNInfpca083oOPGwuV3JHPauiIsDLAHd3t3e3FQHdnfvxUL6oySg2+H8e3qwWcky1MKZuLu5r6xsxHLeQSMG0NFrIfskNRBMI9jmmKYhujd5qF0biUpE5m2xXGcDY59gXNkxhPPaFqD57Bq0ASqvAdJAJ/xLROJtbsE539nitDz5lxhh4uOhr0hHq83DUMgH5Z5VwhITTho84DTgcIn77MkNCLhDK08LLwKOFKBYvmZ/myjYTnKg8qO7m5KXaIiyBHS7sh22yLu7G/GQ/ugoFm4BUEZPBWURo/tKUXMffo0koM6CKlFzignozUD4leBEOKMtASimzPlywWMOUZrKWUW7jHa6wbhiLlMLfe2I7dFfeoiruFSKpjCjBICS/4A1bJr4Pqii4AEHHKQRwBheh0xqndMLcng+xvXhKeGPtHkwQJ4gKWx8ydmrbCqACE/8k/wlU/fi7G5qwIfwSzcpwtlWLXLlURzQ2Ah5urayebdCX4F9eSH5uzFjHfZJ7ZMfUDmK23lcmL2qxFgZQEevBYyo57GdL16+enn47NXL58+fPzt89vLk5Qn08vCQHtLfr148xm4Wjw/58Mmrk5MXz08Onz95+fLk2auTV/QfXfTkycvnT17gthePDx8/efj45YvnVNKTl69evDp5/uzZk8MXh08eP354+PLl8xeHhy9Onp/gVtbhixfPTuj4yeHhk+cP8bR08oRezZPHdN8hFfzw8Pnh4avDx8+ekQ33plqiCf5dZVPGIRUJqFwCpxLywuY2AjSWZFfe4SZ5lhHKa7thr2YsThLlweWV+O5LQGNfBAUo5kOJV1ARGVT2e7UzmtIygI5e8+/qhLPYCF6cdgfd09NObzA47w9OWd1Op9sZ9Hr4u8N7F52fhuqdd/qDXvT4tDPonL3udnFTt9Pt9eiGXp9u7nU6p71utz/odnq9Qe+81z3t0OVngx6e8LQr7z7tn3dOu/1Op9/vU7Hd/indgPODQa87OD8b0I29Xr/T7z6jVv4Sa4iJlPouN7lETEW0stt3t0NAhSHDJZXEZCUxOzmK4+W5HeGqMmXiCPrlN8Uz7EY5fYrQRJ+8eJ6w855vBY2q/1NdOGJW/UgZQEev+Ufx6JdpeIfEJhHU7/XPCQZBTZfouDh/fUbUdru8g9Y5MwOOe8TR+eBUwEYics4Gr1+fnZ0B0NPBGS4f0HW93mtisd8lVgeDQf+8L3jvnZ0POn0mE082OCMQO50O8Xw+OGM+Twd8utulLwzvLXY26Pfpv/4zHrU89cT4fbXMUqw/nIDd3gwHe6goOt5XH94WGxEi23VOM4l5GtKmYm2ybXEpr5cT5ZoqUSfrI+4v3ZeT5BKhGJva4by/Ttk0/PjxDeiNP4VHvv27P6nf6s/Y0YS+/tlfU0fmDijPo/SD58wkAUqgvCYMmbtO//xicFhbN/8AACAASURBVNbH3/0zsmHng76war3zPszd2Wlf0MYmEYC+Hki4cfnFRQeW8vVZ/7Tfp8NkM/vKPPf6g3NpPHt0e59A7OHMGZtY/noI89why07m+GxAL4ROk4l+gdRrkCdIgmDxtrZ2ttbW1rbWNlbWNu6tbfE2htAaHbl9iw7wka179+6pU+Jv3HTv3sbKxsrS0gaf3Lq3scHXi3u2lpbomh3xiM6trNzj01viEJ9TJ+lOKiJ8kq21FSpqY2trQ15Mt2+tbFTy93Vm0/Djx+/i19MItRigsetsBTQQaZ4T1VD3zl6jLWXT2IXdOhdEkfUj80gsdbowa/Q/tcYddZdoqzvnBDEfG3QG1FwP2BxTCf0e4cWQ0hdAAvoaf/ROz7v9/hnZavILzmEfqRVXpUp+6WaCl+zwgF2KzgssQNpq55v3gQBpe+OguletlmvVWq20Wjo4OKjKfQhr5dJ6uVSuyjewVquGGxRiq0J6VKPL98rry+t7tT1sbVjbq1VxfY1LqR6Uy6VqeDtduhffALFGj6vyUiq7SpfWqvIKOkclVvfKqrRabW+vXN3KyMheCtDv33+gjhQL0OO2BFRiMaBGGn5nr3+KVpvA6Eo7R27koDsQpq8XgRm6kXRLhxr5CK0+tc59arLhllJD34nfg9vgr5LLCfMsrj9DW97rn6ZFXxR6WcAbT3wi4v7A19cuErXhlcoaQUioVGtEwB4xFGFUKy2v0jF+QAzFNthUgALq9XJ5fb1c5TOEJ0EqYaTCqmUquFpT94RbcOJOKrhWrlYFt1UislwuHxDRfP4Af9VigJaWl8u1HWPD7SJAGUFu1/9w48abX6gm/tu3yQN4cMFH6Tf7BODy+/dvvPGHxQMquyJP8NEDgbMu2zRu7XvY5fU1zBva7N4prOAZWcVuCFGfGuKeArQDQEOrivLO++dkkMlh7XbPpOlEoy1/UZR13iHT2hN+KZr9AXuaMRPaEceFy0owUyEnYhpIq5WjmnALNzc3quV1BhRWKwHoBRnWamlPmDRAFJKLvxhQMpql6nKpVBOGkuhMAAq7x0eSEk9FRjv8RhCgRDLZ8b2EBVWlHZRKMLE7xkYzSUA//dlfQ0DffvOLHz9+SwIqjr79AEfhCODMxdM3v/j+/XeJ0YUDeiTGcggLCmewyzaNAm/miMxpT8ZFHUaw24/ZQVjSZHtMdi4e2feJd/BNPsEg1XLLQpAKoNPClwX/Z8nLuqHJ5SK6kQVt5rGgPCNoe618UCqXAQIaWLTMkaHcWy+VJTEHeyWYxAs2f9wuc/NdO1gvrxLhNWlWibaasI97ZdFoDwGK+2FbS3vrVXruKrsVIaB7ZHDR4uO1yHtRoHFAOUgi0iJAH1xEdH77jmBQHf1aWM8H/Pvp4gHFDm70ab9ECENQnp2DmFOYu44IvalBB1t9bl+7SXwGg8TDDtxJTktJt4BMI4c+ZIyp6GTbjaL6CMrIZnKwRZdQoE+XdTsxP4EC+z6j3kFxiM1eyd6nXJl6zi1tEAmyGRZNcLQXNrCs1iRSaHBh35R5BMbMKgF6II7zkZr0Gck5wGPplsb4xP3U9Ndgn2tl8aWgf+C/tMeWU5lrxp3vKdF3aL1m3IJeXESAvvNX1eTj0Kc3brwVO/uUeb7xLhlRevzO4gHlzvbmIYU3PWSCYD9h7boCDsAJZ/FsQPj0u2HWUlrI/qBzqhxSuKmEV/9MNfmnYKsjTvf6KmgPz1LJuB8/+wJY+L+n7JRGJahcK7+ePnmoHeWD5l4gdH+tWo1FRomt2mG42LISOtUQyoPQzsoIh66oyiOlUkkGNQcqcCIPNyqdBOqITUKxRlHUKr4DVcW2tOIIn/h1SL8VLulqqXZh3AcdDSh7m5EDwGBecCtvA6CYvdHy2v7LLrWuIKVHLiCT2InaZPByjiR5RJcAUuVBO9JZFCj1oltjgRGSpv2YR0AGGt8AstZkZPvh8/CprvyCnAJa9aR4UQN6WYct9kBzJuqRZ793UI0F2LFI6EJYQW59a3vqIhlpw10NwyYijYgj5laBsrKgpfI6qJLhe1UkAcieot2W11CYhEiK4ix2HsjpXQW+nFWQr0F9EfB4poBGv1XoHguhvpYZU27iNVE83cZwzxJQLEXvt/0TtOW9M/TkcHdND/1BoXFEpw/y6r24gwnfUiZMEbuE8HY6IaAdPhFy1zuNwv8e/+N2u5PKCuA2BfIgtLynfXoRHfITXvo8BzVXEC/HHY0EFB5kWQFak1KtfgLQPWKqrAAVppAAXV4vI0aKIiZhWBlGNpBsTMm7LK/ucbIAT7hOZ9l5zQJ0Bk08wp4fP34jFSQxgzFsf/yYTCdR+v37b2mDpE/fgpf69K0ZA4rRdCdRS91hQJmTWOSNHh4VwPRijbiEpzPoKfsKaiWKbCDDi9DjOcAXgGMizth3OEqKuZyngvSeSPiDYfUSQvdXNvE5DSiipHsc1RyEgHJ2kptkCeje3jqZuKpsg0OjGbbKdDdZy9Xl9TigdGdtvby+vlyqcevPOSdklUTLLxpwbv2Jxr3l6nq5VFOAUvhVq4lwTHoRaPDpx9YMAOWE0j/8WqSZ3gqp/Fr0MylAOaqCFdWnmciAAvRhM2sQUF63IZaoZysmMuIwZCG0ndPXZ+cq73mm+uRVX9DpGRGlrCn3Q3Vls98h3xWBvDSkr7vkR/ZDiGFre4h9koRyx1OP8/od9QoIWHDdFYC2yHHOVU2eFrwWi48upFUTFHJynFPkZdHWx4xZLSIaMU/pTvkOXVtVPigZxGp1fX21vFzak8EUwvYybGm1pnLvIJser3M2C7fggGj1OXrnq5S7S2Tfy9/TOf++eG7h350xoLy8kgA0TLuTOUSr3ou36IOzvopy+imLR0C95tBdOYuviVdRGIxlpzOQ4J+KlFXnXD6R4nvQ752OUcqhVWmmfNXEaIytKHqvShPJUQr8xWpNEhgG14iHqjJ+UYkloq68Tu7junAc0fpTCeXV6uryndXVssz0kwEtcfBeUx4s/qtykES2lDP88EGjfD1fpTgtr5f27o1bRneEDCE4XnFAyTjDY/10lk38EVr5lrKg7FR2T3lUEdLr6OBEcN7pnaGz8lQ0uwOKakTj3RGhDJr3Hgff6FUfEKBniLfJgcQAps7ZKRvRXo/zmJ1+mCTg1Cqd6Pdi6atON/IcYmRGF5yIAc6tnLPmyCJtqeb6QHqJKgEpjWQc0MiZxFuqLqWGmhp0MCYiHe4D5TvKe+tREv9A4Bkm+RWgspNUpEthVlW+XnQFyJ4kMubr9/LSebSI0UzkM7x18akM+ydXznrxEnInSSS6cDe7UcvbOT/v94Yz7SFAsWT+KXfod7lLnR8nGnAZ6Mdv7qZ90MxniHSipojkqyaF8VsEBLoUEYqv75XYwpXIinF0UxKuZw35I9jOg4P19XUV5lQPwpRQqbRaojOrnLuHZ1AS/adk90RrXeO8J9tN/sHPCAvNBhn5pVKJk7F4Masiqq+WhfVlQ12lC7bES3bjQTlT32615dDhly/o/1cnr54dHj578lyMJT558eLlk8ePD5+IkcnPMc74RI4z5lHNL18cvnqFEcsv+PCrk8MXz14+f/7q5LkY9vzsZEhUyotXL+muk5cnL57jfvVcJ4fPD+OlC9FTvggPynnK+cJ42NCNGrI8SP6gEVbZdbagInzHu8eGDUa0DH6qwr6KPkpYQDC2SgHOOowoR+roZod9lDHRgfIRYsYzcmEPwudks0lO6Z404mEnFN82zbriBtDRaxGAom87TcTLw5fxhw8f7zx7McxZirqQMpD3/JUafJ+hlyF3Gedepg+kHstJTDnCeDn3Z4UCkxKyPAQY4hXERcoHDTvSJaC10p3VKgVEyhWolVbvlGRjXFpevSNaeWT2q+XlO3fWq3IIFFjHgBKYSgrtS7WSMo4wtHtiZAi+ImSo0c1U5lEmGA2lXOPq6mr1oiCAPr1x48HTGTfx9aAd+K2TXrpJ7fbjfuH5xeD8NFvhnWHHJ8aKkp+qcviDXrJRl408j6eXTm/iqTNciV438hReoR/e93Mk6sUnXdlf27i5toZxlxhyeXNjaWPl3poclrklB2TyX2trG/eWtpbWbm3c3NqQQzfXltbov50djPK8vbJ26/baFo/xvLeysXT79srSzS01gHRlZWVjZUuOMqXnoDswUnRjbWONTmysbS3Rc63c3NhYWrm3sbGxtbK1QdfjBdCrwhPz9YUA9NM3/5fINOVTPkDVaKbxGoz2QEP1Y6Tpru6lidUrmQfNEyPxql+VzV2CZWlpiXncWlq6ffPWygZo4HHEa7duLQnGtpZu3V7CsOZbt29iVDIGOW/tEJ23bt8CdlQE/X+bxyDzeOObt28v3bwJDte4JPoWoFyikG7a2Li5AlzXVtbWbt5auk03089bSxilfGuNnvX2Gl2wdPM2FXAPCC9t4ZuwxtPoLPdBOc30YNZ5UAVokphuOKRdPOqhn7LX6adgSUEngno5UiRVXvKWTj/el3p6mrajMfVPE3F856UYwZpjygdGK2OL93sHsSx9eY+a8Fo17E+POaHwC8kVEB6ojPyrFButlkSkXZbZ9Qt5+TqFTaVwuF0YsnOGdE9cjEIRfK2u4+o9HvdXKh+sU7N/h1p+8hjI5+DgnxzcveXq1hQbfWTT8H+ylZPLUAsAlD/vZ/Fu89PT09h8OO5IJ/gwnqgXG7qRUvesy1l1NT5vEC+wn+Kv1+Gx+f34kVFWt9frnsa+Ep1DPy+gZIo2MfFnqxZLuhNXHHaPAJRcRhXDi3uqd+6UVCooGj1/gXx/ef3OKuefZP4I0TqXyiNLOMVZQ7YUw0KXS8ucqocPeiAApatWyVMto59qD09MznEhAL14iiYeufp8ylUrOXbtRI3wVBjEaelO0L73upM12q8ljoPUcTzDecrKnnXFKJOkZJop36S5CiYc70S9QuifLFdDQJEkqtbofwpUSmVYONFVGfYFVWFBMVBTAVeTOfkqj+fkSJ8IKwsjiyzVHno0L2Qyn7tAS2VOfIq+JJGLukPh1R0qVAAadseXS0tYu8RIEz9LQLmb9EZePnNuQ9NO+qCd4UxldtwyROi4a2LFifIHQ4Sedodc2J4c/dSJzU9WgPo5J3ViLnvYk8T98CW2V6IbnOznemm1KtLuZcJMDEqSw5lqomeyxDOS9srR2BER8cuBpBhrLAbso42XHUYiV4rSMIiPh4aISUl4nuqdEhG6t0qxPgX8skueg/n1JczzNBIkzRTQlL77zefpQz/87v4vvrq4+Ob+/Z+H5/IBivW6MGBZBtYYINxH53rYsd7r9vqDhLvIIz3O++fdMx5O3OXOpkEv4XaKDnmMVMbQKIw/6fI4us6ACuP/xVDRjurx7GCeCYJ6nCWXon/WH5z1cGUPoPbCmSCvfKxfn3cfBdGTpJQYOaR6d6J+oVjXkjS4quucp4ocJAGNpsfVyiGg4fh6lf6MD566kBnUZfpa3OFLEyep3K39AgD648cPEue+iUEo9dOfP7r48pdMLv2SygdokBnF6wPy1OFhizjitkFXb5A70QCo4ZOwoPl3ooEFXYIBq8qZQGT3RONbk6lztN8EKDX8aUDpcK1ETfFymQHFXXKGJnmMq8tiGL3IfALQ6vKqcBL22AuVgJJTgbBMjein51ku3aHg6g48iqqcY6LKIUC3K3nHi8wd0NhMUeiz9/4CC0o2kzn94cPPxQ9pVyPzmuuD89uZgOZWNO5Iw17GIfVtiEaUjkP4ZIrRduyD3tmithMkwlKur5dLornm/h8GCQM3wBH3bgKlWnV1dZX7OVfLy6urgK6GkSJq5BGi8tVySc1ywvVEebm8vkpx/TK13DyKSY4uxTioEuxwVQwVgU9xZ/XO+vLyanlvvRz2+vMgwDWsXFax3QdN5+iZwc8+EMaSAf3ut19d/PD7T3BSWFCk5nI94bloOU9S8IhhIRlK54skUn3M3ZzAUz3NyACkM/VdbvxHxfSnr07hYgzyva/cQykAxYCPPYKofAddO2wwcUVoNNGpA5tJF+8tl9Frr+ZictIJ+aJ1OXy+jI52oq4me/fFUBQqtsT9VHs4pyYzH1BIBEThE5Q4YKcCKWCioOzOHnfesxMqu7R2Uo3+9JqpBb2hJuQJAVDgSGyS00n64JtfSEC/+8f3PlH35TItcnlOXTfmyH5H1Z358lWsU1PbKzquvJepwtJn0ZMU5F0BfJOskQC0SgYQ89sp5iFrJvjCu6YABSkltqarpRpZy2FAy2Qb2W2kqJ9zoNwXj6I46mJAl0t0Zxn50VUF6Pr6HbpztVQCoIinOAMAhO+QT7Au5x1LH3bL2HjQeQdJ1MLfvw8Y0xZU/soJaF0tMDtaLe0V0VXJa0+yLpxAbbHSc5aChrgi34wksfDi0RoPx+TRHdU71MaDkfLqKoEqRxLB/0PTToAu0+lVAaiYLVcTE0KJHoyoR06I0KVme/lOiY0eZmOKBD4GPFX31lfXa3SaXAAx7YOeqUwXLy/DgmLsPjJXVMI6OQOr4LgsVh8h075XPbiXt30/mg5QnmycMTfuEoB+KF3NtA968dlH0wDajvM1BB2W3fbVBW3+J67EJsTiInZiw4U+2xL4QAto8hl5j5l0IZmA8mrQOVdmEmvPHcnFljaWNjY2bt+8vYZ+9pWVtdu3VuQySVhwCZ3tS/c20CG5srFxa+mWWmBJrdZEZzY2bqILdGNp5dbSEhZW2lnbWNm6eZvuUOstrdzEZejLvHlva21j497avZW1m2t09crS2tbSygr6+NEzf2vj5tKtpZtLK9xBurGxgk7Qe/em2HxOB+jf/va3DEB5StKUgPKiJKkmHj4oGnahn/7MHmnY0ucGVOVBs+QLblpii4MEVliyFhhhb/eWH4MN2y3Rr+MGlgNPACrWsY3ATuPqJy9NnhX7PPAC+tiZuZ5v/VqRpj86UpsXVbBQ0/YuVrLdX129u3lXrBB/VLm7WcHKdBWsgIiVl8PN4eQSnnLVWl6skTf52lzerKzhOtIqlbMplpp/tLt/d3X57u6j7bubu5XtTbXu4uZ2Bdsu4RWI/ZawBxOea7dyl0rapefc3Y4th5dPGkD/9q//+q9/GwL0nf/6lgB0wumZqRH1P378IBbLfyej+MjdVHnQL+/fn84HrfNqyqNa1KCJLUAa2HFTWDW1onzDa/BPj5Cre9ENreA4wHZe2IOhxYC2PS7b5/uxkHM79lSJZ22HB/w0oWQxmW2+px20sANIrpVvCDe1fKfkb18sfUzQrN7dllsYiLW9xdi8bSI3Wp4RiyuqpZcRXcsVPzep2LtqITqs4Xi3Ir8Ed++sVrZX6Wsh1hgXK9diUUbClV8F1gPFIrm8qyJPGAGtan3H2Arhk2s6QP/66QMG9NN3L76eYOBcOs004W0J5alUndf7VlsdtNvKkGHrwVargaXj24EfNbmBAhFbbNV50Xrs5Sn20wQ9ALQtrepJrPXHLtxt+q9xHBbWasYWAefbxaMYwtKzbWAXbmlD27zJCP3OMWBZLgNPn/725m64hCeWqaUjd+7eZWNKBze3V8EPFu68S8Yv3G4hBWi0Ui0Z4srWUQgodgbj/RK3K3fIbq7KjT4Uh2Inhdhms/ubvIoyfTPoa7K5vck711bUYs27OTdKmhLQ7//tF/j592REf/2n3IA+nfGsTgDaTja6TEkbm3JgMkij0Y62nYksWuABGLFRJ7kJ2MOLEMLmm4CXAAWG8SY+qPNa91iOlGlstX0/ZkPbzbg9lTbZC7dY8I7lFg/i28GmPM+IerGA8SYZrrtiQxq5e3sFDazaZZOo3dzclqt2w5reVVsbYjXk/XBtcPzkpZkF9ztqU5nK5ua+2n3mLsVem5vK2oo94+I7fSU2VaJvxvLyKuxsZXNVbZS8axrQbB+UbOfTd+kn/vjxP+YDFNPliM7cI5ZzAXo8wivElrI+odYOjv122itE9CQjGd76IOA958R+HC32B9DQN09ipjCoi6Xl23QxGV9yBbDrV8MPC/QjUuVRn/eeYVKxuUcCYbLSuaZ8iCXgQZ1YW1kaL7H29yPJ0P7qnWU0yQTHJhnWOxVx6SOZMhdLL8NqSjdRrNK9k95LiTdZrBCgisL9cKP4aCsQtVM3O7dkWGGvyevArjii5HAx54mlAzQzimcu/zidBeU595/GF2+eAaBsPnnDN941sx2GQT7vSIgdtOtBS7W+ihDV6JMlJNpaoK7hYzubdlNsAYYfXsyCwuT6ZJfrdGHA28ohFidnEm5ui59cfU3I+rZEPASG8bweUx3PZLXz+aBQuIZ3Re1pQHABiYrwBrFtAXmL5Dpu36VIhXzQzYpYxTtapv6RMroKUJzZSaHHDqpsu5MbgEY+pWzh9yWgFfKDGVTsDypL5gXCZ96TxPE7h/JT+KDTKtfnJpvQFpLfYtNOoQYRx/t2Yev2ujzqy/0SfRUXtZlkIspvYYOZFnmfvJsX9vwMWqEF5Q3lefsvYpM8Ag/RvziF3erbPm+mLOATW3vhQYCRLD7+8atq875MQJaBzrtEvYxuVPMqG1cyXBwscYCCMGd5+xHwxBZK5ATAWEa7GfA9m4h6JJy81dZOuBFT+FQxsxveN/xiFOKRuynSCCG4OTU1oLzK4hRR/HwA5W0QqTU9btR5y3hhSLHnOxiiCCgIAuySyEmittg0XnAifQFCGPvGBdhG3hO7e2E0HMH7Ql7iYWM4clcDXIwdkI78lkw7NcO9vT2ysfS0ZCkDxT9vuRx4wsazM+HLWAm2N08tw50K5T4GClAR2NAFm3AA+ZFwGsU2C7zdBnugAr8K724g8k/hNh87+9H2hbH2fD9leVWzHu7NEAdUwrwvklth4jafpgE0t8bmQWcBqGABATn22faxzSBsIv+PPbGxLSE264YFbALFltjyEJETxUotsrII5+nXMTFOXiud9nAlmUbRxLfJOFLR3ErTtXAdscdiU6BcP5I7a9fp3mO/0Wjw/nUBb4vs8ya2VCJMMzYTw6bL4mvh5TGh8T2M1f7GcocNmSAFdvsizFG2tlJRfoDa+03mhlI7z20pK1iR28UhZI92qeELox3lQr9U7IMUBkySW7m55xQrMy1kuF3e6XJCuWrFTmBDbeqCbTpbaN3r2F0Y1gwNLe9gyEmoNnZCJt+wjeSUjwYYW8MfHQl39fgY59kNCLAf7EuOjqj9x/bFnKXHnsi8XXzAe9Mh9+SJZ5b708Pt5LALe8S3sIkTXAyf23t6eVQSF08/8oyoD4OYoa1jpaVKHk8YuXDnJHFRJaJJ2kgBKJnebQEzW1kY3bDdF75khXcFje1rE5K+zzkvuYnYdmzDpXzKpmGGgKaG202sPJWiZpmgAqAsIqkFkweLyhu1t7EvYYNsYAtNLG/23vCxYzFwIuexwZeSCC6ybrCA2HM2wLIK3iu4pICb/ALsxA3fE18FuuAYxhKkqR25PN6fnheDZBeDfIhGi3dBxGbK7CILO91C5hYvK8ekuRC/xNawoR2VtCRjksiuqZ2TQvO7n2iYFaCbgj8GlKdAVVa3Y5tuiggo8i4TgVW4PydPnqpMscXHkQUDlidVnkrVsZk2YPMJBGDjB8f8N9poalh5j2O6poHWu8UWFBtnImVEBpaYqou2GdbPE0G/WNOR+PGeEdMNBhRBkAeriku8hvgGUMHUikeA1j25WimWOkEuFavr+vifd/LETuBULtlj7HybZ7hI3FiFOxvKdGNF7SOX2FRuPwmQOiKLiTmxR2qnObUTp8hfbXJ+Ve7NGe7+ub25f6QDtDKN9ymUTcMsfdDcKXqhPJUSmSREQrCB2B+e22reC9bzxBayjFIDw0qIThFOEaItBCp1D/vCBz4xDR/0WDT3XsCA1p9gu234oyCTm3oqiuyvdAvgX4jN4evok2o02ETS16BFLbuInODJkhWlb0yAPeLFvrLU9NNXKt+04yjnEx3EfoWxlj3JX5YRU0fEfq8hoPLQ9rbyIzgK30ZCi3dSjveOHqW+BkdRgdN1H8WUTcOsAFWDQWcdJNWlyfO8JKBBowmzqa46RgCESJu9gjp5qUSoj3aWAh5kirAlrYzHjwlG8FN/iA23sPc8jqKfiR1KPNWxiI14XSjsQn+sYiXR+nueipxQVlCnf9gp2cf8qfALlHPpm7RbxyuGbscBVbSmo5uM8iqx8e476sr4xWJnz7uVu9zHyXQOZ+uTL/BIoTwlnxaMB51Q+auGUCTw6gJWgMN2qx1EGxWwm1kXzTHbNbTAcAux22eALk/PV4zJlr5ef4YO0JZqw+G0skPJ93F2ibeyxU7ywooeybsj9PCtwdbe9O3gK32/zd+iulefJg+a+OjRmEaAqrA6ceXIWCV+YmfUE+7LNNVRKiIaDf9UsVGobBquAqAwoKm8oiAjGtQGgI6jx0QWmBGXtklwNdU5cR2R9oR70wE7eOV0ADxevk806bwtPPoD2PqCOy8OKH8nYHCF++nxzre50RQa6s6BN1gJfVAM5IhymSMz7OHW81GyaRSgR3GjnMoeZJc9XWwUKpuG2QH69I0/cUM/03nxrDh64SGOs4+lZeNW2IvNs/AwyEleiuQQfEX5sO6LJpsADTidL+jjDW8QkjXYonJQxD9biP4j1zduGxXrbNQJXt75Nnf1pPZTTWwiGc5hSrw3SB7N6gLinFHU+z4G0Oiy4c3fL2ctszRnQLG4MjKhM15ZBEo2qxJJAkLkNsEW2684xmF7zxQFQXiqziF/w4cpfEKWEZ1Iflh+PbSQwoLip8epqbRrKdwN6dUqhzRotXIl6OOKJ5TEgUSYHsXR8RBmyKKFdji6eQjQ+E3cGZp+shFHLqv5AsqbM/CMkZmOZhKqJ6zWsbB/DGcc0JBJXC4iG37UEF5leDu5mWiWvfpjZEQTgEZfhrqyqiKNCqeSAAy3gY+jGbtFRF/TKCQryokm2vz9MFWeBjCjXHAlzAAAD5dJREFUGJWj51vTgCbzRxkxuzp3meY8S/MFlLP0vKnSjDdRSEtEL56IReoKVyTkwyDpWEb7EpWI1SPlG4hM0g6nnBphBBQGYepBnFavLnCOvQpVZKOhnpcTDVNVK0QlamxTbX4i+zk6PNpXo+oVzZMBOgctAFA2ngsANNbYysgcPz3pk0po62mjKB9FpnAnKmD4uvgRiV4sQIpfK9xVWfSUIVKMw3S6KfF4DKCpwXLh7/GARsHU0CsqtgVFN5LojM+9i8Il6ykQbHjDJEg4vTRoQ9RIU5j66PIAGi9TWdDLKZ7eUZ4hP0yiqPqWRnqfR+MBTeVDh4OjEc9rQFMAKgnLMeYjCpLIerIL+vWNvB2el69qiFIKPRnjaM2YvD/+0YWWN3lh2N6PKTjjvsupIvq7pTK64LNuSg5KjjkJO6OuGlvcAgD91a9+NWRBsbVcjknHiTTTp8gwYW/FnHwaADSKmxNoTOwEDgNa14I95uTU7foIJQFNaiJAEzIDqIEGXwPor/75n//5V2lAYT0/ffdCDVf+WttvuZiepFEaBvR4si4cgVQaUN31kx+/nKYCdCRCYwEdA17ijAl7OhWg3//6j/+GXEiC9OlbF5iYpNka1npA8wAzMaCjzhpv3KXiPmhaOU3Z/v7WZW4Pb1sUoBdP4UJiuhzROcGsObsAHfZBc+GiAOWM0tjmfZTPOyNAzYnAmmbXwqxyZg1opg8qZyXx0CRsefy2bo6mBYCaaFYTTbwes3g074012bNp86eXKUDn4IOOSDMJQP8+9Dw1UzsXCWg0GOmyECSDpAlKDIOy1Di6NI/WmVRjgBrQJQCVk44Bp72Aqt7FRQAa3qcZ6GkdoEM+6AJ1GUCpjUfb/qnNUfzMAM3RLosuVm3BVmncaKa5ajpAc2rxgJr3Qae4c9rTi5ADNK+mraDxDz/nR2chfJPIAZpXi36jQuX76GxsvieRAzSvZvou5DFzDtC5KpuGawaoZmRREl8H6FxlAB29bAc0HJuZqRRjzgedqwygo9fiAJ0Mj1kCmv/VWKFLAmpu3LIBdPRaGKATNrDjm/hkITs7eT+7EMsiNfeXA9TgsFAD6OhlO6Aa0xY/y7sKTfkaigTo5VwqB+iEMo+EA3QSOUAnlfk0/SUALZIPesmg1PmgC9MlfNCJDlsia95vA+joVSxAx5KT34KOeha723sHaF7N7R0ZT44DdM4ygI5eDtC8T7NwOUDzam7vyJwAdT7oZDKAjl6FAvRo/EKypvi0XA7QvJrjezLOhk5oQe02jxPIAZpXc3xPLg+o5Q7mBHKA5tUc35NrAKgukW6PI2MAHb0KBui4BvpqAKrrijQXCl5aBtDRq2iAjtNkn5zlPqgDNKmrC6jlII6SAzSpKwRo8qOzvSkfKeeDJnRtAC2oQc2QLe/31QV0RqyMBbSwBnVYDtC8ylmvWbGS8s6SX4OsJy2oUXWA5lXOes0JUO2TFtWoOkDzKme9zMxGGtb4+Ha4NAfoJWUAHb3s9UFz85M3AeMAvaQMoKOXvVH8zAF1PuglZQAdvUwAOhudv379+jzPDQzorF6N04JkrwXNb+DsSWHPVM6C5tWi36hQ9rySWcqaWhpARy8HaOFkTS0NoKPXVQI00ZFkaQB0+WUT7HFkDKCj1xUCNB7F25pCuvzCM240U34t+o2ScoDOWQbQ0csBOlc5QPPqCgHqfNA5ywA6el0lQO2Jb2cqa2ppAB29HKCFkzW1NICOXg7QwsmaWhpAR69CAapxLO3xzmYqB2hezesN0YTmFsW3M5UDNK/m9YY4QFkO0Lya1xviAGU5QPNqbu+I80EhB2heLfqNCmXPK5mlrKmlAXT0coAWTtbU0gA6ejlACydramkAHb0coIWTNbU0gI5eDtDCyZpaGkBHLwdo4WRNLQ2go5cDtHCyppYG0NHLAVo4WVNLA+jo5QAtnKyppQF09HKAFk7W1NIAOno5QAsna2ppAB29HKCFkzW1NICOXg7QwsmaWhpARy8HaOFkTS0NoKOXA7RwsqaWBtDRywFaOFlTSwPo6OUALZysqaUBdPRygBZO1tTSADp6OUALJ2tqaQAdvRyghZM1tTSAjl4O0MLJmloaQEcvB2jhZE0tDaCjlwO0cLKmlgbQ0csBWjhZU0sD6OjlAC2crKmlAXT0ukqAXnZlEVtXZU7JmvfbADp6XSFAL7s2k63r2qdly/vtAM0pB+icZQAdvRygoRygOWUAHb2uEKDOB52zDKCj11UC1J6PbqayppYG0NHLAVo4WVNLA+jo5QAtnKyppQF09HKAFk7W1NIAOno5QAsna2ppAB29HKCFkzW1NICOXg7QwsmaWhpARy8HaOFkTS0NoKOXA7RwsqaWBtDRywFaOFlTSwPo6OUALZysqaUBdPRygBZO1tTSADp6OUALJ2tqaQAdvRyghZM1tTSAjl4O0MLJmloaQEcvB2jhZE0tDaCjlwO0cLKmlgbQ0WssoN/95vP0oR9+d/8XX6XOLfqNCmXPK5mlrKmleRozNA7Qb+7/PA3oT3/+6OLLX6bOLfqNCmXPK5mlrKnlTIBMawygn733F1hJspnM4g8ffi5+wHbKc0KLfqNC2fNKZilrajkHPCdp4j/7QNhMBvS733518cPvP7kIm3jMpJzH63S6ptICChyJzW/uQx9884sUoNCiv8mh7Hkls5Q1tZw5nJAe0N8RmO99MsqCQot+o0LZ80pmKWtqOXM4IT2gH0oQEz6oA3RxsqaWMwVTaSIf9BuRWbpAFC89UgfowmRNLWeIZSQ9oNTGo4WXcnnQhcuaWs4MyrhcT1LhZE0tDaCjlwO0cLKmlgbQ0csBWjhZU0sD6OjlAC2crKmlAXT0coAWTtbU0gA6ejlACydramkAHb0coIWTNbU0gI5eDtDCyZpaGkBHLwdo4WRNLQ2go5cDtHCyppYG0NHLAVo4WVNLA+jo5QAtnKyppQF09HKAFk7W1NIAOno5QAsna2ppAB29HKCFkzW1NICOXg7QwsmaWhpARy8HaOFkTS0NoKOXA7RwsqaWBtDRywFaOFlTSwPo6OUALZysqaUBdPRygBZO1tTSADp6OUALJ2tqaQAdvRyghZM1tTSAjl4O0MLJmloaQEcvB2jhZE0tDaCjlwO0cLKmlgbQ0csBWjhZU0sD6OjlAC2crKmlAXT0coAWTtbU0gA6ejlACydramkAHb0coIWTNbU0gI5eDtDCyZpaGkBHLwdo4WRNLQ2go5cDtHCyppYG0NHLAVo4WVNLA+jo5QAtnKyppQF09HKAFk7W1NIAOno5QAsna2ppAB29HKCFkzW1NICOXg7QwsmaWhpARy8HaOFkTS0NoKOXA7RwsqaWBtDRywFaOFlTSwPo6OUALZysqaUBdPRygBZO1tTSADp6OUALJ2tqaQAdvRyghZM1tTSAjl4O0MLJmloaQEcvB2jhZE0tDaCjlwO0cLKmlgbQ0csBWjhZU0sD6OjlAC2crKmlAXT0coAWTtbU0gA6ejlACydramkAHb0coIWTNbU0gI5eDtDCyZpaGkBHLwdo4WRNLQ2go5cDtHCyppYG0NHLAVo4WVNLA+jodZUA3dnZyTxer9fn/EpmKmvebwPo6HWFAN3ZySa0fnx8fJUIteX9Lg6glogBzTh+/vr16/O5vxonM3IWtHCy5f0ujgVd9Bul5HzQ+coAOnpdJUDt+ehmKmtqaQAdvRyghZM1tTSAjl4O0MLJmloaQEcvB2jhZE0tDaCjlwO0cLKmlgbQ0csBWjhZU0sD6OjlAC2crKmlAXT0coAWTtbU0gA6ejlACydramkAHb0coIWTNbU0gI5eDtDCyZpaGkBHLwdo4WRNLQ2go5cDtHCyppYG0NHLAVo4WVNLA+jo5QAtnKyppQF09HKAFk7W1NIAOnpdoSkfFxdZEz6unq5HLZUcoIXT9ailkgO0cLoetVRygBZO16OWSlcKUKerJweok9VygDpZLQeok9VygDpZrSsB6Hf/+BF+/ubzRb+QmemnP/+Sfn72y0W/jvnrigD688+vNqAX3/3TJ1e7gqN0NQD9zf/8pQD0h9/d//nV/BTJen72wYWq4Df3r2o907oigH7+2UcMKH2G3/ziq0W/nlnoh9//5bdUMargl7+8+OHDz/HrOuiqAPrDf/gKP+mD++H3nyz69cxEX97/6IIrR5W8qnXM0FUB9OLLD+gn/vjpX67mh8ceKLXw9++/R+7oP+LnddCVAfSnf/nL1bagAtAPQ8/ziroyaV0ZQEUof3V9UBnDiwqijle1nildHUAvvvz5VY7iZSWpgmjbP3NRvJOTDXKAOlktB6iT1XKAOlktB6iT1XKAOlmtqw3o0xvvhn//3/9+8e3f/Uk9iv0Z148f34DeiE6qC+m37vavf/bXEa9DFnvjxlsjnneiUq6lrjSgP37878JPO0XGSECZ6KcRJDFAdbePR0vc4gDNqSsN6Nc/+29vP5B/5wL0+/cfpC90gC5GVxrQT9/83x+/RVC885+4fX0XdKC1fUuAgj9Bw7dv00lBZAQok8Tt+h9u3HjzC9XEy2v5KO5RZXz//o03/iDRCp/ij2+rci8iQP8gC5DF02v72V/VK1Cl8ON3Lz6lUi6evjXnd80uXWVAv3//XW6sv31bEkn//0jEwj7KPy+evvmFYEWYWgnop8SMIujtN7/AlQJQdS2OomxVBp7q+/cFoDjGd8hr5KuRgMqDUfHytaFUVQobcLoIxvTHjx+k63WtdJUB/ZrhfCDgk4DGWuyvheV78O07UZsqoxncGBL04CKiU12rjqoy+LeEkf/+GmbxQbxJV4CGxcWKl6WqUv7fF+J6/ia9c71b/KsMKFpIafxCQJWHR38+FYE1taTcIrOkBb24iLXBf1VNPg7Ja9VZVQYZ0ZCzr/nviMF4gVGx8d+q1KiUr0UqgZr3a97CX2VAyaET1nAUoMAhvFQ1zxpA5bUhoLKMSwIqS1WlfP/+G38SL/id/3HNW/irDKhoceEwxgCNN/GxbKeK2zMAjX5HMIVFqjJUs85/49jXse9FrMCRgEaOAv1gxFHMjx//+2vewl9hQDl+4V8MQSwyks3+jx8TB4QBYyFBiQBFwPLjx2+kgiR1reJLlfH9+28NB0njAA2Lx2NVqioFbH77Njh/euOat/BXGFAZl188feOP0s97KyPNxNYu6juKAOVUzz/8WqSZ3gqplNeG8KkyMtNMfxoNaFQ8jqpXoEohn/SN/wyb/u3b17yFv8KAXgld9xjeAWq5nr6rv+ZqywFqsTirf83lAHWyWg5QJ6vlAHWyWg5QJ6vlAHWyWg5QJ6vlAHWyWv8fySfyVMLdgFgAAAAASUVORK5CYII=)<!-- -->

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
                       -8.723e+03                      9.821e+01  
                 n_tokens_content                n_unique_tokens  
                        5.690e-01                      5.731e+03  
                 n_non_stop_words       n_non_stop_unique_tokens  
                       -8.431e+02                      3.754e+03  
                        num_hrefs                 num_self_hrefs  
                        3.628e+01                      4.804e+01  
                         num_imgs                     num_videos  
                        8.900e+01                      9.767e+01  
             average_token_length                   num_keywords  
                       -1.705e+03                      2.111e+02  
        data_channel_is_lifestyle  data_channel_is_entertainment  
                               NA                             NA  
              data_channel_is_bus         data_channel_is_socmed  
                               NA                             NA  
             data_channel_is_tech          data_channel_is_world  
                               NA                             NA  
                       kw_min_min                     kw_max_min  
                        4.363e+00                     -8.902e-02  
                       kw_avg_min                     kw_min_max  
                        1.195e+00                     -4.611e-03  
                       kw_max_max                     kw_avg_max  
                       -9.355e-04                      1.908e-03  
                       kw_min_avg                     kw_max_avg  
                       -1.343e-01                     -2.583e-01  
                       kw_avg_avg      self_reference_min_shares  
                        1.779e+00                      5.197e-02  
        self_reference_max_shares     self_reference_avg_sharess  
                       -5.127e-03                      1.892e-02  
                weekday_is_monday             weekday_is_tuesday  
                        4.882e+02                     -4.025e+02  
             weekday_is_wednesday            weekday_is_thursday  
                       -5.401e+02                     -2.550e+02  
                weekday_is_friday            weekday_is_saturday  
                       -8.538e+02                      3.915e+02  
                weekday_is_sunday                     is_weekend  
                               NA                             NA  
                           LDA_00                         LDA_01  
                        8.355e+02                      6.966e+02  
                           LDA_02                         LDA_03  
                        1.515e+02                      5.826e+03  
                           LDA_04            global_subjectivity  
                               NA                      3.289e+03  
        global_sentiment_polarity     global_rate_positive_words  
                       -3.445e+03                      1.909e+03  
       global_rate_negative_words            rate_positive_words  
                        1.452e+04                      3.914e+03  
              rate_negative_words          avg_positive_polarity  
                        3.013e+03                     -2.126e+03  
            min_positive_polarity          max_positive_polarity  
                       -1.957e+03                      6.086e+02  
            avg_negative_polarity          min_negative_polarity  
                        2.110e+03                     -2.423e+03  
            max_negative_polarity             title_subjectivity  
                       -3.051e+03                     -2.986e+01  
         title_sentiment_polarity         abs_title_subjectivity  
                        7.915e+02                      2.515e+03  
     abs_title_sentiment_polarity  
                        8.725e+02  

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

               1            2            3            4            5            6            7 
      2646.91317   2094.54501   5107.13439   1481.68901   2096.35382   3121.25753   -237.93634 
               8            9           10           11           12           13           14 
        15.94027   1831.45155    172.12914  -1405.66294   2938.79945    607.03642   3182.68478 
              15           16           17           18           19           20           21 
      2261.51007  -2013.66628   1050.25315    375.96887   -143.68253    578.05244  -1354.15945 
              22           23           24           25           26           27           28 
      1860.81379    956.72387  -2384.56847  -1730.75351   -916.32181  -2084.77149    943.59622 
              29           30           31           32           33           34           35 
       676.68193    799.23827    506.03070  -1125.44716  -3553.80143   2523.17689  -1057.08131 
              36           37           38           39           40           41           42 
       148.77642     75.18548    361.40495    236.99181    738.03544  -1300.07436  -4429.76079 
              43           44           45           46           47           48           49 
     -1288.00330   3454.13150  -1522.90921  -1660.08387  -2255.11144  -1566.62557  -1496.87580 
              50           51           52           53           54           55           56 
     -1196.01122  -2364.51613   -721.02669  -1277.65871  -1427.00922  -2502.28053   -656.00142 
              57           58           59           60           61           62           63 
     -2877.42688    556.99178  -5459.64319    334.36691   -372.08610   3210.14031  -2285.66620 
              64           65           66           67           68           69           70 
     -1048.99730  -1774.74701    372.58152    702.99562   1470.19312   1557.95140  -1162.33180 
              71           72           73           74           75           76           77 
     -1112.32765  -1018.89203    343.66941  -2397.99790  -1639.61686   2860.36433    730.51494 
              78           79           80           81           82           83           84 
      1638.83258   2309.51291  -2848.63023    302.55023  -3613.10687  -1154.37385  -2897.77350 
              85           86           87           88           89           90           91 
      6679.36239   -107.45708  -1988.81112    554.22573   1327.21773    268.57491  -1658.55810 
              92           93           94           95           96           97           98 
      -504.70067   -772.70297    370.42671    237.74765  -2421.94609   1817.62775   1259.09310 
              99          100          101          102          103          104          105 
      1093.38490    355.22269   2041.79488   1908.35961   -126.98461   1839.28642   -129.06986 
             106          107          108          109          110          111          112 
      -670.19433    938.57380  -4070.07013   -737.85145   1551.65723  -2451.11474  -1370.30597 
             113          114          115          116          117          118          119 
      -985.54806  -1148.97600  -1802.46542  -2240.93258  -5552.06816  -1633.07932  -1371.94509 
             120          121          122          123          124          125          126 
     -1598.48746  -1262.37244  -2324.78921  -2489.74845    797.38124    559.81619   1495.89817 
             127          128          129          130          131          132          133 
     -1780.70041   -835.54103  -2095.97390  -2777.37325   2812.65201  -1546.27034   1132.74673 
             134          135          136          137          138          139          140 
       593.83100   -844.51203    224.63754   -623.12170  -1305.13164   -280.72510    567.71603 
             141          142          143          144          145          146          147 
       637.07498   1516.85774    201.64110   8940.46311   1964.74658   -476.46932   -194.40895 
             148          149          150          151          152          153          154 
     -3422.51419  -2037.48095   1481.34194    154.56846   8779.15661  -2364.76388  -3105.84699 
             155          156          157          158          159          160          161 
     -4121.95749  -4172.52048  -6411.24928    796.56669    486.96866  -1760.48010  -1931.78936 
             162          163          164          165          166          167          168 
     -2081.15788    587.16252  -4929.12622  -2821.43791   2070.41291   -385.24614   3418.92763 
             169          170          171          172          173          174          175 
       552.34755  -2173.71050    494.10101   -446.37941    276.36053  -1278.28359  -1037.05361 
             176          177          178          179          180          181          182 
      1719.16732    927.47789   6082.37495   -916.69119  -3755.84240  -1692.56922   3635.44963 
             183          184          185          186          187          188          189 
     -4160.91984  -6434.30298   1436.48537  -2179.46630   6912.79769  -2768.03544  -2402.99189 
             190          191          192          193          194          195          196 
     -2713.50063    931.13901  -1652.83061  -1907.13685  10699.17340  -1678.56868   -479.38944 
             197          198          199          200          201          202          203 
     -1276.85383    -99.84469    782.16015   -478.55895   -649.45581   3647.65612   6759.58058 
             204          205          206          207          208          209          210 
       513.94606   -928.57251    337.89892   9938.00264  -2311.47387  -1346.14640   -887.30205 
             211          212          213          214          215          216          217 
     -1769.74131  -1895.20175  -1877.07536  -2368.21587   -799.11881  -1448.13704  -3144.43700 
             218          219          220          221          222          223          224 
     -1408.36053   1758.35434  -1699.71348  -2169.32295   1483.51896   -909.74923    487.28355 
             225          226          227          228          229          230          231 
      -401.53757  -1888.00848  -1167.26601  -1545.02467    492.34002   1051.99644  -4287.72666 
             232          233          234          235          236          237          238 
     -1633.57752  -1233.45987  -1407.78432    156.65970  -1774.52896    575.31673   1404.84463 
             239          240          241          242          243          244          245 
     -1297.89523  -3060.21569  -3406.83564  -4929.00706  -1956.67370  -2076.25413  -3449.00626 
             246          247          248          249          250          251          252 
      -862.91720    525.45074  -1440.15434  -1976.77959  10987.10462   2302.75063    891.22914 
             253          254          255          256          257          258          259 
     -2868.31806    685.93398  -1414.28264  -1073.14185  -1262.89868  -3732.40886   1948.32550 
             260          261          262          263          264          265          266 
     -3602.41208  -1110.81930   -922.41432    365.65705  -2121.33640  -2477.04555  -1415.72259 
             267          268          269          270          271          272          273 
      2705.12784  -2095.10310  -2155.13411   1933.90172  -3599.95529  -4709.33061  -3344.81583 
             274          275          276          277          278          279          280 
     -8951.49272  -2580.81743  -1108.20263  -2781.57850   -978.71823  -1625.10755  -1917.56889 
             281          282          283          284          285          286          287 
     -1589.40017   -425.30932 -10156.99093   1851.54914  -2152.44955  -1296.90302    107.38062 
             288          289          290          291          292          293          294 
     -1034.94164   6807.83837   4052.87711    444.03530   -601.66804   -700.73877  -3388.14177 
             295          296          297          298          299          300          301 
     -6292.97806   2782.79941    121.43935  -2195.33567    428.41863  -1426.09628  -1768.80316 
             302          303          304          305          306          307          308 
     -2355.11283  -2180.76779   2852.21375   1501.30316    374.34509  -3088.53293  -1520.61163 
             309          310          311          312          313          314          315 
      1624.54288   4026.72935   -645.16582  -2037.56290   1732.94051   -180.21734  -2651.06863 
             316          317          318          319          320          321          322 
     -1371.83272   -648.82397  -1324.96738   -242.54177    423.77703  -1985.58039  -1638.37482 
             323          324          325          326          327          328          329 
     -3855.02245  -1663.76476  -1958.22941  -2516.14496   2490.74603    812.15819    747.27221 
             330          331          332          333          334          335          336 
      -387.15598  -3329.19120   -442.09178   -658.47926  -1646.04804   1108.96826    174.85616 
             337          338          339          340          341          342          343 
     -4145.40679  -3685.84278  -2997.26788   -167.55839  -1955.66365   -838.43767   6835.44622 
             344          345          346          347          348          349          350 
     -3734.97177  -1338.90362  -2221.88015  -4032.11428   -484.00798   -679.75737   -727.21238 
             351          352          353          354          355          356          357 
     -5887.49809  -2890.93235    895.55490   1011.14415  -1558.44544   -122.63458    856.33107 
             358          359          360          361          362          363          364 
     -1280.01202  -9163.03502   7470.89283  -2614.97345    107.17021  -2291.57994  -2891.15812 
             365          366          367          368          369          370          371 
      -896.43422    727.38131   -266.52956     12.01118  -1136.81541  -2505.78827  -1073.30468 
             372          373          374          375          376          377          378 
       450.26982    554.19148  -1794.77366   1423.70167  -1910.25225  -3075.16122  -1470.52422 
             379          380          381          382          383          384          385 
     -3076.25059   1790.71511   -779.89269  -1981.89811  -2953.73829  -1834.59318  -3025.91454 
             386          387          388          389          390          391          392 
     -1085.42424   -894.78068   -539.41169  -2532.43652  -1846.15190   -547.70851  -1349.56468 
             393          394          395          396          397          398          399 
        67.03893  -3124.45000  -3355.27781  -1120.77208   1360.48378  -1364.88271  -1493.37315 
             400          401          402          403          404          405          406 
      -625.94113  -1785.39942    286.46167   3052.95419   3500.24609    884.86421  -2039.45995 
             407          408          409          410          411          412          413 
     21167.21474   1328.97398  22372.37763   1454.53487   2163.16442   -996.59452   -686.19022 
             414          415          416          417          418          419          420 
     -5081.88206  -3408.69431   1951.30025  -4086.75686  11435.10812   -405.45796   1302.15827 
             421          422          423          424          425          426          427 
      -913.94969     62.26403   -346.62172  -1083.21839    377.22763   -632.28284   2137.70580 
             428          429          430          431          432          433          434 
     -1701.22629  -1998.66767  -1514.49419    159.92448   7123.37913   -846.07233  -4279.85412 
             435          436          437          438          439          440          441 
       419.34914   -381.05039  -2880.68183  -2739.45576    562.60414   1926.79436    -86.72653 
             442          443          444          445          446          447          448 
       566.30806    -63.26986   -979.70971  -2756.52159    684.67781    514.50215  -3069.83525 
             449          450          451          452          453          454          455 
     -1621.49168    702.60799  -3494.15713     44.20725  -1534.48783   -194.32283  -2279.55509 
             456          457          458          459          460          461          462 
      1330.20910  -1565.15485   -373.35088  77326.63426  -1266.26519  -1608.20282  -2188.52287 
             463          464          465          466          467          468          469 
     -2673.65569    546.15418   2254.81145    761.49364   -260.17644    271.98283  -2904.18426 
             470          471          472          473          474          475          476 
     -1143.88638   2531.04114   2460.02071     28.83784  -1929.78402   -988.40089  -1971.39892 
             477          478          479          480          481          482          483 
      -183.24112   -117.89358  -4444.88543  -1947.07714  -3279.48183   -648.56905  -2634.69036 
             484          485          486          487          488          489          490 
        32.81543  -3689.97312  -1762.01698  -4652.01057   2544.63969   -331.38634     46.78871 
             491          492          493          494          495          496          497 
     -1309.50321  -4779.18117    133.68369  -1589.78711  -2878.88539   -850.86908  -2229.50959 
             498          499          500          501          502          503          504 
       970.51885    960.61465   1702.35705  -1195.12006   -808.32058    226.97027   1024.39589 
             505          506          507          508          509          510          511 
     -1351.91974  -2732.11837  -1243.70703  -3037.22055  -1559.97966    452.95280   -573.36086 
             512          513          514          515          516          517          518 
     -2157.96756  -5191.75673  -2214.54512   1550.73180   -786.48673  -2299.17673  -2811.88757 
             519          520          521          522          523          524          525 
       476.55161    595.16685  -1666.68537   -778.32298   1607.52393   1430.77957  -2341.23624 
             526          527          528          529          530          531          532 
      -148.65482   -549.20407   1814.89262  -1927.30493    867.53352   -363.95604   -674.76061 
             533          534          535          536          537          538          539 
     -4179.80835   -507.92664  -2253.40048  -4163.33792  -1705.26374   -675.01435  -1918.07130 
             540          541          542          543          544          545          546 
      1067.18291  -3487.99847  -1139.51535 136067.34002    607.86640    110.20388  -2348.33156 
             547          548          549          550          551          552          553 
     -1587.83420  -2144.16301   1331.52986  -4170.28922  -2852.57124  -4131.91478  -1830.34195 
             554          555          556          557          558          559          560 
      -869.37226  -4376.29031  -1054.53576  -4645.93138  -5526.43206  -3719.01569  -3669.26334 
             561          562          563          564          565          566          567 
     -3220.26024  -1699.52236    392.37017  -2525.15365   -948.16743   2149.73465   1396.31214 
             568          569          570          571          572          573          574 
     -1314.39500   1636.22172    382.31995   1890.60667  -1452.50409    -85.64595    536.12317 
             575          576          577          578          579          580          581 
     -6935.12660   6437.88088  -1343.05353  -2377.36839  -2531.19657   -578.48073   1257.01942 
             582          583          584          585          586          587          588 
     -3073.60736  -1000.06183    140.61551  -2495.92707  -1058.55168   1432.52856    787.23640 
             589          590          591          592          593          594          595 
      -407.75059  -1280.18853   1633.29952   2477.91549    196.65772  -2234.03494   5511.54365 
             596          597          598          599          600          601          602 
     -4439.19959  -3550.82104   -249.31827   -167.33230  -3146.25212  -3878.20236  -2751.51328 
             603          604          605          606          607          608          609 
      -207.22600   1935.14782   -998.45583  -3355.60717  -1221.90735  -1772.87640   -592.10920 
             610          611          612          613          614          615          616 
     -2135.16463   -320.38358  -5497.17887  -2844.04786   1420.82732  -1171.71232  12984.35080 
             617          618          619          620          621          622          623 
       574.60125   -205.27407    661.99403  -1261.06236  -2775.86194  -1805.77564   4882.47617 
             624          625          626          627          628          629          630 
     -1602.31965  -1317.54321  -3000.83569  -3967.15792  -1841.56007   -555.98681    104.78296 
             631          632          633          634          635          636          637 
     -1902.63559  40228.23866  -1581.81151  -5129.12502  -2944.27183  -1602.04539  -1014.86689 
             638          639          640          641          642          643          644 
       256.83223     90.95898    335.87574   -843.41597  -1995.36735   -753.09634  55551.48130 
             645          646          647          648          649          650          651 
      3589.84817  -2758.31466   -811.49469   -216.65003  -2359.08379  -5545.30747   1380.14144 
             652          653          654          655          656          657          658 
      1389.36737  -3018.62777  -2657.09989  -1122.60964  -4149.57152  -4639.63273    548.11035 
             659          660          661          662          663          664          665 
     -1671.30829   -682.27163  -1373.47074  -3042.85769  -9639.02312   1501.47951  -3563.36496 
             666          667          668          669          670          671          672 
     -3523.97042   -480.33546   1700.11331  -1626.66452  -2756.27657  -2513.02673  -1709.74004 
             673          674          675          676          677          678          679 
     -1480.92904  -2643.77905  -1769.63299   1641.10366  -3864.57669  -1161.69680   7243.58060 
             680          681          682          683          684          685          686 
       963.08607    739.83376    491.58291   2981.50432   -826.19340  -5878.95392  -2679.73513 
             687          688          689          690          691          692          693 
      1218.61808   -941.58271  -1144.81947   1177.06983  -1875.44587  -1938.54305  -2034.66927 
             694          695          696          697          698          699          700 
        93.82509  -4409.03922  -2071.31614  -3803.80694  -5004.51549  -4451.65619  -4298.08900 
             701          702          703          704          705          706          707 
       525.50588  -2841.04765  -1730.83524   -181.26402   1053.98029   -575.80453    528.36917 
             708          709          710          711          712          713          714 
      1034.39056   4032.00330    440.94988   -475.31353   1835.65221   2559.39638  -2306.51485 
             715          716          717          718          719          720          721 
      1588.26584  -6142.33582  -1100.93998    294.33419   1952.76961    803.50604   -153.91957 
             722          723          724          725          726          727          728 
     -2848.66661    757.25763   1001.11693   3591.14524  -4350.57743   1104.35702   1544.09817 
             729          730          731          732          733          734          735 
     -2371.10253  -1025.02900   -304.27223  -2070.10838  -1341.99985  -1070.18940  -7311.16772 
             736          737          738          739          740          741          742 
      -913.25076  -1102.60420  -1397.58588  -1968.30143  -1353.36184   1153.48464   5273.83883 
             743          744          745          746          747          748          749 
     -1475.07439    -53.67382    802.34755  -1378.61838    581.56861   6358.35409 -10318.70853 
             750          751          752          753          754          755          756 
     -3555.56530  -2428.67682  -3995.50308   2008.40398  -1166.33062  -3436.29290  -2585.10330 
             757          758          759          760          761          762          763 
     -5079.26192  -1638.95706    614.45640  -4675.77460   -359.44137  -1389.68340  -1006.84701 
             764          765          766          767          768          769          770 
     -4280.37177  -1729.41045    692.79157    895.55045  -3239.94518   -694.34459   3417.65624 
             771          772          773          774          775          776          777 
     -3874.88238     16.72715  -1084.75426  -3358.83043   1633.52663  -2205.69101  -3011.86384 
             778          779          780          781          782          783          784 
       -11.25446     29.86055 -23135.32342   -285.81305   1884.18281  -1772.56183    493.09387 
             785          786          787          788          789          790          791 
     -2301.47929  -3867.41680  -2516.44715    844.56066   1380.95952  -5429.57777   3771.03156 
             792          793          794          795          796          797          798 
     -1338.01234  -6197.39870 301786.98062   -251.56761   5559.65087   -731.70726    805.92901 
             799          800          801          802          803          804          805 
     -1523.61888   1434.53578  -1830.62197  -2996.60668   -835.78313   -305.40990    -84.51232 
             806          807          808          809          810          811          812 
     -6586.71450  -1847.16247   -194.72667   -891.15074  -2539.48796    -68.95556   4068.74899 
             813          814          815          816          817          818          819 
       868.55945    113.29685    635.76665  -3937.19201  -2841.17793   -394.18963  -2263.12310 
             820          821          822          823          824          825          826 
     -2909.18957    -37.89490  -1567.90772  -3054.22335  -1935.37982  -1954.84190    652.92200 
             827          828          829          830          831          832          833 
     -2004.26481    220.42557  -2348.02152   3642.14967   1111.53538   2922.93904   -346.24792 
             834          835          836          837          838          839          840 
     -2877.92170   -428.46035  -1940.04139    -64.72358   -887.52626  -1728.85431  18181.56715 
             841          842          843          844          845          846          847 
        32.36266   -986.49629    684.08984  -7692.98398  -1134.23558   -354.32455    313.76872 
             848          849          850          851          852          853          854 
       749.16879   1599.93533    387.22889   -344.93312   2643.71635    940.00905  -1677.98127 
             855          856          857          858          859          860          861 
       617.17801   -701.35622  -1127.16691    361.98050   -229.20312     46.39764  -5321.10770 
             862          863          864          865          866          867          868 
      7473.27474    -13.82518  -3722.93935     65.14388    251.82488    788.25070   2229.90449 
             869          870          871          872          873          874          875 
     -2165.16044  -4493.71350    823.11290  -2093.62694   3386.59018  -1390.31975  -5221.47768 
             876          877          878          879          880          881          882 
     -2536.77419   -511.75548  -1847.72221   3392.88385  -1041.24044   1745.33850   -145.25899 
             883          884          885          886          887          888          889 
      1052.09217  -1847.85145    477.96418   -422.35374   5553.06910   -697.10680    597.38937 
             890          891          892          893          894          895          896 
     -3816.42944   1199.52183  -1960.99903    457.21928    286.01986   -278.53628  -2228.94883 
             897          898          899          900          901          902          903 
      -925.69464   -554.61873   -565.27690    461.59263   1597.12342  -1182.62699   3747.41396 
             904          905          906          907          908          909          910 
      3322.48254  -1239.61431  -2030.76788    751.03421  -1700.85837   -799.32769   -260.95970 
             911          912          913          914          915          916          917 
      1652.36900   -815.98180   -298.92243   1520.63794  -2396.87478   7541.42828   -704.81828 
             918          919          920          921          922          923          924 
      5413.88828    477.75395  -5053.80720   1980.51474   1334.06959  -3313.84910   -639.21451 
             925          926          927          928          929          930          931 
      -595.13968  -3038.60153  -2022.81292   6515.54616   6840.93217    214.63174    735.97155 
             932          933          934          935          936          937          938 
     -3127.46221  -2449.27472   -662.42773   1763.34212  -1525.99929   1813.59557   1319.12804 
             939          940          941          942          943          944          945 
      1634.24454   -500.20355   2674.13459    945.37213 679276.06716  -6207.73671   -558.67914 
             946          947          948          949          950          951          952 
      -169.65243  -6051.41598  -3463.85425  -2717.72522   2722.20373     89.18805  -5983.23195 
             953          954          955          956          957          958          959 
     -1045.64387  -2447.88740  -1573.09202  -3105.42091    471.51747   -485.80120  -1381.66180 
             960          961          962          963          964          965          966 
     -1789.11962   -889.75144    -21.37740    -39.56788   6395.54497   3464.36162    272.25233 
             967          968          969          970          971          972          973 
    -55557.39970   -104.75871   1412.15109   -868.29032  -1151.24818  -2076.75528  -1574.07105 
             974          975          976          977          978          979          980 
       283.54815    352.76001   -700.27297   -731.43438   -650.91011  -3309.43360  -1955.31795 
             981          982          983          984          985          986          987 
     -2776.41879   -306.73031  -2393.50431    609.66120  -5442.72941  -2630.85893   -587.56041 
             988          989          990          991          992          993          994 
      1602.84565   1453.54351    180.24105  -1393.72206  -1957.23680   -902.03229  -1482.82919 
             995          996          997          998          999         1000 
     -1247.76834  -6527.52612  -2253.45170   -455.25565   1086.27111  -1593.93892 
     [ reached getOption("max.print") -- omitted 5258 entries ]

``` r
#summary stats for vars of interest - 
plot(fit_Channel)
```

![](data:image/png;base64,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)<!-- -->![](data:image/png;base64,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)<!-- -->![](data:image/png;base64,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)<!-- -->![](data:image/png;base64,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)<!-- -->

``` r
ggplot(data=fit_Channel, aes(y=shares, x=rate_positive_words)) + geom_point()
```

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAqAAAAHgCAMAAABNUi8GAAAA3lBMVEUAAAAAADoAAGYAOpAAZmYAZrYzMzM6AAA6ADo6AGY6Ojo6OpA6kNtNTU1NTW5NTY5NbqtNjshmAABmADpmAGZmtttmtv9uTU1uTW5uTY5ubo5ubqtuq+SOTU2OTW6OTY6Obk2ObquOyP+QOgCQOjqQZgCQkDqQkGaQtpCQ27aQ29uQ2/+rbk2rbm6rbo6rjk2ryKur5OSr5P+2ZgC22/+2///Ijk3I///bkDrb/7bb/9vb///kq27k///r6+v/tmb/yI7/25D/27b/29v/5Kv//7b//8j//9v//+T///9pAWpXAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAWg0lEQVR4nO2dDXvbRnZG4biKk9Z0HG+rJLWctPJukzZ22sq1pG3kSNrKkvD//1AxIEh8EAABkpfzXuLc57Ek4uPgHeBoMBhLVJJSlHAlsQNQVF8hKCVdCEpJF4JS0oWglHQhKCVduxD0j+7qWze0YOwa4YGBoF4ZIjEQFIYZwgMDQb0yRGIgKAwzhAcGgnpliMRAUBhmCA8MBPXKEImBoDDMEB4YCOqVIRIDQWGYITwwENQrQyQGgsIwQ3hgIKhXhkgMT4JSlFnRg3pjiMTw1IPGa8UUGSIxEBTGMESSJDFiICiMQYgk2cBQkaYg6CEyEBRBpRkIiqDSDMagCCrNEImBoDDMEB4YCOqVIRIDQWGYITwwENQrQyQGgsIwQ3hgIKhXhkgMBIVhhvDAQFCvDJEYCArDDOGBgaBeGSIxEBSGGcIDA0G9MkRiICgMM4QHBoJ6ZYjEQFAYZggPDAT1yhiLaPuBZpGmIOghMkYiWn8lRKQpCHqIDARFUGkGgiKoNIMxKIJKM0RiICgMM4QHBoJ6ZYjEQFAYZggPDAT1yhCJgaAwzBAeGAjqlSESA0FhmCE8MBDUK0MkBoLCMEN4YCCoV4ZIDASFYYbwwEBQrwyRGAgKwwzhgYGgXhkiMRAUhhnCAwNBvTJEYiAoDDOEBwaCemWIxEBQGGYIDwwE9coQiYGgMMwQHhgI6pUhEgNBYZghPDAGCPr4bvbirLnw/s3s5ac0vZrNZt9cIGgEhkgMAUHPT9ObIGNd2tP06tt8HT1oHIZIjPiC3v90segz874yfx0+3P1w8fi+2rXGa8UUGSIx4gt69/o/81v8+UneZ84FvXv9Kb3/8SyTdjbLO9Evs+ruhClqy+oR9LvT4GOmY3DzZhbqJNzzsyV335+lZS8a79tsigyRGAo9aNlZhp602oPmGyzHofFaMUWGSIz4gt7/61zQYihaG4MiaDyGSIz4ggYBQ4eZjUHLh/nHd/mINCx4/I1pphgMkRgCghaP79mnynRoOQ9aLozXiikyRGIICDq44rViigyRGAgKwwzhgYGgXhkiMRAUhhnCAwNBvTJEYiAoDDOEBwaCemWIxEBQGGYIDwwE9coQiYGgMMwQHhgI6pUhEgNBYZghPDAQ1CtDJAaCwjBDeGAgqFeGSAwEhWGG8MBAUK8MkRgICsMM4YGBoF4ZIjEQFIYZwgMDQb0yRGIgKAwzhAcGgnpliMRAUBhmCA8MBPXKEImBoDDMEB4YCOqVIRIDQWGYITwwENQrQyQGgsIwQ3hgIKhXhkgMBIVhhvDAQFCvDJEYCArDDOGBgaBeGSIxEBSGGcIDA0G9MkRiICgMM4QHBoJ6ZYjEQFAYZggPDAT1yhCJgaAwzBAeGAjqlSESA0FhmCE8MBDUK0MkBoLCMEN4YCCoV4ZIDASFYYbwwEBQrwyRGAgKwwzhgYGgXhkiMTwJSlFmRQ/qjSESw1MPGq8VU2SIxEBQGGYIDwwE9coQiYGgMMwQHhgI6pUhEgNBYZghPDAQ1CtDJAaCwjBDeGAgqFeGSAwEhWGG8MBAUK8MkRgICsMM4YGBoF4ZIjEQFIYZwgMDQb0yRGIgKAwzhAcGgnpliMRAUBhmCA8MBPXKEImBoDDMEB4YCOqVIRIDQWGYITwwENQrQyQGgsIwQ3hgIKhXhkgMBIVhhvDAQFCvDJEYCArDDOGBgaBeGSIxEBSGGcIDA0G9MkRiICgMM4QHBoJ6ZYjEQFAYZggPDAT1yhCJgaAwzBAeGAjqlSESA0FhmCE8MBDUK0MkBoLCMEN4YCCoV4ZIDASFYYbwwEBQrwyRGAgKwwzhgYGgXhkiMRAUhhnCAwNBvTJEYiAoDDOEBwaCemWIxEBQGGYIDwwE9coQiSEh6OO70+ai+zezl5/S9Go2m31zgaARGCIxJAS9mjUFDcpefZum59UV8VoxRYZIDAVB7/75X07zPjPvK+9/uph/uPvh4vH9GYJGYojEEBD08f1/h1v8+UneZ84FvXv9Kb3/8SyTdjbvXb/Mqq8TpqitqkfQq5NwQ890DG7ezEKd3LzMBb37/iwte9F432ZTZIjEiN+DZp1lLmjoLF+c1XvQfIPlODReK6bIEIkRX9CreZ+ZexmqOgZF0HgMkRjxBU2LaaZsDBpu7Isl+Yg0LHj8jWmmGAyRGDqCZvf4F+UzezkPWi6M14opMkRiSAg6sOK1YooMkRgICsMM4YGBoF4ZIjEQFIYZwgOjVdDPr44/v0q++IigwgyRGFEE/XCUXn7x8fIIQYUZIjFiCJp1oA9vj9LrsV1ovFZMkSESI5Kgn189R1BthkiMGII+vH1+/eTXcKNHUF2GSIwoY9DbZ8lR+uHp7wgqzBCJwTQTDDOEBwaCemWIxIgj6GWSHF9yi5dmiMSIMw/69K/zmSYE1WWIxIg2zXTMNJM2QyQGgsIwQ3hgtAmaXoZbfJirR1BdhkiMOA9J10lWY/1E0L0yRGIwzQTDDOGB0Sbow9tjBJVniMSI9JCEoPIMkRiRHpLGztEj6N4ZIjHi9KBJXkwzKTNEYvCQBMMM4YGBoF4ZIjGiCHr7jFu8PEMkRpxppucPb4/HP8vHa8UUGSIxYk0zfXieXo99lo/XiikyRGLEEvSS3+oUZ4jEiDIG/ZDbOXo2NF4rpsgQiRFF0GwQmn5Invw6zk8E3StDJAbTTDDMEB4YCOqVIRKDeVAYZggPjDZBx/+6HILunyESI9Y0E4KqM0RixOlBEVSfIRIjyhh09BQ9gu6fIRJj74IufhiUhyRxhkgMpplgmCE8MBDUK0MkRhRB+SMKDhgiMWL9sAh/REGPkT0WKMTYL6NNUP6IgiQjf3CNH2PPjA5B+SMKegwEXRR/REGSMUbQ+mhgpzH2zGgTlD+ioMkYPgZtuLzbGPtltAq6YcVrxRQZCIqg0gwERVAxxohppgMfg1KKlXeLsUNEK3pQeQbTTAgqzUBQBNVm8F+dCOqIIRIDQWGYITwwENQrQyQGgsIwQ3hgIKhXhkgMBIVhhvDAQFCvDJEYCArDDOGBgaBeGSIxEBSGGcIDA0G9MkRiICgMM4QHBoJ6ZYjEQFAYZggPDAT1yhCJgaAwzBAeGAjqlSESA0FhmCE8MBDUK0MkBoLCMEN4YCCoV4ZIDASFYYbwwEBQrwyRGAgKwwzhgYGgXhkiMRAUhhnCAwNBvTJEYiAoDDOEBwaCemWIxEBQGGYIDwwE9coQiYGgMMwQHhgI6pUhEgNBYZghPDAQ1CtDJAaCwjBDeGAgqFeGSAwEhWGG8MBAUK8MkRgICsMM4YGBoF4ZIjEQFIYZwgMDQb0yRGIgKAwzhAcGgnpliMRAUBhmCA8MBPXKEImBoDDMEB4YCOqVIRIDQWGYITwwBgh6991sdtpceP9m9vJTml7NZrNvLhA0AkMkRnxB7388S+++P6svfHx3ml59m6bnVXPjtWKKDJEY8QW9yTwMImZ9Zt5X3v90Mf9w98PF4/uquPFaMUWGSIz4gi560fOTvM+cC3r3+lNYmElb3P6/zKoXQVHbVK+gj+9OckczN29moU5uXuaChlt/2YvG+zabIkMkhkIPev/mJH8qms1enNV70Hz1chwarxVTZIjEEBD07rtgYO5lmtbHoAgajyESI76gcz/TMAYNN/bypp+NSMOCx9+YZorBEIkRX9CrfNSZP8W/KJ/Zy3nQcmG8VkyRIRIjvqDDK14rpsgQiYGgMMwQHhgI6pUhEgNBYZghPDAQ1CtDJAaCwjBDeGAgqFeGSAwEhWGG8MBAUK8MkRgICsMM4YGBoF4ZIjEQFIYZwgMDQb0yRGIgKAwzhAcGgnpliMRAUBi7RCRJstsYCApjh4gkqRkq0hQEPUQGgiKoNANBEVSawRgUQaUZIjEQFIYZwgMDQb0yRGIgKIwtEPUhp0UMBIWxOaLx0G4RA0FhbI5AUASNxhgraJuqIk1B0ENkjByDtnamIk1B0ENkjEQgKILul4GgCCrNGItgDIqge2WIxEBQGGYIDwwE9coQiYGgMMwQHhgI6pUhEgNBYZghPDAQ1CtDJAaCwjBDeGAgqFeGSAwEhWGG8MBAUK8MkRgICsMMsVdG349OI+gBMkRiDGX0/nA/gh4gQyQGgk6X4f73iaqFoAfHWPMbb56aEoox6KExJAVdjcRT/FQZioK2ZELQyTJijkE7ju1bUOpgKhdxxHL7ogf1xjCN0Tm8aC5e8+ZP2+bgFu+XEUfQDbfbNAeCxmHs4qpGGYO2bIagh8fYyWWVaAqCHiTjcARlDHqQjAMS1NU0U7xWeGPoj0FlGAjqlSESA0FhjEEM6ZvLbUSagqCHyGhFDBndVrbZepqplzGcgqAHyDAVdMRjXE9TBlMQ9AAZCIqg0gzTMSiCblAwdo3YfAxaWc0YFIYVYmNGtWvkKR6GFQJBhyTYRSumyEBQBJVmRI0xcAy6gxwI6o8xtyN6jP0wENQdo7i/xo6xJwaCumMg6AEJ2pyIc3BF1tZ2gtbOSOymDGActqAr/5Xh4Iqsr23GoPUzEr0p6xkIuo8cFgwERdCd5bBgRBW0Os1k++srhy2o6hg04q987GQMWtV8F79gNV1BNRkqvzRXSzEmEoIeNiOyoIuD12KMyoSgh80YeE37NxobY0lbHr36xUjPGmNQBD0wxlA/d/j+oCVtRdBkWeOQRY7tu9C+/RE0BsNE0H7oEEHXZ2rLsbWgvQAEjcBYe0nz1SMFXbN5ZXXzi230RNBDZKy7pMX6cWPQAdAuxnaCbj1phqBqjIGCjouxiWQLxnaCbl2MQdUY6+/w4wUd2ZEltR842aITXD0dm3+jtK1CUCNG32VadwmHXOLtmjL/HjA5HRt0xwi6E0Zx3ocx+i7Tlo8VSc9PMw0FbyBoO3p1aUfreu/j3UdF0MG1OPGxBS32bo0xmDxc0AWwHd2ydPCGZSHoLhiHJ+iAuYLmrGnzAG0H7OpAhQXddiJiXSv2whgn6FZj0N4NRwq6ItRyu7Kqy7uI9e17DtjZEl1Bt+sxBrRiP4xkdQy6abuGS756gD5BV6c0668Xr5qClpqWN/Tm/svt2ozfrCkDGAi6DWPjhpkJuvL/QuMFTep71frWVUH7cqxtytpVCLodQ0/QinRtiOWrmppNYVsO3DC3srajKW2EMa1c4vchqM8xaFdoc0Hr/V/X+u4xaN3RaleYNG7d5XZDBW2+amzX9Y3RWwKCKvZ+66rztA0cg/Zen74cnQeuLV56Vdspaa/lFpXOr83kYYK2QAtsE9bTys6GNQpBu2pLQfsvUPd9sX4b7iTOXzRESbo8XX1qr+y0Imjl65Zjt0C78gy8c/aeKgTtqiGCrmxT92WsoPWrXCfUiXUfK2tb7Gut5j29CulY081did582V+9myFoZ3WdtR5BS0tqOjXvx605yn1qF3llbfVVXYi6Ep02jqqVo3ds0zj8Spo1Jzq2oINyritByctTW7l6XTfI+gVvUiuXOxkl6B9LdmV4kDS32LTWdsXVQ5QfK4OV9Ve+d6u9CDos57qKJmgjfNsYtHoxVy9M9epVtm4co2lEc7xQ2WlFjcXKMVLtvjqP299FFZu0F4J2VlLVKanK0bFN8w7XtbbtMajzIjde17Zt9WC7HnOrWvOd0Tx/SfN0tF6xSQk6JMbKaWu5BJVtW5zpetqpXqPGjXiwU9Hk20GVbU9WT17X5ThAQbuPVTtNHVt3nL/lSV5+7N6mNiJruUaRb8QS1XqmW6/6ekHv38xefupYWFvXp8xYQVt2GPgTurWDlaegtqr9LFUHggMsWm4z+tqsRU+n1uqxXtDHd6fp1bftC+vr+mwbKWjbHgN/vqy6pPh6sah+SlZXtZy2yseWc7vhRakee9q1Xo/1gt7/dJHe/XAROstvLorXi4WLdQg66qpUjz3tWq/HekHvXn9K7388S89P5p1lLmixcLEuTb/MqhORJ+hcu9UeqxtWlxRfLxaVq4rz01i1rHLfysdmrew1tDoOOsEacbG7N7h5mUsYPMzcvJmFOikWFp+KLXs7xJ7ucuAeQ39LrLokqU/nrFm1OG/VDZJGV1nfKKn3hKud4h+rX9cPOuXqudjlVV8raNFLZnf42ezFWVcP2i+o4v8CeWdsjci0EGnKdr/yURluLl+PHIPKXNRDYojEiC/o47v54DMbg94sp5SKhYt1CLp/hkiM+IJWpjxfnLUsHDAP6uJMeGOIxBAQdHDFa8UUGSIxEBSGGcIDA0G9MkRiICgMM4QHBoJ6ZYjEQFAYZggPDAT1yhCJgaAwzBAeGAjqlSESA0FhmCE8MBDUK0MkBoLCMEN4YCCoV4ZIDE+C9lT3r4Pst8hRK5EYQ3Ig6F5LJIdIDARdFjlqJRIDQZdFjlqJxBAQlKK2KwSlpAtBKelCUEq6EJSSLgtBy99Jbvsl5f1Vedi772az0zS9ms3mb4QWK0cRIM75WB71Kn8bo9NYpyNdvufHED0MBC3fm7H1zRr3VuVhw7v03H1/lp6f7j1ELUcRIM75qB81vBdHnNORHbv4thikh4Gg5fvitL5Rzt6qPOxNaP756eP7s3X72OYoAsQ5H7Wjhm/ZSKcjPX/xX/MYg/QwELR8Z7HWtxrbW9UPu3gftP33GmWOIkCc81E7auixIp2OdHmLH6SHgaDlezO2vlnj3qp22PBuUuEuH6HbKHMUAeKcj+pR88+RTke6FHSQHhPpQe/fnBRL9z/wajT//DR+D1q+G1yUcWjkHlRvDJo9xS+vw/6vSKP556fxx6Dni2/XqILGGoOW783Y+maNe6vysIWfod94/G3v3yhljiJAnPNROer8xh7pdKRLQQfpYTcPWvwBhujzoFmOysTfiwhjrvJ8FAFizoPml2V+Q410OuaCDtWD/0mipAtBKelCUEq6EJSSLgSlpAtBKelC0M3rb/8zeNPbr34Nm4dPG9T1Fx832e0gCkE3rpG2bShnKASlNigE3Uch6Ji6/frfki8+3j5LkuR5+Pg8fXibJBV9br/6OUme/p7my4/CgrDtcbb8l7D57Vf/8fZ5tvTyi4/1HR/C4utsw/TD0WLf+cE+v0qe/JxtWIAmVwg6pm6fZeJ8fnWcKxa6xIe32YLLYORig6DeUbr4l3ebt8+Os8/hy+xf2DjTsblj+PLD3wfhj5f7zg/2PPs3P1gAxWl3xELQMZUb8n/BqsK4/OabG1vZIFuRL88+3H497yRLQYtPKzt+/fHhzz8//T37vNw3sPIXlyVocoWgY6oYR15nd9snuWqX8z+A/ry2Qebddegbw4sPxZ1+aWa4mWfdZXPHrOe8/Ye//uPHbNVi35yVd7LBzgI0uULQMVX492TZF1Zu0tUNSkHDqyS/QxeCptdP/3fuaB394ej66OHtP2Wr2gUtQHtrqkoh6JjKnckFup73oNmn+gb5LT67TYfli4fvTNiKoJ//9EvmW3PHjPqX4/Ty7/5UMK+LYefifr8A7aWZSoWgY2ruTOhAnz35Nejy8DaztSJb8yEpV2tuZ9g83/9DuFc3d5z3y9dJ/ghVecD6/Ooof0hagKI0O2Yh6JiaG5INB5/8e6ZbMC1MCVU0y6eZwlhxMc00H64Ww9GjueD5bFFjx4yauRme2Zf7LkcI+TRTAZpcIehOa4p9nG0h6E4LQXddCLqLyv+bJ9yDfxkp6HJHvO4oBKWkC0Ep6UJQSroQlJIuBKWkC0Ep6UJQSrr+H43mTe+i0TGbAAAAAElFTkSuQmCC)<!-- -->

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
    2 weekday_is_monday     0.0260 
    3 weekday_is_tuesday   -0.00419
    4 weekday_is_wednesday -0.0130 
    5 weekday_is_thursday  -0.00586
    6 weekday_is_friday    -0.0182 
    7 weekday_is_saturday   0.0182 
    8 weekday_is_sunday     0.00769

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

     n_tokens_title n_tokens_content n_unique_tokens  n_non_stop_words
     Min.   : 3.0   Min.   :   0.0   Min.   :0.0000   Min.   :0.0000  
     1st Qu.: 9.0   1st Qu.: 244.0   1st Qu.:0.4782   1st Qu.:1.0000  
     Median :10.0   Median : 395.0   Median :0.5481   Median :1.0000  
     Mean   :10.3   Mean   : 540.9   Mean   :0.5460   Mean   :0.9959  
     3rd Qu.:12.0   3rd Qu.: 730.8   3rd Qu.:0.6109   3rd Qu.:1.0000  
     Max.   :19.0   Max.   :6336.0   Max.   :0.8732   Max.   :1.0000  
     n_non_stop_unique_tokens   num_hrefs       num_self_hrefs      num_imgs     
     Min.   :0.0000           Min.   :  0.000   Min.   : 0.000   Min.   : 0.000  
     1st Qu.:0.6486           1st Qu.:  4.000   1st Qu.: 1.000   1st Qu.: 1.000  
     Median :0.7042           Median :  7.000   Median : 2.000   Median : 1.000  
     Mean   :0.7034           Mean   :  9.321   Mean   : 2.825   Mean   : 1.823  
     3rd Qu.:0.7603           3rd Qu.: 11.000   3rd Qu.: 4.000   3rd Qu.: 1.000  
     Max.   :0.9730           Max.   :106.000   Max.   :56.000   Max.   :51.000  
       num_videos      average_token_length  num_keywords    data_channel_is_lifestyle
     Min.   : 0.0000   Min.   :0.000        Min.   : 2.000   Min.   :0                
     1st Qu.: 0.0000   1st Qu.:4.527        1st Qu.: 5.000   1st Qu.:0                
     Median : 0.0000   Median :4.689        Median : 6.000   Median :0                
     Mean   : 0.6422   Mean   :4.684        Mean   : 6.489   Mean   :0                
     3rd Qu.: 0.0000   3rd Qu.:4.855        3rd Qu.: 8.000   3rd Qu.:0                
     Max.   :75.0000   Max.   :5.960        Max.   :10.000   Max.   :0                
     data_channel_is_entertainment data_channel_is_bus data_channel_is_socmed
     Min.   :0                     Min.   :1           Min.   :0             
     1st Qu.:0                     1st Qu.:1           1st Qu.:0             
     Median :0                     Median :1           Median :0             
     Mean   :0                     Mean   :1           Mean   :0             
     3rd Qu.:0                     3rd Qu.:1           3rd Qu.:0             
     Max.   :0                     Max.   :1           Max.   :0             
     data_channel_is_tech data_channel_is_world   kw_min_min       kw_max_min    
     Min.   :0            Min.   :0             Min.   : -1.00   Min.   :     0  
     1st Qu.:0            1st Qu.:0             1st Qu.: -1.00   1st Qu.:   435  
     Median :0            Median :0             Median : -1.00   Median :   636  
     Mean   :0            Mean   :0             Mean   : 28.97   Mean   :  1052  
     3rd Qu.:0            3rd Qu.:0             3rd Qu.:  4.00   3rd Qu.:  1100  
     Max.   :0            Max.   :0             Max.   :318.00   Max.   :298400  
       kw_avg_min        kw_min_max       kw_max_max       kw_avg_max       kw_min_avg  
     Min.   :   -1.0   Min.   :     0   Min.   :     0   Min.   :     0   Min.   :   0  
     1st Qu.:  151.3   1st Qu.:     0   1st Qu.:690400   1st Qu.:235375   1st Qu.:   0  
     Median :  253.7   Median :  1700   Median :843300   Median :313625   Median :1095  
     Mean   :  317.3   Mean   : 20647   Mean   :745902   Mean   :316617   Mean   :1119  
     3rd Qu.:  373.6   3rd Qu.:  7700   3rd Qu.:843300   3rd Qu.:403117   3rd Qu.:1950  
     Max.   :42827.9   Max.   :690400   Max.   :843300   Max.   :767414   Max.   :3531  
       kw_max_avg       kw_avg_avg    self_reference_min_shares self_reference_max_shares
     Min.   :     0   Min.   :    0   Min.   :     0.0          Min.   :     0           
     1st Qu.:  3487   1st Qu.: 2332   1st Qu.:   454.2          1st Qu.:   715           
     Median :  4069   Median : 2770   Median :  1100.0          Median :  2500           
     Mean   :  5309   Mean   : 2964   Mean   :  3499.8          Mean   : 10148           
     3rd Qu.:  5300   3rd Qu.: 3344   3rd Qu.:  2300.0          3rd Qu.:  6100           
     Max.   :298400   Max.   :43568   Max.   :690400.0          Max.   :690400           
     self_reference_avg_sharess weekday_is_monday weekday_is_tuesday weekday_is_wednesday
     Min.   :     0.0           Min.   :0.0000    Min.   :0.0000     Min.   :0.0000      
     1st Qu.:   683.2           1st Qu.:0.0000    1st Qu.:0.0000     1st Qu.:0.0000      
     Median :  1990.4           Median :0.0000    Median :0.0000     Median :0.0000      
     Mean   :  6080.1           Mean   :0.1807    Mean   :0.1899     Mean   :0.2013      
     3rd Qu.:  4300.0           3rd Qu.:0.0000    3rd Qu.:0.0000     3rd Qu.:0.0000      
     Max.   :690400.0           Max.   :1.0000    Max.   :1.0000     Max.   :1.0000      
     weekday_is_thursday weekday_is_friday weekday_is_saturday weekday_is_sunday
     Min.   :0.0000      Min.   :0.0000    Min.   :0.00000     Min.   :0.0000   
     1st Qu.:0.0000      1st Qu.:0.0000    1st Qu.:0.00000     1st Qu.:0.0000   
     Median :0.0000      Median :0.0000    Median :0.00000     Median :0.0000   
     Mean   :0.1956      Mean   :0.1378    Mean   :0.03811     Mean   :0.0566   
     3rd Qu.:0.0000      3rd Qu.:0.0000    3rd Qu.:0.00000     3rd Qu.:0.0000   
     Max.   :1.0000      Max.   :1.0000    Max.   :1.00000     Max.   :1.0000   
       is_weekend          LDA_00           LDA_01            LDA_02            LDA_03       
     Min.   :0.00000   Min.   :0.1135   Min.   :0.01820   Min.   :0.01818   Min.   :0.01818  
     1st Qu.:0.00000   1st Qu.:0.5081   1st Qu.:0.02857   1st Qu.:0.02857   1st Qu.:0.02857  
     Median :0.00000   Median :0.7005   Median :0.04000   Median :0.04000   Median :0.03339  
     Mean   :0.09471   Mean   :0.6523   Mean   :0.07683   Mean   :0.08135   Mean   :0.06565  
     3rd Qu.:0.00000   3rd Qu.:0.8400   3rd Qu.:0.05002   3rd Qu.:0.05010   3rd Qu.:0.05000  
     Max.   :1.00000   Max.   :0.9200   Max.   :0.71244   Max.   :0.79897   Max.   :0.64661  
         LDA_04        global_subjectivity global_sentiment_polarity
     Min.   :0.01818   Min.   :0.0000      Min.   :-0.23929         
     1st Qu.:0.02867   1st Qu.:0.3884      1st Qu.: 0.08705         
     Median :0.04000   Median :0.4397      Median : 0.13549         
     Mean   :0.12384   Mean   :0.4359      Mean   : 0.13549         
     3rd Qu.:0.16958   3rd Qu.:0.4877      3rd Qu.: 0.18441         
     Max.   :0.79742   Max.   :0.7316      Max.   : 0.62258         
     global_rate_positive_words global_rate_negative_words rate_positive_words
     Min.   :0.00000            Min.   :0.000000           Min.   :0.0000     
     1st Qu.:0.03226            1st Qu.:0.009009           1st Qu.:0.6667     
     Median :0.04217            Median :0.013986           Median :0.7500     
     Mean   :0.04312            Mean   :0.014689           Mean   :0.7375     
     3rd Qu.:0.05343            3rd Qu.:0.019282           3rd Qu.:0.8333     
     Max.   :0.12500            Max.   :0.058824           Max.   :1.0000     
     rate_negative_words avg_positive_polarity min_positive_polarity max_positive_polarity
     Min.   :0.0000      Min.   :0.0000        Min.   :0.00000       Min.   :0.0000       
     1st Qu.:0.1667      1st Qu.:0.3065        1st Qu.:0.03333       1st Qu.:0.6000       
     Median :0.2500      Median :0.3538        Median :0.10000       Median :0.8000       
     Mean   :0.2581      Mean   :0.3531        Mean   :0.08603       Mean   :0.7692       
     3rd Qu.:0.3333      3rd Qu.:0.4023        3rd Qu.:0.10000       3rd Qu.:1.0000       
     Max.   :1.0000      Max.   :0.7740        Max.   :0.70000       Max.   :1.0000       
     avg_negative_polarity min_negative_polarity max_negative_polarity title_subjectivity
     Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000       Min.   :0.00000   
     1st Qu.:-0.3018       1st Qu.:-0.7000       1st Qu.:-0.1250       1st Qu.:0.00000   
     Median :-0.2366       Median :-0.5000       Median :-0.1000       Median :0.06667   
     Mean   :-0.2432       Mean   :-0.4807       Mean   :-0.1087       Mean   :0.24907   
     3rd Qu.:-0.1781       3rd Qu.:-0.2500       3rd Qu.:-0.0500       3rd Qu.:0.45455   
     Max.   : 0.0000       Max.   : 0.0000       Max.   : 0.0000       Max.   :1.00000   
     title_sentiment_polarity abs_title_subjectivity abs_title_sentiment_polarity
     Min.   :-1.00000         Min.   :0.0000         Min.   :0.0000              
     1st Qu.: 0.00000         1st Qu.:0.1667         1st Qu.:0.0000              
     Median : 0.00000         Median :0.5000         Median :0.0000              
     Mean   : 0.07893         Mean   :0.3427         Mean   :0.1405              
     3rd Qu.: 0.13636         3rd Qu.:0.5000         3rd Qu.:0.2143              
     Max.   : 1.00000         Max.   :0.5000         Max.   :1.0000              
         shares        
     Min.   :     1.0  
     1st Qu.:   952.2  
     Median :  1400.0  
     Mean   :  3146.5  
     3rd Qu.:  2500.0  
     Max.   :690400.0  

``` r
#check structure of objects
str(ChannelTrain)
```

    tibble [4,382 × 59] (S3: tbl_df/tbl/data.frame)
     $ n_tokens_title               : num [1:4382] 9 9 8 13 10 12 6 13 9 10 ...
     $ n_tokens_content             : num [1:4382] 255 211 397 244 142 444 109 306 233 468 ...
     $ n_unique_tokens              : num [1:4382] 0.605 0.575 0.625 0.56 0.655 ...
     $ n_non_stop_words             : num [1:4382] 1 1 1 1 1 ...
     $ n_non_stop_unique_tokens     : num [1:4382] 0.792 0.664 0.806 0.68 0.792 ...
     $ num_hrefs                    : num [1:4382] 3 3 11 3 2 9 3 3 5 7 ...
     $ num_self_hrefs               : num [1:4382] 1 1 0 2 1 8 2 2 1 6 ...
     $ num_imgs                     : num [1:4382] 1 1 1 1 1 23 1 1 1 1 ...
     $ num_videos                   : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ average_token_length         : num [1:4382] 4.91 4.39 5.45 4.42 4.27 ...
     $ num_keywords                 : num [1:4382] 4 6 6 4 5 10 6 10 4 5 ...
     $ data_channel_is_lifestyle    : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_entertainment: num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_bus          : num [1:4382] 1 1 1 1 1 1 1 1 1 1 ...
     $ data_channel_is_socmed       : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_tech         : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_world        : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_min_min                   : num [1:4382] 0 0 0 0 0 0 0 217 217 217 ...
     $ kw_max_min                   : num [1:4382] 0 0 0 0 0 0 0 5700 425 425 ...
     $ kw_avg_min                   : num [1:4382] 0 0 0 0 0 ...
     $ kw_min_max                   : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_max_max                   : num [1:4382] 0 0 0 0 0 0 0 17100 17100 17100 ...
     $ kw_avg_max                   : num [1:4382] 0 0 0 0 0 ...
     $ kw_min_avg                   : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_max_avg                   : num [1:4382] 0 0 0 0 0 ...
     $ kw_avg_avg                   : num [1:4382] 0 0 0 0 0 ...
     $ self_reference_min_shares    : num [1:4382] 0 918 0 2800 0 585 821 0 2000 699 ...
     $ self_reference_max_shares    : num [1:4382] 0 918 0 2800 0 1600 821 0 2000 2000 ...
     $ self_reference_avg_sharess   : num [1:4382] 0 918 0 2800 0 ...
     $ weekday_is_monday            : num [1:4382] 1 1 1 1 1 1 1 0 0 0 ...
     $ weekday_is_tuesday           : num [1:4382] 0 0 0 0 0 0 0 1 0 0 ...
     $ weekday_is_wednesday         : num [1:4382] 0 0 0 0 0 0 0 0 1 1 ...
     $ weekday_is_thursday          : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_friday            : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_saturday          : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_sunday            : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ is_weekend                   : num [1:4382] 0 0 0 0 0 0 0 0 0 0 ...
     $ LDA_00                       : num [1:4382] 0.8 0.218 0.867 0.3 0.441 ...
     $ LDA_01                       : num [1:4382] 0.05 0.0333 0.0333 0.05 0.04 ...
     $ LDA_02                       : num [1:4382] 0.0501 0.0334 0.0333 0.05 0.2393 ...
     $ LDA_03                       : num [1:4382] 0.0501 0.0333 0.0333 0.05 0.24 ...
     $ LDA_04                       : num [1:4382] 0.05 0.6822 0.0333 0.5497 0.04 ...
     $ global_subjectivity          : num [1:4382] 0.341 0.702 0.374 0.332 0.443 ...
     $ global_sentiment_polarity    : num [1:4382] 0.1489 0.3233 0.2125 -0.0923 0.1143 ...
     $ global_rate_positive_words   : num [1:4382] 0.0431 0.0569 0.0655 0.0164 0.0211 ...
     $ global_rate_negative_words   : num [1:4382] 0.01569 0.00948 0.01008 0.02459 0.00704 ...
     $ rate_positive_words          : num [1:4382] 0.733 0.857 0.867 0.4 0.75 ...
     $ rate_negative_words          : num [1:4382] 0.267 0.143 0.133 0.6 0.25 ...
     $ avg_positive_polarity        : num [1:4382] 0.287 0.496 0.382 0.292 0.367 ...
     $ min_positive_polarity        : num [1:4382] 0.0333 0.1 0.0333 0.1364 0.2 ...
     $ max_positive_polarity        : num [1:4382] 0.7 1 1 0.433 0.5 ...
     $ avg_negative_polarity        : num [1:4382] -0.119 -0.467 -0.145 -0.456 -0.3 ...
     $ min_negative_polarity        : num [1:4382] -0.125 -0.8 -0.2 -1 -0.3 ...
     $ max_negative_polarity        : num [1:4382] -0.1 -0.133 -0.1 -0.125 -0.3 ...
     $ title_subjectivity           : num [1:4382] 0 0 0 0.7 0 ...
     $ title_sentiment_polarity     : num [1:4382] 0 0 0 -0.4 0 ...
     $ abs_title_subjectivity       : num [1:4382] 0.5 0.5 0.5 0.2 0.5 ...
     $ abs_title_sentiment_polarity : num [1:4382] 0 0 0 0.4 0 ...
     $ shares                       : num [1:4382] 711 1500 3100 852 575 819 732 1200 2000 1900 ...

``` r
str(Lifestlye_sumstats_Train)
```

     'table' chr [1:6, 1:59] "Min.   : 3.0  " "1st Qu.: 9.0  " "Median :10.0  " ...
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
    9.367299e+03 2.700451e-03 2.564012e+03 

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
    9347.8656899    0.0136459 2616.3884567 

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
    9.426089e+03 5.255047e-03 2.526236e+03 

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
         1 341183960.3066             nan     0.1000 -154784.2316
         2 339637560.2416             nan     0.1000 -269831.6797
         3 338348945.0073             nan     0.1000 -689943.3551
         4 338163904.2853             nan     0.1000 213648.8275
         5 337184342.7423             nan     0.1000 -1193981.1752
         6 336626640.3565             nan     0.1000 -1270944.3635
         7 336305597.4478             nan     0.1000 -1491507.6159
         8 336473724.9525             nan     0.1000 -1325659.9040
         9 336644271.4623             nan     0.1000 -773628.2922
        10 336364724.7968             nan     0.1000 -1183769.8328
        20 335898531.0458             nan     0.1000 -1000066.8090
        40 334819932.7683             nan     0.1000 -689531.2893
        60 334465253.8616             nan     0.1000 -929826.5667
        80 333968636.4558             nan     0.1000 -1322571.1265
       100 333089091.5581             nan     0.1000 -2692417.0358
       120 333737946.3411             nan     0.1000 22806.0059
       140 334101261.3500             nan     0.1000 -1200930.6467
       160 332325020.3052             nan     0.1000 -2012097.1256
       180 332715530.8864             nan     0.1000 -1129761.8421
       200 332213298.2651             nan     0.1000 -903658.0798

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 341276152.2746             nan     0.1000 1682.7619
         2 339238604.6208             nan     0.1000 -153405.3769
         3 337445525.1234             nan     0.1000 -379172.9669
         4 334734765.0800             nan     0.1000 -240135.0968
         5 334910722.3452             nan     0.1000 -739146.9480
         6 335135588.9589             nan     0.1000 -725525.4232
         7 333802530.3604             nan     0.1000 -1007217.0546
         8 334089283.4752             nan     0.1000 -1000382.7579
         9 334393075.0003             nan     0.1000 -1058715.0680
        10 333261788.9340             nan     0.1000 -1416614.4468
        20 331532645.3874             nan     0.1000 -1563658.0923
        40 330236951.3179             nan     0.1000 -400932.4648
        60 330334410.4395             nan     0.1000 -1269803.6427
        80 330195184.7308             nan     0.1000 -1135366.1833
       100 328466081.6166             nan     0.1000 -1317488.9399
       120 329085232.0068             nan     0.1000 -771171.7849
       140 325329626.1364             nan     0.1000 -339463.9238
       160 324113572.9975             nan     0.1000 -733011.3581
       180 320867746.9166             nan     0.1000 -801520.9980
       200 319218257.9487             nan     0.1000 -1108422.7895

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 343313843.6500             nan     0.1000 607550.1738
         2 340686079.9062             nan     0.1000 -61729.7498
         3 339271478.1822             nan     0.1000 62902.9897
         4 336493321.7717             nan     0.1000 -1022707.7604
         5 335199055.9567             nan     0.1000 -548287.5109
         6 333381454.7156             nan     0.1000 -865343.9869
         7 331908362.2739             nan     0.1000 -530780.1533
         8 331988802.4373             nan     0.1000 -406273.7357
         9 329387371.1883             nan     0.1000 -322780.7267
        10 328449746.0648             nan     0.1000 -1102307.9747
        20 319261508.0255             nan     0.1000 -962777.7569
        40 312739240.5739             nan     0.1000 -770599.8011
        60 309131503.0733             nan     0.1000 -2074903.7149
        80 301835809.8983             nan     0.1000 -1031960.9271
       100 295619100.6079             nan     0.1000 -1191067.0753
       120 288538369.6237             nan     0.1000 -1681467.8597
       140 279241990.1667             nan     0.1000 -1648433.2093
       160 276194748.2106             nan     0.1000 -1740080.1449
       180 272734030.6172             nan     0.1000 -1383931.6233
       200 270786600.3989             nan     0.1000 -1195813.7980

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 341015209.2113             nan     0.1000 -169340.1090
         2 336068197.2369             nan     0.1000 -845496.7518
         3 335237644.7621             nan     0.1000 483355.9732
         4 331039751.1796             nan     0.1000 -298930.4972
         5 329277428.9105             nan     0.1000 -911734.1099
         6 328880843.5979             nan     0.1000 -963086.1591
         7 327767681.5784             nan     0.1000 -452195.5331
         8 325220490.9492             nan     0.1000 -1897220.0656
         9 325354803.7236             nan     0.1000 -1055628.4948
        10 323263028.3507             nan     0.1000 -1208365.9785
        20 314226278.8054             nan     0.1000 -831832.7317
        40 304929878.5317             nan     0.1000 -1739134.1995
        60 297500637.7782             nan     0.1000 -1114281.0527
        80 284190173.4580             nan     0.1000 485542.4648
       100 275474308.9857             nan     0.1000 -2598344.7336
       120 266640854.5900             nan     0.1000 -850545.6718
       140 260306300.8021             nan     0.1000 -283176.0744
       160 256622240.0868             nan     0.1000 -754058.6798
       180 250585713.4807             nan     0.1000 -1581547.9236
       200 244904171.6070             nan     0.1000 -2702674.5767

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 297259465.7491             nan     0.1000 41585.0195
         2 294895949.0120             nan     0.1000 -10283.9733
         3 294614480.4626             nan     0.1000 58120.6780
         4 293128912.5212             nan     0.1000 -469239.0296
         5 292973034.0346             nan     0.1000 -62857.3906
         6 292862913.7823             nan     0.1000 -39589.6710
         7 291589276.7605             nan     0.1000 -1077215.6603
         8 291867486.6732             nan     0.1000 -878495.1714
         9 290548777.3621             nan     0.1000 -762956.1877
        10 290832792.8335             nan     0.1000 -1001689.1669
        20 288529323.5069             nan     0.1000 -1972253.7471
        40 288973753.5543             nan     0.1000 -897043.0783
        60 288273049.1726             nan     0.1000 -1080537.3878
        80 287035782.9276             nan     0.1000 -1754152.6429
       100 287060152.2898             nan     0.1000 -685538.5626
       120 286374602.6114             nan     0.1000 -908053.7746
       140 286741234.0980             nan     0.1000 -2635541.8579
       160 286481665.2117             nan     0.1000 -535506.3671
       180 285436339.5212             nan     0.1000 -1331479.5046
       200 285952218.7052             nan     0.1000 -1201207.5026

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 297242887.4499             nan     0.1000 253872.2297
         2 295068990.9639             nan     0.1000 -117003.4946
         3 294808493.6019             nan     0.1000 34597.9296
         4 292790761.4677             nan     0.1000 -332356.9395
         5 291557594.4980             nan     0.1000 -300172.5478
         6 291713897.2536             nan     0.1000 -482212.7217
         7 290611972.6056             nan     0.1000 -1016501.5131
         8 289677173.0266             nan     0.1000 -597891.6561
         9 289117904.2761             nan     0.1000 -1490612.2123
        10 288646782.9819             nan     0.1000 -733117.6256
        20 287789900.3274             nan     0.1000 -486375.6148
        40 284099830.8383             nan     0.1000 -165247.5761
        60 278790863.6411             nan     0.1000 -966832.8232
        80 275325057.1459             nan     0.1000 -569127.1950
       100 274315561.8272             nan     0.1000 -1370035.3532
       120 273071037.9991             nan     0.1000 -872491.5407
       140 273263482.3860             nan     0.1000 -909807.9676
       160 272623921.0452             nan     0.1000 -1502186.5560
       180 271768407.6880             nan     0.1000 -721111.0228
       200 271255737.0280             nan     0.1000 -554191.6703

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 294549973.3131             nan     0.1000 -13404.7548
         2 292608146.8623             nan     0.1000 -164744.6071
         3 291472447.8285             nan     0.1000 -513751.7149
         4 291666411.0026             nan     0.1000 -745857.5712
         5 289268117.3082             nan     0.1000 -482934.7286
         6 288043158.6330             nan     0.1000 -467010.3450
         7 287611857.9694             nan     0.1000 -1187476.5017
         8 286431217.8483             nan     0.1000 -1366158.5818
         9 285170495.7570             nan     0.1000 -875272.2790
        10 284768405.0976             nan     0.1000 -1118889.1422
        20 278584983.5995             nan     0.1000 -2206373.6584
        40 271220519.0031             nan     0.1000 -1340830.3346
        60 266172913.6544             nan     0.1000 509514.6760
        80 261893504.2002             nan     0.1000 -1411036.2930
       100 259574283.8751             nan     0.1000 -647823.3324
       120 256327594.9635             nan     0.1000 -215845.7546
       140 250626502.7799             nan     0.1000 -1411660.6342
       160 247558712.8838             nan     0.1000 -548843.4440
       180 243997822.9177             nan     0.1000 -806188.3131
       200 241548047.2290             nan     0.1000 -2493154.6855

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 297276344.2224             nan     0.1000 196556.5547
         2 293429207.2745             nan     0.1000 194879.0407
         3 291476759.6409             nan     0.1000 -392835.3402
         4 291095100.6763             nan     0.1000 246265.2720
         5 287327484.3290             nan     0.1000 -575363.5979
         6 285785019.3505             nan     0.1000 -445622.2173
         7 286008910.5709             nan     0.1000 -859463.8809
         8 283692082.3129             nan     0.1000 -267724.4174
         9 283664569.5803             nan     0.1000 -469343.0947
        10 282161796.4864             nan     0.1000 -1039776.6665
        20 273160584.1880             nan     0.1000 -2348126.5727
        40 262994886.5246             nan     0.1000 -1222680.8757
        60 249498649.8108             nan     0.1000 -1199440.2735
        80 235078297.1496             nan     0.1000 -27339.2911
       100 227705720.5383             nan     0.1000 -1313285.1967
       120 219151564.2441             nan     0.1000 -972804.7309
       140 212478689.2802             nan     0.1000 -426735.5501
       160 203305544.1810             nan     0.1000 -1528437.5269
       180 198012142.7217             nan     0.1000 -1071769.9056
       200 192980032.8199             nan     0.1000 -832443.2722

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 342226743.7953             nan     0.1000 -130558.1007
         2 340463524.4351             nan     0.1000 -806567.1273
         3 339178402.8867             nan     0.1000 -671708.4531
         4 338456370.6162             nan     0.1000 -1821367.8418
         5 338679921.1524             nan     0.1000 -987468.6002
         6 337878466.8777             nan     0.1000 -416936.9468
         7 338044682.2549             nan     0.1000 -658489.3202
         8 338277329.1832             nan     0.1000 -922245.3667
         9 337836333.2574             nan     0.1000 -1099019.3700
        10 337368041.1632             nan     0.1000 -995072.8584
        20 336926783.4586             nan     0.1000 -921852.0935
        40 335293416.5646             nan     0.1000 -1998885.7538
        60 334675759.7155             nan     0.1000 -1360128.3248
        80 334279333.5089             nan     0.1000 -1221798.9370
       100 333817878.2624             nan     0.1000 -646717.5368
       120 333504241.5233             nan     0.1000 -1443785.2789
       140 333174063.4713             nan     0.1000 -1432778.5815
       160 332753065.1939             nan     0.1000 -575482.6912
       180 332891801.2780             nan     0.1000 -1540960.2922
       200 332761153.8367             nan     0.1000 -1916427.6515

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 342322377.5292             nan     0.1000 8612.3702
         2 340359779.2703             nan     0.1000 -654997.6630
         3 340482541.4333             nan     0.1000 -508219.9399
         4 339015032.4995             nan     0.1000 -541009.7013
         5 338050285.9626             nan     0.1000 -1564405.9085
         6 337294208.3078             nan     0.1000 -1018248.2051
         7 337486526.3910             nan     0.1000 -1447145.8836
         8 336623626.1198             nan     0.1000 -519894.3527
         9 336317411.3701             nan     0.1000 -1827973.0554
        10 336255420.4681             nan     0.1000 -1542213.1836
        20 331522349.1296             nan     0.1000 -939548.3282
        40 326041374.7727             nan     0.1000 -983683.5425
        60 323727034.7084             nan     0.1000 -1575694.4469
        80 321611013.6633             nan     0.1000 -1404080.4880
       100 321326758.8539             nan     0.1000 -302219.6851
       120 317342557.1724             nan     0.1000 -612475.7683
       140 315668706.7189             nan     0.1000 -1442562.3441
       160 313955710.5908             nan     0.1000 -458815.1502
       180 313046261.1812             nan     0.1000 -1455359.0940
       200 311727895.1783             nan     0.1000 -908869.2143

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 340477241.2339             nan     0.1000 -305805.7168
         2 338026229.4407             nan     0.1000 -304676.1654
         3 335583917.1447             nan     0.1000 -289941.5471
         4 334006702.3561             nan     0.1000 -448304.9230
         5 333987447.3391             nan     0.1000 -819874.7121
         6 331147593.9652             nan     0.1000 -2534583.4427
         7 330964631.2185             nan     0.1000 -1264269.8265
         8 329710386.1970             nan     0.1000 -1750549.5218
         9 328293846.4258             nan     0.1000 -1587338.7015
        10 327498974.5523             nan     0.1000 -1287096.9319
        20 318852871.3791             nan     0.1000 -1956982.6220
        40 312787433.2931             nan     0.1000 -1706198.4942
        60 304929305.5937             nan     0.1000 -1893364.9772
        80 298562761.6440             nan     0.1000 -1694064.0441
       100 295694339.5482             nan     0.1000 -2586591.5714
       120 288010310.1069             nan     0.1000 -858330.8486
       140 279374848.7178             nan     0.1000 -296352.3617
       160 275395756.2667             nan     0.1000 -765560.5725
       180 272530363.4666             nan     0.1000 -820010.0291
       200 266502675.5121             nan     0.1000 -857321.0237

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 340031659.3352             nan     0.1000 -456463.0734
         2 337603678.4914             nan     0.1000 -294211.8514
         3 335071837.4565             nan     0.1000 -17559.0889
         4 332004254.8292             nan     0.1000 -1433512.1995
         5 329145505.6650             nan     0.1000 -888174.3070
         6 326657526.3185             nan     0.1000 -1482764.8108
         7 325279397.5136             nan     0.1000 -2644018.2069
         8 323845946.8626             nan     0.1000 -2053972.4159
         9 323484879.6744             nan     0.1000 -1610228.6933
        10 322739019.3082             nan     0.1000 -826648.7291
        20 310620024.9812             nan     0.1000 -2326321.5928
        40 301893568.1042             nan     0.1000 -1681675.8420
        60 294422582.4641             nan     0.1000 -1724563.4306
        80 287060773.9761             nan     0.1000 -1286749.9827
       100 278388396.3940             nan     0.1000 -1338019.2127
       120 270066658.9070             nan     0.1000 -504668.3453
       140 266831928.0835             nan     0.1000 -279144.7187
       160 258824160.5711             nan     0.1000 -1694937.0307
       180 252338935.3243             nan     0.1000 -1576821.0509
       200 245283502.4053             nan     0.1000 1249938.1600

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 96054737.9120             nan     0.1000 90322.4486
         2 96019916.8419             nan     0.1000 -35690.9491
         3 95732040.3443             nan     0.1000 15758.0271
         4 95569764.6727             nan     0.1000 68783.2536
         5 95445494.8433             nan     0.1000 55014.6234
         6 95315713.4078             nan     0.1000 59547.1501
         7 95203934.7487             nan     0.1000 49174.0027
         8 95097537.2105             nan     0.1000 10611.7720
         9 95078542.1872             nan     0.1000 -3657.8373
        10 95010079.4331             nan     0.1000 -5286.6437
        20 94533851.3815             nan     0.1000 7643.3960
        40 94228853.0633             nan     0.1000 -35108.6299
        60 94126189.9154             nan     0.1000 -48739.8568
        80 93876717.5936             nan     0.1000 -4692.5211
       100 93719204.7156             nan     0.1000 -97774.0296
       120 93558229.8866             nan     0.1000 -69446.0376
       140 93454945.7287             nan     0.1000 25958.3778
       160 93389929.1531             nan     0.1000 -91714.9509
       180 93304057.1193             nan     0.1000 -58848.4014
       200 93176572.8056             nan     0.1000 50103.2153

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 95845947.8794             nan     0.1000 221865.6901
         2 95477103.3981             nan     0.1000 63194.3830
         3 95217694.6467             nan     0.1000 165729.8227
         4 95149437.2164             nan     0.1000 11185.9096
         5 94881352.8941             nan     0.1000 -26231.4368
         6 94786379.6177             nan     0.1000 49061.7561
         7 94603219.1541             nan     0.1000 -82302.4254
         8 94464151.2476             nan     0.1000 -30965.8230
         9 94434858.9854             nan     0.1000 -4737.2499
        10 94106713.1568             nan     0.1000 -133391.0755
        20 92805182.2244             nan     0.1000 -56511.0881
        40 92073575.7389             nan     0.1000 -75753.8993
        60 91105073.7969             nan     0.1000 -40674.9290
        80 90233656.1984             nan     0.1000 -74016.0449
       100 89471074.4384             nan     0.1000 -176533.8518
       120 89075919.6485             nan     0.1000 -165711.4696
       140 88212047.3835             nan     0.1000 -81324.9927
       160 87818136.2769             nan     0.1000 -265858.8031
       180 87118211.8627             nan     0.1000 -128497.8345
       200 86616800.5748             nan     0.1000 -10799.6055

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 96026331.2337             nan     0.1000 75632.0184
         2 95707047.1085             nan     0.1000 71432.5180
         3 94995013.7059             nan     0.1000 -86285.3906
         4 94803519.8243             nan     0.1000 29319.3839
         5 93959951.3281             nan     0.1000 -68192.7827
         6 93712316.3583             nan     0.1000 -167344.6785
         7 93320360.0662             nan     0.1000 -388197.9831
         8 93012588.1677             nan     0.1000 95794.9969
         9 92480596.7050             nan     0.1000 -92719.1092
        10 92450152.8421             nan     0.1000 -83704.0683
        20 90570829.9797             nan     0.1000 -141782.9575
        40 88715153.6189             nan     0.1000 -96150.0375
        60 87109771.2322             nan     0.1000 -117603.7953
        80 84763398.8440             nan     0.1000 -270584.2053
       100 83177739.0494             nan     0.1000 -330543.3833
       120 82113926.7745             nan     0.1000 -208653.0714
       140 80596210.9470             nan     0.1000 160854.1758
       160 78998631.2628             nan     0.1000 -25306.2271
       180 78011057.6919             nan     0.1000 -158560.6084
       200 77029333.5445             nan     0.1000 -100491.2164

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 95891785.2879             nan     0.1000 188976.7420
         2 95498798.2241             nan     0.1000 19902.6739
         3 95348740.7980             nan     0.1000 28536.6219
         4 94611429.0837             nan     0.1000 -61943.6075
         5 94330846.7991             nan     0.1000 -57811.5920
         6 94129679.4971             nan     0.1000 -42600.8872
         7 93535328.8556             nan     0.1000 -181438.3680
         8 93018055.2297             nan     0.1000 -92714.2211
         9 92981445.7147             nan     0.1000 -81368.1160
        10 92561596.6703             nan     0.1000 -300087.7744
        20 89652734.6247             nan     0.1000 -117760.8955
        40 86282559.1993             nan     0.1000 -170570.7399
        60 83176723.2036             nan     0.1000 -249429.9497
        80 80986450.6758             nan     0.1000 -128331.3765
       100 79036659.0848             nan     0.1000 -233850.6808
       120 76941661.1992             nan     0.1000 -243787.8277
       140 75833182.2680             nan     0.1000 -136600.0241
       160 74413603.4977             nan     0.1000 -57401.3957
       180 73015235.5258             nan     0.1000 -158446.6257
       200 71995811.0992             nan     0.1000 -232817.0081

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 346577394.5039             nan     0.1000 222152.4748
         2 346355411.7429             nan     0.1000 16592.1377
         3 343983217.9580             nan     0.1000 -109137.9607
         4 343648518.3509             nan     0.1000 237462.9490
         5 341979979.2154             nan     0.1000 -350677.9244
         6 340477333.2786             nan     0.1000 -1283517.7071
         7 340251437.2344             nan     0.1000 80410.0286
         8 339470854.9118             nan     0.1000 -1263119.5918
         9 338985022.3742             nan     0.1000 -1120527.0238
        10 339182906.7554             nan     0.1000 -930044.0291
        20 339280327.4879             nan     0.1000 34327.6243
        40 337700498.5986             nan     0.1000 -1658965.9275
        60 336951322.8042             nan     0.1000 -1786417.7984
        80 336391734.1753             nan     0.1000 -1373326.1386
       100 336283855.8603             nan     0.1000 -1567634.8720
       120 336013499.7046             nan     0.1000 -146090.6971
       140 335569830.0035             nan     0.1000 -1310082.6973
       160 335150605.2947             nan     0.1000 -508893.7895
       180 334834240.3407             nan     0.1000 -373906.3951
       200 334819304.5003             nan     0.1000 -1008226.6372

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 345801257.0123             nan     0.1000 -129012.5527
         2 343385785.1319             nan     0.1000 -199012.5581
         3 341307315.2029             nan     0.1000 -696540.7274
         4 341480648.8426             nan     0.1000 -674877.3853
         5 341163878.3206             nan     0.1000 85946.3938
         6 338956865.0229             nan     0.1000 -164707.5578
         7 337690966.7701             nan     0.1000 -732714.6245
         8 336631234.2737             nan     0.1000 -889378.5364
         9 335693912.4775             nan     0.1000 -560354.9280
        10 335220299.3707             nan     0.1000 -995392.3167
        20 332817794.3855             nan     0.1000 -1665880.2575
        40 331580923.3868             nan     0.1000 -1229523.6850
        60 331457489.5564             nan     0.1000 -1490478.7378
        80 329456038.6882             nan     0.1000 -1062495.5108
       100 324883578.6447             nan     0.1000 -1091895.2623
       120 321915441.0058             nan     0.1000 -1088669.5116
       140 322100933.6642             nan     0.1000 -943678.7859
       160 318230750.4518             nan     0.1000 -671046.3381
       180 316782237.0470             nan     0.1000 -659803.1809
       200 316897554.4460             nan     0.1000 -747748.7441

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 344125641.9379             nan     0.1000 -170229.5077
         2 342125049.8941             nan     0.1000 -134496.6187
         3 341979200.4765             nan     0.1000 -738980.9676
         4 339567646.7084             nan     0.1000 -319240.9748
         5 338295215.1117             nan     0.1000 -566804.1694
         6 337178672.8479             nan     0.1000 -1165092.4948
         7 337159283.4811             nan     0.1000 -1036316.2668
         8 336294438.4404             nan     0.1000 -899297.0979
         9 335703483.0512             nan     0.1000 -1907250.7113
        10 335327556.6378             nan     0.1000 -2029051.8077
        20 328459658.0682             nan     0.1000 -1513242.1659
        40 322685073.9687             nan     0.1000 -1711551.0489
        60 313831627.2290             nan     0.1000 -1586482.7854
        80 308943249.9351             nan     0.1000 -1087611.4437
       100 300037733.9474             nan     0.1000 -985161.2553
       120 296061820.1604             nan     0.1000 -1139508.0811
       140 292851718.0449             nan     0.1000 -1474095.1538
       160 289049206.6752             nan     0.1000 -1651805.4262
       180 285941849.8540             nan     0.1000 -2721697.7440
       200 282648621.8570             nan     0.1000 -1188780.7738

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 346138073.9440             nan     0.1000 742994.7722
         2 343332354.6213             nan     0.1000 -84742.0284
         3 341167976.6538             nan     0.1000 236724.2904
         4 337024827.2807             nan     0.1000 -609206.4858
         5 334007336.6781             nan     0.1000 -1707393.6215
         6 334196147.0212             nan     0.1000 -937523.2715
         7 331751453.3922             nan     0.1000 -1545512.2108
         8 330638192.0731             nan     0.1000 -923008.3571
         9 330744431.8280             nan     0.1000 -1210078.4493
        10 330082231.9783             nan     0.1000 -1033764.9569
        20 319861789.0130             nan     0.1000 -2116876.2376
        40 307372341.9568             nan     0.1000 -2092914.4365
        60 303361861.0275             nan     0.1000 -1747506.8450
        80 292705869.0305             nan     0.1000 -1239063.0299
       100 286356675.1318             nan     0.1000 -1204423.5669
       120 280130763.9066             nan     0.1000 -1184492.0256
       140 278162171.4842             nan     0.1000 -1294781.3702
       160 272887620.9273             nan     0.1000 -861723.5839
       180 271609403.0446             nan     0.1000 -833722.1018
       200 265697290.5691             nan     0.1000 -1593959.1193

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 283874365.5297             nan     0.1000 -135952.4169
         2 283717916.6338             nan     0.1000 202193.9214
         3 283540153.1483             nan     0.1000 -22497.9097
         4 283384941.7975             nan     0.1000 181518.7171
         5 282014410.3370             nan     0.1000 -384968.1991
         6 281840244.3132             nan     0.1000 52862.6870
         7 281619774.0541             nan     0.1000 174728.0690
         8 280672318.4871             nan     0.1000 -596874.8395
         9 280039453.9748             nan     0.1000 -709545.2188
        10 280297791.8027             nan     0.1000 -986809.4065
        20 279306318.8383             nan     0.1000 -1009439.0386
        25 278560508.1555             nan     0.1000 -62100.6782

``` r
test_pred_boosted <- predict(boosted, newdata = ChannelTest)
m4 <- postResample(test_pred_boosted, ChannelTest$shares)
m4
```

            RMSE     Rsquared          MAE 
    9.461004e+03 1.822855e-02 2.641151e+03 

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
    1 First linear regression  9367. 0.00270
    2 Second linear regression 9348. 0.0136 
    3 Random Forest            9426. 0.00526
    4 Boosting                 9461. 0.0182 

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
      model                     RMSE     R2
      <chr>                    <dbl>  <dbl>
    1 Second linear regression 9348. 0.0136

When comparing all 4 of our models, we are looking for the smallest
value of RMSE to tell us which model is the best. In this situation, we
can say that the smallest RMSE is 9347.8656899 and this comes from the
Second linear regression model.

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
