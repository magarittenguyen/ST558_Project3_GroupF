ST558 Project 3 Group F
================
Magaritte Nguyen and Matthew Sookoo
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
data_channel_is_lifestyle: Is data channel ’’?
<!-- str_to_title("social media") ->> "Social Media" -->

Here, `read_csv()` is used to read in the OnlineNewsPopularity.csv data
and we are subsetting for the data_channel_is_lifestyle: Is data channel
’’? variable.

Firstly, we read in the data using `read_csv()`.

``` r
#check working directory
getwd()
```

    [1] "D:/ST558/Project 3/ST558_Project3_GroupF"

``` r
#reassign working directory
#Magaritte's directory
setwd("D:/ST558/Project 3/ST558_Project3_GroupF")
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
       url         timed…¹ n_tok…² n_tok…³ n_uni…⁴ n_non…⁵ n_non…⁶ num_h…⁷ num_s…⁸ num_i…⁹
       <chr>         <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
     1 http://mas…     731      12     219   0.664    1.00   0.815       4       2       1
     2 http://mas…     731       9     255   0.605    1.00   0.792       3       1       1
     3 http://mas…     731       9     211   0.575    1.00   0.664       3       1       1
     4 http://mas…     731       9     531   0.504    1.00   0.666       9       0       1
     5 http://mas…     731      13    1072   0.416    1.00   0.541      19      19      20
     6 http://mas…     731      10     370   0.560    1.00   0.698       2       2       0
     7 http://mas…     731       8     960   0.418    1.00   0.550      21      20      20
     8 http://mas…     731      12     989   0.434    1.00   0.572      20      20      20
     9 http://mas…     731      11      97   0.670    1.00   0.837       2       0       0
    10 http://mas…     731      10     231   0.636    1.00   0.797       4       1       1
    # … with 39,634 more rows, 51 more variables: num_videos <dbl>,
    #   average_token_length <dbl>, num_keywords <dbl>, data_channel_is_lifestyle <dbl>,
    #   data_channel_is_entertainment <dbl>, data_channel_is_bus <dbl>,
    #   data_channel_is_socmed <dbl>, data_channel_is_tech <dbl>,
    #   data_channel_is_world <dbl>, kw_min_min <dbl>, kw_max_min <dbl>,
    #   kw_avg_min <dbl>, kw_min_max <dbl>, kw_max_max <dbl>, kw_avg_max <dbl>,
    #   kw_min_avg <dbl>, kw_max_avg <dbl>, kw_avg_avg <dbl>, …

We now subset the data for the data channel of interest: .

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

    # A tibble: 2,099 × 59
       n_tokens_…¹ n_tok…² n_uni…³ n_non…⁴ n_non…⁵ num_h…⁶ num_s…⁷ num_i…⁸ num_v…⁹ avera…˟
             <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
     1           8     960   0.418    1.00   0.550      21      20      20       0    4.65
     2          10     187   0.667    1.00   0.800       7       0       1       0    4.66
     3          11     103   0.689    1.00   0.806       3       1       1       0    4.84
     4          10     243   0.619    1.00   0.824       1       1       0       0    4.38
     5           8     204   0.586    1.00   0.698       7       2       1       0    4.67
     6          11     315   0.551    1.00   0.702       4       4       1       0    4.38
     7          10    1190   0.409    1.00   0.561      25      24      20       0    4.62
     8           6     374   0.641    1.00   0.828       7       0       1       0    4.91
     9          12     499   0.513    1.00   0.662      14       1       1       0    5.08
    10          11     223   0.662    1.00   0.826       5       3       0       0    4.55
    # … with 2,089 more rows, 49 more variables: num_keywords <dbl>,
    #   data_channel_is_lifestyle <dbl>, data_channel_is_entertainment <dbl>,
    #   data_channel_is_bus <dbl>, data_channel_is_socmed <dbl>,
    #   data_channel_is_tech <dbl>, data_channel_is_world <dbl>, kw_min_min <dbl>,
    #   kw_max_min <dbl>, kw_avg_min <dbl>, kw_min_max <dbl>, kw_max_max <dbl>,
    #   kw_avg_max <dbl>, kw_min_avg <dbl>, kw_max_avg <dbl>, kw_avg_avg <dbl>,
    #   self_reference_min_shares <dbl>, self_reference_max_shares <dbl>, …

``` r
#testing
#correct - we expect 2099 vars
table(Channel[[params$channel]])
```


       1 
    2099 

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
     0.0000  0.0000  0.0000  0.1508  0.0000  1.0000 

``` r
# 32. weekday_is_tuesday: Was the article published on a Tuesday?
summary(ChannelTrain$weekday_is_tuesday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      0.000   0.000   0.000   0.163   0.000   1.000 

``` r
# 33. weekday_is_wednesday: Was the article published on a Wednesday?
summary(ChannelTrain$weekday_is_wednesday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1882  0.0000  1.0000 

``` r
# 34. weekday_is_thursday: Was the article published on a Thursday?
summary(ChannelTrain$weekday_is_thursday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1651  0.0000  1.0000 

``` r
# 35. weekday_is_friday: Was the article published on a Friday?
summary(ChannelTrain$weekday_is_friday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1433  0.0000  1.0000 

``` r
# 36. weekday_is_saturday: Was the article published on a Saturday?
summary(ChannelTrain$weekday_is_saturday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.0856  0.0000  1.0000 

``` r
# 37. weekday_is_sunday: Was the article published on a Sunday?
summary(ChannelTrain$weekday_is_sunday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1039  0.0000  1.0000 

``` r
# 38. is_weekend: Was the article published on the weekend? 
summary(ChannelTrain$is_weekend)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1895  0.0000  1.0000 

``` r
# 60. shares: Number of shares (target)
summary(ChannelTrain$shares)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
         78    1100    1700    3737    3225  208300 

``` r
#contigency tables
# example: table (crabs$color, crabs$spine, crabs$y)
# monday is the mot published articels... compare to diff of the week
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_tuesday)
```

       
           0    1
      0 1010  240
      1  222    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_wednesday)
```

       
          0   1
      0 973 277
      1 222   0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_thursday)
```

       
           0    1
      0 1007  243
      1  222    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_friday)
```

       
           0    1
      0 1039  211
      1  222    0

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

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAqAAAAHgCAMAAABNUi8GAAABg1BMVEUAAAAAACsAAFUAK4AAVaoEtLkHrbELoaUMwscTjZATw8cUxMkfa20fxckhx8wrAAArACsrAFUrK4ArgNQzMzMzycw3zdFNTU1NTWtNTYhNa6ZNiMRVAABVACtVAFVVK4BVVVVVgIBVqqpVqtRVqv9Vz9JX0tVc1tlrTU1rTWtrTYhra4hra6ZrpuGAKwCAKyuAK1WAgCuAgFWAqoCA1KqA1P+CTkqITU2ITWuITYiIa02Ia6aIxP+N2duR3uCZ5eema02ma2uma4imxKam4eGm4f+qVQCqVSuqqlWq1ICq1P+q/9Sq//+xXljEiE3ExIjE///NaGDUgCvUqlXU/6rU/9TU///ebmXhpmvh///ocWjr6+vuc2rwvLnydGvy8vLzoJv0dWz0wL31j4n2dWz2hX72op33dWz3d273eG/3eXH3e3P3f3f5d275eG/5enH5fHT5gHj5h4D5k436p6L8yMX/qlX/xIj/1ID/1Kr/1NT/4ab//6r//8T//9T//+H///+COy8DAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAgAElEQVR4nO2di2Mcx33fRxZrmY5JReGRlCU5TlPCdFyLae0aslopVuqKfQmqwKYCBYjqKpd1SNwB9wSplg/dn555P3Znd3Z2f3MzAOYrEbjbx+9m5j74zW+eizZZWQkLxU5AVlabUOwEZGW1CcVOQFZWm1DsBGRltQnFTkBWVptQ7ARkZbUJAdg4SkYJJSWckskkADpuIQAbsQtKKaGkhFMymQRAxy0EYCN2QSkllJRwSiaTAOi4hQBsxC4opYSSEk7JZBIAHbcQgI3YBaWUUFLCKZlMAqDjFgKwEbuglBJKSjglk0kAdNxCADZiF5RSQkkJp2QyCYCOWwjARuyCUkooKeGUTCYB0HELAdiIXVBKCSUlnJLJJAA6biEAG7ELSimhpIRTMpkEQMctBGAjdkEpJZSUcEomkwDouIUAbMQuKKWEkhJOyWQSAB23EICN2AWllFBSwimZTAKg4xYCsBG7oJQSSko4JZNJAHTcQgA2YheUUkJJCadkMgmAjlsIwEbsglJKKCnhlEwmAdBxCwHYiF1QSgklJZySySQAOm4hABuxC0pqNBpBmiuKAtIclJIpbwB03EIANmIXlNBoBEpo8ejRoxQJTaa8AdBxCwHYiF1QQhnQ7QoAHbcQgI3YBSWUAd2uANBxCwHYiF1QUjkG3aoA0HELAdiIXVBKCSUlnJLJJAA6biEAG7ELSimhpIRTMpkEQMctBGAjdkEpJZSUcEomkwDouIUAbMQuKKWEkhJOyWQSAB23EICN2AWllFBSwimZTAKg4xYCsBG7oJQSSko4JZNJAHTcQgA2YheUUkJJCadkMgmAjlsIwEbsglJKKCnhlEwmAdBxCwHYiF1QSgklJZySySQAOm4hABuxC0opoaSEUzKZBEDHLQRgI3ZBKSWUlHBKJpMA6LiFAGzELiilhJISTslkEgAdtxCAjdgFpZRQUsIpmUwCoOMWArARu6CUEkpKOCWTSQB03EIANmIXlFJCSQmnZDIJgI5bCMBG7IJSSigpoNrZ2ZGvgSe9DhAAOm4hABuxC0opoaRAaufjjz8WhAIvGxgiAHTcQgA2YheUUkJJgVQGdJhiF5RSQkmBVAZ0mGIXlFJCSQFVjkEHKXZBKSWUlHBKJpMA6LiFAGzELiilhJISTslkEgAdtxCAjdgFpZRQUsIpmUwCoOMWArARu6CUEkpKOCWTSQB03EIANmIXlFJCSQmnZDIJgI5bCMBG7IJSSigp4ZRMJgHQcQsB2IhdUEoJJSWckskkADpuIQAbsQtKKaGkhFMymQRAxy0EYCN2QSkllJRwSiaTAOi4hQBsxC4opYSSEk7JZBIAHbdQ69nnv/qieujlB7ff+WqzeXj79u2f8pOxC0opoaSEUzKZDMFjTajt5DPJoNT3n3y0efjuZvP5R+pY7IJSSigp4ZRMJuFptAi1nPv87T8SD4p9JuX05YdfsB/Yr37/95+q62IXlFJCSQmnZDIZGE0m1HqWVvGfv099JgP0+a+/2rz8/acY2tu3qRMdjUZbSGbWZRVqPUsAxTgSNp/dJnr/2TsU0Od/8+lGetHYf8lKCSUlnJLJZHg6N50AJc7y7U9ND0rPijg0dkEpJZSUcEomk4HRZEKtZymgH/KGkh6D0gMZ0ChKJpMBsVRCrWdFDEoqdqbvP6ERKTnw/X/O3UwxlEwmg4IphFrPPuet+LdVm131g8qDsQtKKaGkhFMymQxHpSYEYCN2QSkllJRwSiaTAOi4hQBsxC4opYSSEk7JZBIAHbcQgI3YBaWUUFLCKZlMAqDjFgKwMTSjYI8cTGdFbkhlQH01MJ9gD21NaE+DkMqA+mpgPjOgfsqA+mpgPjOgfsqA+mpoRnMM6qUMqK9iF5QUAzTRx7yDKZnyBkDHLQRgI3ZBCbEqHixiSFXJlDcAOm4hABuxC0ooA7pdAaDjFgKwEbughDKg2xUAOm4hABuxC0oqx6BbFQA6biEAG7ELSimhpIRTMpkEQMctBGAjdkEpJZSUcEomkwDouIUAbMQuKKWEkhJOyWQSAB23EICN2AWllFBSwimZTAKg4xYCsBG7oJQSSko4JZNJAHTcQgA2YheUUkJJCadkMgmAjlsIwEbsglJKKCnhlEwmAdBxCwHYiF1QSgklJZySySQAOm4hABsBy8Cv0z3PZtqqANBxCwHYCFcEfsOWeT7odgWAjlsIwEa4IvAHdO+Cj3MeZUD9Fa4IvAHd273gM0WOMqD+ClgGXjFoBnS7AkDHLQRgI3ZBCWVAtysAdNxCADZiF5QUJvSiz7U7yoD6K3ZBKSWUlHBKJpMA6LiFAGzELiilhJISTslkEgAdtxCAjdgFpZRQUsIpmUwCoOMWArARu6CUEkpKOCWTSQB03EIANrZSGl1aP5diICkD6q1tFEaXLvs81LldAaDjFgKwESDvNX+ZAZXKgPrKN2Pu2rqOYwZUKgPqK898uVjD/Fou6RCDZkC3KwB03EIANjzzpdFno46cLnvtDpIB3a4A0HELAdjwzJcC1OpL6cFeI5b9AD13g6MZUF/5Zkwi0QxorwLrBej528opA+qr3jm0w9HbpWVAtysAdNxCADb6ZxG2es2AblcA6LiFAGyEL4qOIPdqI+UYtK8A0HELAdgIXhJas6qNptyK364A0HELAdgIXhIS0Pb6OAO6XQGg4xYCsBG8JDKgujKgvgpfFKJmz4AeZUD9tcUyaW/RBOIzsWZUBtRXAcvAd9mxQSgQWKl1RGVAfRWuCAZtfQMFVga0QQDouIUAbIQrggyoRRnQdLQ+Oztbd76aAtr35rZUrEHMZPURArAR8I900PaLiTVuWrSzs9P52nR6KgDQcQsB2AhYBpdjf9Cdjz/+uCuhCfWlAaDjFgKwEa4ILsn+oIEB9fHPPgJAxy0EYCNI7qkyoDX5Z9LHupcA0HELAdgYksn2OjwUoKlFpx4+LgPqrwF5rBJYJWdQR33nTz1PyoD6a0AeK6h4kVODl+wPutfl9vMMaI+WYI5B+2sAoPVryf61u13uP9eA5o56bw3JpOkGtwRocjGoZxAaMiUeAkDHLQRgAzDPHuS0AeoNYMMN2wLZI0xMqKsCAB23EICNSOXTHIN6V+ENN2wtFMiANgoB2IhdUELyu2sBy+4TM6B9BICOWwjARuyCEuoAqB+J22tM5Ri0SQjARuyCElLOpTF2bFofGjkG9VIy5Q2AjlsIwAZclrsA0XxNh9qv4/K7pJUB9RVYjrtQ03JNl/Cs2/K7bahv93mu4r0FluMtAOrzUUHVdwAyN5L8BZbjhp1D1W54+AUQoNHDy2ZA211rBtRfvhlrZsO6MWMlbhwUg/omKJwaAXW41gyovzzz5VuRd27Y9P3uyvEYchfIjmpylBlQQwjAhme+ivF4HAXQpr6kcVHUExQtSM2AGkIANjzzVWJQStdFjTFoixzfXRNyiQHqat4nw+eFBbSLB+2lvoA+Go/rfzDRm/mNyv2gvvLMV7CvviegTePzKY4iEWVAfeWbsWHjRS1y1H6azWTp66AMqK8C5L2Xl/VYNNfRfJIcZ0B9FSDvaQCaZhyaAfVVgLzHBpS5zgxoqwDQcQsB2AiRea/KlV/ceVWn0zwnMwPaKgB03EIANmIXlOCo+6K5rhZzDNomAHTcQgA2YLLrCQOvhIvCDugwtNJ0nVwZUF+B5NaTCT5xRPuJj+0d7ALNR07SdXJlQH0FktsBgKomzW6ZzHzkcMqA+gokt0MAlYd2axNMOtlK2F1alAH1FUx2PdetaTGoOKIB6to1T54lT6Y/Z942A+qrYCXgSU9R7HW8UK3txK/K7QM6aDuv3uUNvYkYADpuIQAboLnW5E9Px4losQEdtiFi3/IG34YRAB23EIANyEzr2hKgxdZj0GGo9J0OmgGFVp0eF0qd13TqMaj7ImhlQLsLAdiAzLSh2n7LRqPdwg/kXPOQbadB0WDvTOYYNLSsK5V0nRdABymVFR+XEFBXparX+V0AHVRJZ0BdAkDHLQRgAyrDbiS0fqcOgBrjTD2SAxKDwm8QnwH1FVSGO/kstQjZGYNaRps6JgSueSRbJnCgZkB9BZVhP0Btage0I3dFOYar3AWggE3oDKivfDPWvHvn0N6fkXmNMRmv+zqPcWHbaaSfMqADhQBseOarYYuwhku8xLevNV1g1x0XZesLElBRtfsD2hgTjIZFC3CxBgA6biEAG575ogNE+pqf+i4iAwAtirKBMIdRrfU1LuGb775cNBN9dZAzBnTlAOi4hQBseOaLEDDW1vxYeje7RaN19ztixhtcYMfnghbF9gc/68qAMiEAG74ZI06uHdAu7RkbxBxQXxfIYlW1I49pOg6tfQDt4qUzoE7pnZlFxV161O2NgD4qPYnifycNgMbqsPePQbuxt0M1JGVCAOi4hQBs+GWrYQqI3vDubqdybNTL39UceRKANqqxFd/VOUI5UQB03EIANvyyZf/C+3Snl7WKvE8PjAg4DEduTtS/sIAOc6UA6LiFWs8+/9UX1UMvP7j9zlfkxfeffMQP+WXLCWhXH2gxJL87P0dc1paPGFfEbzEZav4r7MibGt0a5krBYbQJtZ18dvunVUAJlg/fJa8e3u4HqL0yr8whbr+1eovUqPlUY2pSc5BODe+oFyCfd0A/f/uPxINin0k5ffnhF+wH9avP/+1/7AkoU7WlLFs2DcTIJ3xYH7TAlQH10nkHlFfxn7/PfCYF9Pmvv9q8/P2nm+///r+wKn40GvX64PXZ2dna9sY4YV5OfizV6fW6et1Iv7pqoXZ1+/Fk1a+8rbp79y6csTBCrWcJoARHzOaz20TvP3uHAfrw/b4xKFdzS9ka8zHn6Vqk1BKDnj9P2aQ8Fq9EAf0Ag/n2p6YHxb8GAsrqbN4Q7zATlLW0m9chUyT7bADemsDegp8GKpUBVaKAfsgbSnoM+pD5U3aidw7V8zXcMDge9cH4gwR0kMsFX6CmKQOqJGLQZ6xnaUNa8Twi7d3NpIkBWpb6MzZ6+i0noN17ryC2d8qAQgm1nn3OW/Gkhuca3A+qiQI6kY9NcjyKU7+xNnHUDajLkjjgOX3UrgwolBCAjf5ZJDGofK4XHQz3nFVfmS7fdeMGxXft40yLvePQHIMCCQHYGJZNCSh90TDOZHLS2KvvvUN9G6DW0wkoA+qrgfkUMSgj1eKzaouEQgKaxDh8q//NgPoKKL9Nj0i0rMFQEJktLP9nfDTX4d0jYnBdu3mzJYLNgPoKKsNNO4S2LBLq5EHrDaEuj7oTHa/OK8G1c3MH/9942pLJiscNGADrAkDHLQRgI0ju1Qa1TYuEhIvT5idbAe3nBu2PmA0piZU3oJU+g5BdCLoA0HELAdgIkXl9EnFL17xa30TVDdBO8+rsD+kOKG2W5sc3b15rvjAD6qteuXM82dW9K4iAt9T6hQ6M4abKLk4tPfC1pSdY5Rhw8XEHaVjVq2j9SAbUV30yZ21J69B2BNToWR/vjbVO9somOS098NYP23YDqQ0r41ziMeire4jotd/JI9/9+e/Eb/FSO2ro6Q8+qxxBQ+ncwAFqmdPU1kiRHlF6xgZA2z5GO1UB2lx+vIXWUgtWLkDjyE7Dq3s3yK8HCjUNUO268w5oH5MMUDHlqdEjNg1v1jZ27DbNfws6h4C+eO9OFcVzBWg9BtWjyX5iMaiadl9ZVFJfY2dLTJKAOmLQSLLToAClCNJ6/TcIvf6lqOK/exNHAHc29Cj+TWMCwuWL99Brv0kA0MbeTv8F7TWzo6OqO5Qn7Z1Vtkl8FixBN7wbqvMB6P0ffCYBffP1L1/du8IBZUffvEOOkkCAnNk8eP3LF+/dwIzGB7Sp06e6RskTBzWbydLiYTPxLd39cvCqYUq/SluI7Zp6imRyS82gdjUBShtJmDQF6J2NovO7txiD4uhT5j3v0N8P0gO01hg3Lmpyt/UVHRQ1tnlYrc+oDig3oGZStVbhsSt4UyPwjqSeuDcBeoO/koC+9Zmo8smh+whd0c4+oDyjG9iJ4vdvJQUoGwviIza2SRoNo+YWYBhqI2qOzjAdV3mnh+jsPlVjswlUzkH3Cw5oX2s9AaXRpgoAKJgbWssnAai2wphxYxuxsQBqsGrpaucelM7QH1f3D1PNMOJGlTMld5UdBt3bGlhb1/kDVP0WTXetCfWU95jSKt7Rise3UbiDAmp0K2GMrCM2emBa3zK0FiaItXQaoPaVdRVALavwLNFD80q9KAKPQUMBSpo9r+69VmkkUQY1bF/dw64TU/rivSvORtL9KyRKfXBla4AyXFqmKJcln8JcqbONXnyKuGjFl+Np4QRU96+V1pm1Fz/k4zy9WYNvxdMk+DPvApR2KP31z1g30xVJ5VM2ziQApa0q4kXd3UzYgRLQ624WGlAxT4hR1zwUr+CwtaNlHKCCBNqKp1FlwxAQiy/MMSjHfjqBAfV3X2G6mXq4UT9Kegppr2kNfyM4oNo0DGvVqTVaaJNHjQrZt3OqAFox1mE0Xz9Um7zPhg/CjXRuH1C7qzwPgGLnTCLW+4GreKPpY1ngoQ1TUvZKOTxkH7vkDXdyqD+gbOipFI0rsWBu6PCBW2EA7TquPyQdEWYz4ZjhyuY+b/Z3l1+2XBPZpLMkgEymU9Uhamkb8d+iCu4NKP8DkK17LbQI3TrqG4O2MXjtZseZUUPScWGn21nmqusho6hSKSSs9rYONpkmmwC1LKG3nosHqLdYJls83s7HN3eaFzXBdVEBoOMWArDhma/qBOLqmHdZyF3CSsqya1ypGdDOKzRFCDGelAagye1eeyQy2bKw7trNH7cACtdFBYCOW8h49wChOw9CV/F6C70y5124MAVodVy9CgyftlRaY1CDbMdgEdvKrNT+eBJkk4pmsmXdEjn142sdIBxKKhiEbUL6m/uv/wPrafKTb8Zkz7vorrQCWkhImsaTBHUspiVvGwDttmdJ6A5PKDFAm9ctOZY0adcNrOvhKGwR0l7TbqY74ftB1RShsVl3q97Oau+lZQxJhI3jCQ1U6dvK/qDiajbkrg1XWp2jASio+4Sde8QBbQlBW8FTi0fDAPp/7To/gMo2vDZDubp6o1E1QDGZ02kN0EqYSwCdOMbyxTR8fgfkirnuJHQieeS6tNWKvnj0vAG6eUCqeNJX7yevXBmTQxqa5y2cqqny7CYy7j6WLakGQNWcEPO0ZtbsjYddc2wlwUZRN2SGddS3Lh71k52GkIDSYVLky+cAQI8s7Rf30g99zrxqarEY1Kjb9UaS1p3fBGhzIofJxp0d2u0COlR2GoIC2k9euar0gtaGiApjK4ZCH1Y37pFv9NMj03UaF9JZJGKI1Rh+x8FpZXALeFsRi6uKBmjwx3EHBPTVvTtNl7XKL1u2AXVzMrICVL3p1KNZ7JWcLNVRUCryq2s++EV0OFW2oBibwbuY7Cx6xKAJyE5D2EZSLxv+WbM2y9UB/ZlJDNDKnLimdXe74ykbehKOVMz9YHV8OTWCCzXefzwdi78CwNq9vbHS25FdXkA3/n30VN45a+t5r/pKG6CNZncfTVifqDYnWvWrYj7tgJaTUmINB2ioHWguL6Av3kNiQd72AHVcyWNQdy87jRx3q2NPvHVuYFtUmkqYT93vgvUwRQY0/MLPPoDStZyWpUedAO0r75y5AVW9SfoBl8ViT4Sz8nJetysPqfUoqYvG02l5VAXYlgwfEUCvDaCkibBugG5hBzE7DYrJP/3pTxZA6YqPxAF1fueqbW+Z9K4ZKbRglbBlnc1EliBNedNJm4gi7iRteL48vjbQTxpZ/Uc/d3auDaCkkbDzAuif/vEf//FPNUDf+m9XGKAdV78ZgNJNSbZQxTvFVhlZZ4sQiVp/PJadoAzmg9rqS3IVdo/TsVz+XhqAsjZ8A4O04d+0vqmLhlByUQH97P4dCuj9G5unHdo8OqCv7t14de+Of1t+eFYrrov3/IwbAJVVNVldbDTTD8pqA4cCOuatdFm9Fx0AZRbPLaDxY9AmQF/8/Evy8y+xE/2ZZf+wFkAJmh25hgW02hnKlyJNJ2XRFVB6ePr1xAbouDZtSg8/abu9aeVJOR625KMrJdaBz0Ex6BbkANQeg2Lf+eAG/klevPpbf0AfhF/VWZGcpqGFnI/kVjXVGJS8Kqe0P5O6wlKN+WBPeHiMG+RV89g/TqdqgkplbKppTwbemG+JgXsIR6XDV6y5AO3jOnu5Wxeg1lY85fK3/TwoWS6H6fTuDfXPGpPsQJrwkHM8YZ2erC1je7YHWwdSllPpB7VeoXL8zeRYeFB6rmT72pRjRbG5qX1jusw5LQNniYqvv3EtRtcZclQOQPuEFf1Ckb6AsqZ8jxiUrrm/r2/eHBRQraZm05FwY7sYqxWdti0PGaCcneo4fvFov9AXNE9I33wlROgAqJxoWhpHeubySPv6ewJaOXv+AaWb2PVpxfeUb8aMSXbacDt2dBqg1opVB5Rv+6ANjRYHxij+kxIK0PF4OmBzJjegXadwUnkD6q6/tweot1DfGzV55kst8KBTOdT0OnGgzV/xtUM0NmBj6/r0vJHWMToujkksYOl7N3rxK4s++cS8UoYOrL6flgOGl7Q5wg0xaNf7qXxj0C70bS0G9RbS32ynH1QbYlR9ROwMn85uPN6w2YyY/KHm2B1oIGKkSDdAS/OGTnbWXK7wtbIXtlDutPFZd100tMfHKwat3639fYD2PNlpCAio/3I5Js98qa/eXtl2jPjMVezMpe5pGLmH78lyERugemwLAiisegMK3XdvpyEgoNuabkda6Xujvd3d/f3d3b2Rpr09/HYPHz+oHTWFD+0dfC1uZxfg+/b2NXuW20wb+3t7h4f7++wqnJzdPfaTpOxgTxrdnxRlMWz/G8N1DfVj3v2gqhPhnAO6nQnLR9Qt7a7XZ2dny/VaN0QOrTfr1Rr/Xz26qVy4WlVvX5+t1qvqlS3C16/mq5X4qDU1Rn+ulyv5kcvV4WDvaZAxGJPeHfXnHlD/Lnom75xRQDkRutYMl+XK4GytIJKHGKDm0fVyOV8u+euabYvwRRr86/VyLe4Xh+kV+2Qkf5gD1aPAeICe7xhUTAbt0UjyFv7+d3UCBU3YI66XNZfJj4p3mCHi4QxA1wRO7Rh3xcwuPrc2kVWv1UcR/ztbLdkn8cPUyZ8drpbLRc2Jd9Tdu3fxjz/84Q936bs/3Lr1I/Gmr0ZDbg6vkB60p/z/9opiT92uQcJ9pen/DA9KaJ1j/0l+Kz7xe6yVCaigjEYMOvTGa2HFAFTU99TMwXQ87TthhLtLGQWSDWuGzBElOjdj8ecVUNrzMxKejdXX/JWlMjeqYQ7oYjHjN3AfuVrMdUBZDOkEVCSAfwoDdL5WwQe7cK/D6GiTqs8hbn8SfDddWkAfvPY7WtGHXRfP+3NGqi2kGjd1QJkP0xwqAfRktVjORBW8pgeXi/l6IbwqJ94FqGqM8U8hMeic1urSpRN7I+va5y4aja7+5Cc/uar1HPzwjTeM9+moR/bsNAQDlGyuTHpCA+8sogBdYJ9H2+HYJXJANTKWa+2I8JT4F6nLl9iHnmmtKQw2dqEq6DQ9pCUGpUeWmOiVcQM+MV/pgNLb+nusEY9Bhe5SeZauurffjd2UPqD04Qx0SVPg2UwCUFIlz2hf0VL5UhlDcqfKWzvEJeLrlMNcLfT+KNWmobGCeLusNPRZFxKpwjHQ5K8D/2cSvcLornRAyZm93tPtKs2Zu7bmkQNacU7c2+XaPkofUNpLTx+qtJXd7UgVv1jMaXcRrthXetvEqPUpVPjtYq3aQNiF8sMrs00jsBY3md1VsuVECV8Rt2v0gVLiF8t1pZW/13s2UwdA8bFbt5qb9Vr7n76wMt5ivrPOCaDUeW5lwvKI9ZMTQDGo1E3KJksNriqg9JjZibmkQad+F/4DWBqA0oBAB7Te/6+GCLRoIQyg3N31AbTBU7YA6vatWwKUjab7PKYDiRdkGInfvo0JyyMGDKvfqdcyxo9EDCre4mvXK33kyGw98ZuNSh1fvJzrNlRjibFbGcZin7PU2+8bHoMCAapzIqvsjoDye8n76w0gNgPawbeGAPQXv/hFzYPSB8Z3X3SsN5Kw96Qh6FMUdNEcX2IxkoydkgbPWgWiSjql9DXpj+dNdbMzf0360rUeVB5orvQOgOVqtpizjn5hWbva/Fyj0T8q+o7Et3SpK9fYLQbV3jfi1minC6A9RpnslhSff/d3f/eLKqDEe96/sRHTlZ86h4WQenmf9DCRZyu2Z6Uun0yJpRQjMU5DWj8r3CxZLaqAWoJIcvFixdtNOqC4wl4utQt5tKk3d1ibyNbdVBnrr9xI+kF7jsV3AdRf/rd2uONqjwFYuyUHoC9+9tu/wDU0hvTBlQ1ZmOR48ibyyqldPpkSqyjJSBLvHl/gpjdhQnWbk5ek0V4BdEna3uvZQjWE+PXYIS4WK73GJ/2pxIo2F+RssVyc2ftD6UXMR5PhfBE9cHt743HPzZqueje5OzXEq11X7nvdZrcG6OYBqaHJcjlMZ4dVc8h1QQf5ZEqsQ981muuGE6OdPbRNZAJKjs/JhJCap2UeT3k9Sho5PFfD+JZP4q/ZWD89T2LT5UKMR/FLD8jiUc/vjmrnJwFcXeMdgxrxIQC1xqB8VRKd+UGeKPumawkc6p0lJa9c8e1id3kQuKxEg4SWBYZwgR3rXMWg1KHhFv/p/FT2SQnR3ibi8haLBesMYOEnYZZcLPr8yWcRvuf6COdGeFDacFrN5gs+eqAc7MHx9LjsE4VSQO9ev271d1ZtGVAtNQFi0IZuJgboX8rI07G0E/llySrvbw4Duq+NlksxLzfHVfmcVOZao54HlauVbZodb16RuZ1z+mapxaC6H2a+eVlxwSwVtOuJfO5cBQUs2D0cT8bHfeaEEkCv37p791at7d6k7QKq37G9flDWhmeLjgmcyQFKXWhxQN2eOejN40QKyjTirWUAACAASURBVHpOnd9GOE82fW5pTnLmfpf5STYIyjuT5JgRwW5pADo7PSUDSFqQSTsHlmx0aTGbi+FR+g9/5H75+MnjybRHQwnHoHe9AO0xGNQpBsUnDUdeT822ASUPh/8dbZh3b8X3lleueDN+T3o6YkE2V+j4I/dczPPpM+eqbXd5lF7KIs9qb5UYF6U3kCj2dD7HoYDRVKcjSLpLFweoB94vn0yeTCY9GkpkLN4P0FAyk2FJTfojSQPklSsO6IiN6xjz2mg7HQeY3J0utf4keaHRfa/meNBLWRenNiBFzxHPKJtFZJ7JfD5bbmqAroxYWAF6ttybTJ/g/3q0k0g3k1cMGkxWQI0Y1D93FxxQc7EFrbqXpF5XY+lLS4cnu9wIEs1X5kWiy13vk2IxADFOPo32/C8XMi7g6dEAXY/K6WRc9ulpauhmqlEKg21rf78VUE0ZUCk2lDQyOWO9nqTpLpZ8yGnMtXEenWw10GS7SMBp9mIRJOn0KLpojpK4mi/VRaJTVkSpe4/G0yd9NhZp6Gaq1fMwFX+7FVsMqisDWtFIm/wmY87FfLZYK0CpU11WOoXoLKja0ri1Vj/T92qa3lpMEzEmo4hPwA0jFn2utYCYdGTReIEB2nfjm0GA1v0heBeVrgxoRSPV+FGAnmBY5nqn0mqtOoVknEra28aRjdmSUqdE5zwNMfXWk7x+LialastE6eVz3nuPjx0U5bhPG34QoPVj8F1UujKgFY10NkVH+nyu/BaNTG2A0pn4LkCNhhbrya/MlmIel7pjHgTI/ivicDVA93rvzDQgBvUHdFgkCwcosBCADc98sQnLLNJbnc1O51jMEF0RZyzWpKNKbIWc6gKiM5coXWKkncWU2oomPl1peToTw5u1/ic2tHRGZy2bk++Xs5PZqQbo9HjSD1A+WUSS095TaZys43j91i18pCeFztsyoFJyTRKJ+lYni9XJyWolCKWL1jQ/hxv2i9lSm1xPLqITQ/hAppxfgls6C21mCOsZJR3vS9krUOl/YsNWCz6ZSgtQFzMcC8+lLz8oy8lkwHS76qRju6ona/Ps/nDr1vW+9bj7tgyoFNvXkHx3BLKTxQIDujiVFb1Z6bP5TubkYl5j0wUjZ9p9dOUIW1c3PyNzPtYsXKUOWutIXc5P2colMpHqFJO4WMp1zDTQOJlhH6rmOveeLDIIUPv5dhMWN6nmOWdAu0n0g24YVCfL5ckJWUW81CZn6k0cOunOXOxBGzG8dSNXv7MZpaRFPmez72gHAAb0lA7Rq6EoMd7OdnvAsC6Wch0zPTifnZ6ezpYyHjgvgLa0tTKg3cW3LqbfHanlZzgIPZ2pYR2z42nF1qvr84f5WhGxaHmt7iNVPgN0jd0inRI6Z4P6NkDxHXPMNK7OMe18HTOn9uTkRJtQMuq2X6lFA2LQpvNtkz5bOgNyDNpZfOdi6kFx7bsQHeqUIz4ZTnXd8+FQ4h/nc76bCN2Fab5Q2z6Q0VE6IMTmOs3ppBFR/a9PZ2TuCZmqtyS0LmancsYSX4x3JgEljOPPWYmFUjSReyTZvRYej7RC8p+K3HLKep0tiq2uaWo0Meqxs5g7PwBCADZ8MiX2fh+RrTcP9w8Ovqa7cO4d7O4ffrP39SH+j+zbid/v7h7skV062b6dB4cH+wdkK0+6q+fX+7v7Xx+wjT0P9vd3D8jBfb6r597h4eEe3R2UbkG6/+0/fbOHr/pm/+v9b/a+OTg8/PZbfiv5XPoZh4ffHNCdSbFZfPfBSG4+Sj6+6LAbrlUaoJ1aN23rMo0VofbrbP0A1XX1TSZGPTbdc2UHRAjAhk+mxDctAN3jW9USNg4loGI/2ZF8sbevAbp/sKt2viUXcECNO7jRfbarLfkwAuihscetZmJPmNJenzNA24xlQDuKPZSjLPY2uO49IZ05YtolaeTMcYA4p1X3mjXJ2QQnElWS0JFuHorvmZFKXo6AnrEKf8F7mda0ZUSnc2KjC9JnRKLRBf6w1QxX3AsZXJKBgTWbRMVnjZzxGSQqtsW/KKC91iVpMWgfQHWPqC+Iv3v9VlPFrRu7detWBpTKK1fs6cPjXQzK4vRksZATh+iiYrkgg8ySY4103MAmjXk+lRi/n5+QSFG162nsORf99KQZhAFekjmfpPN+Qdrp9OUJbjEtl6qzlJ5kU07ZrJEV/UOh20mcabOZSQw6BFCzrm2VGWiaLlCuNyZL6a+7Z9GbgOYYtLsKAeiKNJEEoOZsJNavyYYpaTtGNvIr7/m1Z7rLY0vf2BQ6tqxZjSNp46EaoCwZnO8zs8+ANnCHVPF9B8mbxuy143A74eRWvFLxaFpOd+czXHXPMCKz+XxW2dNmUwV0ITeTx1DRXXDmpCtI3FEHlM6L4oCSFXinJ6fEiZLp9SuxZQhureMWfQVQ3JxfnS4W+q5Ne0UpH5jjJwEoGQNySfYiyYlxdGyzVs0rD2rdw0E2iu42bUAip94ZPjQDqqkcT8dfn2E65hSlUzLcWJkox2ZyiIWfhM4Fr8BJp+aSoHU6n5mzQdU+IWtC/5LvukiRwwHCCfPVfE0oDTdPZ3T+Ket7ZVsykoGkNU6SmqGy2h+XZdFrwh1vg3XZFJRtJIp/vvGvrl594yo98sYbPzT3F716lb6++sM38FF6ih+pmGG/f3jV/qHYPPmEytal/rm7uICS+vLgTLjHyiLL+uR45U43yk1iv7ucVa+zGiGvT8WCTxlM1Oc/UZG21Wyt1t5LQHtt3VChxhdQQaH9YuspHdCmj8yAunR5AGVGu0SDciTz1p/xxRms3W69tfmUtidZS+uJfoJ5SQZUV1EUozXfZ4ZPmadQUGtqcrw2YX7JRpj4auHl/PT0hOh0udS2lNfuUPezqSFswgi++vT0lAUPtHcLUz6nbfsl63IiR4jp0/l8LeMGEoP2e5Ss6AftsrMyj0GvE2ldSC075Nhmkd69fle7uemjfvSj69VLCKC+7fj2DAEJAdjo+d3pMzTXartj+rbi39b6jBF87WK2WOIQli5x17eUr69KVvPvqXA0u5ixh4Cx2SUni9XihEyVXpAeUjIjaj6j/azK6qAtwLm6NqmHTYvveLftslGP53z1TqePEICNnt9dBrSuDGhVCMCG59dWPHn8pDyYk01oMGK8fl/gl2ySMKHlFLOCmVnNcGVLQwHcCD85WbC9RjCas5PZHFfEpKuJoLRYsAnPbGL9WtTOpPeIdEedLPmaeQLo4uRkRixRVAmg2PR6Sev12YJ+DAYUf77cEH95gJM8mfSZ0KRGkqwzjWzTN83hn8pSTFecwCbdN0lNqmJznw1jGVCp4ngyffL4a9KVjj0gX8y2JiieLOnWIMQ/zhc4VMRwLUhP0AIDhGmczehe4fgCfIK8wTDN8WUbGsnSlLCdmKWrJbP5CKArtc0dBnHOLJGhURx3ns5mqzn9A5jPZktMKU7J6ULufYuTtFcW0/G4z5Q7raPeskjT2sjRAa0uZndPGW3rcNXuJiBXuklzDCqlAMUOcS4AJQM/MwXokoy/L09mAlDc0pkt2LbyvDGOX5PuU0Kd9qzEtTm9mbb256caoGSqM7Ok9wvwrXEX69M5WVeqDzcBAVovtdZWOHvjDWjrynhzAMoCqK9akgInBGDDL1sZ0E3z4QxoVQjAhl+2cAhKYtDTOd2sE/+iXUFzsuR4fnp6SoLGU9LlRA7imp0u+sQ/8Cu28TKJUWlcig/jepn1FpEYlPUWLVkXEU0Y4Z2YxPEnNs06npa0g2ou7PAnJLPd75f0YzZ8gR2v43EMWpSPn0z8ckmry+qMevr6R9ev1w9r53UiW2LQhgVI7inPdG7V3erslas9HiDa9EGgQgA2vHLFvdHemWhLC/+1IvvVn5IokDW75RQPvt2ybHuzLZtWtOlNVl+utCNL5oZZutToPB9qZ+P0ZJR0Lv32Uj2rxhwPkM34EZ3d4jcUzxoco1pR3f3Dn926ftc9Mu+Uj1vucMXdn/R4RvjwXHQQArDhlasMaAbURwjAhleuMqAZUB8hABt+2WJ9iiM+W0nMWGJB3xJHkCSGpGb5Q2B55KmuF7va0PHJudbvybZYXqrn0aj5TeqJsnSclPe+LvmDl7Tr9VvWoqO+x4OS9BhUlxaDDlPT4+ac86LtV+QYVIgvjxzpDRk2LY5Op1+zjvr5UuJF91I4NZ4ZJx+8QNtHxpk12897rQDUx+or4/v6EL6Ak/A9p80n0gTDzna91+spXoTQ2t5Maulwlwn22nJlOkLP54Devd7UdrLviNeJ2dyK5xJT0/e0GfJ0+6TFar44ZVuAL07oMxTUFfMZmSAvPk49UIY85nOx0s+QsUq64fyZ7Lxa1Sff01facznPVOzAnke/WsxWp6cz0p+wmO33matM6vhr1d3t1OYLzbOJq1fTF7cIoLfoDKZbt/Abe++TfcMx90eRq6565/CiAyoXT9JVl3TR5eG3dOnmweE/fX14cKBd8TVZLCzXYspbdvf3Dw8P9/UzZBXnARY5T1Z6HlqWgPIVn2R1qFz8SRZz7pNloWQR8j9ju9/sf/vtN//0z99+jV9lQO3qDMgQodazz3/1RfXQyw9uv/PVZvPs9u2finM+mRKAqt+0AVI8mo4n0yfjkvw3fTyZlqV2xeS4nE4LZYLf8mg8nk6nY+3MLj6Em2Al2S6R7LGD76KPDZOEqbVF4pmM/GBJrOFz5Akkj7Hd4/GTJ8ePHz+Z4FcZULsc6YcRajv5TEEo9P0nH20evkvJxb+YvHJFn0LD/9H3BVmFjJma0P/Iy8nkCWlHFVT0CnygOJI70PA2C9kyiTyAg9qhczaLvYIeLOkbYgXbKgu1K4i8syxkAo5YXEzvxBeTnewm+F9RPn78ePKE2NAtdBaNQav7bstJn7ax+eYjfjFotTvf/VHnNQb9/O0/Eg+KfSbl9OWHX7Af3K9K9+qVK+L4Kn5N68bhG+PwtpSxlrJke3gZtOHzE+Yzp5i36fjA+JDyeMrcovbZjwrj88ykjfV00aSwzyh7Pk72at9BzgZ1W7qsViU33N0w3c5b7rQACLWepQx+/j5zlhTQ57/+avPy95+Sk8yD4hjO6wP5NnQrsbkn3d6YPueVbJtorg425neSDqS53HYeN8Jx82hF58qR5yayOfGHWo8mGc9frrRNQ7WO0ZXYvkFv4G/UU+roGzIfUOut9colEzCg3aZ74oDgrm3WnbZNkw1Qp91IQq1nCaAER8wmDjqx3n/2Dgf0+S/f/pRf5fVnJzzohDtE4gDpf6TaLY95YEh9XTmZ6h4UuzR8I/d+JGgty8c4WJwQ94lj1vLJdPw122i2wDEo2bd7UpLHH/C9E0k9zbZfwPdOJzReMJe7Gx6UDihg9zwdEw/KNpTyVcPStablbm/8kB2tLtVsva9yCdZP3rhKVpE2LfhssNMje8HhJEKtZymgH2AwCYxVD8p/eXfUs/CPw0JjTrIOuTyigE7ZA7MIOSQO1Hc2nkynj6qATiZjfAs+hGF8Uk72p6wKfzQmMSgdsxJbgtCWEH9DxgoooCKi4HEDDUt56ItRLafkrwj/U5GHp6wzLHd2rlkPX7vJRnN2bt68aes1Fxe0sEQHsNh1tenH2oGGiZ/Xrl1rNm1RaDapUOtZCuiHPNSsxqCbzz9iJ7xyJcQ2aSqoX2ReiwIqdpghZJAWk2jAHAl3R7wjBXRcHuPLMd4Fa/OQZ3EcENBVD4FAi9p4JDxhwe9RLfnKxjbsfnInIbrkN/daNmdRlRxJiziB8d2xkIJP37xGzrsAZSbr8+PFB5l47ly7xt82fG6zAmKphFrPihiUVOxM339CI1JZ0xP5ZEq1cnj7Y4or8pIdw411rUnDBu1FF1BZqMY2w5Ww/WjKlmJwW+UhBU7ihCEnvpm+Zx6U1OG0+4nX9azqLs09lEVbqiD+ejrlNwcCVL11A8oudANq+Zimz9+5ubPD/fW5BRTX8TLclP2gD2/f7h2DqtY7CTSnpeqP1FvXNFIUjk8c19jTQaSdmJjEA1YVixr70RjX5eOCV/nMn5JO1XJcSp9MXtkBJSrHxyUJG3rtX2sXA6TmN4+ka7NX8TICaANU945NCzh2Pr55U3F4zgHtJp9MiYq6kLFiKaEqjEe6Mb9Xjq2AalaOOKDkmgNOnACY9eMr8Mmrx8fHsm+fuFjap2/uXae6SAvWfvPKoUtmBSxrbvMC/Xflsv6rTJkljOSP5Sfil9fEn8M5jEG7yStXsr4tWGubdzLyVpHhyAru+0TcSY6NWSvK8KTME5Jr9lhdX4hPmeK20+RIvx877OmTY96uJ0NOLCgohLFK/ys+WfZ5zrFDyh2ar82LVEBpONqBgB5du/njnZvy02/++Md+WCoBoOMWArDhly1ZOTMAH7FtO0STpDAulK5N+MryeFKOi4onZeND5OWe9K28QcVizSPWTUANKZeoxkKLQv45jNXd7AN7tt+VRMVtuMObCpFqULhjHheYwgFqfHqPfWulANBxCwHY8M6Z9Jz4H66ECRLjyqA5a1pXfKqGlwwz1TgPdogVQI9k+38qI0md1YI0xMYT0lTSx+ONRvvQ6LMCGOXPrNYNRmrNHONGKg1Q/01n6V26/86A1oW/f9z65jHmlDe8aQeQDgNpuUyUTy1YT1IlJDQAffRoV7aQ1EC+GtusfAj7oygK9pt0KAlAtWt4z2i/b5DIBNSETlxixpqq7r+2YyNoZLvYM1HVtlQv0gHQcQsB2PDNGOOFB4vTyWQqfZaOAgVUBYOsoY6bUZOJmjRS8JpZBLS71d5M0dJigFYCSt4WokmQvakGjBbH7isboLZq37z86MjiOrkAAG3+VB8BoOMWArDhmzHh0AgfZTmdHitPp8/sIN5T8oIZOz6e0q59McAkW/LKS+qAsi560Y1assEhS5O8KB/jhtfEugk9AKAmjE3Vee1y86wBaQbUV945Y61q5t2mpWKmMjReaB1J42JyzKZ+lkV5/HhaHBn9AbzPij7vgE+pG1Pbxlwkrc9V7ywtJ+XUTiEEoKaaqvM2X1rhpyEGrZrwqbUzoFWppryaN1wFVD+AMSKzQsjuCWXxZHo8nlgAfVSMVG8/HwQqVQhgjqlr86Hp/rT2QJOu8APspTdUr87N01p7Xu9bt7fiayOoXszlGNQQC/5EV1BpOk3jQg0/OS+pfHw8JoCao0n0nQGonAuqhQ/abFLVtJo+mRS2Tz+y/MkMUB0Ca3Vuu1MN9xyFAbSXANBxCwHY8M2YnKNhAaKwe1A2fZ43cOiMeesdGqBHos+eXya6RHXTtLkle/ErMNaj4mFqabo7abp2U3WbNgFaGSDNgCr5Zsyo1s0ztTreWrs2Pn6YPtJILWKX3rmgvZ/mQ7XpRDo6p0kbNdCcudGfCqBKf3wLro57mwE1pvF1r7X79aZeZEBx48X2WBfD5/UK/MR3p3Xj8zgTf+a0+kdRstmeoi/VHMiydHwNUyugzps1hux7LJDO/4YxU6+EeQgAHbcQgA3fjBXj6bGYK68BIOck8Td211UjRj8wkpZqS0en9WVIJKilk+nKCXlQlxVQQHlV6i1m7LvUZECb5Zsxvf1SWRJcNgSE+r3GcTUPhKgRUN4TWlFZTnhPAvnc0hKDhlPferUJUDJRvx9pGdCqWgAtqmxZ7jUoMhdoVgDVJkc3wCa7ukgfQa0XNkk1AXrUG/ocg1alhhTNsSPWbcQq+QZAOgHqQRf9TEuvAnwND6Y++3wFEQA6biEAG0MyWQ8py/adPCqD5YJndmqv1XSzzfqDuowOrrS8qdGK7x0pAAgAHbcQgA3YbPv5LrORVZss0vXe2tHKchK4NZ3DpQO6hd7OZgGg4xYCsAGb7XawWpxZFVDr9A/NiH3Wp5pJKtct9QQ0FDz+gAb6SwFAxy0EYAM4320VquhUt11aAbSyEq5qxAC08pJO8ldXnXdAQyUEAB23EICNAHlvkjZBuTb2U4lBmz1oC6B0rIDufFJomzr0i0G3AWgn55gB3Z4UoHQRUzUaGFUubQXUPnPkEVlnypfPD1zO2bjwd1iNO/K1kAGFUgdPJfymfaamAWjzM7Trn2P0enHb/fZjcmsoLyNvCzkGhVHX9rvqu6xCqAHaqyNTrh6pdttDavuABhIAOm4hABtQGfZhgi+Aq9wxFNCjyq62QZQB9RECsAGVYS+mrNM12wDtBNxWBpC2HYN2lLdRAHTcQgA2IEpHrRH2uqsZULX82H5pN4MpaujGDQ3yd8sA6LiFAGwAlI6Xv9NHj4qmGLRqtyOgzb37yagfoE7/mAFtU20WXQtOLbOOUgYUrFruBagbvwxom5oAtTlScwaUceOoeoveGR83BoVr2AQCNMegrRIdkYXh76y8GIsxzJUZo/p8PL+w1rbQo3EFlJfSB9RbAOi4hQBsAOS1Nj20Pp+jcrGBsLhuJPqfhiXE+NjmMX0vDSCk4toCxaD+AkDHLQRgY3hWm+bRt9S4RhCgAzp8iDIIoAPWeFTQDtSK9xcAOm4hABvDs9q40KO5hq5Holjkuxu+o2cYQHsrAzpUw7NaW0TU5R49auVD9HtHrV63s+USPgbtrwzoUAHktcKEx41GP9IeszWQz9Q660Fi0AACQMctBGADIrMWKjz7hSSgAZKSlDKgvoLIbJ0K77FJHoMGSEpayoD6CiKzfQE1dhEF+u7SWsRZUwbUVyC5ra8/7uzIeF8o236x46znPklMRBlQXwXKf2eM1JYk9ZGkxuuHpy+WMqC+il1QGdA4AkDHLQRgI3ZBFXKVcAZ0mwJAxy0EYCNyOWkTPHIMuk0BoOMWArARuZw0h5jMd9euYRM3kskkADpuIQAbkcvp3AE6cOpbMpkEQMctBGAjdkGpGjuZ765VGVAPIQAbsQtKKZnvrlUZUA8hABuxC0opme+uXTkG7S4EYGMrpdGp5Z3MdxdSyWQSAB230FY+ZbjWZ2dna+dVoy2kJLouRSalEICNbfy1dutcFw9RONf9nC5lD+qrbRSGD6DnfKTIpQyor7ZSGh4xaAZ0OwJAxy0EYCN2QSllQLcpAHTcQgA2tl4yjd40x6DbFAA6biEAG9sumGYPCfzdpQl6BtRX2y6YbQGaaKiQAfXVtgtmKKBdHWMGtF0A6LiFAGxsvWRcMajj7q7cZUDbBYCOWwjARuyCUoIFNMeg7QJAxy0EYCN2QSkBe9Ak+cyAeit2QSmBxqCJ1vAZUG/FLigl0O/u4gEKvEcoADpuIQAbkJluUjevlwFtE/QuywDouIUAbADmuUkdYQHuB00zBu1d3hnQcOoIaELRRjhlQH0FmOcmZUCV+mcyx6Dh1K26zYBuUwDouIUAbMQuKKWEkhJOyWQSAB23EICN2AWllFBSwimZTAKg4xYCsBG7oJQSSko4JZNJAHTcQgA2YheUUkJJCadkMgmAjlsIwEbsglJKKCnhlEwmAdBxCwHYiF1QSgklJZySySQAOm4hABuxC0pqNBo2lJTo0FFFyZQ3ADpuIQAbsQtKaDQaRmiqg+8VJVPeAOi4hQBsxC4ooQzodgWAjlsIwEaU0rFUxxnQ7QoAHbcQgI0YhWODaSigOQb1EwA6biEAGzEKJwig50MZUF/FKJwMaHwBoOMWArARpXRs1fGl4DMD6i24LA8MAjOgWxUAOm4hABtgOR7YjM5V/HYFgI5bCMAGWI4zoF2UAfUVWI4zoF2UAfUVXJZzDNpBGVBfxS4opYSSEk7JZBIAHbcQgI3YBaWUUFLCKZlMAqDjFgKwEbuglBJKSjglk0kAdNxCADZiF5RSQkkJp2QyCYCOWwjARuyCUkooKeGUTCYB0HELAdjon0Xg6UOtrfjzMVWpgzKgvuqdQ+AJmK39oOdksmcHZUB91TuHGdA+yoD6qncOM6B9lAH1Vf8s5hi0hzKgvopdUEoJJSWckskkADpuIQAbsQtKKaGkhFMymQRAxy0EYCN2QSkllJRe6rLDbDozYgDQcQsB2IhdUEoJJaWPuuzRndCcQgB03EIANmIXlFJCSemjDGhdCMBG7IJSSigpfZQBrQu1nn3+qy+qh15+cPudr/CZX96+/RE/FLuglBJKSi/lGLQm1Hby2e2fVgH9/pOPNg/f3bz8/aeb53/zKTsWu6CUEkpKOCWTyTBEVoRazn3+9h+JB8U+k3L68sMv2A/sV5+9S85zFxq7oJQSSko4JZPJ8HRuOlXxn79PfCYH9Pmvv6Luk7ynv3CNEz6VHaWlZb1ex0xJFpRQ61kCKOEQs/nsNtH7z94RgH7/yfv8qth/yUJa++HijLzXlUx5h2aTCrWepYB+gMF8+9OqB335geAzmQLLgG5XodmkQq1nKaAf8oaSHoPiVvxH8qrYBSWUAd2uAmKphFrPihiUVOxMpGLHEanOZzIFpvfAXJi5S3UlU97BoNSFWs8+5634tz+Vh1g/6EMakeZWfAwlk8mAWCohABuxC0opoaSEUzKZBEDHLQRgI3ZBKSWUlHBKJpMA6LiFAGzELiilhJISTslkEgAdtxCAjdgFpZRQUsIpmUwCoOMWArARu6Ckws2jSKlTIJnyBkDHLQRgI3ZBCYWbiZZUt2oy5Q2AjlsIwEbsghLKgG5XAOi4hQBsxC4ooQzodgWAjlsIwEbsgpLKMehWBYCOWwjARuyCUkooKeGUTCYB0HELAdiIXVBKCSUlnJLJJAA6biEAG7ELSimhpIRTMpkEQMctBGAjdkEpJZSUcEomkwDouIUAbMQuKKWEkhJOyWQSAB23EICN2AWllFBSwimZTAKg4xYCsBG7oJQSSko4JZNJAHTcQgA2YheUUkJJCadkMgmAjlsIwEbsglJKKCnhlEwmAdBxCwHYiF1QSgklJZySySQAOm4hABuxC0opoaSEUzKZBEDHLQRgI3ZBKSWUlHBKJpMA6LiFAGzELiilhJISTslkEgAdtxCAjdgFpZRQUsIpmUwCoOMWArARu6CUEkpKOCWTSQB0dhP//AAABJxJREFU3EIANmIXlFJCSQmnZDIJgI5baCufsi2lsxNkQF2KTEqh2AkA1aX47i5FJqVQ7ASA6lJ8d5cik1IodgJAdSm+u0uRSSkUOwFZWW1CsROQldUmFDsBWVltQrETkJXVJhQ7AVlZbUKxEwAitmW+5cGNF0Xff0KfnPZu7HRsXyh2AkD0/JfkWXgXGFD63MmLnL9GodgJANHzX/2vd+VTnWrPF70Qwt7z8/flcymf3b6g2awJxU4AiDCan39EATWemXOR9PL3f/z1V+K5lORpVQ8vR32PYicARBjNl//pK/Lzwy/Eo0Qvmh6Sp/7w51Je0CzahGInAETEdz58H/8kL77/+wv57YlnVtHnUj7/pf7sqossFDsBIGJc/vFCe1AG6Icy8ryYkUxNKHYCQES/PNqUv7AxKG/Ds/yRLF7QbFaFYicAROzLe/jTC9yK53nkz6X8PLfis7JSEIqdgKysNqHYCcjKahOKnYCsrDah2AnIymoTip2ArKw2odgJyMpqE4qdgC3oAbohX/+//7H57s9/J95pL3W9uoeIXlMnxYX4t+v2pz/4rCkh371Jz7147/Uvredbbr20QrETEF6v7v2V/OIrSDUCSol+oHjRAHXd3gooZf67NzOgnYViJyC8nv7gv795h7/2AvTFe3eqFw4F9K+I4Qd/lQHtLBQ7AeF1//X/c+8KpuOtf08r7hsEK1KJX2GEkZcEjO/exCcZkQpQiiCt13+DEMaKV/H8WnqU3CNsvHgPvfYbTpn8iN++Kex+9+Zf//zLzau//Q22VD0tbqWmb2zu43ObB1filFhKQrETEFwv3rtBK+vv3uRE4n+vMLHEP/KXmwevf8lQZK6WA3r/B59JQHGtTK5kgIpraV2NbQsb5KNevMcAJcfoHfwacuy7N//Nv8MJ+Yv/zYzpp8Wt1Gvj98SZvrp3pzlbl0UodgKC6ymF8w6DjwOq1dhPmee7891bqnrljSRyowT0zkbRKa4VR4UN+pvDSF/jH/Jj2fUP7mye3nj6+pfV0+LW//8lSxb983kr1/iXAFBSWXLnJwEVwR5++QCxin9zn1a5VNyDbjYK0Lc+E1U+OcSvFWeFjQcktuRYPaWvhbeVgD69srl/hwBaOa1ufcr6D3D1nmv4zSUAFMd2zBs2AaoaLPhSUT07AOXXGnRtaC3vAvTFz//hLz9rAfTFe6/9jqXyrf+Za/jNJQCU1bgkYNQA1at4rbdTtNstgKrf4l6tCSVsiHqbvibHnmp/FywVm//6mysE3uppcSsFl5x8de9f5xp+c/EBpe0X+ouioLWMeLX/6h5GAhNBCeEgKUBJ2+XVvdcqjSRxraBL2Hjx3pV6I6kCKBk1eKo1kvhpcSthk3WXPkC5ht9cfEB5u3zz4LXfUkjuoyuWbibqztTYkQKU9vr89c9YN9MVSSW/VsInbFi7mUxA6e16NxM/LW7F4e1r/4E4cpHySy4UOwFZDcpteCoUOwFZDXpww33NJRCKnYAsqxrH6y+bUOwEZGW1CcVOQFZWm1DsBGRltQnFTkBWVptQ7ARkZbUJxU5AVlabUOwEZGW16V8A6RJedW3IVDMAAAAASUVORK5CYII=)<!-- -->

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

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAqAAAAHgCAMAAABNUi8GAAABdFBMVEUAAAAAACsAAFUAK4AAVaoEwMUHrbELoaUMwscTjZAUxMkfa20fxckhx8wrAAArACsrAFUrK4ArgNQzMzMzycw3zdFNTU1NTWtNTYhNa6ZNiMRVAABVACtVAFVVK4BVVVVVgIBVqqpVqv9Vz9JX0tVc1tlrTU1rTWtrTYhra4hra6ZrpuGAKwCAKyuAgCuAgFWAqoCA1KqA1P+CTkqITU2ITWuITYiIa02Ia6aIxP+N2duR3uCZ5eema02ma2uma4imxKam4eGm4f+qVQCqqlWq1ICq1P+q/9Sq//+xXljEiE3ExIjE///NaGDUgCvU/6rU/9TU///ebmXhpmvh///ocWjr6+vuc2rwvLnydGvy8vLzoJv0dWz0wL31j4n2dWz2hX72op33dWz3d273eG/3eXH3e3P3f3f5d275eG/5enH5fHT5gHj5h4D5k436p6L8yMX/qlX/xIj/1ID/1Kr/1NT/4ab//6r//8T//9T//+H///9QQkJrAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAgAElEQVR4nO2dj4PbxpXfZVvNRWfL54rSOrZzbU+KcmmsNqnXcWvHzrlSrzVVr1qvvJJcJCxS75K7JEGu5Fa/+M933vweYIDBgANgwH1fy7skCAww4GffvHnzZnBpg0JFrEt9XwAKVSUEFBW1EFBU1EJAUVELAUVFLQQUFbVCAPooGkV0Ke0pmkoGQMctBHRwiqaSAdBxCwEdnKKpZAB03EJAB6doKhkAHbcQ0MEpmkoGQMctBHRwiqaSAdBxCwEdnKKpZAB03EJAB6doKhkAHbcQ0MEpmkoGQMctBHRwiqaSAdBxCwEdnKKpZAB03EJAB6doKhkAHbcQ0MEpmkoGQMctBHRwiqaSAdBxCwEdnKKpZAB03EJAB6doKhkAHbcQ0MEpmkoGQMetqAFNksRr/9Fo1NKVxCQE1Fdt3YDkyZMnPoSORheCUATUV23dAATUKgTUV23dAATUKgTUV63dAfRBbUJAfdX3jVKK6FLaUzSVDICOWwjo4BRNJQOg4xYCOjhFU8kA6LiFgA5O0VQyADpuIaCDUzSVDICOWwjo4BRNJQOg4xYCOjhFU8kA6LiFgA5O0VQyADpuIaCDUzSVDICOWwjo4BRNJQOg4xYCOjhFU8kA6LiFgA5O0VQyADpuIaCDUzSVDICOWwjo4BRNJQOg4xYCOjhFU8kA6Lg1QEDLs0QxH7RTBUDHreEBWp5njxn13SoAOm4hoIMTAuqrbm8LAtr3BQgFQMet4QGKPmjfFyAUAB23BghohSK6lPYUTSUDoOMWAjo4RVPJAOi4hYAOTtFUMgA6biGgg1M0lQyAjlsI6OAUTSUDoOMWAjo4RVPJAOi4hYAOTtFUMgA6biGgg1M0lQyAjlsI6OAUTSUDoOMWAjo4RVPJAOi4VQ3o8998m9/08tO9D77fbB7u7e39gn/Y941SiuhS2lM0lWwFyLwqAX0mGZR6/dXnm4cfbjb3P1fb+r5RShFdSnuKppIt4FhUFaD33/8aLCixmZTTl599y34Qu/r6T3fVfn3fKKWILqU9RVPJttmkqtHE3/+Y2kwG6PPffr95+Ye7BNq9PWpER6NRF9eJuqByA0pwBDaf7YE+fvYBBfT5P97dSCva91+yUkSX0p6iqWQHeNYCFIzl+3dNC0o/FX5o3zdKKaJLaU/RVLJtNqlqAPoZ7yjpPijdgID2omgq2SaXUvV8UGjYmV5/RT1S2PD6nzDM1IeiqWS7ZHLVAJS08e+rPruKg8qNfd8opYgupT1FU8kWsVTCkaTBKZpKBkDHLQR0cIqmkgHQcQsBHZyiqWQAdNyKC1DfZx/mhNOOO1UAdNyKClDfp8fmhAs3dKsA6LiFgA5OCKivgtUYAa0jBNRX4aqMPmgNIaC+avMmeCGLgHaqAOi4FTmgXo0+NvHdKgA6biGggxMC6qsW7wECWhQC6qs2bwL6oAUhoL7q+0YpRXQp7SmaSgZAxy0EdHCKppIB0HELAR2coqlkAHTcQkAHp2gqGQAdtxDQwSmaSgZAxy0EdHCKppIB0HELAR2coqlkAHTcQkAHp2gqGQAdt3YK0IaB+i1zqLpWNPc7ADpu7RKgDYc6t8xC7VzR3O8A6LjVI6DBDRcC2q0CoONWf4CG5wIB7VYB0HELAUUftKkCoOMWAjo4IaC+ali/8IbrQvCJgHqr7xulFNGltKdoKhkAHbcQ0MEpmkoGQMctBHRwiqaSAdBxCwEdnKKpZAB03IoJ0K17TdhJ6lQB0HErIkC3jjthmKlbBUDHregB9TCrCGi3CoCOW30DqvFnBdTHrCKg3SoAOm71DKjBn81YdgnoQIY8EVBfbVFHJ38dAjqQpJFArcStW7e2LSIAOm7FA2iJ/erOBx0GoIH8mFtffPHFtoQGQMetaHzQAHggoPWFgPqqf0CH4YMioP7a/nY9igLQYQh9UG+FuF9B7Fd7fMZkXLEX76u+b5RQwYIGwyoq9zSa+x0AHbd2GdBwWCGgNgVAxy0EtI4QUJsCoOMWAlpL6INaFAAdt3YEUAZQvpMUE1bhFMP9pgqAjltDBLTIHbOVFybMFCBEFEIB0HFrgIBaWu4LBCip4pW3tw+yh1AAdNxCQAcmBDR6rc/Pz9f5bWuyhQLayyV1KArol1/e7vs6utIALWjBB5XvL4ABRR+0gcJX3av7LZv8C9HEYy/eX41rWMahXwATAe1JAdBxq09ASzlEQKuEgPrKu2bccuY5bJq8LI5DQLtVAHTc6gNQwV8ymUyS4uZHTYeAENBuFQAdt+IE1FWAnd+tAB3OsCgC6ivfiklATSJrA1q24zaARpWvVC0E1FfeNSvxQdM0rXc4AhqFAqDjVgRhJtG42oYwre3uxQNUj8zH42cHQMet/gP1Eo0iI2XUXDQfVJ+CGVFPMAA6bg0S0BJF9N2FlRPQfsY+A6DjVkSAFo0YAsrkAjTEJPcGCoCOW/0DWtW4era7O5tRr1lIBNRf3d8aKQNB/zlJAyQYAfVX63eilCMTQW9A4+66l8jmxqAPWqm2b0Q5RxcRUIyDesuzXt7talNALb0uc0N+KCu2Bt9qGOPpCAZAx63uAa1jtigqdZKbKn1Q96mNw6Ozp1bXMqJQRQB03OoF0Enq6LsAKvnkJrd98wfU49MehIBu+gF0kkyq8+rygMpt1SV7A2qeHQH1VAB03OrDB00nMjRvZ6ItQB1Eog/qpwDouNVnup1jsN3bvvkal+hMZj1hL95X3jVrNLcjgA+aLxEB3UoB0HGr76d8BG1VPflMUvfZo2v2EVB/9X2jlHwupZb9lMn/EXEazf0OgI5buwVo8Aae7xSVMxDN/Q6AjlsXClD/uDwCWqEA6LgVCaCNm1DzQEeQqcHIJp+VgoBaFAAdt+IAtDEAuQO9APU6D/qgRQVAx60dApRANHqUb8f9B9tjYtEqBNRX21c1BKDwcpwrqrRRL6cwqtbcKgTUVwHqGsAHrQHoI9f26o8iEQLqqx7ujQVoBLRrBUDHragBLV1qxEqRwwfVt1dRiD5oXQVAx62YAU0JK3ZCS9cWKS/MPEQHN03tRMcqBNRXbd2AFgHVtk+SZOL0CWISAuqrtm5AOaCli9+UF4aABlcAdNzqH9CKRrXucndSVYH6kvNUAhplg4+A+mqrWgaxWXIR8CbHlvugcdpTBNRXW9UyBATqMQpbFlRWblRCQH21VS1DJNVbARWr5G7RSiOglQqAjlu9A+pBUDqZ2HmxAeqZKFcyvRR90AoFQMet/gGtLbM7IzYaizTXAdQKXZy20i4E1Fcd3Q8boOXpdvyTgtW1oxg3oOb0YwTUV+3dglyfejLJh53KAE2oLMdok/IryolLuQUcEFBftXYHSqKSWveH7aEed8y3ly4rbixrYpzKnIQfle+ZAzT8ug0NV28MgI5bQwKUg2N4l4pS0IgflJYDWrEwVOl0/Z55DQeoncSm698GQMetfhducO1XxOtJUuz+VABatuCi7QpKFzzpvf03uWoOaAmJCKihJElrf+FWvGoAmjiylezpenZAfa63EyGgvvKqFTSy1n6Ktotjxe9CCL7gg+rHWINT1YAa2Xju6+1YTQG9deudEhLRB9Xk/sLrrldrkeW7qw9oeYS0xhI5tbX9cvINAQU7+U7QtewDoONWH4A6vvAtXL66gPoOX9VaxqmWAjyQYwtAwz5qIQA6blUD+vw33+Y3vfx074Pv4cXrrz7nm/yq5WQjLKCaD1qfSn0q3oR0+8uCU/5CQD1VCeizvV/kAQUsH34Irx7uNQPUreZRncrvzhhUqjxHbjJzshOAhn9WTRs8FlQF6P33vwYLSmwm5fTlZ9+yH9SuPv+3/7EtQJ2yzemkm+zfHe+562197dXqQwPanw8aXh3gWauJv/8xs5kU0Oe//X7z8g93N6//9J9ZEz8ajbq4Tl3r8/PztXWT9VL4Z+vVmvwrL4JtX69zn9It63W2tu3eizq/373KDSjgSNh8tgf6+NkHDNCHHzf1QbeXxfzxTVbjIuOm2rB81eL4j3ofOqoWWlAlCuinBMz375oWlPyKB1AIy08mkyKgZlS+fNEm2ZPqfcyojhBQJQroZ7yjpPugD5k9ZR90fmeKj1dIbYDWt4fCP0VAfdQymkz1fNBnLLK0gV4890gbh5msqrOsV9mn2uC7HdAapxcdqPbbduwk+akGoKSNhxaea+s4qE1qDLN299rc6AOo5Y/BHs0PoAKOPYaZgqs1KHXFkW6nskBSM8HTul9ha5KYYaZc4qjxyp4TYmaUBFMRRwTUU1ECWmpGbR/oMI9K9jLWuS3LqmtBCOjW6g/QYqdaJsqVk1M0rca+8QParQ8afPDIUAB03OoN0Cpj6DVXvj6g5Wl6xUsIJEVIOFbqAxp++N1QAHTcigpQ9aG+lmeSVFFjAdRySLVdrnlV2yggKwiorxrVrvaKCrn8UaMDpLpHTCPtqKJ9dp4xnzwf0JzWY6WWmUVAfdWgbg6zqO9pAiqD76IzZSRqbgdo4W8hoDmtxUo9oNAH9ZV/1WyTK8uWRywHNE0n+md8CXD6Ema/F3KMS9YD109lHFQ5BbSGDDzqsBIc0HYVAB23+gK0kL9WHloyjK0GKIxuThSg8MlY7jRJq6a62QdBa0+iryf/BnYnAH115xLojU/klp/+7hPxW7zUthp6+uY3uS3xAyo+zwXfqb8oMeRjUArQimCqOplr/nvJMiQ11cADDOyDNiq+vuw0vLpzDX49UKhpgGr7RQ2o5at3AFqaYicjqKkN0HK/wQZonbPWV1tdlMaAhr4gOw0c0Bcf3cyjOCRALYOLjiwRC6CqBAGj9EETx8h+xfR4j4tyqKUuymAApQjSdv13ly699Z1o4n96l3gANzd0K/lNfQLg8sVHl974XUSA5hZHcKQzVY4OSXucX8C2rt9Qetq2tA27RUBrltYpoPfe/EYC+u5b3726c5kDyra+exO2giMAn2wevPXdi4+uEUZjAlQluOsuaRlTBYCMIUve29ZWt7MP6lesCVFcOq89bYVKAdDapXXkg9JOEiFNAXpzo+j86T3GoNj6lFnPm/T3g4gAnaWpyHDTAS1dRrlQQMnSN7xpp9176QWIUc7yQf6qhLvg1rUnQAOrDNBr/JUE9L1vRJMPm+5dunRZ+/QB5fnSNWJEyfv3ogCUtr4K0GR6cpJyLCtASYzFlLVXfL7HI2PxMAA0FabVCO/bC9fOW+jMBx//7APQ8B5xQ0Cpt6kcAArmhrbysQDKujSSiGSSzqYnwtRZm1ptKVDbEJENUAi5S8tshPft5lBZ7qJfEH6AvnsftAUzWxtQ9Vt03bUu1FMeMaVNvKMXTw6jcLcKqHQPBYkE0Ik0ptbIoxbXrB7DzK1uJwBVpVYsVScNdFBAW+jJN+vF9wAodHte3Xkj10miDGrYvrpDTCeh9MVHl52dpHuXwUt9cLlNQOXQpQJCAaoNLibmmKMOaN4GKuOXX92OkUk4nU3zY6W2S2NwFhFu7oO24R6WAOr4U+gBUBpQ+odfsjDTZUnlUzbOJAClvSqwou4wEzGgAHrRzAYGVCOMoZdO03zrakahnuhE5wHSvAJ9jXr1IremSFl3XSX0h1sOvDtAnWfqygcNrBygYJXbB1TlyOWGe8qy3c3s+wKg8v3IugsAOpMriE1nRpjAPHkB/i1Xr40I0PAKCmKZdECJcQaP9V6rTTxtSJVPmIPC0jPXP1AzQ/SPioDmYlXpZCbCWPksAD3cb7GeMpWqqR3tzAe9CICCz3B5c493++vLt2JGXL5kPNIElBMthtDzYSD5XmTUT5J0luq4a38RBUAn+eUZDaM60c8chZr5oC0oIIbl6ifMZEBiB9T0QXlv3JFQkshkkVk6M8aR5Mt8jqdxLbkReta+pzar3adq9eI9cG1MdgB03OopDjopfQQ25SI1sznrAUo+3U/0/Y3R1CSxv9ACW/y6bEHToQHq0eA39w0CoOOWCeiDS5duPmi9iXetHjtJ02RiTW13HCgAFeEl6L2nltW76V+A7gbnuNZnlRSa/QDarjW+wIDee+t/sEiTnxrVrlQWQOvhoQHKj5ienMwmYjBJi44SFzWd6W6wPDMz1GrgvpUn0GzZn7m4gNIw082Ww0y6SmYGTdJpetIgl537oAo4Qud0BvNCUsMfJXBKQM0AljmVSXXgwmaLdABojz7o/7JriICWOHZJcgyWr3o2hl1yqJMdM5lOfyQWFFhM9YactvDUaSjMk8tPPKafB7ajXQDahToHdPMAmniI1fupUe3oGOfEmrhEA+sTY1pbzU5KDlBiQdNpQt1NHdAnk2maynInlWdiU58CP8mrfR+0E9lpaBNQOkx6yZfPRoACB1MI2ds+Y50bQEJE3BsB+igllljEiOQaD/lBVBGJL8vIS1p81FwjUptP+QgcKbXT0CqgzeRdM5GVUWZBtUQnsbBseZ6crlyySMr/AkzjaDyVS7bpWvTTPA38jYR81ByIo9KsrW/8GJrQY012GloE9NWdm6X7Vcm3YgDgVO8iF4eGRAuskkZdeXJUI3NTzocQ0apCK15lo41UqEASqNy6fv06AlqtXCepURm+FZNNuLJsuRU8VHurT1yyTyPWt/PvrsQxEHFO+2z3kohnyGckCQlU3iGW9B3voy8uoBv/GD2Vb8Xy0zqKDNja27KwpL59lCs/DxvrLlUSV0xFaQ/Qbi3o8H3QFx9dEhPyWgU0n2xUCmghMbMsn74M0Lz4vrOp1jfLTT0udpK2Wl7ELqcPWsXSoHvxdC6nZepRLUCbyr9qNsumNbBJMk1Tm1sok0mNfHsFLu3FE2+1dAoxDHKWpqpoiftVVxtQRQ7ZlsrWeDCA/vWvf7UASmd8xA5oacYcZ8SaGyICRSzuY04NUT5oZX+ftfGGSSykPHkueRJWnEzpA9gM6aiP1DqbHID+9S9/+ctfC4C+918uM0Brzn7L54N20sSzfrwti4Omu9sBNTLmxAh7bp9RdcQ0mcwInC5Ay/Oh25cJqN2QjmD79Xf6R7QZoN/cu0kBvXdt87RGnyeXUf/qzk3/vrx/1XLpGmoznT6nZgvbZnokdFVQkdaR2gAts6ApOXamWV9WbpIYdrgbQEtsoGk6ywG9fut6L2s1GGoI6It/9R38/HtiRH9pWT+sAlBAsybXbQEqMuFziGm9FxaTEtM1n5i4CR+0BKmUzs8r6Wgllte290FU6mSai94OGlC7D0ps54Nr5Ce8ePXv/AF90PasTiaYJUT+kyFwbsG05XB06X0jaUjJEXSQJ5Vj6SnPqC9FigbuzaFOfYyJv0lTvYelppyGVM2YZKkP+s516/FldrmkL7alXIBae/GUy983s6AwXY7Q6R0NbVI5wGk6SyEipFnHyWxmHZznH+tZHzTZhP4TlpW0+gfmM4sL3RvVnDMjbeYms4i/OQDLQ1ahO0pbAlrySUmp1seJBXBimwLKuvINfFA65/6evnhze4CC2IiSFtspH25kvRc2ECRHJlk4SQN0Np7UTIHKJc9LHwKCpKmewmL8EQRULRNW1sT77W8FNISP0BhQuohdk158QzWtYA5Q13C7Ob9NhecFsQpQvktqJtKpkoqAqiInJ1MNUEhuBsejo558DtsdBNRbvT6rE0KOyr90JSwZQ/bMnTSnhaTpAUSvJML5hZkeaaEAc3aHKAGs5fT4RFuG5MlkOp20l29nKk+SfSjUBqgYmqr0QbVPy5xYL9lpaBPQzuKguowYfa096WvmKeai6ocTbaqRmKPJM0Ty7qn9jyEl5lL5wdI3DZ1vZ5cTUIqYBdBKl1Zwae4UoJvUOaD+0+WYmlRuVNB4f39/XNxcIrb3+GBM/ulbD8YHvBReHtt0yHd0nsQske4+7ixSXwDU+t4TUPnZ8LOZukq3A42KxazXa9eZ1C7r1Wq1Jj/X61Wmjlufr9ar87W+8/r8HPaAHdeOk6zXZMdsJQtgGzajMmtbV7qxqjZcuba4AlCznEaAbm1D7XexVQvaK6BuEdgkfRLQ5UpuFEiZB8EGCWhl6ZRu7Y+AnW60ZaxeB8PziYjWTtPIUk4FbGWlbW9Q7bexTR/UO0TP1KRydkCt9i1HDHvLDd16sVica4Bqh5hlrbOssuhN0fwSY6oA9X0mot4haQ6otVQboM5LscTqBwaoSAZt0ElqIgNQwQlBZJWxV4onoJKbRfqS8igsIjTgK/G5xFLtZ55FWld+Qr05NwElr5dL/nYE77KlywAbuv3ll1/edryudbBFo7rlVBfpW0RdtWlBG6rJX58OqGy5laeotcicQbYDEQOUo8zo5dAqfG2AavzxE+bbfZ3gFfkTIaeAt5CBMk3tE1DLZJin+j5orZ3KR5JqXo/PpVTJTsOOADqWNq8AKOEkW+qAEmOmYIOdF5lo19cSyFJANfNM/NWFsLAC0ILPSg/JCKALbjTHMOpfMkO6TNxb9NOVK1c8j6hZ6pUrP3v77berC2/wHdppaA/QB298Qhv6LubFJ/sKLK3vA21uBiCRFl7atmy1XK/0fhCBbL0Q2CngNCw1H1TRT9ppopV+3tXK6sHC38BqyVv19T5dh8w+Q7pUzFv0uo3ttLmk1Bs3vvzy6u3qogcAKCyuDJHQTlYWMQBVfZU1RYg0xauF6tNAG6+/pYBmxhXwjlOWUSfA7B3R7j4/UKAu4IV2XALKDxd9MfLJckFOkx0Uhpzqqg6gt297+afe4oDeNs9VuIgrDb5Ee1ltAUofzkCnNHWRzZTsgw9J4FlmZlwHcBIGU9nAlcKIvINjKKA5FPP2mAqQFzRnq3m2PFemd53N5wthnGG/heExLEn7Tyz5uPwRdA7VAFSjsgVACZEaoKUnIB+83cAftZ+zvV78TWZFu1k87BA60GvC58qEj7wjLXHONV1rPR7mg2abTQFFJ6AEuWwuwgTUHyC8Ls/4zgtyJWfKQ4AQFvwhrM8PGj/E0w/QcgPXVLRwpvy58vsNBFBqPNsGlLaWY9qMQsdaAxRoNXCtfLkmvRjNHIooaVYBqB5HAj/zlPiZC16ABFTaZTDuBND90sfOu+RpQb34rLN3jsgIAGWj6T6P6dCa+Jvi8HabeDYsYwOUxo4KAznstTacKbpHq4z8Z4SNWBDK7JeXA0oc0sWcGWN62HK5XMs4ljiWfDZunA7q5YP6tfCNAqod+6C/+tWvChaUPjC+/qRjvZNErCd1QZ9eanfSHFu1YURD8TTyKInLcoOWLFhfMnq+zpbkX6b14s0ihANLbORKYS4i/kDt2XK5Ol0wAwqur3R5xWgBP2bceKjTqxefN3dVFvL27at872pDWt8ot9CL/9Uf//jHX+UBBet579pGpCs/dQ4LaWGmexBhgmcr1qyTlFet+ByK0Tof3zFGGtW7wn7ycwhFZVqvxhqLNwqVB8MQPnF/MzGOn2lxATN8T8rZb9WCSpmAVlpI1fEJ1rHqDNAXv/z9vyQtNIH0weUNTExyPHmz80A9Xw9sZA4zbjYi7UgLq9OQJbeJuh0FQwgeI+nEiCH5jHasaBFGDwu82ix3+CZbzAFQYlwX3CPgqSfMmtMyxVgrBbTplKS6gDJDZ5g7F6A8sGnd7fbVq8Vt3cdB7YBuHkALDdPlCJ01Zs31ACi1RuNCehHr42hhdZpaJDjV/VEVyVdD8nxvFarPD9mrv4YMyARAqQGmLrA4t3yTyUFXCmhD1QTURpkT0Nvlh964Tf55FAdqI1Bv80H5rCSa+QFPlH3XNQWu+6FOZo0OV2zYkfVDVK6H6qOvhU2EIL0B6GpOTOByfpZB4Gi5oK4n51j1cbhzulpCsIhtpGZ2vVmA/0leLRaLtRzH5+da8TfUCaANf5YdNk4GpYC6bJfyJ3ObK31QYiWv8qPVjtwSxwKoPczEAP176Xk6pnb2tTbTAUvkXLBIji2eJN4rE8e3ZaRvdAYBTYiiU5TOVXDfLEF8QimEqOYSeuuk1c8Mq7s2zkVfs2QROqh10DgZtE7ekT7S46GrwOjGLJ+/HAKgfNIxwBkjoEmS7rNhcAJotsgM+nggXY61KxO3YTaQ8LlYLmgUnfuLyvXc5NzN9WJJ0QWXEozmHGClVld5udyOw4WoGCjkiiznSxiQP2g8JSkHaMEowgblT26KH5aLAcpGijRAb4D3afVB6bbyMrsGFB4O/wntmNfvxTeWb8Ug//eAeYukkSVtfTE4bzeqzAauaKoT63ibjmtRzBKyXRbU91xl8hSyg5/ROH3OKSbHLc8WpKd/0HhSpwlowYqxgZ4S2+aweRRQCrcO6I3bN0oOqjzXZhDJIs3lWzHoJx3yfCNiqPTQugVQzSSKRpr2sJmtZa5m6UQjmrAkfFtIoFtlunHmr6yAQkeMmNBVNm78nCTTB7UDWmbVXI0y+KBiKFMec7XUWUBAPQSAjuFAs1u00QLt2cpIaOLigJbRKAqRwXiZ9wF+AsSw8jmiHFIA9HR+tpjrOVLg3FJAm89JKgJqNOa3b9zI+4rahzUinCXIl+6KgNYU6cjDd7fWvEsqFgrdsN733DLNjffDK2Wmy4u/AZZXZ8kRpc086davF6enmWlCM5oUej5uvIZtwQc1++uVgNYbbLd5tRW7xuCDeqrPKR8ZTPvRkovBfgpACaGQV88G2DPRe5EpmxUSsXsRAuUD9Po4qgHonHaZWHDUBJTY3dViPj9sHgc1OzFeo0ViHw2phtlO5mElhSCg+e8OnDyI9+gTNWS0CACd02gQS+rgc4upr1jeI6KSYHILyopfrcxxVAUo8UvBmS0CSqNO82ye/dB4yvEVsxPTAFDvCXfVRZQXgoDmNKLpSDD3SJ9JtFqsZJid21dvQEWuBxusVDl4K82l1XzQMwhAbcA4L8yZyfTCFovF8mgrQG+bI5h1rJm+x/AADazuhzqZxmvaTQYzt9JSPojXx2ZrksZcUguA0pykjKdtmvlKZgCUtefQnYJQqehtaeNLpAiZYr9ei3AV9zEyOQjPxudhtF1x+g0AAB8rSURBVH9LQBvdUoGuAajVZXWmMyGgXoDyVbsn+zSffpnpmW5g6JZ0ToY235L5oBnDEsgTgOYT6BWDGUtWovlKorcl6V2t6EyOjTwkyzJt5H4p55OyExHDOt7KB210R7XgqRZEsgFabVbzcahNBz5oYPUB6Gx2MjtYLjIFqGqQ+egOG8KUbS4MthMXkb40gaSBqSyXFEpNLumVn54Sl2E1X5zN+YA/TIIiZz2DLFA9N5lPr6eALhZzvfz1elS+Fp5DVcki1WPthfgRH3OyA1qeiFzbhCOgXAk8520yO368yuaktV6KJlZ0aTRAZUYRTf5c8PR5E1AtJ19LCiVgL+dzwufZ6RqGg5Zz5uuy4fg5afvneuaTGIanvsQpcYwXWvnn5+PGj0OsALSG5cu/LwXUmmxS4yy6EFChBB7kkZ78AAwJH1TLi+OjO9Qb1AA9JzuLN7rPyYbh9aluIgEqA0Dn0EVfns1hmIjyBg5vdrqQ77WAPfddSbdISwfoCdC8fa0Ycyp4mVXllAsBVYKc+tkRdRN5L37Ne/RQmJauAXOGztjadKsln+CxODuD5ppQxACiE4lkfJ86rGx0k3AJI5UA5WK5WBILTEwzzV/OeAqUkQitxrBg9jHt0UN36my+ooDO0lnrgNpgcs3HFGXdKKaH1BecBAHVBKsdjw8Px4dHRwfj0XgM68Wy19oKs+TFwf95/PjgiK5Te3Bw+PiI/Dz64fHh48PxEbyHPQ9Bo/HhAV3OlhxCXpBj4ICDI3I4lH149MMPpPCjg8Px/sHR0f4+OQTWsh1rC9rCoYfsvEdHPxwdHjw+hBKIfjgc0afmNJl77OWDVqYtO/rq5WPwNURPgoDmv7uRudyxRooEdP8xIe+Ikbc/pvgVACWYHcr1lhmgh7Cm8sGBLJtupisv8x2MJZlzp6V7a4AS2B3PV6yqpM9d9M6rb7Bf+cEIqBJ9UNZozRYzzthAp5zjfjafs0lGkHl0BqPhov9DejekyZ5D87smXfHF2TkdiCINshjepH10GkuVk5lpc72C2FK2PF8slsvTU7VqiejHZ2w8ay1WWIaM/dOzJc0HJWV1A6jVClaP1mv7VQAqQ6qVXX0EVIotFDemw480aTmjsXjiYW5geY/l8oylcS6WNCIkg6HclWQ+6Nmc8AZULqibyUaPaBdI+KDUueTTjzKadUqKOjsl1MmJ8LyblPH/eUSAHL0ifC7m8BeyWKw37PmKLc/qtPuRdQGtShIR85Ore1IIqJQGKIOEAcr66HSypppxoWfiqXUaNjpgWsayWFNJy88XI+wsYZl0eiCypR+/UXOOZcgqY4Eqcfbmz2f3A9TCT4BZxTUABSGgUtPpNJ0mhyzyuKA8LOenhEdojomFIw07sZ5ZRhr7lVxweb3WFxJZqyjmmjTaC76eCINVLohDh6AWcwHokuxHLOiKGEe2AO5CWdBsQfle0n4/XBCxnPMlm/YMk+YCTjsusXVXb9BceH3gqCw27ycE1Hvhhun0x8mTfWq3WHodcROXp0uIxBNC56dgPYmzuCCM8rnzjLxsIaeqswgmzcg/W7DpSXwj2N6lXFoso04rLYL8WkADf0qHBzbc/xWZ9nwS/TyDcVBYkXR5tmLr762zw0njKR+W5WTtK8leeftv/uZnxqfsZYA1bUURjqIaVC8AOm71AGiSzAig2qgQdRHPMwroCqakQ/LmQstcMicdmZPcF2B4tZF4PbqvrwMuMqEWGQXU5hUYq5nItfA7ApRuLgDanRpULwA6biGgbQJavFclLa2YMdzqaqFVQkClpj/+eDydwpwkuT7YYnFGl5Nl4zdn4FXSMUfekGfGhGBtsAmUncHecChbh2xNW3xW6oKticM+yHh58HsjHyNCRzYzngxKU/TYf2KZB7LfY3iiqDefsAa4Caha4Eb8b3xIpyvx5Rg2alFP/dgWhYAKpenk5CRNDkWGRq7fveGJcnIRBWOVMJug/5Oxycs8LrCS2c0Zz9IXAQN99pPowcP6Ikt6DhpomkM4iw2F8qvbb2I+6VMUDEDN+ceFBA8jH8SaLLL191QlBFQIAUVAfdQ5oKQPT9p4BuhyPueTkVYLiMBDa7w4PT2bz2mi8XK5oOFz0vCyxCT90TVaTgnp8S8gdwmGmoDk+emcAHYGKU0CUFgjBM7CFyWF1BEa2oe+/RnxKeZnZ+Buruakp0/KWkAGymoO65Bki6MZPELes5F/5/r1L25dKa5XByt83P7yxo1/ceNGBaBXjU+vXv25LT/U8tr+Ur0XuSdFh+FKg4cm1SdkC3WfD/oj6BiMC3h/NAuZ2L/FnCCaLdfLDBKNgZUluIf02ZmLOUF2DsvWSHNrTHtbZJBZB5AtID0KRjTnpKtFimT5e9ma+ZmrJbPFYC5plBOML4F/DgNH4AaTd2fZKXFqFxCIgmSrBbmSPx/P0plnN+nWF9evv3Pr7cKStGzdpKs3/vb23964at5FjSAgWH0Ki4j83JZ+V3hd0cfS+bdlUr3d4LmIzWjxVPeAEnuUTlM67XgtntYB03sFoBlfq0Y+1QgGkYg55avNFgGFUZ8l7AHdIzpLA4bejYVCRHOvAF2qVRfpkCZbR4ftwJOnedJ09ng6aQAo+cJzgIIYoFVr1NC9DILkOmH2HRBQp3wqhYAioF7qIaN+enyc0gjMmrTMazEkSV5nZ4tTmOh7ltFVGaHF5jlH5DUdMeLvaQQI9mOH0pEk4kkuaG4HxEbB/WQSA05sGVIesKKnWJxSr5dN/4QVQ7MNL40dfwYfw+U8nk5TogZPO77CgkVyKU+Ag68yJ9fAsbqNppPIjreFnaRbkHMu81Eqsemq3Qcl79EHzWkk+uu8uwy5Q6dsqTu+pKe+OLIxO37DF5aFVRhXWmdfrRHKD2IR/2LvnS3RfLo8W8yLGSPsCfSw7i1k4cMbeAxN03Q7MFY/ZxbQmQ7iN03J2Jb70DPzBD4I95SPwEJAEVAE1PrdIaAgBNShPhcPWy/OFms+1Q1GNiH/neW/UddRPGeDrwCqlhBjHmXGfFCxTRzGxA5SPqgULw18VOKDap/KpZ35kClxiDP2BhZuaJywnPdBC6oIXZbuWNxWGDh1nKrwAQbqi9+dqTXtkUBXhXVaFryPI6PzdAydLfqZ8aFyOmbOaOMwZ5Byv9CoFYfkHgtG/xTkwnpqaqd4uJj444EDHqdT3y6S2Umyqs4H+hMSymZuuN7X1EhedH01OY+3YgEU2uMzWFNhfQZLb0PKMhuDFE+hWS5E8Ij+gLjQHBKg9MfLkx8LGFVaynafP1CGhZZWMjzF86fOZUq/yoTKaEpTxtwPOtx1MJ1NfR94LMJMpc9HqGxvZZuvolF1B0GbDoqOxEV7VLLBafzV56xOXeOD8eGfj354/Hj858ODoz8fPj46JK8Pj+hsTJhqefT4AGZbjscH9Mfj8fjwh0PyGuZwHh0ejmHSMvnx+H8/fvzDEZ+7CXM12SH7B2wXPnvzkE4XPYSP+f9jdg10V3LKw6Mj8o8WcYSAlqjBafxVDejz33yb3/Ty070Pvt9snu3t/UJ85vXVlYgQkB7PTqbT5DidzI7T6Swlr9MZW9KDLZgzmaXwHEX6Y5ok6UlKXqdPJsmMNMFAUHKQTH+cTk9mPIET+jbskCcTtgvv7aQJOckTWHpe/J884k9pTOkqIulsRv7RImYTBNSuBqfxVyWgzxSEQq+/+nzz8ENKLvnF5PXVaUog/E2/eMjFIG+Oj38kW45/PCavid83nRJQj6cp2yGF+D6s+cB+TIHfKbxLCG701aNHh2Tr8fE0EXF1/hlMgyI/U7ZmBAiOTvhp6f/0guBvQnwEJ05o92hKznzsu2wD80Gp7Bns+gfGTtqbK1d+Jt+Uzdxwva+nK1duPRqeD3r//a/BghKbSTl9+dm37Ae3q9K8en53QmA00wm3dGDhUniMJzNjFA1lG6ETLUI9rEOdC/ywtwnPjFMfMhvKLC3ZBk9aTp/wx8qIQuUzPJLZjNlojuuEr8eUqG0NxL/1ii8/Z7lcmDSfZVoqX9vJ1D6dm1pN/P2PmbGkgD7/7febl3+4Cx8yC0r+/BqeWjzDiAcx4XntENxciXineiansURYbllQXhabVndAf7J1mOR22pVawTbeYWKxU75O00qlmkIO3pl8SGe2FOuKms8/9lT5+Hd+F+s7iwr329Vxr17p8bbj6nqWG1DAkbBJnE6ij599wAF9/uv37/K9Gv7ZSguaTIm7d0Js6I/Egk7ZnCXqeAoLShfvmhHXMpHWkRpdZdXgLXFSxxPwOaG9n+QsKDlDOptyJ3M2o74pOfuM2OqpMM3HxHc95tYyYV5rSm37NhaUG6cqG2V+ZtvTMKqj3KaSouUOleaRfThoC0pa+L09gDFvQfmvhoBytxOaWYLKyWwGgBKywGlM2SO7mQcJbibppxwTH3IGxwicUiPBKIFuzeQgpYs7pmqpL9qOg0MLjE8mUC5puifTlAE6OQFymWP6ZDaDgCdzSOlfB/kTYF0m/zioVA1ATf4se5qbRrlN9qLV1hqA+nqfTK3DCaoB6Gfc1cz7oJv7n7MP/KumHDwgg9o12m9OZ8xSUV9RG7yZTmcnpOs0A3KniTKOfA+gkHbMD1IwlsfT4mKenLQkUauQz05OnnALCk5pCpEC3g2TFrrpyqC6AXP6oGVHqi3+gN565zo1jbfy5lGULi6rke1kapNLqXo+KDTsTK+/oh6pbOlBnvVKmNVMRIPNW1AwibTVptbMfD5mmkxPfpye0PZfNLYKUAo7dMaP4bGas+nJzGLwlMXlhR8To03An0xSCegTdWGsL5ZQJ6QJoH5ffDm99JNqQG1H3/ri+q3rX9ziDbj2uThOHt/IdjK1SyZXDUBJGy/dTRkHfbi319AHTZRbxxtsZbRk8DIHaEKwOz451vrYiZDoZCfQfO+Tw6jJSxJtL1EICyxR7Ej5J+AJULPKT8a8gZnmb9IrajQMzw1Y3b1Laba1wHkftOS46+/YfMsCoFuoRSyVuh9Joq0m9QbJLyNTXQsgJbkHuIJrSRrvlJg9HlMnbHGjSP0Dyt70aPaEmjxwM3ljPpsog6isLkQ3iQPKbLbCOBEBfSYZaPIVN2ClH9+yU2MrqPhJdZiJlV3q+SKgTilvELomU80+mRDlLBfxMEmbnPDuD6S4T59MqM+azEhLDfumyWE6ZUF9uoIeHYBK+SvW7VLU03GAfBYdDQZI/4A3901WbWAGrPxTE46tAS126Queb8733KZpFwqAjlt9LGA7nTEuGKCyM8Qg4k98yVFBbVyqeixTYiKPYRRyepxALGrCyhsnrPeeMkhTBShzAzSHMk3T4oohZvifX9ATEdWvr2r7RKd8mluqfVBTRUC1v4eyM4ewmHkFQMetPiyoiGCmYBOVy8iHwqUjqjX9vAOjAOUWdApuqXRMFaDUIQVfNhGNPS97ksrWnH2QvzidQ+ZsUKh9M5Yr7dOt67fIv8al2QCVHoWlUb9V1qRva0QDoONWDwvYTmS4ZzI7Ft0U0YFOlQeaqniSSP6Q5pb7oDOeLsLDnulhKg3wlNtpjpwY5ExlHNWNHB2nZ38UTZ8YL2XAQFd18DjWhKsS0DL/1hldbaAA6LjV1+p2YqQoOUlnYjScQ8S71XLAXIs5aYTSnj8hlAYDBDsjaWSn6XQyM4xwwmADq52yTTbitK3MgIp46HaAOgaLanXJhWw+aHnQIOeUll5TAwVAx63uAYVYu2qxKS+i1eeBIBpoIoDxplVZ04R3ix7J7JBUdWngSAko+Rsg/qmKo7LuODT4pNzUOm6ZJDnXggFKww2Nekq6qvNBHKjkYgLWXnwp4n4dMC8FQMetHgBVUaBU2EnZb+KdIaCSkkbJSqTVhMcVMTdT0mMYvLEOaCpT5FT0nRD+49T6TC5OvAVQ30UbbHL1mqpRMQ2kZzaTVwfMSwHQcauHTlLCwGLmkvmcomHmrXma8KbVSHSDvU50QMF8JopCABSiR8wSzmZTdUrRz3+UwCB8TUBFPl7T5WsNVfeaXLbM2CEHaIB4UUMFQMetXqZ8qCxM5lQagM4mKmkpkf2fRzxIORM2E9iW9lQUOtYi8RpTNGuZv4Scz3wESxyePEryaSGhAK2WEzJ9BxPQNuJHNRUAHbf6BTSfO6ci6+xxX6ZB0wYemXGbTU80d5LANU6snRnlCugmuTC4VOwLaQOq7cnXBHoC2p6FDYCOW/1MmuM9IdYH0rsgSaJGKbUgkfxQz2SCNL0Znw/CN+7LIJLBlJ5hL02yNvSfFHe0vW1H3ibQD1At7S40qQHQcauvWZ1WD08zYlY2JF7sU9E357uSt/uJdUKI9geg5ejVAZSNbbVrQJsCqkYzNfQKFKq0peC+QAB03OoPUCojKYS1xBbEZDde9ca1Ho34RbrtR0UO1alSEcky98kZaYNrbWyrNTUF1JqRXJ4dUpbXvIVZDYCOWz0DauZvJHqnPCnatUTPtlM/awFanPlmJuJZJYYOYvRBawKqskOsec3bmNUA6LjVO6AaHVpn29zDTE0uKQEIPChHrmJqZrmraUz6jEWegErZ/hAQUB+pcGVuu2qMq/xB6oOWF94EUJXkHJFyPqjxytccI6BeSmez8lFIMyha/Bh+jysKL4Q4tYKNGaLREZlT0Hnx6IOWyoKB4YQWD+DTRPLNuGYAPb87aZqNiUedBJe2UAsLNzRTAHTc6jcOqt6y39YcTRnnNPvUquu0NaAlsaZILWmwsfhtFQAdt3oe6nxkRJqKtssY3jH71K0Dup0l3Z6LshL8KtniUGgAdNzqHVAYOZINrHUKhjYOpBteYzPf3/zuEsvckUfFPQonNkbnG2p7LkpLQEB95VsxPotCBofK89lygNJNVdHLkb6dpZU2z/RAQB0KgI5bPQBqdJrFYnYl+e2eE9ZGj8x2m8+S97xAeXarfa2naABFH7QJoHJwM0kL84HNff3QCAuo5YLrKxYftEUFQMetXgEVyUzbh3Y4yAagfAWR5ut+ycLjijshoL7yrZglt2hLCyoON3xQj+PrlR6JNED7y6YHBUDHrV5HkozGvtwHrV+Q+O5cXDpndNb8oBcpQHvMpgcFQMetXi1oVaob29QMUNdhrrz7uIWA+sqzXiX4WHM46zaumg9a4zAjXV/+XVQPtMYjBNRXnvXyALRJLz4/tF56Bfl5nB0CupXviD6orzzrVbKo4RZdEWkKR2Vd9xzo2iINWkctaBNfxc52lg978b7yq5Yza85birSxWAsizQFpn+GUmwkfsvtfZ2H4hkJAfeVXrfBBG0XaIVsctzCVvaRXZPqgQS8SAQ2k3gENEMLJAQqLLuZndfry1i6gwXzQfhUAHbf66CQV1uDc9k5JUzgWq5DlS636M7B9tv1ltdd/CQxo8wsNgI5bfU/5CNvgj9Tsj9qFVjX/QRQa1bCAbuFuBEDHrR0DtPcrKMjveR91hID6aqsbFHQYMT5AHc/7aCIE1FdBb9hWavTd1cu5b6joAUUftC3Z0Nnqu2uls1T9QJpGCgfolt5xAHTcGiygVnS2+e4qgvnbKHxvPhig2w7lB0DHLQS0ssDIUkGpEFBfhbphXuoG0M5SQT0MLQLqq1A3zE+d+KBdyYcV9EF9Fep+ba96311cCfJU/QC6pQKg49YFBDRGvxIBLRMCGof68EG3VQB03EJABycE1Fd93yilwfqgPkJAfdX3jVLaKsw0FGwR0OFq1PzQ9fn5+TrclbSoLSo5QKEF5erOM9128BMtqK/6vlFKQwB068nsCKiv+r5RSkPwQbd/THuoK9lWAdBxCwHtWgiolxBQqQjzQqyK5n4HQMet3Qe0LneDid9Hc78DoOPWzgNaf/0xBNRTAdBxa8cBTQprOJQKAfVVAHTc2m1AkyeFVXDKNZShpGjudwB03Np5QPPriA1f0dzvAOi4FSWgjW2ZDdAdwxMB9VfoijfHyuKD7hyfCKi3tqxnAaKAgO6iEFBfbVdNyxNkGwDKKEdAu1QAdNyKEdAGDTMvBAHtUgHQcStKQBsXEs1316aiqWQAdNzqH9AgHRkEtAcFQMetCAANIkZ5FJfStqKpZAB03NoVQJkiupT2FE0lA6DjFgI6OEVTyQDouIWADk7RVDIAOm4hoINTNJUMgI5bCOjgFE0lA6DjFgI6OEVTyQDouLVTgI5GIYaSYk8wieZ+B0DHrV0CdDQKQWj0KXrR3O8A6LiFgOaFgNZVAHTc6hPQ0G0pAtqtAqDjVo+ABichDKDog9ZVAHTcQkAHJwTUVw3rh4A2EwLqq6YVDN6WXgg+EVBv9X2jlCK6lACyL+IUz19hAHTcQkCjlX0ZvIj8mADouIWARisEFISARisEFISAxiv0QTcI6AAVTSUDoOMWAjo4RVPJAOi4hYAOTtFUMgA6biGgg1M0lQyAjlsI6OAUTSUDoOPW7gCaJEk8HdwWVauS2z5JpJYCoOPWzgCaPHmyP74AhNaKg279LKZaCoCOWwjowISA+qv1O1FHCKgmBNRQ63eiltAH1YQ+qK72b0VdRXQp7SmaSgZAxy0EdHCKppIB0HFrpwAN3MRHOnsumvsdAB23dgnQwJlosc4/juZ+B0DHLQS0VAioQwHQcQsBLRUC6lAAdNyqBvT5b77Nb3r56d4H35NPfr239znf1PeNkkIftFO1wWNBlYA+2/tFHtDXX32+efjh5uUf7m6e/+Ndtq3vG6UU0aW0p2gq2RKSpqoAvf/+12BBic2knL787Fv2g9jVZx/C59yE9n2jlCK6lPYUTSU7wLNWE3//Y7CZHNDnv/2emk94T3+RZrWDy6yn8Xjc9yWgAssNKHBI2Hy2B/r42QcC0Ndffcz36vsvWWi8v78/7vsi2lc097t1OEE1AP2UgPn+3bwFffmp4DOaG4aAdqvW4QTVAPQz3lHSfVDSi/9c7tX3jRJCQLtVm1xK1fNBoWFngoadeKQ6n9HcsEfEB+37EjpQNPe7PSo11QCUtPHv35WbWBz0IfVIsRffh6KpZJtcSu3SSFJE312biqaSAdBxCwEdnKKpZAB03EJAB6doKhkAHbcQ0MEpmkoGQMetiAH1z9W4EHOSEFBvtVN9/2y3iJbObFMIqK/aqT4CWiIE1FftVB8BLREC6quW6o8+qF0IqK/6vlFKEV1Ke4qmkgHQcQsBHZyiqWQAdNxCQAenaCoZAB23ENDBKZpKBkDHLQR0cIqmkgHQcQsBHZyiqWQAdNxCQAenaCoZAB23ENDBKZpKBkDHLQR0cIqmkgHQcQsBHZyiqWQAdNxCQAenaCoZAB23ENDBKZpKBkDHLQR0cIqmkgHQcQsBHZyiqWQAdNxCQAenaCoZAB23ENDBKZpKBkDHrRCAxqN4VoJsUReiklII6OB0ISophYAOTheiklII6OB0ISoptVuAonZOCCgqaiGgqKiFgKKiFgKKilq7AShbMt/y4MZd0euv6JPTPuz7OrrXrgAKz8LbYUDpcyd3uX6l2hFAf/PfP5RPdSo8X3QnRKzn/Y/lcymf7e1oNQvaFUC/vf85BdR4Zs4u6eUfvv7t9+K5lPC0qocXo73fGUBf/qfv4edn34pHie6aHsJTf/hzKXe0ijbtDKCbhx+Tn/Di9Z928tsTz6yiz6V8/mv92VW7rN0B9PWfvt5pC8oA/Ux6nrvpyRS0O4CyrvzO+qC8D8/qB1Xc0WrmtUOAbh7+Yod78byO/LmU97EXj0LFIAQUFbUQUFTUQkBRUQsBRUUtBBQVtRBQVNS6MIA+uHRNvv6//3Xz0999It5pL3W9unMJ9Ib6UOxIfrsOf/rmN2UXwsu9dNM4uuKAi62LAuirO/9aIpBDqhRQSvQDRY4GqOvwSkCvWbYioCW6KIA+ffOf373JX3sB+uKjm/kdEdAOdVEAvffW/7xzmdD03r+n7es1wAoa28uMMHgJiPz0rmx8FaAUQdqu/+7Spbe+E00835duhWNEGS8+uvTG7zhv8hS/fzdXLruWN/+ZFCQOoAVe29wjB2weXO7+HkWpCwLoi4+u0cb6p3c5keT/V4RYsI/85ebBW98xFJmp5SDde/MbCei7b30HezJAxb6wFcoWZcCpXnzEAIVt9Ai+j1buRl6LOIDaarITGNNXd27aK3LhdEEAfUrhvMng44BqLfZTZvlu/vSeamh5ZwYOlIDe3Cg6xb5iqyiD/uYw0tfkhzytKveaeSA54P99t+HAkut8D1t8pgsCKDSb3PhJQIXbR14+uMShuUdbZCrlK0pA3/tGNPmwie8rPhVlECO6EYA9pa+FtRWAXjOLVQc8ZVED0rxjCy90MQAlXh6zhmWAAiNy11xTXAYo39fgbENb+WaAvvjojU/Ytb3337CFF7oYgLIWFxxGDVC9ideinaLfbgFU/RbHal0oUYZo1ulr2PZU+7vYWAAVB1Ca4YhXd/4NtvBCFwJQ2n+hvygUWs+IN/uv7hA4CBuUlTxItIf16s4buU6S2FdwJsp48dHlYiepClBxALD507uA9INL2MILXQhAeb988+CN31NI7l26bAkzUWunxo60eCXEf/7hlyzMdFlSyfeV8IkyrGGmCkDlAcSpfeM/gPn+6V1s4YUuBKBDE/bhlRDQCPXANtZ0QYWARica1UdxIaCoqIWAoqIWAoqKWggoKmohoKiohYCiohYCiopa/x/4mUXE6v3SqQAAAABJRU5ErkJggg==)<!-- -->

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
                        2.249e+03                      2.910e+01  
                 n_tokens_content                n_unique_tokens  
                        1.650e+00                     -8.000e+03  
                 n_non_stop_words       n_non_stop_unique_tokens  
                       -1.041e+04                      1.427e+04  
                        num_hrefs                 num_self_hrefs  
                        4.133e+01                     -7.506e+01  
                         num_imgs                     num_videos  
                        5.173e+00                      3.972e+02  
             average_token_length                   num_keywords  
                        3.340e+02                     -2.418e+01  
        data_channel_is_lifestyle  data_channel_is_entertainment  
                               NA                             NA  
              data_channel_is_bus         data_channel_is_socmed  
                               NA                             NA  
             data_channel_is_tech          data_channel_is_world  
                               NA                             NA  
                       kw_min_min                     kw_max_min  
                       -1.843e+00                     -4.735e-02  
                       kw_avg_min                     kw_min_max  
                       -9.214e-02                      2.788e-03  
                       kw_max_max                     kw_avg_max  
                       -1.731e-04                     -7.468e-03  
                       kw_min_avg                     kw_max_avg  
                       -6.368e-01                     -1.732e-01  
                       kw_avg_avg      self_reference_min_shares  
                        1.695e+00                      1.140e-01  
        self_reference_max_shares     self_reference_avg_sharess  
                        2.759e-02                     -9.217e-02  
                weekday_is_monday             weekday_is_tuesday  
                        9.411e+02                      6.334e+02  
             weekday_is_wednesday            weekday_is_thursday  
                       -4.440e+02                      7.004e+01  
                weekday_is_friday            weekday_is_saturday  
                       -4.492e+02                      1.966e+02  
                weekday_is_sunday                     is_weekend  
                               NA                             NA  
                           LDA_00                         LDA_01  
                        2.059e+02                     -1.960e+03  
                           LDA_02                         LDA_03  
                       -1.441e+03                      6.243e+02  
                           LDA_04            global_subjectivity  
                               NA                      1.615e+03  
        global_sentiment_polarity     global_rate_positive_words  
                       -6.048e+03                      2.233e+04  
       global_rate_negative_words            rate_positive_words  
                       -1.892e+04                     -1.228e+03  
              rate_negative_words          avg_positive_polarity  
                               NA                      6.238e+03  
            min_positive_polarity          max_positive_polarity  
                       -4.847e+02                     -2.394e+03  
            avg_negative_polarity          min_negative_polarity  
                       -3.113e+02                      5.118e+02  
            max_negative_polarity             title_subjectivity  
                       -1.226e+01                      3.021e+02  
         title_sentiment_polarity         abs_title_subjectivity  
                        3.167e+01                      1.791e+03  
     abs_title_sentiment_polarity  
                       -3.445e+02  

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
     2.623737e+02 -2.596619e+02  4.356289e+03 -2.062321e+03  2.950396e+03 -9.815427e+02 
                7             8             9            10            11            12 
    -1.442163e+02 -1.513422e+03 -8.389649e+02  2.356625e+02  7.813427e+02  1.683956e+03 
               13            14            15            16            17            18 
     1.967492e+03  1.559147e+02  1.305700e+03 -1.063319e+03  1.698740e+03 -1.070673e+03 
               19            20            21            22            23            24 
     1.601029e+03  2.050881e+03 -1.258797e+03 -7.777051e+02 -9.645957e+02 -1.430050e+03 
               25            26            27            28            29            30 
     1.194733e+03  4.127788e+03  9.418014e+03  1.065346e+04  1.552507e+03  5.205587e+02 
               31            32            33            34            35            36 
     9.559453e+02 -4.264267e+02  3.335751e+03 -1.194753e+03  3.037449e-01 -7.457170e+02 
               37            38            39            40            41            42 
     1.480452e+04  3.997552e+02  7.120565e+03  1.703822e+02  3.070808e+04 -2.099420e+03 
               43            44            45            46            47            48 
    -2.112978e+03  3.143767e+03 -3.902286e+03  2.649774e+02 -2.409570e+03 -2.294906e+03 
               49            50            51            52            53            54 
    -1.166203e+03 -3.939137e+03 -1.488107e+03 -1.472338e+03 -2.662379e+03  1.013588e+03 
               55            56            57            58            59            60 
    -4.280964e+03 -9.269867e+02 -3.153720e+03 -2.796840e+03 -1.045337e+03  8.026986e+02 
               61            62            63            64            65            66 
    -3.005912e+03  6.267751e+03 -1.208734e+03 -1.832459e+03  1.446680e+03 -1.234841e+03 
               67            68            69            70            71            72 
    -2.210514e+03 -3.257914e+03 -1.317067e+03 -9.771981e+02 -3.716868e+02 -1.250150e+03 
               73            74            75            76            77            78 
     3.265883e+02  1.213746e+04  3.330969e+03  1.554767e+03 -1.179989e+03  1.080647e+03 
               79            80            81            82            83            84 
    -2.269517e+02 -3.454982e+02  1.924756e+03 -3.128937e+03 -4.152309e+02 -2.160020e+03 
               85            86            87            88            89            90 
    -1.389778e+03 -2.043382e+03 -2.621171e+03 -3.752406e+03 -1.630284e+03 -4.720324e+03 
               91            92            93            94            95            96 
    -1.544709e+03 -3.003054e+03 -9.493881e+02 -5.439245e+02  1.266897e+03  8.210350e+02 
               97            98            99           100           101           102 
    -1.779079e+03 -2.237071e+03 -6.513396e+02 -2.511686e+03 -2.948527e+03  5.275678e+03 
              103           104           105           106           107           108 
     7.430243e+02  1.200411e+03  9.542464e+03 -2.303160e+03 -3.592159e+03 -1.547322e+01 
              109           110           111           112           113           114 
    -2.923312e+03  8.006376e+02 -1.109027e+03 -7.068403e+02 -2.798347e+01 -3.280573e+03 
              115           116           117           118           119           120 
    -4.594674e+03 -2.354828e+03 -2.225076e+03 -3.196038e+03  7.239943e+03 -1.640423e+03 
              121           122           123           124           125           126 
    -1.253442e+03 -4.504533e+01 -3.019400e+03 -1.077150e+03 -2.338491e+03 -3.545477e+03 
              127           128           129           130           131           132 
    -1.122827e+03  1.028877e+04  5.313437e+02 -9.102788e+02 -4.324440e+02 -8.486363e+02 
              133           134           135           136           137           138 
    -5.987562e+02 -2.616063e+03 -2.128426e+03 -2.930617e+03  4.645477e+03 -2.343580e+03 
              139           140           141           142           143           144 
     4.428374e+02 -2.759769e+03  2.927012e+02 -8.425289e+02 -1.434454e+03 -4.408280e+03 
              145           146           147           148           149           150 
    -2.796224e+03  7.581431e+02  3.094336e+03  5.727995e+03 -3.024712e+03 -3.005921e+03 
              151           152           153           154           155           156 
    -3.498478e+03 -2.821134e+03 -2.577530e+03 -4.835333e+03 -4.867023e+03  7.600388e+03 
              157           158           159           160           161           162 
    -1.717091e+03  7.876876e+02  7.044876e+02  1.700037e+04  2.092101e+03  2.144117e+03 
              163           164           165           166           167           168 
     2.190304e+03 -3.104528e+03 -8.348520e+02  5.807264e+03  8.816624e+01 -2.025550e+03 
              169           170           171           172           173           174 
    -1.105113e+03 -1.675431e+03 -1.268565e+03 -2.850977e+02 -3.023176e+03  2.806106e+03 
              175           176           177           178           179           180 
     5.668584e+02 -6.822987e+02 -3.272581e+02 -2.439612e+03 -5.491718e+02 -2.018032e+03 
              181           182           183           184           185           186 
     1.197121e+03 -5.986788e+02  5.353930e+02 -4.641250e+03 -1.007321e+03 -4.062922e+03 
              187           188           189           190           191           192 
    -3.669869e+03 -2.880799e+03 -5.007901e+03 -2.012793e+03  4.398811e+02 -1.127523e+03 
              193           194           195           196           197           198 
    -1.605537e+03 -3.062336e+02 -4.754782e+02 -9.031588e+02 -3.146965e+03 -2.774191e+03 
              199           200           201           202           203           204 
    -2.046880e+02  3.788048e+03 -3.490260e+03 -1.683883e+03 -1.575758e+03 -1.640679e+03 
              205           206           207           208           209           210 
    -3.129401e+03 -2.717292e+03 -5.013164e+03 -1.793520e+02 -3.640868e+03 -2.827498e+03 
              211           212           213           214           215           216 
    -1.956300e+03  4.174281e+02  3.339646e+03  2.447951e+03 -9.099914e+02 -2.751238e+03 
              217           218           219           220           221           222 
     1.060725e+03 -2.719691e+02 -1.068270e+03  1.168069e+04 -1.931773e+03  2.120871e+03 
              223           224           225           226           227           228 
    -9.451662e+02 -1.731672e+03  1.093096e+04  1.935616e+03  1.010345e+04 -1.886371e+03 
              229           230           231           232           233           234 
    -1.425538e+03 -1.769389e+03  9.390939e+02  1.743280e+03 -2.697206e+03 -2.694325e+03 
              235           236           237           238           239           240 
    -4.030538e+02  2.976230e+03 -3.518422e+03  1.219776e+03 -7.585957e+02  1.286724e+03 
              241           242           243           244           245           246 
    -3.040720e+03 -3.986926e+03 -1.638960e+03 -5.203500e+02 -1.841944e+03  2.007949e+02 
              247           248           249           250           251           252 
    -2.026262e+03  1.529277e+03 -7.368063e+02 -3.586206e+03  1.761240e+03 -5.072186e+03 
              253           254           255           256           257           258 
     3.184381e+04 -1.538226e+03 -6.906431e+02 -3.763004e+03  6.378562e+01  5.132509e+02 
              259           260           261           262           263           264 
     1.774592e+01 -1.574771e+03  1.557275e+04 -2.641585e+03 -3.067935e+02 -1.693441e+03 
              265           266           267           268           269           270 
    -1.414721e+03 -2.378000e+02 -1.353804e+03 -7.214140e+02 -3.303007e+03 -3.337179e+02 
              271           272           273           274           275           276 
    -9.436807e+01  3.430788e+03 -4.078239e+03 -4.773377e+03 -4.635404e+02 -2.038803e+03 
              277           278           279           280           281           282 
    -2.549417e+03  1.947354e+03 -1.323519e+03 -3.616251e+02 -3.557428e+03 -2.366308e+03 
              283           284           285           286           287           288 
     6.901984e+02 -2.095879e+03 -1.301347e+03 -2.915460e+03  2.198755e+02 -1.506853e+03 
              289           290           291           292           293           294 
    -2.594583e+03 -1.813404e+02 -5.396970e+01  1.381800e+02 -1.746539e+03  2.560773e+02 
              295           296           297           298           299           300 
    -2.769684e+03 -1.131426e+03 -1.435505e+03 -1.981005e+02 -3.252479e+02  1.078284e+04 
              301           302           303           304           305           306 
     7.200703e+02  4.529123e+02  3.268136e+03 -2.591774e+03 -1.979000e+02 -3.284394e+03 
              307           308           309           310           311           312 
    -2.317012e+03  4.849159e+03  3.470706e+03 -4.669075e+02  1.433929e+03  1.048107e+04 
              313           314           315           316           317           318 
     1.646352e+03  5.027116e+03 -8.960255e+02  3.216563e+03  4.286402e+03 -6.322973e+02 
              319           320           321           322           323           324 
     1.600522e+03 -1.223270e+03 -6.803130e+02 -1.098116e+03  5.096576e+03  2.172798e+01 
              325           326           327           328           329           330 
     2.299741e+03  1.647681e+03  2.049175e+03 -5.231735e+03  5.548354e+02  4.391992e+03 
              331           332           333           334           335           336 
    -7.734043e+02 -3.333206e+03 -2.316134e+03 -3.619153e+03 -3.529999e+03 -2.917945e+03 
              337           338           339           340           341           342 
    -2.959103e+03 -2.316114e+03 -1.909953e+03 -6.754531e+02 -2.730874e+03  6.112410e+01 
              343           344           345           346           347           348 
     6.174060e+03 -1.951490e+03 -1.387040e+03 -1.789142e+03  1.398193e+03 -1.656229e+03 
              349           350           351           352           353           354 
     3.189076e+04  3.348647e+03 -1.639626e+03 -1.231528e+03  7.203607e+02  4.278473e+02 
              355           356           357           358           359           360 
    -3.777868e+03 -8.127838e+02  1.550919e+01  6.086582e+02  4.063435e+00 -2.711927e+03 
              361           362           363           364           365           366 
    -6.241171e+02 -1.050281e+03  8.066323e+01 -2.781335e+03  1.379206e+03 -3.589362e+03 
              367           368           369           370           371           372 
    -1.237276e+03  4.216983e+03 -3.361373e+03  1.194211e+03  1.034426e+02  1.231831e+04 
              373           374           375           376           377           378 
     2.480271e+02  2.055586e+03 -3.988632e+02 -1.154752e+02 -4.649775e+03  8.315759e+02 
              379           380           381           382           383           384 
    -2.622121e+02 -2.004217e+03 -1.634808e+03  7.942543e+02 -3.115405e+03 -9.356698e+02 
              385           386           387           388           389           390 
    -4.488500e+02 -1.061424e+03 -4.072833e+03  1.316317e+03 -2.364133e+03 -1.592340e+03 
              391           392           393           394           395           396 
    -1.800004e+03 -2.960748e+03  5.875888e+03  6.122952e+02 -2.168208e+03 -6.641670e+02 
              397           398           399           400           401           402 
    -1.653221e+03  8.179868e+02  2.304648e+03 -5.197536e+03 -7.225504e+02 -5.170806e+02 
              403           404           405           406           407           408 
    -3.381199e+03 -1.777779e+03 -5.567419e+02  6.740089e+02 -1.356813e+03 -1.786761e+03 
              409           410           411           412           413           414 
     1.141149e+02  8.212331e+02 -6.441549e+02  1.647278e+03 -2.003075e+03 -7.153564e+02 
              415           416           417           418           419           420 
     3.306421e+03 -1.522472e+03 -2.044918e+03 -1.659344e+03  3.066314e+02 -3.811467e+03 
              421           422           423           424           425           426 
    -2.446880e+03 -2.164639e+03 -1.468906e+03 -2.334883e+03 -1.426675e+03  2.640560e+03 
              427           428           429           430           431           432 
    -1.303674e+03 -1.746483e+03 -1.829428e+03 -1.631123e+03  9.082367e+02 -2.319353e+02 
              433           434           435           436           437           438 
     1.931662e+04  3.766616e+01  2.357734e+04 -2.011328e+03 -1.937653e+02 -1.689633e+03 
              439           440           441           442           443           444 
    -4.128358e+02 -9.740505e+02 -9.032359e+02 -1.837209e+03 -3.715321e+03  1.482275e+03 
              445           446           447           448           449           450 
    -2.979688e+03 -7.083035e+03 -1.124207e+03 -6.548616e+02 -1.636680e+03 -3.389419e+03 
              451           452           453           454           455           456 
     3.445121e+03 -4.887278e+03 -1.588327e+03 -2.446871e+02  3.131460e+03  1.508302e+03 
              457           458           459           460           461           462 
     1.116258e+04  4.502397e+03 -1.371462e+03  5.601181e+02 -1.003735e+03 -1.027332e+03 
              463           464           465           466           467           468 
    -6.037609e+02  9.105751e+02  3.329571e+02  5.446562e+02 -5.288296e+02 -4.997784e+02 
              469           470           471           472           473           474 
    -2.673157e+03 -1.126777e+03 -3.486144e+03 -9.472847e+02 -2.114971e+03  8.328322e+03 
              475           476           477           478           479           480 
    -1.275475e+03 -1.989159e+03 -1.323176e+03 -6.861395e+02 -3.582749e+02 -3.079534e+03 
              481           482           483           484           485           486 
     1.257472e+03 -3.193842e+03 -1.922389e+03  4.364406e+03  3.113787e+03 -1.582778e+03 
              487           488           489           490           491           492 
     8.548369e+02 -1.678068e+03 -1.697691e+02  1.430674e+03 -2.627454e+03  8.706161e+02 
              493           494           495           496           497           498 
    -1.748228e+03  9.811201e+03 -2.054249e+03 -1.496305e+03 -3.277886e+03 -2.672795e+03 
              499           500           501           502           503           504 
    -4.294038e+03 -1.296338e+03  3.302669e+03 -6.656688e+03  3.740055e+04  1.711980e+03 
              505           506           507           508           509           510 
    -5.572953e+02 -3.275718e+03  4.132534e+03 -1.778057e+03 -8.127717e+02 -1.487356e+03 
              511           512           513           514           515           516 
    -4.791290e+03  4.288669e+02  7.310384e+03  1.300247e+04 -6.851217e+02  9.009098e+02 
              517           518           519           520           521           522 
     3.140283e+03  2.540344e+02 -3.297637e+03 -2.543107e+03  1.161691e+03 -9.942803e+02 
              523           524           525           526           527           528 
     6.507481e+02 -2.075676e+03  5.603911e+03  1.286616e+03  7.201638e+02 -5.941970e+02 
              529           530           531           532           533           534 
     1.860691e+03 -2.638079e+03  1.418327e+02  5.473349e+03  3.396125e+02 -3.780175e+03 
              535           536           537           538           539           540 
    -1.733753e+03 -2.675393e+03  1.441051e+02 -2.414943e+03 -9.352484e+02 -1.580157e+03 
              541           542           543           544           545           546 
     6.362343e+02  1.637331e+02 -1.189926e+03 -1.578506e+03 -1.677223e+03 -1.243157e+03 
              547           548           549           550           551           552 
    -2.273047e+03 -1.546579e+03 -9.529262e+02 -4.217051e+02 -2.577966e+03  5.043123e+03 
              553           554           555           556           557           558 
     5.225302e+03 -3.576056e+03 -1.758324e+03 -3.704676e+03 -1.567516e+03 -1.765965e+03 
              559           560           561           562           563           564 
    -4.585454e+03 -3.487538e+02 -2.469674e+03 -1.821102e+03  1.965195e+04  2.118882e+03 
              565           566           567           568           569           570 
    -1.679638e+03 -3.278000e+03  2.091049e+04 -1.159833e+03 -2.301482e+03 -3.646871e+03 
              571           572           573           574           575           576 
    -2.780325e+03 -1.377802e+03  1.331284e+03 -1.699472e+03  2.738839e+03 -1.419304e+03 
              577           578           579           580           581           582 
    -6.826240e+02  2.614548e+03 -9.857837e+02 -1.287403e+03 -2.022682e+03  2.778391e+03 
              583           584           585           586           587           588 
     6.377789e+04 -4.722351e+03 -2.349319e+03  9.873521e+02 -2.119540e+03 -1.647517e+03 
              589           590           591           592           593           594 
    -2.998707e+03 -2.286915e+03  1.724851e+03  7.072665e+03 -3.007454e+03 -2.805123e+03 
              595           596           597           598           599           600 
    -1.979365e+03 -1.400400e+03 -1.337993e+03  4.333250e+03  5.667799e+02 -2.201969e+03 
              601           602           603           604           605           606 
    -3.761446e+03 -4.041513e+03 -1.341075e+03 -2.257988e+03 -3.310132e+02 -1.144606e+03 
              607           608           609           610           611           612 
    -4.110211e+03 -1.533669e+03 -1.171180e+02 -1.481909e+03 -5.245382e+03 -3.185516e+03 
              613           614           615           616           617           618 
    -4.033032e+03 -2.648257e+03  9.270851e+02 -3.702103e+03  6.697929e+04 -2.856749e+03 
              619           620           621           622           623           624 
    -1.064689e+04 -7.605610e+02 -3.212320e+03 -3.718077e+03  1.259073e+04 -4.497961e+03 
              625           626           627           628           629           630 
    -4.754008e+03  2.863877e+02  1.507882e+03 -1.960068e+03 -3.064422e+03 -2.664640e+03 
              631           632           633           634           635           636 
    -2.325989e+03  7.475669e+03 -5.787009e+03 -2.747017e+03 -2.389725e+03 -6.561563e+02 
              637           638           639           640           641           642 
    -2.556129e+03 -2.634310e+02 -2.667149e+03 -1.122361e+03 -5.532365e+03 -3.428651e+03 
              643           644           645           646           647           648 
    -1.952142e+03 -2.233995e+03  1.026356e+04 -3.633410e+03 -1.013235e+03 -2.555405e+03 
              649           650           651           652           653           654 
    -1.202965e+03  1.392086e+04 -3.113684e+03 -1.161715e+03 -2.265976e+03 -4.164903e+03 
              655           656           657           658           659           660 
     3.591458e+02 -3.901162e+03 -4.232088e+03 -4.360768e+03 -5.673485e+03  2.501525e+02 
              661           662           663           664           665           666 
     8.538795e+02  1.255708e+03 -1.563632e+03  3.250972e+03 -2.260080e+03 -1.193453e+03 
              667           668           669           670           671           672 
    -8.251114e+01  1.532332e+03 -4.150391e+03 -3.641389e+03  3.648257e+04 -2.617576e+03 
              673           674           675           676           677           678 
     8.605728e+02 -2.026969e+03 -2.495674e+03 -1.998908e+03 -1.991714e+03 -6.103137e+03 
              679           680           681           682           683           684 
    -8.722157e+02 -3.102097e+03  1.020454e+04 -1.179663e+03 -3.583469e+03 -1.472030e+03 
              685           686           687           688           689           690 
    -4.455017e+03 -2.692459e+03 -2.314908e+03 -1.024631e+02 -9.831743e+02 -2.226956e+03 
              691           692           693           694           695           696 
    -2.939884e+03 -1.047962e+03 -6.892623e+03  2.610383e+02 -3.215369e+02  1.849723e+05 
              697           698           699           700           701           702 
    -3.841089e+03 -1.622536e+03 -1.421913e+03 -2.469504e+03  8.580021e+02 -2.342681e+03 
              703           704           705           706           707           708 
     2.477467e+02 -2.752641e+03 -3.669565e+03 -2.373788e+03 -5.969495e+03  5.149182e+04 
              709           710           711           712           713           714 
    -2.453220e+03 -4.208936e+03 -1.910043e+03 -6.877655e+02 -1.395383e+03 -3.415869e+03 
              715           716           717           718           719           720 
    -4.611518e+03  4.077905e+02 -1.876264e+03 -2.797584e+03 -4.939361e+03  4.337086e+03 
              721           722           723           724           725           726 
    -4.810160e+02 -2.954218e+03  5.051699e+02 -4.078139e+03 -1.023399e+03 -4.378731e+03 
              727           728           729           730           731           732 
    -1.359982e+03 -2.098171e+03  2.331061e+02  1.736792e+03 -1.309908e+03 -3.286031e+03 
              733           734           735           736           737           738 
     3.783348e+03 -2.364538e+03 -5.345470e+03 -1.026275e+02 -3.076011e+03 -6.428559e+03 
              739           740           741           742           743           744 
    -2.198990e+03 -3.864447e+03  1.343326e+02 -2.582007e+03 -2.153741e+03  1.844588e+04 
              745           746           747           748           749           750 
    -1.942459e+03 -2.865954e+03 -3.992892e+02 -7.899830e+03  1.575845e+04 -1.623267e+03 
              751           752           753           754           755           756 
    -6.784931e+02  2.707255e+03 -2.542708e+03 -1.345635e+03 -1.807041e+03 -1.887836e+03 
              757           758           759           760           761           762 
     4.763399e+02 -4.549039e+03  2.241731e+02 -3.087046e+03 -3.383548e+03 -4.492400e+03 
              763           764           765           766           767           768 
     1.237394e+02 -2.727124e+03 -1.389878e+03 -2.820079e+03  3.609683e+03  5.840877e+01 
              769           770           771           772           773           774 
    -2.000676e+03 -3.140111e+03 -2.527495e+03  2.111048e+03 -1.814089e+03  4.865824e+03 
              775           776           777           778           779           780 
     1.763567e+03 -2.391926e+03  1.003803e+04  1.007312e+04 -9.117985e+02  1.383190e+03 
              781           782           783           784           785           786 
    -1.662252e+03 -9.764024e+02  3.271400e+02 -1.849043e+03 -2.975173e+03 -3.614682e+03 
              787           788           789           790           791           792 
    -1.549936e+03 -4.313854e+03  6.711367e+03 -2.329642e+03 -2.526749e+03 -2.942518e+03 
              793           794           795           796           797           798 
    -1.385525e+03 -3.203281e+03 -3.654629e+03 -2.276913e+03 -5.899876e+02 -4.794086e+02 
              799           800           801           802           803           804 
     2.949327e+03  2.072444e+02 -3.504413e+02 -3.425808e+03 -2.737325e+03  9.208814e+02 
              805           806           807           808           809           810 
    -1.613831e+03 -1.084166e+03  2.043545e+04 -2.536039e+03 -1.312973e+03  9.938984e+03 
              811           812           813           814           815           816 
    -2.985196e+03  2.906631e+03  2.675780e+04 -5.017695e+01  7.234037e+01 -2.233403e+03 
              817           818           819           820           821           822 
    -1.265493e+03 -4.748375e+03 -1.891155e+03  1.300704e+03 -5.089036e+03 -3.019775e+03 
              823           824           825           826           827           828 
    -3.279146e+03 -3.218349e+03  2.837683e+03 -3.359853e+03 -3.341693e+03 -9.759507e+01 
              829           830           831           832           833           834 
    -2.968605e+03  1.190182e+03  5.581931e+03 -4.557707e+03 -3.876025e+03 -2.640027e+02 
              835           836           837           838           839           840 
    -8.514152e+02  5.171180e+03  1.981518e+03 -1.100868e+03 -2.144823e+03 -1.675044e+03 
              841           842           843           844           845           846 
    -1.997380e+03  8.163142e+02 -9.082572e+02 -4.080465e+02 -7.859750e+03 -4.323641e+03 
              847           848           849           850           851           852 
     1.551568e+04 -1.472760e+03  3.778317e+02 -1.568287e+03  4.990186e+02 -5.002465e+03 
              853           854           855           856           857           858 
    -6.039596e+03 -8.955134e+02 -4.601287e+03 -4.191277e+02 -4.643717e+03  2.009469e+03 
              859           860           861           862           863           864 
    -4.197044e+02 -4.879783e+03  1.922765e+03 -1.161413e+03 -2.959788e+03 -3.742381e+03 
              865           866           867           868           869           870 
     1.947016e+03 -3.795190e+02 -2.365965e+03  2.006382e+02 -2.790702e+03 -6.550537e+02 
              871           872           873           874           875           876 
     3.717694e+04 -6.635925e+03  3.048166e+03 -1.784323e+03 -4.268227e+03 -2.729340e+03 
              877           878           879           880           881           882 
    -8.037556e+02 -1.050296e+03 -2.586427e+03  1.381103e+04 -4.759951e+03  3.547483e+03 
              883           884           885           886           887           888 
     9.423488e+03 -1.908883e+03 -7.706420e+02 -2.660968e+03 -3.999299e+02  1.136785e+03 
              889           890           891           892           893           894 
    -3.030161e+03 -8.600580e+02 -1.843826e+03  1.009214e+03 -4.886642e+03  2.786464e+01 
              895           896           897           898           899           900 
     6.015999e+02  4.259174e+02  5.044873e+01  4.507967e+02  1.615314e+02 -4.119238e+03 
              901           902           903           904           905           906 
    -2.047918e+03 -5.006453e+02 -1.554239e+03  4.963690e+03 -2.405173e+03 -1.320244e+03 
              907           908           909           910           911           912 
    -2.803965e+03 -8.746746e+02 -1.717475e+03 -4.280700e+03 -1.993202e+03 -2.855522e+03 
              913           914           915           916           917           918 
    -3.880891e+03 -2.656741e+03 -4.197144e+03 -2.206814e+03  1.187106e+03 -1.773016e+03 
              919           920           921           922           923           924 
    -1.677723e+03 -1.849062e+03  2.092892e+04 -4.905063e+03 -3.209638e+03  3.234919e+03 
              925           926           927           928           929           930 
    -3.807549e+03  8.234934e+03 -2.127124e+03 -7.005411e+03  8.412591e+02 -3.499117e+03 
              931           932           933           934           935           936 
    -1.269854e+02 -1.812915e+03 -2.286146e+03 -1.834119e+02 -1.027882e+03 -3.694779e+03 
              937           938           939           940           941           942 
     8.982078e+02 -1.893593e+03 -3.785550e+03 -3.230075e+03 -3.730296e+03 -4.582909e+03 
              943           944           945           946           947           948 
     2.422943e+03 -3.524632e+03 -2.026465e+03  4.179936e+02  1.391401e+04 -1.762615e+03 
              949           950           951           952           953           954 
    -2.815975e+03  8.984487e+02 -4.704912e+03 -1.797500e+03 -2.432711e+03 -8.546658e+02 
              955           956           957           958           959           960 
     1.776220e+02 -2.241072e+03  1.660168e+03  3.258042e+04 -7.949278e+02 -1.581864e+03 
              961           962           963           964           965           966 
    -4.628746e+02  8.606100e+03  1.017459e+04 -4.205536e+02 -2.545537e+03 -1.224271e+03 
              967           968           969           970           971           972 
     2.916476e+02 -3.023317e+03 -3.048932e+03 -2.029923e+03 -4.668656e+03 -1.467587e+03 
              973           974           975           976           977           978 
     5.092512e+04 -1.049262e+03 -3.193934e+03 -3.659676e+02 -1.118569e+03 -1.684746e+03 
              979           980           981           982           983           984 
     1.799649e+02 -4.263254e+03  4.504360e+04 -2.309487e+03 -1.717602e+03 -6.007329e+03 
              985           986           987           988           989           990 
    -1.187446e+03 -2.502432e+03 -6.616446e+03  1.894328e+03 -1.678245e+03 -1.577296e+03 
              991           992           993           994           995           996 
    -3.071755e+02  1.794509e+00  1.325251e+03 -3.310631e+03  8.766337e+03 -6.376472e+03 
              997           998           999          1000 
     2.126100e+03  1.272558e+03  1.090212e+03  2.620850e+03 
     [ reached getOption("max.print") -- omitted 1099 entries ]

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
#shares_corr_tibble <- as.tibble(shares_corr)
shares_corr_tibble <- bind_cols( var_names = rownames(shares_corr), shares_corr ) 
#call shares_corr_tibble object that has correlations with shares and vars...
shares_corr_tibble
```

    # A tibble: 8 × 2
      var_names              shares
      <chr>                   <dbl>
    1 shares                1      
    2 weekday_is_monday     0.0318 
    3 weekday_is_tuesday    0.0230 
    4 weekday_is_wednesday -0.0273 
    5 weekday_is_thursday  -0.00928
    6 weekday_is_friday    -0.0305 
    7 weekday_is_saturday   0.0132 
    8 weekday_is_sunday     0.00406

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
corr_vars <- as.tibble ( Channel_corr[ ,"shares"] ) %>%
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
     Min.   : 3.000   Min.   :   0.0   Min.   :0.0000   Min.   :0.0000  
     1st Qu.: 8.000   1st Qu.: 315.0   1st Qu.:0.4626   1st Qu.:1.0000  
     Median :10.000   Median : 501.5   Median :0.5178   Median :1.0000  
     Mean   : 9.762   Mean   : 633.3   Mean   :0.5211   Mean   :0.9891  
     3rd Qu.:11.000   3rd Qu.: 801.5   3rd Qu.:0.5886   3rd Qu.:1.0000  
     Max.   :17.000   Max.   :8474.0   Max.   :0.8248   Max.   :1.0000  
     n_non_stop_unique_tokens   num_hrefs      num_self_hrefs      num_imgs      
     Min.   :0.0000           Min.   :  0.00   Min.   : 0.000   Min.   :  0.000  
     1st Qu.:0.6292           1st Qu.:  6.00   1st Qu.: 1.000   1st Qu.:  1.000  
     Median :0.6829           Median : 10.00   Median : 2.000   Median :  1.000  
     Mean   :0.6818           Mean   : 13.61   Mean   : 2.566   Mean   :  5.058  
     3rd Qu.:0.7514           3rd Qu.: 19.00   3rd Qu.: 3.000   3rd Qu.:  8.000  
     Max.   :0.9697           Max.   :145.00   Max.   :27.000   Max.   :111.000  
       num_videos     average_token_length  num_keywords    data_channel_is_lifestyle
     Min.   : 0.000   Min.   :0.000        Min.   : 3.000   Min.   :1                
     1st Qu.: 0.000   1st Qu.:4.449        1st Qu.: 7.000   1st Qu.:1                
     Median : 0.000   Median :4.620        Median : 8.000   Median :1                
     Mean   : 0.485   Mean   :4.584        Mean   : 8.235   Mean   :1                
     3rd Qu.: 0.000   3rd Qu.:4.791        3rd Qu.:10.000   3rd Qu.:1                
     Max.   :50.000   Max.   :5.947        Max.   :10.000   Max.   :1                
     data_channel_is_entertainment data_channel_is_bus data_channel_is_socmed
     Min.   :0                     Min.   :0           Min.   :0             
     1st Qu.:0                     1st Qu.:0           1st Qu.:0             
     Median :0                     Median :0           Median :0             
     Mean   :0                     Mean   :0           Mean   :0             
     3rd Qu.:0                     3rd Qu.:0           3rd Qu.:0             
     Max.   :0                     Max.   :0           Max.   :0             
     data_channel_is_tech data_channel_is_world   kw_min_min       kw_max_min   
     Min.   :0            Min.   :0             Min.   : -1.00   Min.   :    0  
     1st Qu.:0            1st Qu.:0             1st Qu.: -1.00   1st Qu.:  488  
     Median :0            Median :0             Median :  4.00   Median :  803  
     Mean   :0            Mean   :0             Mean   : 41.06   Mean   : 1580  
     3rd Qu.:0            3rd Qu.:0             3rd Qu.:  4.00   3rd Qu.: 1300  
     Max.   :0            Max.   :0             Max.   :377.00   Max.   :80400  
       kw_avg_min        kw_min_max       kw_max_max       kw_avg_max       kw_min_avg  
     Min.   :   -1.0   Min.   :     0   Min.   :     0   Min.   :     0   Min.   :   0  
     1st Qu.:  185.5   1st Qu.:     0   1st Qu.:690400   1st Qu.:118866   1st Qu.:   0  
     Median :  296.3   Median :     0   Median :843300   Median :182440   Median :   0  
     Mean   :  408.7   Mean   :  7057   Mean   :705830   Mean   :183327   Mean   :1052  
     3rd Qu.:  444.9   3rd Qu.:  6300   3rd Qu.:843300   3rd Qu.:248253   3rd Qu.:2264  
     Max.   :13744.8   Max.   :208300   Max.   :843300   Max.   :491771   Max.   :3594  
       kw_max_avg      kw_avg_avg    self_reference_min_shares self_reference_max_shares
     Min.   :    0   Min.   :    0   Min.   :     0.0          Min.   :     0           
     1st Qu.: 4061   1st Qu.: 2638   1st Qu.:   648.8          1st Qu.:  1000           
     Median : 5034   Median : 3227   Median :  1700.0          Median :  2800           
     Mean   : 6583   Mean   : 3401   Mean   :  4440.8          Mean   :  8445           
     3rd Qu.: 7303   3rd Qu.: 3953   3rd Qu.:  3600.0          3rd Qu.:  6800           
     Max.   :95422   Max.   :20378   Max.   :138700.0          Max.   :690400           
     self_reference_avg_sharess weekday_is_monday weekday_is_tuesday weekday_is_wednesday
     Min.   :     0.0           Min.   :0.0000    Min.   :0.000      Min.   :0.0000      
     1st Qu.:   996.8           1st Qu.:0.0000    1st Qu.:0.000      1st Qu.:0.0000      
     Median :  2485.1           Median :0.0000    Median :0.000      Median :0.0000      
     Mean   :  6136.0           Mean   :0.1508    Mean   :0.163      Mean   :0.1882      
     3rd Qu.:  5400.4           3rd Qu.:0.0000    3rd Qu.:0.000      3rd Qu.:0.0000      
     Max.   :401450.0           Max.   :1.0000    Max.   :1.000      Max.   :1.0000      
     weekday_is_thursday weekday_is_friday weekday_is_saturday weekday_is_sunday
     Min.   :0.0000      Min.   :0.0000    Min.   :0.0000      Min.   :0.0000   
     1st Qu.:0.0000      1st Qu.:0.0000    1st Qu.:0.0000      1st Qu.:0.0000   
     Median :0.0000      Median :0.0000    Median :0.0000      Median :0.0000   
     Mean   :0.1651      Mean   :0.1433    Mean   :0.0856      Mean   :0.1039   
     3rd Qu.:0.0000      3rd Qu.:0.0000    3rd Qu.:0.0000      3rd Qu.:0.0000   
     Max.   :1.0000      Max.   :1.0000    Max.   :1.0000      Max.   :1.0000   
       is_weekend         LDA_00            LDA_01            LDA_02       
     Min.   :0.0000   Min.   :0.01818   Min.   :0.01819   Min.   :0.01819  
     1st Qu.:0.0000   1st Qu.:0.02250   1st Qu.:0.02222   1st Qu.:0.02222  
     Median :0.0000   Median :0.02913   Median :0.02507   Median :0.02523  
     Mean   :0.1895   Mean   :0.17892   Mean   :0.06751   Mean   :0.07769  
     3rd Qu.:0.0000   3rd Qu.:0.25060   3rd Qu.:0.04001   3rd Qu.:0.06667  
     Max.   :1.0000   Max.   :0.91980   Max.   :0.68825   Max.   :0.67623  
         LDA_03            LDA_04        global_subjectivity global_sentiment_polarity
     Min.   :0.01820   Min.   :0.02014   Min.   :0.0000      Min.   :-0.30000         
     1st Qu.:0.02260   1st Qu.:0.32329   1st Qu.:0.4265      1st Qu.: 0.09929         
     Median :0.02925   Median :0.56851   Median :0.4780      Median : 0.15023         
     Mean   :0.14188   Mean   :0.53400   Mean   :0.4734      Mean   : 0.15143         
     3rd Qu.:0.19724   3rd Qu.:0.79956   3rd Qu.:0.5273      3rd Qu.: 0.20511         
     Max.   :0.91892   Max.   :0.92707   Max.   :0.7778      Max.   : 0.51389         
     global_rate_positive_words global_rate_negative_words rate_positive_words
     Min.   :0.00000            Min.   :0.00000            Min.   :0.0000     
     1st Qu.:0.03493            1st Qu.:0.01025            1st Qu.:0.6667     
     Median :0.04424            Median :0.01521            Median :0.7399     
     Mean   :0.04457            Mean   :0.01632            Mean   :0.7235     
     3rd Qu.:0.05378            3rd Qu.:0.02094            3rd Qu.:0.8125     
     Max.   :0.10791            Max.   :0.06180            Max.   :1.0000     
     rate_negative_words avg_positive_polarity min_positive_polarity
     Min.   :0.0000      Min.   :0.0000        Min.   :0.00000      
     1st Qu.:0.1852      1st Qu.:0.3358        1st Qu.:0.05000      
     Median :0.2560      Median :0.3836        Median :0.10000      
     Mean   :0.2657      Mean   :0.3824        Mean   :0.09207      
     3rd Qu.:0.3333      3rd Qu.:0.4335        3rd Qu.:0.10000      
     Max.   :1.0000      Max.   :0.7553        Max.   :0.50000      
     max_positive_polarity avg_negative_polarity min_negative_polarity
     Min.   :0.0000        Min.   :-1.0000       Min.   :-1.0000      
     1st Qu.:0.7000        1st Qu.:-0.3250       1st Qu.:-0.7143      
     Median :0.9000        Median :-0.2625       Median :-0.5000      
     Mean   :0.8297        Mean   :-0.2671       Mean   :-0.5633      
     3rd Qu.:1.0000        3rd Qu.:-0.2039       3rd Qu.:-0.4000      
     Max.   :1.0000        Max.   : 0.0000       Max.   : 0.0000      
     max_negative_polarity title_subjectivity title_sentiment_polarity
     Min.   :-1.0000       Min.   :0.0000     Min.   :-1.0000         
     1st Qu.:-0.1250       1st Qu.:0.0000     1st Qu.: 0.0000         
     Median :-0.1000       Median :0.1389     Median : 0.0000         
     Mean   :-0.1046       Mean   :0.2928     Mean   : 0.1101         
     3rd Qu.:-0.0500       3rd Qu.:0.5000     3rd Qu.: 0.2143         
     Max.   : 0.0000       Max.   :1.0000     Max.   : 1.0000         
     abs_title_subjectivity abs_title_sentiment_polarity     shares      
     Min.   :0.0000         Min.   :0.0000               Min.   :    78  
     1st Qu.:0.1667         1st Qu.:0.0000               1st Qu.:  1100  
     Median :0.5000         Median :0.0000               Median :  1700  
     Mean   :0.3438         Mean   :0.1803               Mean   :  3737  
     3rd Qu.:0.5000         3rd Qu.:0.3000               3rd Qu.:  3225  
     Max.   :0.5000         Max.   :1.0000               Max.   :208300  

``` r
#check structure of objects
str(ChannelTrain)
```

    tibble [1,472 × 59] (S3: tbl_df/tbl/data.frame)
     $ n_tokens_title               : num [1:1472] 10 11 10 6 11 7 11 9 10 7 ...
     $ n_tokens_content             : num [1:1472] 187 315 1190 374 223 ...
     $ n_unique_tokens              : num [1:1472] 0.667 0.551 0.409 0.641 0.662 ...
     $ n_non_stop_words             : num [1:1472] 1 1 1 1 1 ...
     $ n_non_stop_unique_tokens     : num [1:1472] 0.8 0.702 0.561 0.828 0.826 ...
     $ num_hrefs                    : num [1:1472] 7 4 25 7 5 24 28 10 2 9 ...
     $ num_self_hrefs               : num [1:1472] 0 4 24 0 3 23 24 5 1 6 ...
     $ num_imgs                     : num [1:1472] 1 1 20 1 0 20 20 1 11 1 ...
     $ num_videos                   : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ average_token_length         : num [1:1472] 4.66 4.38 4.62 4.91 4.55 ...
     $ num_keywords                 : num [1:1472] 7 10 8 8 6 10 10 9 9 10 ...
     $ data_channel_is_lifestyle    : num [1:1472] 1 1 1 1 1 1 1 1 1 1 ...
     $ data_channel_is_entertainment: num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_bus          : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_socmed       : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_tech         : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_world        : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_min_min                   : num [1:1472] 0 0 0 0 217 217 217 217 217 217 ...
     $ kw_max_min                   : num [1:1472] 0 0 0 0 1900 2600 823 2600 695 2600 ...
     $ kw_avg_min                   : num [1:1472] 0 0 0 0 748 ...
     $ kw_min_max                   : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_max_max                   : num [1:1472] 0 0 0 0 17100 17100 17100 17100 17100 17100 ...
     $ kw_avg_max                   : num [1:1472] 0 0 0 0 4517 ...
     $ kw_min_avg                   : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_max_avg                   : num [1:1472] 0 0 0 0 1953 ...
     $ kw_avg_avg                   : num [1:1472] 0 0 0 0 1207 ...
     $ self_reference_min_shares    : num [1:1472] 0 6200 545 0 6700 543 545 2000 0 1100 ...
     $ self_reference_max_shares    : num [1:1472] 0 6200 16000 0 16700 16000 16000 4900 0 6000 ...
     $ self_reference_avg_sharess   : num [1:1472] 0 6200 3151 0 11700 ...
     $ weekday_is_monday            : num [1:1472] 1 1 1 1 0 0 0 0 0 0 ...
     $ weekday_is_tuesday           : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_wednesday         : num [1:1472] 0 0 0 0 1 1 1 1 1 1 ...
     $ weekday_is_thursday          : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_friday            : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_saturday          : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_sunday            : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ is_weekend                   : num [1:1472] 0 0 0 0 0 0 0 0 0 0 ...
     $ LDA_00                       : num [1:1472] 0.0286 0.0201 0.025 0.2066 0.0335 ...
     $ LDA_01                       : num [1:1472] 0.0286 0.0206 0.1595 0.1461 0.217 ...
     $ LDA_02                       : num [1:1472] 0.0286 0.0205 0.025 0.276 0.0334 ...
     $ LDA_03                       : num [1:1472] 0.0287 0.1208 0.025 0.0251 0.0335 ...
     $ LDA_04                       : num [1:1472] 0.885 0.818 0.765 0.346 0.683 ...
     $ global_subjectivity          : num [1:1472] 0.477 0.554 0.507 0.399 0.372 ...
     $ global_sentiment_polarity    : num [1:1472] 0.15 0.177 0.244 0.122 0.103 ...
     $ global_rate_positive_words   : num [1:1472] 0.0267 0.0349 0.0639 0.0374 0.0493 ...
     $ global_rate_negative_words   : num [1:1472] 0.0107 0.0127 0.0151 0.0187 0.0179 ...
     $ rate_positive_words          : num [1:1472] 0.714 0.733 0.809 0.667 0.733 ...
     $ rate_negative_words          : num [1:1472] 0.286 0.267 0.191 0.333 0.267 ...
     $ avg_positive_polarity        : num [1:1472] 0.435 0.401 0.403 0.361 0.255 ...
     $ min_positive_polarity        : num [1:1472] 0.2 0.1364 0.0333 0.1 0.1 ...
     $ max_positive_polarity        : num [1:1472] 0.7 0.5 1 0.8 0.5 1 1 0.8 0.6 0.6 ...
     $ avg_negative_polarity        : num [1:1472] -0.263 -0.32 -0.236 -0.13 -0.188 ...
     $ min_negative_polarity        : num [1:1472] -0.4 -0.5 -0.5 -0.2 -0.4 ...
     $ max_negative_polarity        : num [1:1472] -0.125 -0.125 -0.05 -0.05 -0.1 ...
     $ title_subjectivity           : num [1:1472] 0 0.55 0 0 0 ...
     $ title_sentiment_polarity     : num [1:1472] 0 0.35 0 0 0 ...
     $ abs_title_subjectivity       : num [1:1472] 0.5 0.05 0.5 0.5 0.5 ...
     $ abs_title_sentiment_polarity : num [1:1472] 0 0.35 0 0 0 ...
     $ shares                       : num [1:1472] 1900 343 507 552 1900 1100 1200 2300 752 1000 ...

``` r
str(Lifestlye_sumstats_Train)
```

     'table' chr [1:6, 1:59] "Min.   : 3.000  " "1st Qu.: 8.000  " "Median :10.000  " ...
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
    9.076276e+03 3.142305e-03 3.179992e+03 

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
    9.112152e+03 3.521337e-04 3.195064e+03 

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
    9.117765e+03 1.461214e-03 3.157174e+03 

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

boosted <- train(shares ~ num_hrefs + weekday_is_monday + weekday_is_tuesday + weekday_is_wednesday + weekday_is_thursday + weekday_is_friday + self_reference_avg_sharess, 
data = ChannelTrain, method = "gbm",
 trControl=trainControl(method = "cv", number = 5),
 preProcess = c("center", "scale"),
 tuneGrid = expand.grid(n.trees = tune1, interaction.depth = tune2, shrinkage = tune3,    n.minobsinnode = tune4))
```

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 90156553.6493             nan     0.1000 58076.1335
         2 90045785.4075             nan     0.1000 11845.2508
         3 89773116.0577             nan     0.1000 47212.8242
         4 89629194.7071             nan     0.1000 41207.8332
         5 89402141.0909             nan     0.1000 23703.8565
         6 89352350.2116             nan     0.1000 13024.6973
         7 89144178.1779             nan     0.1000 -335842.9741
         8 89105215.5835             nan     0.1000 -10414.3298
         9 88975588.9952             nan     0.1000 -217232.6993
        10 88873818.3879             nan     0.1000 -20897.5820
        20 88393956.6243             nan     0.1000 -31326.6841
        40 87904025.3363             nan     0.1000 -51214.7691
        60 87525522.9680             nan     0.1000 -95377.4760
        80 87117838.7301             nan     0.1000 -54722.3376
       100 87031247.5468             nan     0.1000 -214571.1079
       120 86681450.2013             nan     0.1000 -153890.8162
       140 86510239.9130             nan     0.1000 -90818.8148
       160 86235019.7558             nan     0.1000 -14288.9404
       180 86062525.9384             nan     0.1000 -64136.8614
       200 85913731.0103             nan     0.1000 -103949.8273

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 90078396.6187             nan     0.1000 230085.5683
         2 89988319.7472             nan     0.1000 54422.2507
         3 89891672.0903             nan     0.1000 -188799.3632
         4 89550540.6720             nan     0.1000 12348.0148
         5 89195588.2965             nan     0.1000 27571.8474
         6 88871339.2739             nan     0.1000 -83625.9547
         7 88737870.5863             nan     0.1000 91258.2006
         8 88663879.0163             nan     0.1000 9877.5926
         9 88504170.6083             nan     0.1000 -7541.2365
        10 88253407.2723             nan     0.1000 19218.9627
        20 86802338.6665             nan     0.1000 -160088.0071
        40 85437087.8345             nan     0.1000 -257297.0744
        60 84542095.3094             nan     0.1000 -110857.0441
        80 83166195.5336             nan     0.1000 -141375.5102
       100 82357759.4980             nan     0.1000 -77994.5142
       120 81844014.9664             nan     0.1000 -293458.3116
       140 81010548.5841             nan     0.1000 -74320.5632
       160 80510015.2696             nan     0.1000 -40141.1463
       180 79982853.5345             nan     0.1000 -303384.8232
       200 79581049.7274             nan     0.1000 -147549.1258

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 90138260.2550             nan     0.1000 -73932.8715
         2 89318108.0474             nan     0.1000 -76444.4076
         3 88741420.3886             nan     0.1000 -8309.6345
         4 88530064.7200             nan     0.1000 -148382.1653
         5 87925238.6500             nan     0.1000 -175312.2482
         6 87528147.6982             nan     0.1000 -268740.8472
         7 87180943.0980             nan     0.1000 -192107.2295
         8 87018638.5023             nan     0.1000 49344.4393
         9 86868133.7846             nan     0.1000 -76453.2006
        10 86301280.1712             nan     0.1000 -313414.5376
        20 84317368.1808             nan     0.1000 -154161.6463
        40 82098066.7848             nan     0.1000 -140881.3523
        60 80168694.6012             nan     0.1000 -113908.6596
        80 78457821.7825             nan     0.1000 -196042.1144
       100 76834625.4420             nan     0.1000 -373414.8911
       120 75944965.3802             nan     0.1000 -218749.1012
       140 74566939.3838             nan     0.1000 -189307.9831
       160 73462184.6277             nan     0.1000 -136535.2846
       180 72586038.8876             nan     0.1000 -284130.5380
       200 71912814.9012             nan     0.1000 -170501.2445

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 90123916.9174             nan     0.1000 243124.0209
         2 89232550.3572             nan     0.1000 -162452.6881
         3 88802228.1289             nan     0.1000 -15786.1273
         4 88585651.6395             nan     0.1000 -120777.6593
         5 87919049.8772             nan     0.1000 -250891.2830
         6 87511884.4945             nan     0.1000 -92896.5576
         7 87081453.0616             nan     0.1000 -116595.9776
         8 86987213.8273             nan     0.1000 -172056.9676
         9 86271749.5291             nan     0.1000 -409371.8482
        10 85930063.1898             nan     0.1000 -242459.0078
        20 82965537.5592             nan     0.1000 -443768.1720
        40 79548957.8710             nan     0.1000 -325273.9830
        60 76612161.0238             nan     0.1000 -154656.6301
        80 74556232.4085             nan     0.1000 -269517.0035
       100 73050165.8075             nan     0.1000 -424024.5278
       120 71424130.3793             nan     0.1000 -260135.2880
       140 69570481.5605             nan     0.1000 -548826.5298
       160 68015516.8716             nan     0.1000 -679923.4592
       180 66550138.1112             nan     0.1000 -305764.9630
       200 65338589.7007             nan     0.1000 -258483.6651

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 84922731.8039             nan     0.1000 -17087.0037
         2 84796911.5115             nan     0.1000 -61509.7665
         3 84720831.8117             nan     0.1000 -31063.3679
         4 84611503.6173             nan     0.1000 -21412.3064
         5 84460631.2709             nan     0.1000 -12760.9631
         6 84353925.8098             nan     0.1000 -55320.4732
         7 84285315.1471             nan     0.1000 39211.3891
         8 84196758.0194             nan     0.1000 -32047.5934
         9 84094306.4510             nan     0.1000 27948.7802
        10 84028140.9302             nan     0.1000 -32238.8856
        20 83553019.9630             nan     0.1000 -25661.4812
        40 83143987.5726             nan     0.1000 -19753.4161
        60 82730108.2273             nan     0.1000  130.9823
        80 82535013.8048             nan     0.1000 -162146.1928
       100 82437372.1972             nan     0.1000 -78322.0395
       120 82291349.8671             nan     0.1000 -122312.4740
       140 82140343.7735             nan     0.1000 -60966.5367
       160 81939216.5155             nan     0.1000 -71138.3423
       180 81737758.6389             nan     0.1000 -97911.2503
       200 81554955.2126             nan     0.1000 -127573.4130

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 84896838.0526             nan     0.1000 18705.2270
         2 84419158.9678             nan     0.1000 -151282.0305
         3 84244719.2911             nan     0.1000 -53387.0917
         4 84130706.1310             nan     0.1000 -55016.6977
         5 84047534.3335             nan     0.1000 42248.3932
         6 83942682.4353             nan     0.1000 -47192.5958
         7 83822749.1791             nan     0.1000 -101107.1171
         8 83359137.2784             nan     0.1000 -264588.4947
         9 83182788.7083             nan     0.1000 -26227.1977
        10 83089510.2999             nan     0.1000 9894.0234
        20 81816180.5231             nan     0.1000 -169984.6153
        40 80162355.7058             nan     0.1000 -437196.7939
        60 79122533.1927             nan     0.1000 -60478.6864
        80 78303094.3427             nan     0.1000 -196717.4660
       100 77851660.0182             nan     0.1000 -311348.2293
       120 77185376.5761             nan     0.1000 -49648.2778
       140 76582556.8334             nan     0.1000 -92989.1619
       160 76070960.1956             nan     0.1000 -93798.3689
       180 75508207.7768             nan     0.1000 -366659.0531
       200 75041823.5877             nan     0.1000 -73085.3678

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 84087059.9383             nan     0.1000 -161929.6026
         2 83890251.0123             nan     0.1000 -114071.4277
         3 83520193.0136             nan     0.1000 -249670.5785
         4 83142403.0632             nan     0.1000 -100472.2335
         5 83012905.3175             nan     0.1000 -83853.2603
         6 82526093.9573             nan     0.1000 -199950.3809
         7 82197444.2634             nan     0.1000 -222202.9156
         8 81985470.0711             nan     0.1000 -49540.9661
         9 81837535.7533             nan     0.1000 -39216.5072
        10 81746105.2265             nan     0.1000 -199390.7979
        20 79743755.2425             nan     0.1000 -201958.7899
        40 76650735.9124             nan     0.1000 -384593.2936
        60 75466968.0929             nan     0.1000 -151573.5726
        80 74144662.2535             nan     0.1000 -153669.1541
       100 73288225.0531             nan     0.1000 -281813.4130
       120 72622197.0557             nan     0.1000 -219635.6648
       140 70951869.4035             nan     0.1000 -733628.2400
       160 69409669.3344             nan     0.1000 -304260.3910
       180 68568987.1831             nan     0.1000 -218979.0958
       200 67560899.1575             nan     0.1000 -175673.7973

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 84834238.5312             nan     0.1000 76982.5613
         2 84456185.1190             nan     0.1000 -8964.2285
         3 83951586.8788             nan     0.1000 -336553.4483
         4 83842583.8660             nan     0.1000 -45766.6584
         5 83142425.3169             nan     0.1000 -156406.5195
         6 82910640.2114             nan     0.1000 -146021.8855
         7 82093171.6537             nan     0.1000 -192345.4828
         8 81575174.4052             nan     0.1000 -240437.1878
         9 81175388.8385             nan     0.1000 -344987.7780
        10 81066450.9978             nan     0.1000 -112958.1530
        20 78638877.8967             nan     0.1000 -80726.4904
        40 75739262.1344             nan     0.1000 -133548.2884
        60 72698527.3392             nan     0.1000 -244853.2955
        80 71140535.6952             nan     0.1000 -273383.9666
       100 69554344.5773             nan     0.1000 -208427.7215
       120 67499620.6239             nan     0.1000 -113017.6685
       140 66243235.4818             nan     0.1000 -425034.2991
       160 65431743.7124             nan     0.1000 -625691.7801
       180 63875599.9150             nan     0.1000 -266695.6252
       200 62982471.9020             nan     0.1000 -168009.8598

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 50586454.0445             nan     0.1000 222074.8055
         2 50373769.3549             nan     0.1000 182869.7830
         3 50257398.3618             nan     0.1000 59982.3439
         4 50022836.4961             nan     0.1000 114055.9215
         5 49908180.4974             nan     0.1000 73785.6914
         6 49822256.9703             nan     0.1000 65763.5660
         7 49774760.0657             nan     0.1000 6584.6343
         8 49649512.7943             nan     0.1000 4701.5653
         9 49453328.5045             nan     0.1000 73025.9281
        10 49390766.5333             nan     0.1000 -15004.4857
        20 48801287.3592             nan     0.1000 -121120.5783
        40 48351932.5879             nan     0.1000 -51567.8434
        60 47963942.0001             nan     0.1000 -71255.4683
        80 47646529.0870             nan     0.1000 -29097.0845
       100 47419554.9693             nan     0.1000 -137900.5282
       120 47190278.4552             nan     0.1000 -21926.6220
       140 46969350.3914             nan     0.1000 -90602.1869
       160 46827851.1580             nan     0.1000 -30403.8082
       180 46669628.5692             nan     0.1000 -250832.3558
       200 46472669.2077             nan     0.1000 -85308.4642

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 50710088.0986             nan     0.1000 -18877.0843
         2 50518184.0774             nan     0.1000 -44078.9881
         3 50129077.4361             nan     0.1000 274119.7520
         4 49726774.6759             nan     0.1000 -44349.8348
         5 49523231.2951             nan     0.1000 111451.3101
         6 49487138.3361             nan     0.1000 -24025.4562
         7 49280318.1944             nan     0.1000 61623.8366
         8 49171596.7978             nan     0.1000 4233.2026
         9 49040254.1995             nan     0.1000 -21307.3557
        10 48898716.8670             nan     0.1000 -44169.5908
        20 48100935.8559             nan     0.1000 -63318.3072
        40 46916405.3956             nan     0.1000 -96515.4730
        60 45974242.7238             nan     0.1000 -117106.6075
        80 45025501.2961             nan     0.1000 -50670.9857
       100 44452974.7906             nan     0.1000 -130870.1722
       120 43863662.2740             nan     0.1000 -184250.5424
       140 43319984.2183             nan     0.1000 -48129.8984
       160 42867787.9389             nan     0.1000 -93500.9113
       180 42624311.8832             nan     0.1000 -111330.8169
       200 41925600.6104             nan     0.1000 -188563.1922

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 50196795.5561             nan     0.1000 -27441.3997
         2 49986179.7981             nan     0.1000 -1322.5352
         3 49784443.3332             nan     0.1000 -16640.2813
         4 49372558.6024             nan     0.1000 118678.6796
         5 49393588.4576             nan     0.1000 -142478.6207
         6 48945312.9704             nan     0.1000 -45932.0618
         7 48609730.7459             nan     0.1000 20411.2767
         8 48327179.1961             nan     0.1000 -20763.0469
         9 48216711.0762             nan     0.1000 -117911.8372
        10 48063147.7023             nan     0.1000 -178468.9852
        20 46959852.6848             nan     0.1000 -142614.0518
        40 45289391.2509             nan     0.1000 -146281.9147
        60 43768724.7850             nan     0.1000 -102026.6851
        80 42714448.1871             nan     0.1000 -101631.7318
       100 41825702.9258             nan     0.1000 -90592.9928
       120 41160512.2214             nan     0.1000 -111130.9839
       140 40309063.4074             nan     0.1000 -23834.4752
       160 39667754.2886             nan     0.1000 -195839.5259
       180 38988482.7459             nan     0.1000 -241668.2821
       200 38601371.2866             nan     0.1000 -78077.6061

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 50207176.7310             nan     0.1000 -11269.2894
         2 49606033.1690             nan     0.1000 138359.4017
         3 49186292.1269             nan     0.1000 -2225.4038
         4 48806937.0595             nan     0.1000 -76047.4066
         5 48705022.2902             nan     0.1000 -91013.9398
         6 48270585.6174             nan     0.1000 -101850.6589
         7 47912794.7579             nan     0.1000 -86891.5062
         8 47870065.5899             nan     0.1000 -109797.7653
         9 47513547.1246             nan     0.1000 -90081.4454
        10 47426939.9916             nan     0.1000 -76721.4898
        20 45884204.1050             nan     0.1000 -99694.6182
        40 43922538.8824             nan     0.1000 -350519.4816
        60 42653305.9598             nan     0.1000 -225748.6815
        80 41440129.6010             nan     0.1000 -267589.1658
       100 40033445.3973             nan     0.1000 -269375.7106
       120 38896140.2449             nan     0.1000 -356926.9736
       140 37835540.1042             nan     0.1000 -163685.8756
       160 36919650.6063             nan     0.1000 -224623.5235
       180 35638058.9937             nan     0.1000 -186965.2509
       200 34964900.2111             nan     0.1000 -177494.3367

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 72845975.7035             nan     0.1000 62748.1592
         2 72652190.1462             nan     0.1000 21688.9150
         3 72509788.8386             nan     0.1000 94246.8603
         4 72150967.5856             nan     0.1000 21980.6870
         5 72029827.4280             nan     0.1000 -72113.4570
         6 71930999.5566             nan     0.1000 58662.4283
         7 71829547.0765             nan     0.1000 -40929.2019
         8 71782303.4987             nan     0.1000 -28320.6099
         9 71737371.2757             nan     0.1000 -20646.2557
        10 71599932.5850             nan     0.1000 37499.2428
        20 70958140.1647             nan     0.1000 -119257.5628
        40 70337751.8092             nan     0.1000 -53092.3897
        60 70084271.3127             nan     0.1000 -137764.0363
        80 70001428.9825             nan     0.1000 -49198.2557
       100 69747780.0893             nan     0.1000 -151723.0769
       120 69514396.0014             nan     0.1000 -73465.8103
       140 69277944.1239             nan     0.1000 -38828.2714
       160 69114880.3378             nan     0.1000 -121458.1710
       180 68972151.6003             nan     0.1000 -63722.3550
       200 68823753.3956             nan     0.1000 -160585.2603

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 72698021.9868             nan     0.1000 120908.1542
         2 72266607.9849             nan     0.1000 10933.1003
         3 71815307.8314             nan     0.1000 -120722.6401
         4 71610600.9844             nan     0.1000 133783.1358
         5 71118177.6700             nan     0.1000 -56806.1252
         6 70896262.8274             nan     0.1000 23578.0256
         7 70607626.5053             nan     0.1000 -172266.5135
         8 70487649.0555             nan     0.1000 -51831.9825
         9 70298773.0071             nan     0.1000 63891.7608
        10 70217431.5214             nan     0.1000 -52746.8749
        20 69420097.0808             nan     0.1000 -115361.2141
        40 68278630.1534             nan     0.1000 -34721.6532
        60 67212446.0623             nan     0.1000 -114017.5404
        80 66673868.5533             nan     0.1000 -429905.4311
       100 66303227.5598             nan     0.1000 -35251.0928
       120 65505018.9732             nan     0.1000 -58010.0531
       140 64843908.4403             nan     0.1000 -285367.1537
       160 64513839.0180             nan     0.1000 -64595.3630
       180 64066082.3755             nan     0.1000 -71540.1118
       200 63356463.4026             nan     0.1000 -89358.3904

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 72083472.5113             nan     0.1000 -82307.4959
         2 71808698.5601             nan     0.1000 160772.2526
         3 71079260.7413             nan     0.1000 4047.4447
         4 70835938.0240             nan     0.1000 130568.5170
         5 70501873.0084             nan     0.1000 -127620.4392
         6 70210476.0079             nan     0.1000 -147463.4103
         7 70106783.9506             nan     0.1000 -160735.7002
         8 69835986.8554             nan     0.1000 -123365.3084
         9 69392965.9135             nan     0.1000 -210942.2951
        10 69225879.0599             nan     0.1000 -631087.3148
        20 67259757.5218             nan     0.1000 -280846.9817
        40 65606415.7217             nan     0.1000 -191584.9793
        60 63601411.7227             nan     0.1000 -380854.0925
        80 62481960.8249             nan     0.1000 -129546.4154
       100 61814610.6730             nan     0.1000 -144634.0449
       120 60873751.5138             nan     0.1000 -147450.7263
       140 59917694.1681             nan     0.1000 -593567.9924
       160 59057802.2204             nan     0.1000 -298395.4724
       180 57778141.5882             nan     0.1000 -392029.7266
       200 57297517.5650             nan     0.1000 -200196.8407

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 72411239.9180             nan     0.1000 -59094.3153
         2 71942337.3054             nan     0.1000 -92906.4288
         3 71485141.3259             nan     0.1000 23618.9799
         4 71068001.0456             nan     0.1000 -148722.4389
         5 70432020.8877             nan     0.1000 -124968.0493
         6 69810783.7309             nan     0.1000 -14101.0992
         7 69650233.4114             nan     0.1000 -140759.9500
         8 69500673.3542             nan     0.1000 -23769.0527
         9 69368736.6344             nan     0.1000 -15476.4338
        10 68857750.9890             nan     0.1000 -503690.5004
        20 66989329.6476             nan     0.1000 -488429.1654
        40 63910722.2209             nan     0.1000 -352937.7326
        60 62295061.4394             nan     0.1000 -364363.7507
        80 60295226.1767             nan     0.1000 -215434.4801
       100 57762338.7416             nan     0.1000 -90774.9065
       120 56565237.8282             nan     0.1000 -122355.9293
       140 55659460.8253             nan     0.1000 -131710.2214
       160 55310686.7321             nan     0.1000 -184263.5732
       180 53844295.9206             nan     0.1000 -271439.8605
       200 51887160.1149             nan     0.1000 -145018.7906

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 87097853.2030             nan     0.1000 35580.4040
         2 87051518.6040             nan     0.1000 -69442.3027
         3 86954855.8247             nan     0.1000 -82238.1227
         4 86797429.7295             nan     0.1000 73913.1084
         5 86712098.4486             nan     0.1000 80352.2748
         6 86681663.9523             nan     0.1000 -21261.1035
         7 86611231.1506             nan     0.1000 -74670.7080
         8 86477250.4343             nan     0.1000 -51261.4765
         9 86389816.1129             nan     0.1000 -9347.3065
        10 86370055.1283             nan     0.1000 -179213.4012
        20 85912559.1608             nan     0.1000 -3157.9402
        40 85401373.7039             nan     0.1000 -188113.0424
        60 85145973.6108             nan     0.1000 -84859.1817
        80 84783040.7258             nan     0.1000 -59572.3297
       100 84586233.7405             nan     0.1000 -105627.3304
       120 84386671.2945             nan     0.1000 -22114.5677
       140 84296098.3972             nan     0.1000 -84650.4679
       160 84055165.9323             nan     0.1000 -123015.0241
       180 83848401.5840             nan     0.1000 -93039.6836
       200 83693717.9983             nan     0.1000 -15694.1152

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 86972253.1744             nan     0.1000 -54933.9132
         2 86706904.1200             nan     0.1000 54631.1006
         3 86486485.5575             nan     0.1000 47419.2144
         4 86251016.3172             nan     0.1000 26684.4004
         5 86066308.7708             nan     0.1000 -116091.8731
         6 86026116.0182             nan     0.1000 -7459.1551
         7 85887939.9578             nan     0.1000 -144237.9867
         8 85442360.1600             nan     0.1000 10686.9302
         9 85148909.8037             nan     0.1000 -23208.0248
        10 84925315.0418             nan     0.1000 -95147.0618
        20 83848092.2690             nan     0.1000 -27751.0845
        40 82389249.9016             nan     0.1000 -71024.0806
        60 81376476.5103             nan     0.1000 -30573.9997
        80 80290439.5191             nan     0.1000 -154626.0685
       100 79808341.4650             nan     0.1000 -188623.2490
       120 78935646.2896             nan     0.1000 -80147.3275
       140 78415050.9115             nan     0.1000 -178755.9044
       160 78144996.4324             nan     0.1000 -129790.9813
       180 77654157.6148             nan     0.1000 -155282.5588
       200 77020221.2356             nan     0.1000 -27860.6643

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 86727434.5021             nan     0.1000 191232.9997
         2 86059145.7488             nan     0.1000 -58247.8418
         3 85790082.3428             nan     0.1000 29790.1660
         4 85354369.7181             nan     0.1000 -285877.1841
         5 85004965.9523             nan     0.1000 -167001.6167
         6 84881056.0210             nan     0.1000 -50391.0088
         7 84573835.4095             nan     0.1000 -180658.3575
         8 84486591.1401             nan     0.1000 -184038.1001
         9 83997389.9494             nan     0.1000 -223236.1256
        10 83909487.7769             nan     0.1000 -146964.1189
        20 81718114.6323             nan     0.1000 -205778.7624
        40 78790504.0283             nan     0.1000 -130662.8030
        60 76899461.1100             nan     0.1000 -173024.2980
        80 75547732.2338             nan     0.1000 -155597.8716
       100 74608523.1489             nan     0.1000 -108212.9596
       120 73308532.8063             nan     0.1000 -330626.1866
       140 71689568.7753             nan     0.1000 -176808.8387
       160 70782802.6252             nan     0.1000 -328242.7887
       180 70095110.3924             nan     0.1000 -569855.1373
       200 69194213.7288             nan     0.1000 -161383.6364

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 86630644.5541             nan     0.1000 -288235.7500
         2 85956324.6129             nan     0.1000 -17299.2378
         3 85552550.9112             nan     0.1000 -3649.0074
         4 84947347.7122             nan     0.1000 -156947.5087
         5 84706792.6188             nan     0.1000 -222716.9170
         6 84613355.0801             nan     0.1000 -131130.9707
         7 84386478.3281             nan     0.1000 -92230.1202
         8 83693381.5827             nan     0.1000 -402567.2405
         9 83466479.0748             nan     0.1000 117757.1584
        10 83423453.4631             nan     0.1000 -96309.0095
        20 80322975.9042             nan     0.1000 -449132.1101
        40 76175974.1341             nan     0.1000 -322383.5850
        60 74182939.5876             nan     0.1000 -348028.6480
        80 71613384.2623             nan     0.1000 -293596.5933
       100 70206675.7167             nan     0.1000 -140048.0151
       120 68514562.0883             nan     0.1000 -197508.0179
       140 66992368.8892             nan     0.1000 -214174.0089
       160 65160835.4601             nan     0.1000 -289133.7261
       180 64009793.6650             nan     0.1000 -330517.0669
       200 63009337.8192             nan     0.1000 -119704.3366

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 77167353.9665             nan     0.1000 171312.2810
         2 76942876.8770             nan     0.1000 106739.4421
         3 76822232.5980             nan     0.1000 -13246.6708
         4 76736386.7498             nan     0.1000 81764.5684
         5 76558563.8358             nan     0.1000 -17346.6884
         6 76485708.9850             nan     0.1000 -36533.4125
         7 76384726.7244             nan     0.1000 -14426.2365
         8 76338981.2186             nan     0.1000 4118.9450
         9 76240234.2675             nan     0.1000 28051.8972
        10 76152950.5073             nan     0.1000 18147.3765
        20 75716272.3702             nan     0.1000 -39172.2511
        25 75522862.2754             nan     0.1000 -43749.8502

``` r
test_pred_boosted <- predict(boosted, newdata = ChannelTest)

m4 <- postResample(test_pred_boosted, ChannelTest$shares)
m4
```

            RMSE     Rsquared          MAE 
    9.148731e+03 1.212610e-04 3.257273e+03 

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
      model                     RMSE       R2
      <chr>                    <dbl>    <dbl>
    1 First linear regression  9076. 0.00314 
    2 Second linear regression 9112. 0.000352
    3 Random Forest            9118. 0.00146 
    4 Boosting                 9149. 0.000121

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
      model                    RMSE      R2
      <chr>                   <dbl>   <dbl>
    1 First linear regression 9076. 0.00314

When comparing all 4 of our models, we are looking for the smallest
value of RMSE to tell us which model is the best. In this situation, we
can say that the smallest RMSE is 9076.2761362 and this comes from the
First linear regression model.

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
