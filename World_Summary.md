ST558 Project 3 Group F: World Summary Report
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
data_channel_is_world: Is data channel ‘World’?
<!-- str_to_title("social media") ->> "Social Media" -->

Here, `read_csv()` is used to read in the OnlineNewsPopularity.csv data
and we are subsetting for the data_channel_is_world: Is data channel
‘World’? variable.

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

We now subset the data for the data channel of interest: World.

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

    # A tibble: 8,427 × 59
       n_toke…¹ n_tok…² n_uni…³ n_non…⁴ n_non…⁵ num_h…⁶ num_s…⁷ num_i…⁸ num_v…⁹ avera…˟ num_k…˟
          <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
     1       10     231   0.636    1.00   0.797       4       1       1       1    5.09       5
     2        9    1248   0.490    1.00   0.732      11       0       1       0    4.62       8
     3       12     682   0.460    1.00   0.635      10       0       1       0    4.62       6
     4        9     391   0.510    1.00   0.650       9       2       1       1    5.30       7
     5       11     125   0.675    1.00   0.797       1       1       1       0    4.82       6
     6       11     799   0.504    1.00   0.738       8       6       1       0    4.70       6
     7       11     317   0.611    1.00   0.729       7       6       1       0    5.24       5
     8       11     399   0.598    1.00   0.806       8       0       1       0    4.58       7
     9        9     443   0.467    1.00   0.589       3       1       1       0    5.01       6
    10       12     288   0.589    1.00   0.726       5       2       0       0    4.38       6
    # … with 8,417 more rows, 48 more variables: data_channel_is_lifestyle <dbl>,
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
    8427 

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
     0.0000  0.0000  0.0000  0.1573  0.0000  1.0000 

``` r
# 32. weekday_is_tuesday: Was the article published on a Tuesday?
summary(ChannelTrain$weekday_is_tuesday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1861  0.0000  1.0000 

``` r
# 33. weekday_is_wednesday: Was the article published on a Wednesday?
summary(ChannelTrain$weekday_is_wednesday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1863  0.0000  1.0000 

``` r
# 34. weekday_is_thursday: Was the article published on a Thursday?
summary(ChannelTrain$weekday_is_thursday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1825  0.0000  1.0000 

``` r
# 35. weekday_is_friday: Was the article published on a Friday?
summary(ChannelTrain$weekday_is_friday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
       0.00    0.00    0.00    0.16    0.00    1.00 

``` r
# 36. weekday_is_saturday: Was the article published on a Saturday?
summary(ChannelTrain$weekday_is_saturday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.00000 0.00000 0.00000 0.06102 0.00000 1.00000 

``` r
# 37. weekday_is_sunday: Was the article published on a Sunday?
summary(ChannelTrain$weekday_is_sunday)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.00000 0.00000 0.00000 0.06678 0.00000 1.00000 

``` r
# 38. is_weekend: Was the article published on the weekend? 
summary(ChannelTrain$is_weekend)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
     0.0000  0.0000  0.0000  0.1278  0.0000  1.0000 

``` r
# 60. shares: Number of shares (target)
summary(ChannelTrain$shares)
```

       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
         35     827    1100    2305    1800  284700 

``` r
#contigency tables
# example: table (crabs$color, crabs$spine, crabs$y)
# monday is the mot published articels... compare to diff of the week
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_tuesday)
```

       
           0    1
      0 3874 1098
      1  928    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_wednesday)
```

       
           0    1
      0 3873 1099
      1  928    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_thursday)
```

       
           0    1
      0 3895 1077
      1  928    0

``` r
table(ChannelTrain$weekday_is_monday, ChannelTrain$weekday_is_friday)
```

       
           0    1
      0 4028  944
      1  928    0

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

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAqAAAAHgCAMAAABNUi8GAAABmFBMVEUAAAAAADoAAGYAOpAAZrYBu8ABvcIBvsMBwMUCuL0CwMUEtLkEwMUHrbEHwMUHwcYLoaULwcYMwscTjZATw8cUxMkfa20fxckhx8wzMzMzycw3zdE6AAA6ADo6AGY6Ojo6OpA6kNtNTU1NTW5NTY5NbqtNjshVz9JX0tVc1tlmAABmADpmAGZmOpBmZmZmkJBmtrZmtv9uTU1uTW5uTY5ubo5ubqtuq+SCTkqN2duOTU2OTW6OTY6Obk2ObquOyP+QOgCQOjqQkDqQkGaQtpCQ27aQ2/+R3uCZ5eerbk2rbm6rbo6ryKur5OSr5P+xXli2ZgC2tma225C22/+2/9u2///Ijk3IyI7I///NaGDbkDrb/7bb/9vb///ebmXkq27k///ocWjr6+vuc2rwvLnydGvy8vLzoJv0dWz0wL31j4n2dWz2hX72op33dWz3d273eG/3eXH3e3P3f3f5d275eG/5enH5fHT5gHj5h4D5k436p6L8yMX/tmb/yI7/25D/27b/29v/5Kv//7b//8j//9v//+T///8zMhgtAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAgAElEQVR4nO29i2MbR5buJ+/YMkmBD4CgAJK+TiyPB0PPTXK9OxlLM07sZPfOajYT03mMYykZ2aY4aS3UIwDdfAGk7Ru/+G/nfKequqtf6C6gATTI+myRQKMfaPCHU+ecOlV159rKqsK6s+g3YGU1ThZQq0rLAmpVaVlArSotC6hVpWUBtaq0ygD0qCqqzjuZpSpzlyWgky8L6NKpMndZAjr5soAunSpzlyWgky8L6NKpMndZAjr5soAunSpzlyWgky8L6NKpMndZAjr5soAunSpzlyWgky8L6NKpMndZAjr5soAunSpzlyWgky8L6NKpMndZAjr5soAunSpzlyWgky8L6NKpMndZAjr5soAunSpzlyWgky8L6NKpMndZAjr5soAunSpzlyWgky9bD2pVaVkLunSqzF2WgE6+bhKgu7u7/NtxnAW/k5mqMp93Cejk6wYBursrCHWOj49vMqFV+bwtoIaygM5ZJaCTLwvo0qkqn7cF1FTWB52vSkAnXzcJ0Or86WaqytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr4soEunytxlCejkywK6dKrMXZaATr6WCNDcGW3U1Dc3XBZQU83n48idE0xNHnbTZQE11Xw+DguolAXUVPP5OCygUhZQU83p80j6oLEtt4NPC6ixFvUBxWyqtaBzVgno5MsCunSygJpqUR+QBXSxKgGdfC0zoNYHXaxKQCdfSw1oXNV5J7NUZe6yBHTyZQFdOlXmLktAJ19LA2iBpTtsEz9flYBOvpYF0AKLH9kgac4qAZ18jQX0+99+Ed/04+8fvPfV9fWXDx48+KV6cR4fhgU0kAVU6duQQaWf//Tx9Ze/ur7+/GNt4zw+DAtoIAuo1Ofv/hkWlGwmc/rjR1+IH2RXf/63T7Ud5/JpWB9UyQIaiJv4zz9kmykA/f53X13/+IdPCdoHD9iIwmrN5Y0W0BRv5fLyssx3YlWacgElHMHmtw+gD799jwH9/p8+vQ6t6KK/yVJTNPFLtf5sVT7vilhQNpbvfhq1oPxq4Icu+oOSsoDOWbNmk5UP6EcyUNJ9UN5gAV2MqvJ5VwRQ+KBo2IV+/hN7pNjw8/8yzzRTEU0RJC3TCt6V+bxnS6ZUPqDUxr8bxuxhHjTcuOgPKlB13sksVZm7nCGWoSrck2Rs1Wyaab4qAZ18VRdQY7/QJurnrBLQyZcFdOlkATXVbG7fApohC6ipZnT/1gdNlwXUVPP/aNLZtYDOVyWgk6+lBDS99bdN/JxVAjr5soAunSygppr7J5MH6DL1C5nLAmqq0u64MFipOwaALlXPurksoKYq64anBMsCOmeVgE6+LKBLJwuoqcq64bIAtT7ofFQCOvmqEqDTgnU7gngLqLEW/UEFqs47maUqc5cloJOvmwSokQVdXjegMp93Cejk6wYBurt7eHhYdOclDqSq8nlbQA21e/jw4cOi0FlAp1cJ6ORr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)<!-- -->

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
                        5.696e+02                      1.118e+02  
                 n_tokens_content                n_unique_tokens  
                       -5.003e-01                      2.922e+03  
                 n_non_stop_words       n_non_stop_unique_tokens  
                        5.659e+03                     -1.910e+03  
                        num_hrefs                 num_self_hrefs  
                        3.208e+01                     -4.229e+00  
                         num_imgs                     num_videos  
                        7.930e+01                      5.484e+01  
             average_token_length                   num_keywords  
                       -1.814e+03                      8.009e-01  
        data_channel_is_lifestyle  data_channel_is_entertainment  
                               NA                             NA  
              data_channel_is_bus         data_channel_is_socmed  
                               NA                             NA  
             data_channel_is_tech          data_channel_is_world  
                               NA                             NA  
                       kw_min_min                     kw_max_min  
                        3.165e+00                      1.891e-01  
                       kw_avg_min                     kw_min_max  
                       -1.185e+00                     -1.469e-03  
                       kw_max_max                     kw_avg_max  
                        5.597e-04                     -1.455e-03  
                       kw_min_avg                     kw_max_avg  
                       -4.386e-01                     -1.633e-01  
                       kw_avg_avg      self_reference_min_shares  
                        1.174e+00                     -8.252e-03  
        self_reference_max_shares     self_reference_avg_sharess  
                       -2.026e-03                      1.323e-02  
                weekday_is_monday             weekday_is_tuesday  
                       -8.806e+01                     -3.557e+02  
             weekday_is_wednesday            weekday_is_thursday  
                       -6.810e+02                     -1.591e+02  
                weekday_is_friday            weekday_is_saturday  
                       -4.285e+02                      2.291e+02  
                weekday_is_sunday                     is_weekend  
                               NA                             NA  
                           LDA_00                         LDA_01  
                       -1.633e+02                      1.739e+02  
                           LDA_02                         LDA_03  
                       -1.250e+03                      1.024e+03  
                           LDA_04            global_subjectivity  
                               NA                      3.094e+03  
        global_sentiment_polarity     global_rate_positive_words  
                       -2.868e+03                      4.039e+03  
       global_rate_negative_words            rate_positive_words  
                        7.062e+03                      1.463e+03  
              rate_negative_words          avg_positive_polarity  
                               NA                     -1.135e+03  
            min_positive_polarity          max_positive_polarity  
                        1.279e+03                      1.486e+02  
            avg_negative_polarity          min_negative_polarity  
                        1.416e+03                     -4.080e+02  
            max_negative_polarity             title_subjectivity  
                       -3.202e+03                     -1.953e+02  
         title_sentiment_polarity         abs_title_subjectivity  
                        5.360e+02                     -1.074e+02  
     abs_title_sentiment_polarity  
                        6.495e+02  

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
     1198.5281910  1415.2748433  1060.5008181  1408.7482436   447.6142093   714.6086184 
                7             8             9            10            11            12 
     1803.1025962  -262.9199615   404.4644038 -1106.2055834  -333.1022135   280.9330347 
               13            14            15            16            17            18 
    -1122.4242432  3610.9926114   888.6769513   305.7373728  1172.4240084  9920.0795373 
               19            20            21            22            23            24 
     -127.2139765  2684.1575384   639.1613757  -118.9126191 -1041.6939168   456.8154355 
               25            26            27            28            29            30 
      426.5459478  4051.1215783  -432.9095252   -19.9011366   367.6892398   379.8811737 
               31            32            33            34            35            36 
     -326.4139652 -1382.5509230     7.3600438   351.5946537  1803.7448018  3327.5877405 
               37            38            39            40            41            42 
    20717.0533711 -1807.0377266  5163.1775086  1208.1615781 -1664.8267949 -1592.3632064 
               43            44            45            46            47            48 
     -191.9365656   920.4462413 -2520.1267651  -343.5667373 -1127.1267316  -738.3401100 
               49            50            51            52            53            54 
    -1216.9683935 -2049.8237977 -4088.1913827   278.0275425  -418.1413765 -1373.6655380 
               55            56            57            58            59            60 
    -1375.0667419   -42.6718361 -1604.2185831 -1567.7611163 -1719.3100469  -895.4136455 
               61            62            63            64            65            66 
    -1627.6586512 -2557.5809866 -1024.4834574  1087.8746901  1827.5751323  -578.2429790 
               67            68            69            70            71            72 
     1278.1180014  -938.9876374  -361.0606197 -1311.6008994  -993.8560140  -439.1273092 
               73            74            75            76            77            78 
    -1895.8385847  -208.4202983  2611.7769632 -1236.0451240 -1170.8647185  1342.3780306 
               79            80            81            82            83            84 
    -2506.1788174 -1425.5254531  -254.9106254 -2929.3916729 -1326.8492531   171.1147199 
               85            86            87            88            89            90 
      -83.0417884  -713.7690544  4872.4301440 -1267.4179043   531.1781251 -2984.9267680 
               91            92            93            94            95            96 
    -1092.8465635    -0.5726951  -871.0270164   604.5721297  6037.3522377 -1554.3123004 
               97            98            99           100           101           102 
    -2123.4774769 -3500.4970282   602.5482996  -413.0690977  1158.7086479 -1179.3789510 
              103           104           105           106           107           108 
    -2597.7946906  1713.6432653  -415.4504399 -1805.6165886  5256.9335781  -229.1995412 
              109           110           111           112           113           114 
    13836.8775525  -229.3483602  1119.7478788   711.5393571  -799.1348135  -417.7603257 
              115           116           117           118           119           120 
    -1038.5637109   114.7250540 -1527.9692820   317.2959077 -1457.1916312 -1201.7738476 
              121           122           123           124           125           126 
       -9.6888158  -968.3599894 -1160.2595694 -1352.6283909  1243.7188284    -8.5853924 
              127           128           129           130           131           132 
     -520.9952561  3045.9744322   848.9825942  1332.7204479  -269.2895949 -3648.8362411 
              133           134           135           136           137           138 
     -827.0991046  -151.9708929   -85.6810591  -372.9755677  -374.5744688 -1731.7350468 
              139           140           141           142           143           144 
      372.0222914    23.1197370  3479.2674929   473.8353408  1463.5649663 -1288.4278590 
              145           146           147           148           149           150 
    -6177.7558791 -1006.1566324  -981.3796500 -2858.9396549 -1551.5185809 -3243.0997488 
              151           152           153           154           155           156 
    -1168.9806126  -648.2647625  -469.1888290   339.2471757 -1356.4646192  -600.2582833 
              157           158           159           160           161           162 
     -583.7333826 -1619.1328105  1226.4238150   121.4257538  1425.3963499 -2747.8804624 
              163           164           165           166           167           168 
     1011.7933841    -3.9499395   921.1729495  -211.4338899  1095.6249299  8898.3975648 
              169           170           171           172           173           174 
     2555.2285565  7105.4036340 -2731.8527648 -2323.1864447 -1111.8434999  3945.0049418 
              175           176           177           178           179           180 
     1774.2218171   299.9651228  -490.8182495  -506.6860524  -704.0669034  -889.3135045 
              181           182           183           184           185           186 
    -1124.0821377  -224.6848464   641.8469894   122.4234774  -375.7372869  -632.1157072 
              187           188           189           190           191           192 
       94.8780292 -1197.5074169  -395.5160101  -740.3220571 -1842.6597102 -3141.6340706 
              193           194           195           196           197           198 
      676.8644390  -879.0942894 -2301.7166070  1121.0500892  -302.6787630  -711.6174440 
              199           200           201           202           203           204 
    -1222.3364325  -963.0275674 -1220.4486944  1307.8928997 -1109.3031464 -2154.6720601 
              205           206           207           208           209           210 
     -219.6216333 -2172.9578268 -1485.8274479  -611.9444274 -2533.5359899 -2807.7866195 
              211           212           213           214           215           216 
    -1797.4054195    18.5119968   200.6471652   886.1158220 -2083.2098986 -2560.5516698 
              217           218           219           220           221           222 
    -2042.1670775  -779.2091332  -736.3049901    87.4087976  -457.6374789   -15.3957380 
              223           224           225           226           227           228 
    -1393.6117191  -457.8670736   -12.3004639   -73.2424170  -852.5611839  -818.2182598 
              229           230           231           232           233           234 
     -109.6477103   820.1765402 -2139.3236741  2681.9828748 -1003.7258152 -1602.3320166 
              235           236           237           238           239           240 
    -2393.3493900  -875.8769769  5706.4409906   432.8851432  -467.4184227   164.9462702 
              241           242           243           244           245           246 
      616.4064337    48.2836183 -5021.9012545   -12.9702610  -637.2195618  -848.6396628 
              247           248           249           250           251           252 
    -1075.8822507  -304.2607992  -655.1870273   198.9185799  -753.9908224  -639.7620233 
              253           254           255           256           257           258 
     1618.0553069  -179.3398870  -773.3354294 -2301.3163689  2728.8509660   422.8790688 
              259           260           261           262           263           264 
     9953.4534709 -2150.6825026 -1209.7917465 -1113.4348780  -486.5630470  1639.7977572 
              265           266           267           268           269           270 
     -526.9607295  -744.9738310   881.6379939    97.4674765  3983.1326837  -322.5408101 
              271           272           273           274           275           276 
     1427.3102424  -712.7510413  1917.9442824 -1704.0385594 -3260.4571846 -2984.7793090 
              277           278           279           280           281           282 
    -1848.7189615 -1160.9814905    -0.2600715 -2115.5430761  1961.4209820 -3802.0348932 
              283           284           285           286           287           288 
     -277.1894787  -128.7482814  1576.0965652   212.9317731 -1034.9482529  1195.7152056 
              289           290           291           292           293           294 
      541.8295192  -687.5854383  3159.1983909  -724.5293395    94.4327474   -69.9720488 
              295           296           297           298           299           300 
    -2056.4767265   -67.3157697  2871.6966248 -1853.6351822  -226.1773749 -4082.8244056 
              301           302           303           304           305           306 
    -1211.6788133  -286.0376225   875.7753260  -667.8329063 -1484.9242460    29.8589644 
              307           308           309           310           311           312 
    -1483.3666242   538.3539930 -2116.6804936  -360.7987928  -363.3760506  1910.2438493 
              313           314           315           316           317           318 
    -2134.7328640   -39.5317876 -2849.5537336 -1442.8630704  -114.6090960  -759.0167769 
              319           320           321           322           323           324 
      396.7280647 -1910.7586178 -2393.7310265 -1038.3399656  -644.3079744 -2940.0847452 
              325           326           327           328           329           330 
     4097.7757602  -631.2564277  -400.0989392  9577.2797246 -1318.3017081  1357.7273226 
              331           332           333           334           335           336 
       26.6394524 -2091.4777492   218.1913911 -1077.2995147 -2364.7825625  7860.3871572 
              337           338           339           340           341           342 
      147.4505798   190.9868619  1188.3037932 -1614.4066122  4098.1115080    86.0021596 
              343           344           345           346           347           348 
    -1783.3430732  3167.7962656   399.2951548  -402.7646302 -2019.1303404 -1890.4521556 
              349           350           351           352           353           354 
    -5146.9599354  -969.0681049 -1454.4130092  -818.8668744  2098.3732194   208.0838046 
              355           356           357           358           359           360 
    -1975.8813312  -274.9956174   -73.5717237  -688.2435241  -413.5914254   782.7501170 
              361           362           363           364           365           366 
    -1178.3248441 -1253.8395409 -1241.9346601 -1291.2183204  -947.2404466  -259.8023529 
              367           368           369           370           371           372 
    -2961.4105186 -2162.5179016  7603.2223437  -668.4519105  4093.5591527  2836.6112925 
              373           374           375           376           377           378 
    -1915.6231016  -363.1802243 -1023.0292204 -1694.3479975  -390.7642700 -4070.9743561 
              379           380           381           382           383           384 
     -251.3627842   734.9968577 16508.4639375 -2803.0857575 -3651.7847283  -647.0125128 
              385           386           387           388           389           390 
    -1907.0641289  -345.7411963 -1829.8013867   996.0507571  -528.6281792   784.8661607 
              391           392           393           394           395           396 
    -2969.9594478  6901.1587660   486.5083455 -1154.3218049  -104.0052913  1586.8852032 
              397           398           399           400           401           402 
    -1092.5864569   498.3380197  2434.3411895  -323.0033685 -2929.3585734  -302.5336817 
              403           404           405           406           407           408 
    -2502.6657040 -1651.9750935   454.7559677 44458.1577411  -893.2259901 -4423.9998063 
              409           410           411           412           413           414 
     -864.4727061  -931.7954275  -395.9730368  1213.8263365  -759.5143215  -847.9999996 
              415           416           417           418           419           420 
    -2657.3281685 -2035.9318375  3193.7930136 -1192.3615480  -701.3123135  -626.0227346 
              421           422           423           424           425           426 
     1861.7729527  -154.5053805  8329.5029983   713.5999253  2220.6935489 -2121.0662388 
              427           428           429           430           431           432 
    -1260.0721219   533.7960855 -1450.4360987 -3046.6980929 -1561.0800878    58.9207219 
              433           434           435           436           437           438 
     -453.4466783  -683.8927858  -813.2651410  -450.7912509 -1211.2865072  -290.5898277 
              439           440           441           442           443           444 
     -987.0050961 -1314.1468473  -574.5549106  -110.3374620   125.7262366  -366.6433476 
              445           446           447           448           449           450 
    -1123.7326482  -160.5656393  -790.8763253  -581.3544645 -1529.4530785 -1213.1220568 
              451           452           453           454           455           456 
     7065.1549829  -547.7273209  -482.2529210 -1817.7623379 -2133.1218254   435.6856538 
              457           458           459           460           461           462 
      394.1449831 -1988.7498615  -182.8034168  2826.4365872 -2526.8830502 -1717.4785072 
              463           464           465           466           467           468 
     1407.9101437 -4602.3035513  -476.8194350 -1661.3264209 -2926.0542090   597.9161059 
              469           470           471           472           473           474 
    -2005.6355053 -1785.7445789 -1092.1913603  -599.9728861 17479.0244672 -1718.0227670 
              475           476           477           478           479           480 
    -1387.8444978   153.0171206 -1677.5450379 -1876.4326079 -1678.1862955  1762.7248511 
              481           482           483           484           485           486 
     -869.9399732  -459.2937455 -1318.7468988  7386.3096849 -2879.1967013  -437.6026139 
              487           488           489           490           491           492 
     -744.2919194   659.5250723  -362.9791265 -1640.0362241  -616.6534956  -703.7240315 
              493           494           495           496           497           498 
     -565.3368158 -2022.6488774 -1116.3701963  -225.5817986  -244.5616603 -3285.6690046 
              499           500           501           502           503           504 
     -835.7106444 -5114.8014872 -2265.7817917  1439.1705024 -1816.3231073 -4124.9881067 
              505           506           507           508           509           510 
    -1804.1637823 -3863.1135544  -810.8691158  -936.2048406  -309.6486969   237.8047352 
              511           512           513           514           515           516 
      158.8691411 -2956.5000702 -1860.2703300  -363.3202177 -2307.1274310 -1447.4863783 
              517           518           519           520           521           522 
     2155.7556116  1564.2465736 -2721.9971264 -2453.4312198 -1263.6263339 -1038.5640746 
              523           524           525           526           527           528 
      869.5338653 -1346.3471291 -2107.0809227   313.4392941   338.7519458 -1361.9638681 
              529           530           531           532           533           534 
      696.3268041  -358.8851718  -470.7137292 -1511.1530033  4957.5659087  -852.5569340 
              535           536           537           538           539           540 
      795.9542922    54.5524504  -376.9325667   971.9270542   -45.6938674  1470.4573802 
              541           542           543           544           545           546 
     1212.1972277  -277.9641836  4625.4753294  6754.4032133 -2383.0600343 -2251.6006572 
              547           548           549           550           551           552 
     -552.1301592 -1032.9802773     7.3411844  1177.5157182 -1074.6861353 -1685.7239189 
              553           554           555           556           557           558 
     -686.7639404  -564.2925355  -190.6236399 -3018.2524045 -1509.5639288 -1920.7395145 
              559           560           561           562           563           564 
     5823.7949590 -1555.3346647   241.0431500  5854.7129388  7342.7499651  -650.1800051 
              565           566           567           568           569           570 
    -1265.9672881  1294.4471678 24401.4922229 -3094.9315772  -287.8775735 -5603.8824048 
              571           572           573           574           575           576 
    46493.1409841 -2258.9508453  7041.4725622 -1554.1491357 -1292.8736112  -709.8519548 
              577           578           579           580           581           582 
    -1556.3256688  -868.6826992  -159.8032713  -148.1253565 16292.1252806   840.5672148 
              583           584           585           586           587           588 
    -1283.8588091  1407.9487077  -612.3271698 -2547.0128205  1055.4206898 -2142.6977882 
              589           590           591           592           593           594 
    -1081.5719866   605.8869273  7726.4343648  2751.0991392 -2955.4381545  -693.8817206 
              595           596           597           598           599           600 
     -923.6337101  -910.1259488  -959.9157225 -5791.5570567 -1820.7165999   116.7502532 
              601           602           603           604           605           606 
    -1655.3399121  2801.3386225 -1179.2898349    47.4638720 -1161.2449517  2843.1628740 
              607           608           609           610           611           612 
    -1747.1113921  -387.3172325 -3451.2775757 -2672.1277136 -1607.2798613 -1733.0422711 
              613           614           615           616           617           618 
    -3718.9330960 -1625.2227277 -3146.4321352  -297.8159071  -414.7065736  -265.8808207 
              619           620           621           622           623           624 
     -427.6748194  1417.5696550  1610.8055864   214.5385750  1694.9051420  -986.1305079 
              625           626           627           628           629           630 
       -9.0351032  -295.1535428  -371.6236338   121.2984064  -883.5808883  -292.6567809 
              631           632           633           634           635           636 
     1526.2546014 -2495.4702126   604.0893709  -479.5726801   163.7594321   500.6749143 
              637           638           639           640           641           642 
     -411.9108797 -3557.8765199 -1982.8157331  2354.0933844   519.2493389   168.7189644 
              643           644           645           646           647           648 
    11653.8064286   423.6449188   780.2704669   709.3103100 -1516.4986618  -441.2518841 
              649           650           651           652           653           654 
    -1335.9447898    34.4590296  6688.5379786  -464.4568810  3122.6995647   519.8706144 
              655           656           657           658           659           660 
     -100.7299354   635.4732808  2243.3297313 -1720.0532133  -894.8702520  -138.1750505 
              661           662           663           664           665           666 
     1443.4154933  -139.7011580  -154.3434901 -1715.4515604   572.7645688  -199.4385862 
              667           668           669           670           671           672 
     1352.3265212  2435.7083875    30.2431685   413.1559722   123.2296174  -801.5246493 
              673           674           675           676           677           678 
      660.8202875 -1909.4924841  -146.6419091  -315.9142203 -1293.4231876  -593.7746153 
              679           680           681           682           683           684 
    -1175.5187437   310.1906552   827.3208982  5549.0595135 -1428.3783113 10512.8397793 
              685           686           687           688           689           690 
      874.3043698  7574.2988470  -932.8589987 -1234.9668944     4.9299820  -493.7507220 
              691           692           693           694           695           696 
      869.2620275  -902.7559030  -146.3909383 -2963.8907297   370.8901386   985.1456325 
              697           698           699           700           701           702 
    -4477.6868730  -514.5751683  -915.3915894  2261.3454042  -570.1160541  -584.8514965 
              703           704           705           706           707           708 
     -184.5193808   354.6299850  -427.8771898  -920.4562642  1505.1812004   869.3310637 
              709           710           711           712           713           714 
      923.1034566  -821.0728126 -1956.6221981   -68.1017633    59.1884700  -259.9142110 
              715           716           717           718           719           720 
     -712.9264207   127.1346122  -219.4047808 -1913.3039097  1730.2301663  -875.1335033 
              721           722           723           724           725           726 
     5433.9859723 -2269.3766224 -1659.9116423  4459.1193106  -442.6743066  -996.2337020 
              727           728           729           730           731           732 
     1284.8728571 -5248.0176313 45598.7627859  2491.6912767  2326.5776841   495.1754193 
              733           734           735           736           737           738 
    -1826.8515094  -655.6816753   191.6053935   679.2517374  -866.6014931  2224.4837987 
              739           740           741           742           743           744 
      772.0393761  6008.3543185   282.9440785 -1437.3995270  -199.8730481   328.0470587 
              745           746           747           748           749           750 
     1511.4375605 -1177.2616758  -819.6632279  1730.9337836   -37.6230139  -800.1554046 
              751           752           753           754           755           756 
    -2335.5900691 -4304.3808366 -1141.4973912  -889.6749366  3531.1712576  -816.2554628 
              757           758           759           760           761           762 
     -838.9249486  -403.5227466 -2987.8184338 -1784.7169579   808.6481760   343.9319160 
              763           764           765           766           767           768 
      -60.1371945 -2951.1142737   565.2816333  -233.6452444 -2105.3802506  3515.9042449 
              769           770           771           772           773           774 
      804.8640439  1854.8938023  -601.3414060  -704.1144615  -428.8791111   374.8558147 
              775           776           777           778           779           780 
    -1266.9543005  2781.1721040  -753.3174755  -598.5108794  -462.0606659  1440.4523929 
              781           782           783           784           785           786 
    -1803.4726486   146.5867808    71.8824630   -41.3143011  6093.1353934     9.8137036 
              787           788           789           790           791           792 
      806.8659679 -1167.2809234 -2215.8836384   758.3701720  -876.1248500  -834.6815259 
              793           794           795           796           797           798 
    -1367.4325061   146.8775966 -2882.2386349 -2555.4183051  -764.5798611 -1215.3201622 
              799           800           801           802           803           804 
     2004.2655812 10965.5482811  -429.3639098   366.9436131  1285.6388558  -443.5252464 
              805           806           807           808           809           810 
    -1926.8516158  -477.8636462  -205.7046878   175.4510684   -75.1380696  1411.0542604 
              811           812           813           814           815           816 
      259.8469817  -748.2322225 -1337.4275378   936.2979957   520.9631957   281.6182902 
              817           818           819           820           821           822 
      418.2389999   -49.5055384  4129.2139879   950.0998999  -956.6571894  -410.8884025 
              823           824           825           826           827           828 
      221.1193863 -1581.4441005   660.1199924   362.9411988  1320.3964528   104.0803328 
              829           830           831           832           833           834 
       98.4459453 -1727.4231047  -534.7888497  1402.6528240  -446.9302847  1050.7308701 
              835           836           837           838           839           840 
     5809.0458588    12.8927310   -41.3577417 -1507.2302145 -1184.6155371  -215.6278054 
              841           842           843           844           845           846 
       36.5415492  1058.4651238    39.7119605  -258.6978873  -303.5885919   488.6357542 
              847           848           849           850           851           852 
      701.7244754  -535.4141240   -30.9154945  1054.4570851   217.0975943  -837.0095957 
              853           854           855           856           857           858 
       61.0002874  5289.0353622  -786.3379443  2283.2544945  1991.7630231 -1629.0910710 
              859           860           861           862           863           864 
     -158.0066028  -364.1480182  -609.4298299  -752.8320998 -1653.8344753  2641.2409855 
              865           866           867           868           869           870 
    -2879.9617771  -865.7300062  -190.8709242 -1168.8531109  -349.5540953  -239.2518652 
              871           872           873           874           875           876 
    -2306.4889765  8815.6722824 -4941.6893384  -665.5503752 -1288.4969024 -1301.6734638 
              877           878           879           880           881           882 
    -4062.8428172 -2765.5534993 -2287.2063572 -1797.3823566    11.8718614 -1382.3823933 
              883           884           885           886           887           888 
       41.0416390 -3250.7918028 -1871.4774221  -348.5611283  1702.8596978 -3547.7907036 
              889           890           891           892           893           894 
    -1570.1866142  2663.0724997 -1758.9384129  -142.9014405   425.6780608  -658.3055140 
              895           896           897           898           899           900 
     -608.3437809  8372.6323628 -1648.0541087  -320.2595818   864.1240411  3805.0462891 
              901           902           903           904           905           906 
      796.4009391 -1623.9874233   869.8252049 17080.8240054  -751.0553612 -2047.1578898 
              907           908           909           910           911           912 
       78.1104703 -2218.8751222  -729.4051739 -1156.3099935   609.1457129 -1522.9681830 
              913           914           915           916           917           918 
      306.6786527  4792.6864630  -538.7528647 -1843.1091090 -2243.6976569 -2291.1743371 
              919           920           921           922           923           924 
     1638.3820658 -2328.5784902  2112.7043140 -1117.4220869  -926.8686516  -775.5532744 
              925           926           927           928           929           930 
    -1267.4154939  1099.7557304  -789.3093146 -1006.7212218 -1663.4343257  7612.3925182 
              931           932           933           934           935           936 
      701.3583749 -1904.8093457  3263.3613941  2003.1605865  -786.3857206  -354.5706228 
              937           938           939           940           941           942 
    -2283.8171133  -247.5549791  -677.2951835 -1508.6965796  2157.6253733   264.7593477 
              943           944           945           946           947           948 
    -2050.6156183  -370.8102538 -1491.3364950  -671.4118868  -368.1368788  -917.8678934 
              949           950           951           952           953           954 
     1106.1513774  -620.0466579 -1120.4253550   230.0224543  -991.5453121 -1516.1746779 
              955           956           957           958           959           960 
     -550.9618640 -1511.1029906 -5020.9249121 -1282.3538083  -211.9132687   500.0439264 
              961           962           963           964           965           966 
     1314.7758720   875.0336190 -1611.8646181  2450.1861624 -2541.5931111 -1002.5839657 
              967           968           969           970           971           972 
    -1618.4503654  1463.9729079 -2991.2082168 -1182.3039809 -2517.2626099  1081.7002933 
              973           974           975           976           977           978 
    -3118.9252051 -1048.6514552 -1013.3405498  -536.2493331 -1799.8773951 -2777.3698893 
              979           980           981           982           983           984 
     -858.3782417  -242.8727796   367.0587704  -224.5416217  -455.8867362  -325.9401894 
              985           986           987           988           989           990 
      877.0896687 -3940.1962856 16210.1802606 -1147.6902607  3781.5965603  3949.9108127 
              991           992           993           994           995           996 
    -1409.7164017  2196.5914391 -1233.7115711   460.5513105 -1271.8061561   162.7701365 
              997           998           999          1000 
     -803.0731385   158.5989939   144.5844738 -1428.9913607 
     [ reached getOption("max.print") -- omitted 7427 entries ]

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
    2 weekday_is_monday     0.0121 
    3 weekday_is_tuesday   -0.00526
    4 weekday_is_wednesday -0.0320 
    5 weekday_is_thursday   0.00835
    6 weekday_is_friday    -0.00417
    7 weekday_is_saturday   0.0199 
    8 weekday_is_sunday     0.0140 

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
     1st Qu.: 9.00   1st Qu.: 330.0   1st Qu.:0.4655   1st Qu.:1.0000  
     Median :11.00   Median : 507.5   Median :0.5201   Median :1.0000  
     Mean   :10.58   Mean   : 596.9   Mean   :0.5102   Mean   :0.9676  
     3rd Qu.:12.00   3rd Qu.: 768.0   3rd Qu.:0.5751   3rd Qu.:1.0000  
     Max.   :23.00   Max.   :4661.0   Max.   :0.9762   Max.   :1.0000  
     n_non_stop_unique_tokens   num_hrefs     num_self_hrefs      num_imgs      
     Min.   :0.0000           Min.   :  0.0   Min.   : 0.000   Min.   :  0.000  
     1st Qu.:0.6269           1st Qu.:  5.0   1st Qu.: 1.000   1st Qu.:  1.000  
     Median :0.6835           Median :  8.0   Median : 2.000   Median :  1.000  
     Mean   :0.6639           Mean   : 10.2   Mean   : 2.426   Mean   :  2.923  
     3rd Qu.:0.7352           3rd Qu.: 13.0   3rd Qu.: 3.000   3rd Qu.:  2.000  
     Max.   :1.0000           Max.   :161.0   Max.   :38.000   Max.   :100.000  
       num_videos      average_token_length  num_keywords    data_channel_is_lifestyle
     Min.   : 0.0000   Min.   :0.000        Min.   : 2.000   Min.   :0                
     1st Qu.: 0.0000   1st Qu.:4.655        1st Qu.: 6.000   1st Qu.:0                
     Median : 0.0000   Median :4.821        Median : 7.000   Median :0                
     Mean   : 0.5353   Mean   :4.670        Mean   : 7.296   Mean   :0                
     3rd Qu.: 1.0000   3rd Qu.:4.972        3rd Qu.: 9.000   3rd Qu.:0                
     Max.   :22.0000   Max.   :6.124        Max.   :10.000   Max.   :0                
     data_channel_is_entertainment data_channel_is_bus data_channel_is_socmed
     Min.   :0                     Min.   :0           Min.   :0             
     1st Qu.:0                     1st Qu.:0           1st Qu.:0             
     Median :0                     Median :0           Median :0             
     Mean   :0                     Mean   :0           Mean   :0             
     3rd Qu.:0                     3rd Qu.:0           3rd Qu.:0             
     Max.   :0                     Max.   :0           Max.   :0             
     data_channel_is_tech data_channel_is_world   kw_min_min       kw_max_min    
     Min.   :0            Min.   :1             Min.   : -1.00   Min.   :     0  
     1st Qu.:0            1st Qu.:1             1st Qu.: -1.00   1st Qu.:   427  
     Median :0            Median :1             Median : -1.00   Median :   627  
     Mean   :0            Mean   :1             Mean   : 14.93   Mean   :  1020  
     3rd Qu.:0            3rd Qu.:1             3rd Qu.:  4.00   3rd Qu.:   928  
     Max.   :0            Max.   :1             Max.   :217.00   Max.   :139600  
       kw_avg_min        kw_min_max       kw_max_max       kw_avg_max       kw_min_avg    
     Min.   :   -1.0   Min.   :     0   Min.   :     0   Min.   :     0   Min.   :  -1.0  
     1st Qu.:  116.6   1st Qu.:     0   1st Qu.:843300   1st Qu.:179456   1st Qu.:   0.0  
     Median :  203.9   Median :  1000   Median :843300   Median :222079   Median : 822.7  
     Mean   :  265.8   Mean   :  7028   Mean   :787432   Mean   :229343   Mean   : 836.2  
     3rd Qu.:  320.5   3rd Qu.:  5100   3rd Qu.:843300   3rd Qu.:274975   3rd Qu.:1593.5  
     Max.   :18687.8   Max.   :141400   Max.   :843300   Max.   :685260   Max.   :3009.0  
       kw_max_avg       kw_avg_avg    self_reference_min_shares self_reference_max_shares
     Min.   :     0   Min.   :    0   Min.   :     0.0          Min.   :     0.0         
     1st Qu.:  3457   1st Qu.: 2074   1st Qu.:   470.5          1st Qu.:   700.5         
     Median :  3588   Median : 2403   Median :   978.0          Median :  1700.0         
     Mean   :  4751   Mean   : 2528   Mean   :  2815.5          Mean   :  6329.2         
     3rd Qu.:  4733   3rd Qu.: 2783   3rd Qu.:  1800.0          3rd Qu.:  4500.0         
     Max.   :139600   Max.   :17839   Max.   :690400.0          Max.   :690400.0         
     self_reference_avg_sharess weekday_is_monday weekday_is_tuesday weekday_is_wednesday
     Min.   :     0.0           Min.   :0.0000    Min.   :0.0000     Min.   :0.0000      
     1st Qu.:   677.1           1st Qu.:0.0000    1st Qu.:0.0000     1st Qu.:0.0000      
     Median :  1400.0           Median :0.0000    Median :0.0000     Median :0.0000      
     Mean   :  4195.7           Mean   :0.1573    Mean   :0.1861     Mean   :0.1863      
     3rd Qu.:  3200.0           3rd Qu.:0.0000    3rd Qu.:0.0000     3rd Qu.:0.0000      
     Max.   :690400.0           Max.   :1.0000    Max.   :1.0000     Max.   :1.0000      
     weekday_is_thursday weekday_is_friday weekday_is_saturday weekday_is_sunday
     Min.   :0.0000      Min.   :0.00      Min.   :0.00000     Min.   :0.00000  
     1st Qu.:0.0000      1st Qu.:0.00      1st Qu.:0.00000     1st Qu.:0.00000  
     Median :0.0000      Median :0.00      Median :0.00000     Median :0.00000  
     Mean   :0.1825      Mean   :0.16      Mean   :0.06102     Mean   :0.06678  
     3rd Qu.:0.0000      3rd Qu.:0.00      3rd Qu.:0.00000     3rd Qu.:0.00000  
     Max.   :1.0000      Max.   :1.00      Max.   :1.00000     Max.   :1.00000  
       is_weekend         LDA_00            LDA_01            LDA_02           LDA_03       
     Min.   :0.0000   Min.   :0.01818   Min.   :0.01818   Min.   :0.0200   Min.   :0.01820  
     1st Qu.:0.0000   1st Qu.:0.02500   1st Qu.:0.02240   1st Qu.:0.5261   1st Qu.:0.02500  
     Median :0.0000   Median :0.02972   Median :0.02858   Median :0.7298   Median :0.02962  
     Mean   :0.1278   Mean   :0.06598   Mean   :0.05473   Mean   :0.6698   Mean   :0.07323  
     3rd Qu.:0.0000   3rd Qu.:0.04001   3rd Qu.:0.04000   3rd Qu.:0.8599   3rd Qu.:0.04011  
     Max.   :1.0000   Max.   :0.81801   Max.   :0.81511   Max.   :0.9200   Max.   :0.81603  
         LDA_04        global_subjectivity global_sentiment_polarity
     Min.   :0.02000   Min.   :0.0000      Min.   :-0.32273         
     1st Qu.:0.02857   1st Qu.:0.3562      1st Qu.: 0.02165         
     Median :0.04000   Median :0.4128      Median : 0.07315         
     Mean   :0.13625   Mean   :0.4012      Mean   : 0.07690         
     3rd Qu.:0.20061   3rd Qu.:0.4648      3rd Qu.: 0.12708         
     Max.   :0.91954   Max.   :0.9500      Max.   : 0.52000         
     global_rate_positive_words global_rate_negative_words rate_positive_words
     Min.   :0.00000            Min.   :0.00000            Min.   :0.0000     
     1st Qu.:0.02184            1st Qu.:0.01092            1st Qu.:0.5333     
     Median :0.03058            Median :0.01644            Median :0.6429     
     Mean   :0.03126            Mean   :0.01693            Mean   :0.6232     
     3rd Qu.:0.03967            3rd Qu.:0.02222            3rd Qu.:0.7445     
     Max.   :0.11273            Max.   :0.07143            Max.   :1.0000     
     rate_negative_words avg_positive_polarity min_positive_polarity max_positive_polarity
     Min.   :0.0000      Min.   :0.0000        Min.   :0.00000       Min.   :0.0000       
     1st Qu.:0.2432      1st Qu.:0.2800        1st Qu.:0.05000       1st Qu.:0.5000       
     Median :0.3450      Median :0.3309        Median :0.10000       Median :0.7000       
     Mean   :0.3444      Mean   :0.3240        Mean   :0.08845       Mean   :0.6975       
     3rd Qu.:0.4483      3rd Qu.:0.3793        3rd Qu.:0.10000       3rd Qu.:0.9000       
     Max.   :1.0000      Max.   :0.8667        Max.   :0.80000       Max.   :1.0000       
     avg_negative_polarity min_negative_polarity max_negative_polarity title_subjectivity
     Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.00000      Min.   :0.00000   
     1st Qu.:-0.3088       1st Qu.:-0.8000       1st Qu.:-0.10000      1st Qu.:0.00000   
     Median :-0.2460       Median :-0.5000       Median :-0.10000      Median :0.03542   
     Mean   :-0.2515       Mean   :-0.5599       Mean   :-0.09356      Mean   :0.24826   
     3rd Qu.:-0.1908       3rd Qu.:-0.4000       3rd Qu.:-0.05000      3rd Qu.:0.45455   
     Max.   : 0.0000       Max.   : 0.0000       Max.   : 0.00000      Max.   :1.00000   
     title_sentiment_polarity abs_title_subjectivity abs_title_sentiment_polarity
     Min.   :-1.00000         Min.   :0.0000         Min.   :0.0000              
     1st Qu.: 0.00000         1st Qu.:0.2000         1st Qu.:0.0000              
     Median : 0.00000         Median :0.5000         Median :0.0000              
     Mean   : 0.02920         Mean   :0.3603         Mean   :0.1297              
     3rd Qu.: 0.06818         3rd Qu.:0.5000         3rd Qu.:0.2000              
     Max.   : 1.00000         Max.   :0.5000         Max.   :1.0000              
         shares      
     Min.   :    35  
     1st Qu.:   827  
     Median :  1100  
     Mean   :  2305  
     3rd Qu.:  1800  
     Max.   :284700  

``` r
#check structure of objects
str(ChannelTrain)
```

    tibble [5,900 × 59] (S3: tbl_df/tbl/data.frame)
     $ n_tokens_title               : num [1:5900] 10 9 12 9 11 9 10 10 12 6 ...
     $ n_tokens_content             : num [1:5900] 231 1248 682 391 317 ...
     $ n_unique_tokens              : num [1:5900] 0.636 0.49 0.46 0.51 0.611 ...
     $ n_non_stop_words             : num [1:5900] 1 1 1 1 1 ...
     $ n_non_stop_unique_tokens     : num [1:5900] 0.797 0.732 0.635 0.65 0.729 ...
     $ num_hrefs                    : num [1:5900] 4 11 10 9 7 3 8 7 1 9 ...
     $ num_self_hrefs               : num [1:5900] 1 0 0 2 6 1 0 0 1 5 ...
     $ num_imgs                     : num [1:5900] 1 1 1 1 1 1 1 1 10 1 ...
     $ num_videos                   : num [1:5900] 1 0 0 1 0 0 0 0 0 1 ...
     $ average_token_length         : num [1:5900] 5.09 4.62 4.62 5.3 5.24 ...
     $ num_keywords                 : num [1:5900] 5 8 6 7 5 6 6 6 10 7 ...
     $ data_channel_is_lifestyle    : num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_entertainment: num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_bus          : num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_socmed       : num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_tech         : num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ data_channel_is_world        : num [1:5900] 1 1 1 1 1 1 1 1 1 1 ...
     $ kw_min_min                   : num [1:5900] 0 0 0 0 0 0 217 217 217 217 ...
     $ kw_max_min                   : num [1:5900] 0 0 0 0 0 0 504 3600 598 495 ...
     $ kw_avg_min                   : num [1:5900] 0 0 0 0 0 ...
     $ kw_min_max                   : num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_max_max                   : num [1:5900] 0 0 0 0 0 0 17100 17100 17100 17100 ...
     $ kw_avg_max                   : num [1:5900] 0 0 0 0 0 ...
     $ kw_min_avg                   : num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ kw_max_avg                   : num [1:5900] 0 0 0 0 0 ...
     $ kw_avg_avg                   : num [1:5900] 0 0 0 0 0 ...
     $ self_reference_min_shares    : num [1:5900] 0 0 0 704 638 0 0 0 0 1300 ...
     $ self_reference_max_shares    : num [1:5900] 0 0 0 704 3300 0 0 0 0 1300 ...
     $ self_reference_avg_sharess   : num [1:5900] 0 0 0 704 1560 ...
     $ weekday_is_monday            : num [1:5900] 1 1 1 1 1 1 0 0 0 0 ...
     $ weekday_is_tuesday           : num [1:5900] 0 0 0 0 0 0 1 0 0 0 ...
     $ weekday_is_wednesday         : num [1:5900] 0 0 0 0 0 0 0 1 1 1 ...
     $ weekday_is_thursday          : num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_friday            : num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_saturday          : num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ weekday_is_sunday            : num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ is_weekend                   : num [1:5900] 0 0 0 0 0 0 0 0 0 0 ...
     $ LDA_00                       : num [1:5900] 0.04 0.025 0.0333 0.0288 0.04 ...
     $ LDA_01                       : num [1:5900] 0.04 0.2873 0.0333 0.0286 0.04 ...
     $ LDA_02                       : num [1:5900] 0.84 0.401 0.867 0.681 0.84 ...
     $ LDA_03                       : num [1:5900] 0.04 0.2619 0.0333 0.0286 0.04 ...
     $ LDA_04                       : num [1:5900] 0.04 0.025 0.0333 0.2334 0.04 ...
     $ global_subjectivity          : num [1:5900] 0.314 0.482 0.473 0.284 0.375 ...
     $ global_sentiment_polarity    : num [1:5900] 0.0519 0.1024 0.0622 0.0333 0.0913 ...
     $ global_rate_positive_words   : num [1:5900] 0.039 0.0385 0.0499 0.0179 0.0379 ...
     $ global_rate_negative_words   : num [1:5900] 0.0303 0.02083 0.03959 0.00512 0.01893 ...
     $ rate_positive_words          : num [1:5900] 0.562 0.649 0.557 0.778 0.667 ...
     $ rate_negative_words          : num [1:5900] 0.438 0.351 0.443 0.222 0.333 ...
     $ avg_positive_polarity        : num [1:5900] 0.298 0.404 0.343 0.15 0.316 ...
     $ min_positive_polarity        : num [1:5900] 0.1 0.1 0.05 0.05 0.0333 ...
     $ max_positive_polarity        : num [1:5900] 0.5 1 0.6 0.35 0.8 0.5 0.5 0.7 1 1 ...
     $ avg_negative_polarity        : num [1:5900] -0.238 -0.415 -0.22 -0.108 -0.189 ...
     $ min_negative_polarity        : num [1:5900] -0.5 -1 -0.6 -0.167 -0.3 ...
     $ max_negative_polarity        : num [1:5900] -0.1 -0.1 -0.05 -0.05 -0.125 ...
     $ title_subjectivity           : num [1:5900] 0 0 0.75 0 0.483 ...
     $ title_sentiment_polarity     : num [1:5900] 0 0 -0.25 0 0.417 ...
     $ abs_title_subjectivity       : num [1:5900] 0.5 0.5 0.25 0.5 0.0167 ...
     $ abs_title_sentiment_polarity : num [1:5900] 0 0 0.25 0 0.417 ...
     $ shares                       : num [1:5900] 710 2200 1600 598 1800 495 468 971 1400 5600 ...

``` r
str(Lifestlye_sumstats_Train)
```

     'table' chr [1:6, 1:59] "Min.   : 4.00  " "1st Qu.: 9.00  " "Median :11.00  " ...
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
    5.160365e+03 1.268899e-02 1.897436e+03 

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
    5.193550e+03 1.274165e-03 1.931547e+03 

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
    5.171464e+03 9.617930e-03 1.855813e+03 

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
         1 49585721.5250             nan     0.1000 99811.2061
         2 49458408.7663             nan     0.1000 89949.6054
         3 49374135.3778             nan     0.1000 64836.7229
         4 49343897.7887             nan     0.1000 -8402.8311
         5 49293964.6977             nan     0.1000 15036.0971
         6 49256459.6258             nan     0.1000 6736.7866
         7 49215788.5889             nan     0.1000 3109.4848
         8 49149264.8163             nan     0.1000 37060.9388
         9 49123024.1569             nan     0.1000 -27416.3191
        10 49102787.6894             nan     0.1000 2124.4655
        20 48804363.0657             nan     0.1000 -12483.9429
        40 48579965.7791             nan     0.1000 -2184.6759
        60 48469032.3135             nan     0.1000 -11268.0991
        80 48344790.2569             nan     0.1000 -9178.4000
       100 48247490.4831             nan     0.1000 -21102.0671
       120 48157888.1789             nan     0.1000 -3390.6363
       140 48002593.2087             nan     0.1000 -4888.2153
       160 47913223.4640             nan     0.1000 -26372.4017
       180 47807662.1950             nan     0.1000 -21229.4795
       200 47751552.0793             nan     0.1000 11728.7276

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 49584174.9816             nan     0.1000 -17046.0607
         2 49295900.7991             nan     0.1000 41019.4697
         3 48997480.2419             nan     0.1000 -24668.0350
         4 48756842.8246             nan     0.1000 -52456.5744
         5 48609320.2999             nan     0.1000 -21249.2279
         6 48538254.2412             nan     0.1000 11443.2563
         7 48465894.4390             nan     0.1000 1539.1420
         8 48332043.2075             nan     0.1000 23923.4629
         9 48299785.4698             nan     0.1000 -14535.3710
        10 48262313.7026             nan     0.1000 16019.1847
        20 47694988.4533             nan     0.1000 -15471.6367
        40 46871944.0464             nan     0.1000 -107012.8952
        60 46515817.2559             nan     0.1000 -43062.8328
        80 46064965.8564             nan     0.1000 -68900.9329
       100 45798544.0548             nan     0.1000 -52357.1548
       120 45470158.7330             nan     0.1000 -149424.0146
       140 45161540.5234             nan     0.1000 -35277.5832
       160 44721139.8961             nan     0.1000 -47281.3991
       180 44460877.7118             nan     0.1000 -75450.3524
       200 44172326.0932             nan     0.1000 -29286.0698

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 49219849.6894             nan     0.1000 6751.5063
         2 48844507.8069             nan     0.1000 -35771.7896
         3 48750463.0892             nan     0.1000 69470.0901
         4 48454456.2024             nan     0.1000 -55000.4780
         5 48377778.7553             nan     0.1000 -22432.2676
         6 48320789.6866             nan     0.1000 30018.9133
         7 48268809.0971             nan     0.1000 -3440.0130
         8 48201742.9786             nan     0.1000 56597.4112
         9 48022222.2165             nan     0.1000 52648.2918
        10 47876444.3302             nan     0.1000 20881.3398
        20 47052481.5692             nan     0.1000 -60938.1478
        40 45460654.8039             nan     0.1000 -18042.4400
        60 44702598.6546             nan     0.1000 -77720.9209
        80 43850911.5184             nan     0.1000 -46150.8965
       100 43329753.6529             nan     0.1000 -245405.1600
       120 42808906.8606             nan     0.1000 -212892.7978
       140 42375131.6880             nan     0.1000 -91101.4581
       160 42210186.3605             nan     0.1000 -161108.2364
       180 41715544.3214             nan     0.1000 -213496.7186
       200 41341362.1259             nan     0.1000 -69301.8184

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 49466931.4689             nan     0.1000 135598.5282
         2 49350876.1852             nan     0.1000 30590.2785
         3 49094318.1634             nan     0.1000 11745.9003
         4 49008782.5512             nan     0.1000 43397.5988
         5 48574882.2483             nan     0.1000 36204.3810
         6 48271975.9542             nan     0.1000 -20329.7789
         7 47987506.9477             nan     0.1000 19568.1589
         8 47720839.6115             nan     0.1000 -117110.9215
         9 47637231.7630             nan     0.1000 37836.8812
        10 47341901.6503             nan     0.1000 -62745.7809
        20 46015348.1151             nan     0.1000 -88829.4613
        40 45182978.1944             nan     0.1000 -37581.6253
        60 43998435.9864             nan     0.1000 -212264.0244
        80 43148854.5503             nan     0.1000 -188022.2204
       100 42126042.6514             nan     0.1000 -41690.5065
       120 41149853.9817             nan     0.1000 -37567.5389
       140 40603914.9087             nan     0.1000 -79194.8139
       160 40058477.6184             nan     0.1000 -105677.0744
       180 39459875.1832             nan     0.1000 -109740.6437
       200 38684730.5497             nan     0.1000 -52928.2212

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 28639955.5272             nan     0.1000 82282.9468
         2 28553691.4780             nan     0.1000 57067.8190
         3 28511600.3443             nan     0.1000 41126.0373
         4 28465282.7808             nan     0.1000 46160.4973
         5 28425709.8781             nan     0.1000 37702.2488
         6 28399342.5779             nan     0.1000 28665.7677
         7 28369519.8630             nan     0.1000 -11003.2815
         8 28345781.3899             nan     0.1000 16944.5717
         9 28304904.8539             nan     0.1000 3409.3465
        10 28264663.6218             nan     0.1000 23985.1065
        20 28062119.6501             nan     0.1000 -13616.2648
        40 27933691.8829             nan     0.1000 -14794.1006
        60 27849799.3375             nan     0.1000 -18453.0558
        80 27794482.2085             nan     0.1000 -1342.6295
       100 27687513.6582             nan     0.1000 -2013.9623
       120 27629288.8069             nan     0.1000 -18699.1113
       140 27588082.0424             nan     0.1000 -15066.2297
       160 27511813.7032             nan     0.1000 -22103.4265
       180 27467267.5320             nan     0.1000 -23378.0915
       200 27406093.8818             nan     0.1000 -26964.4709

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 28641936.7577             nan     0.1000 120994.5667
         2 28512449.4899             nan     0.1000 29154.8819
         3 28457707.6087             nan     0.1000 44304.6886
         4 28341051.9408             nan     0.1000 27690.6049
         5 28252430.8339             nan     0.1000 41621.4568
         6 28201387.1620             nan     0.1000 -355.8783
         7 28108309.6025             nan     0.1000 -35346.1758
         8 28059158.2201             nan     0.1000 -62488.9615
         9 27976448.0150             nan     0.1000 1774.3925
        10 27950736.8411             nan     0.1000 -25118.4136
        20 27534278.0657             nan     0.1000  879.0736
        40 27107796.3348             nan     0.1000 -21419.5779
        60 26839447.8704             nan     0.1000 -34736.0072
        80 26624746.8221             nan     0.1000 -30100.9939
       100 26462266.5223             nan     0.1000 -16256.5191
       120 26239090.4789             nan     0.1000 -19399.6994
       140 26066782.5126             nan     0.1000 -30245.9226
       160 25937545.5240             nan     0.1000 -8409.0443
       180 25733874.2874             nan     0.1000 -11233.7891
       200 25597093.7044             nan     0.1000 -27324.1054

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 28642684.0062             nan     0.1000 68423.3757
         2 28519140.6216             nan     0.1000 71340.1565
         3 28424705.2642             nan     0.1000 97970.7472
         4 28257257.1264             nan     0.1000 26055.0019
         5 28119343.2493             nan     0.1000 58403.5493
         6 28048055.8598             nan     0.1000 5801.3448
         7 27906297.8666             nan     0.1000 4796.1455
         8 27834178.0782             nan     0.1000 6730.4282
         9 27764455.5420             nan     0.1000 -7514.4850
        10 27682957.0053             nan     0.1000 -4977.4917
        20 27008583.3662             nan     0.1000 -133881.4346
        40 26512961.7736             nan     0.1000 -69964.9578
        60 26229670.8194             nan     0.1000 -28944.5431
        80 25915144.3533             nan     0.1000 -42643.0686
       100 25585602.2989             nan     0.1000 -34948.7329
       120 25358396.6111             nan     0.1000 -102920.6185
       140 25160018.8849             nan     0.1000 -50437.4464
       160 24966920.4941             nan     0.1000 -74564.0438
       180 24771125.3770             nan     0.1000 -23397.8169
       200 24591968.6787             nan     0.1000 -64522.9868

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 28509377.8338             nan     0.1000 67110.2720
         2 28315031.0548             nan     0.1000 12060.5306
         3 28064839.6594             nan     0.1000 77756.9433
         4 27915436.1812             nan     0.1000 14779.7020
         5 27837078.4582             nan     0.1000 53403.1928
         6 27719766.1412             nan     0.1000 -58444.0723
         7 27617163.4155             nan     0.1000 -32106.3571
         8 27511542.9941             nan     0.1000  346.3820
         9 27382880.2581             nan     0.1000 -45304.8781
        10 27349503.4067             nan     0.1000 -10298.0193
        20 26766629.5196             nan     0.1000 -54686.9517
        40 26227219.9050             nan     0.1000 -95021.9094
        60 25643858.8320             nan     0.1000 -49696.2299
        80 25281160.2035             nan     0.1000 -80311.6712
       100 24944500.0727             nan     0.1000 -66967.4010
       120 24669138.8953             nan     0.1000 -51018.8123
       140 24323257.5494             nan     0.1000 -25571.2111
       160 24002007.2600             nan     0.1000 -69596.1583
       180 23711350.6749             nan     0.1000 -23058.1084
       200 23407259.1615             nan     0.1000 -38216.4029

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 40797154.5081             nan     0.1000 58113.1447
         2 40687509.7454             nan     0.1000 38837.4315
         3 40643968.0958             nan     0.1000 9226.7561
         4 40592434.8019             nan     0.1000 31468.8639
         5 40552144.9541             nan     0.1000 30109.7710
         6 40515494.1847             nan     0.1000 28438.4796
         7 40468609.6373             nan     0.1000 7810.3942
         8 40443979.7164             nan     0.1000 6524.7429
         9 40413091.0002             nan     0.1000 6499.1175
        10 40372384.3473             nan     0.1000 2654.6905
        20 40194155.2188             nan     0.1000 -11840.7209
        40 40038242.1968             nan     0.1000 -10828.7195
        60 39949199.8462             nan     0.1000 4405.7276
        80 39915366.3397             nan     0.1000 -26559.6949
       100 39824319.8584             nan     0.1000 -6304.5580
       120 39769729.9934             nan     0.1000 -19107.9381
       140 39629327.6875             nan     0.1000 -2488.7897
       160 39535589.8680             nan     0.1000 -35093.7555
       180 39459221.3204             nan     0.1000 -16717.6427
       200 39386784.6164             nan     0.1000 6622.6223

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 40745798.2859             nan     0.1000 40160.2534
         2 40605432.3821             nan     0.1000 58072.7558
         3 40551540.0703             nan     0.1000 19113.8315
         4 40360334.6216             nan     0.1000 -1206.0024
         5 40292222.8099             nan     0.1000 20890.7106
         6 40027205.6787             nan     0.1000 -70041.8652
         7 39889958.8620             nan     0.1000 -86196.3574
         8 39831276.6384             nan     0.1000 -17298.8279
         9 39787097.2394             nan     0.1000 30248.5447
        10 39630499.6038             nan     0.1000 -136278.2409
        20 39028797.1794             nan     0.1000 -11270.3946
        40 38491322.3511             nan     0.1000 -44989.5347
        60 37967421.4180             nan     0.1000 -31350.1679
        80 37569991.4749             nan     0.1000 -277074.9455
       100 37165100.3093             nan     0.1000 -30197.5118
       120 36794689.0141             nan     0.1000 -162544.7214
       140 36469470.7388             nan     0.1000 -113735.0272
       160 36160061.4706             nan     0.1000 -16176.6868
       180 36007665.4943             nan     0.1000 -16708.1835
       200 35904339.8809             nan     0.1000 -63892.2817

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 40744080.0154             nan     0.1000 60691.5534
         2 40599942.3566             nan     0.1000 112476.1298
         3 40428036.2139             nan     0.1000 21907.0149
         4 40353834.8813             nan     0.1000 -26019.1118
         5 40060299.0193             nan     0.1000 -12208.9662
         6 39822706.7045             nan     0.1000 -67160.4760
         7 39699251.4560             nan     0.1000 32573.6568
         8 39384136.9773             nan     0.1000 -42276.0674
         9 39332220.4344             nan     0.1000 35937.7384
        10 39275489.1758             nan     0.1000 54639.8349
        20 38475844.9946             nan     0.1000 -15843.1281
        40 37387902.5584             nan     0.1000 -50041.7185
        60 36492988.1444             nan     0.1000 -241243.7639
        80 36118611.2959             nan     0.1000 -1440.2730
       100 35679408.6121             nan     0.1000 -14784.4454
       120 35199873.2570             nan     0.1000 -112935.4169
       140 34897111.1323             nan     0.1000 -38317.8616
       160 34482403.4509             nan     0.1000 -9255.2461
       180 34082074.0718             nan     0.1000 -46791.5627
       200 33671531.9124             nan     0.1000 -20173.1014

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 40779465.1881             nan     0.1000 51413.5925
         2 40366732.4829             nan     0.1000 3333.7738
         3 40276754.2769             nan     0.1000 40527.7902
         4 40000574.5477             nan     0.1000 32248.9536
         5 39723850.1696             nan     0.1000 -13912.3200
         6 39438135.3144             nan     0.1000 -87195.3750
         7 39370484.1178             nan     0.1000 -46733.5606
         8 39318967.1878             nan     0.1000 -18741.4161
         9 38954420.3334             nan     0.1000 -204021.1535
        10 38758374.6966             nan     0.1000 -197233.6144
        20 37586902.5993             nan     0.1000 -27756.5819
        40 36408787.9546             nan     0.1000 -121157.7729
        60 35461495.9221             nan     0.1000 18463.9489
        80 34640625.8519             nan     0.1000 -25659.7041
       100 33959095.8657             nan     0.1000 -65557.0506
       120 33487610.5610             nan     0.1000 -58979.0626
       140 33173509.1573             nan     0.1000 -31080.5227
       160 32499505.1247             nan     0.1000 -136411.7391
       180 32058038.4672             nan     0.1000 -8757.9380
       200 31477903.7961             nan     0.1000 -36062.9843

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41673943.1022             nan     0.1000 74276.1949
         2 41582571.5341             nan     0.1000 64000.9594
         3 41507316.0395             nan     0.1000 16824.4649
         4 41473096.2739             nan     0.1000 35717.4746
         5 41434546.4862             nan     0.1000 30119.1238
         6 41407314.8285             nan     0.1000 26229.0628
         7 41381352.8551             nan     0.1000 19148.8179
         8 41357086.9451             nan     0.1000 12245.6691
         9 41320495.1478             nan     0.1000 -27461.8625
        10 41283380.2514             nan     0.1000 16232.3040
        20 41129469.7366             nan     0.1000 9520.3353
        40 40961718.3469             nan     0.1000 -11236.9728
        60 40851578.3272             nan     0.1000 -5149.7922
        80 40766280.5282             nan     0.1000 1261.9991
       100 40700277.4268             nan     0.1000 2128.4263
       120 40654585.3061             nan     0.1000 -7064.7502
       140 40594495.6640             nan     0.1000 -1948.4322
       160 40553163.6494             nan     0.1000 -15572.4079
       180 40526421.5831             nan     0.1000 -21484.2681
       200 40510378.6962             nan     0.1000 -6070.6279

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41672228.7455             nan     0.1000 97564.0012
         2 41484149.1701             nan     0.1000 81886.0323
         3 41413402.4040             nan     0.1000 34496.2053
         4 41372387.4328             nan     0.1000 18104.0768
         5 41327340.2579             nan     0.1000 33357.7071
         6 41211466.3797             nan     0.1000 -1903.2354
         7 41011084.7724             nan     0.1000 -15555.6259
         8 40758439.3130             nan     0.1000 -53844.2464
         9 40570241.6795             nan     0.1000 -77844.8684
        10 40517142.9041             nan     0.1000 -16515.6744
        20 39787498.5467             nan     0.1000 -299156.0449
        40 39356088.6875             nan     0.1000 -96651.3932
        60 38888010.4506             nan     0.1000 -11066.6022
        80 38597020.8233             nan     0.1000 -17058.2654
       100 38205347.3984             nan     0.1000 -117384.1155
       120 37898248.2229             nan     0.1000 -62165.5643
       140 37619135.2839             nan     0.1000 -103106.7243
       160 37428646.4773             nan     0.1000 -169416.4506
       180 37174970.0601             nan     0.1000 -8475.3210
       200 36912740.5042             nan     0.1000 -44090.6436

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41722607.6874             nan     0.1000 70669.4025
         2 41609148.8938             nan     0.1000 54295.0720
         3 41512224.3065             nan     0.1000 55008.7537
         4 41384637.2798             nan     0.1000 49886.4945
         5 40988484.1341             nan     0.1000 35750.6126
         6 40392755.9423             nan     0.1000 15114.2637
         7 40316633.0158             nan     0.1000 8690.7207
         8 40062357.4551             nan     0.1000 -166423.9316
         9 39883773.6864             nan     0.1000 -126086.9993
        10 39838626.4052             nan     0.1000 18124.0395
        20 38640488.8512             nan     0.1000 -208792.4645
        40 37257361.4560             nan     0.1000 -7293.0632
        60 36564890.3874             nan     0.1000 -213160.6360
        80 35739540.2961             nan     0.1000 -39566.0271
       100 35351939.9085             nan     0.1000 -64617.7899
       120 34647274.9102             nan     0.1000 -247486.7543
       140 34103921.3133             nan     0.1000 -166257.4024
       160 33845068.1835             nan     0.1000 -249432.8732
       180 33449339.3774             nan     0.1000 -50589.1729
       200 33157158.2886             nan     0.1000 -86782.5854

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41643643.3622             nan     0.1000 56300.5577
         2 41468675.9800             nan     0.1000 34956.8157
         3 41192887.4225             nan     0.1000 53158.5547
         4 40855755.0237             nan     0.1000 -56006.0665
         5 40819783.6989             nan     0.1000 -56405.6780
         6 40754844.2652             nan     0.1000 44487.3008
         7 40694405.6246             nan     0.1000 19848.1182
         8 40495875.0908             nan     0.1000 -53948.3085
         9 40402306.9434             nan     0.1000  323.2538
        10 40351009.7327             nan     0.1000 -90589.3959
        20 39057656.6753             nan     0.1000 -140648.0610
        40 37453928.1229             nan     0.1000 -217400.3267
        60 36010306.1392             nan     0.1000 -136410.8052
        80 34923353.5452             nan     0.1000 -101206.4160
       100 34246421.9931             nan     0.1000 -220602.2828
       120 33581387.9693             nan     0.1000 -95909.6063
       140 32846664.7845             nan     0.1000 -295718.8898
       160 32293836.1881             nan     0.1000 -92310.4472
       180 31969957.9723             nan     0.1000 -124561.2803
       200 31582942.4350             nan     0.1000 -205145.6984

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 45722563.4198             nan     0.1000 85494.1565
         2 45660171.3854             nan     0.1000 9199.6444
         3 45549602.4489             nan     0.1000 82372.5311
         4 45494451.4391             nan     0.1000 66764.7038
         5 45412358.0318             nan     0.1000 33830.0209
         6 45382885.7107             nan     0.1000 20735.6069
         7 45331874.7113             nan     0.1000 -11500.4741
         8 45255754.5845             nan     0.1000 15266.1793
         9 45244228.2487             nan     0.1000 7091.1113
        10 45220658.8621             nan     0.1000 16518.3757
        20 44964327.8012             nan     0.1000 -3009.7590
        40 44727827.1967             nan     0.1000 -10155.4407
        60 44606961.7692             nan     0.1000 -22553.7418
        80 44504605.5903             nan     0.1000 -5749.2157
       100 44420263.6294             nan     0.1000 -28391.9794
       120 44313402.8457             nan     0.1000 -7791.3674
       140 44242291.5530             nan     0.1000 -28314.4844
       160 44178210.0817             nan     0.1000 -39278.0906
       180 44084661.3389             nan     0.1000 -8057.5474
       200 44018626.5077             nan     0.1000 -9901.9154

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 45811240.8237             nan     0.1000 81767.2180
         2 45560290.5793             nan     0.1000 7217.6406
         3 45351426.3762             nan     0.1000 -9409.2907
         4 45070319.4977             nan     0.1000 -7545.1478
         5 45002537.9668             nan     0.1000 73692.6604
         6 44938356.4293             nan     0.1000 -21088.9821
         7 44871495.8893             nan     0.1000 50562.7657
         8 44786894.8997             nan     0.1000 20670.1134
         9 44705613.8752             nan     0.1000 2485.1516
        10 44599552.4345             nan     0.1000 9166.9793
        20 43629350.3569             nan     0.1000 -180183.4688
        40 42933243.7515             nan     0.1000 -42955.9916
        60 42471946.6894             nan     0.1000 -85352.7243
        80 41733628.1848             nan     0.1000 -33749.2936
       100 41312331.6922             nan     0.1000 -28922.3302
       120 40888803.2958             nan     0.1000 -152182.7902
       140 40607666.1633             nan     0.1000 -48266.7626
       160 40339852.8543             nan     0.1000 -58911.1149
       180 40002159.8032             nan     0.1000 -21921.5681
       200 39718775.8499             nan     0.1000 -41255.2425

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 45741461.7687             nan     0.1000 89973.7054
         2 45504933.4855             nan     0.1000 47870.0016
         3 45384904.6269             nan     0.1000 17457.0556
         4 45127861.4906             nan     0.1000 -65565.7904
         5 45029150.0958             nan     0.1000 42535.8064
         6 44882259.5614             nan     0.1000 61109.3746
         7 44749695.0853             nan     0.1000 15177.8889
         8 44478558.0895             nan     0.1000 -10507.6587
         9 44382233.6984             nan     0.1000 24517.7521
        10 44063452.1399             nan     0.1000 -99893.8297
        20 43147315.5694             nan     0.1000 -40691.7071
        40 41898689.1172             nan     0.1000 -78251.2780
        60 41022865.1952             nan     0.1000 -185426.9948
        80 40110847.0625             nan     0.1000 -17129.9364
       100 39237493.9610             nan     0.1000 -121424.9149
       120 38687210.8487             nan     0.1000 -52864.5468
       140 38129447.0157             nan     0.1000 -88032.0258
       160 37658782.5225             nan     0.1000 10471.9465
       180 37202052.6365             nan     0.1000 -18407.7802
       200 36826918.2308             nan     0.1000 13518.6601

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 45378233.9588             nan     0.1000 98150.7336
         2 45208766.9735             nan     0.1000 88097.6750
         3 44872344.0728             nan     0.1000 -22188.4243
         4 44726050.8736             nan     0.1000 136893.5280
         5 44518506.1997             nan     0.1000 68544.3250
         6 44353847.1953             nan     0.1000 1043.2233
         7 44250497.3697             nan     0.1000 41200.0411
         8 44135961.3443             nan     0.1000 -13033.0774
         9 44023152.7539             nan     0.1000 -3206.9866
        10 43527567.8493             nan     0.1000 -68665.2411
        20 42123361.3382             nan     0.1000 -42163.0747
        40 40336910.0885             nan     0.1000 -29261.4750
        60 39070796.2434             nan     0.1000 -173196.7713
        80 38452352.2724             nan     0.1000 -144539.4562
       100 37952385.5118             nan     0.1000 -34042.7536
       120 37308027.8603             nan     0.1000 -52197.5239
       140 36455500.9285             nan     0.1000 -43000.6982
       160 35737145.4118             nan     0.1000 -205733.9010
       180 35312285.5687             nan     0.1000 -21914.0525
       200 34886240.6698             nan     0.1000 -125897.4036

    Iter   TrainDeviance   ValidDeviance   StepSize   Improve
         1 41289778.8692             nan     0.1000 90527.2220
         2 41232313.4456             nan     0.1000 74601.5181
         3 41158709.3771             nan     0.1000 41294.6354
         4 41093005.0259             nan     0.1000 24883.3049
         5 41016082.7018             nan     0.1000 -7423.1704
         6 40977640.7206             nan     0.1000 13417.7075
         7 40942997.4421             nan     0.1000 12784.6314
         8 40917956.1683             nan     0.1000 17982.4428
         9 40900645.1156             nan     0.1000 12196.1885
        10 40879898.9687             nan     0.1000 -6271.7184
        20 40684197.7090             nan     0.1000  922.2296
        25 40614605.5755             nan     0.1000 -188.4844

``` r
test_pred_boosted <- predict(boosted, newdata = ChannelTest)
m4 <- postResample(test_pred_boosted, ChannelTest$shares)
m4
```

            RMSE     Rsquared          MAE 
    5.172796e+03 8.761744e-03 1.867260e+03 

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
    1 First linear regression  5160. 0.0127 
    2 Second linear regression 5194. 0.00127
    3 Random Forest            5171. 0.00962
    4 Boosting                 5173. 0.00876

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
      model                    RMSE     R2
      <chr>                   <dbl>  <dbl>
    1 First linear regression 5160. 0.0127

When comparing all 4 of our models, we are looking for the smallest
value of RMSE to tell us which model is the best. In this situation, we
can say that the smallest RMSE is 5160.3649905 and this comes from the
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
