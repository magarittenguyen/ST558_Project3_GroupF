ST558 Project 3 Group F: Lifestyle Summary Report
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
data_channel_is_lifestyle: Is data channel ‘Lifestyle’?
<!-- str_to_title("social media") ->> "Social Media" -->

Here, `read_csv()` is used to read in the OnlineNewsPopularity.csv data
and we are subsetting for the data_channel_is_lifestyle: Is data channel
‘Lifestyle’? variable.

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

We now subset the data for the data channel of interest: Lifestyle.

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
       n_toke…¹ n_tok…² n_uni…³ n_non…⁴ n_non…⁵ num_h…⁶ num_s…⁷ num_i…⁸ num_v…⁹ avera…˟ num_k…˟
          <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
     1        8     960   0.418    1.00   0.550      21      20      20       0    4.65      10
     2       10     187   0.667    1.00   0.800       7       0       1       0    4.66       7
     3       11     103   0.689    1.00   0.806       3       1       1       0    4.84       6
     4       10     243   0.619    1.00   0.824       1       1       0       0    4.38      10
     5        8     204   0.586    1.00   0.698       7       2       1       0    4.67       8
     6       11     315   0.551    1.00   0.702       4       4       1       0    4.38      10
     7       10    1190   0.409    1.00   0.561      25      24      20       0    4.62       8
     8        6     374   0.641    1.00   0.828       7       0       1       0    4.91       8
     9       12     499   0.513    1.00   0.662      14       1       1       0    5.08      10
    10       11     223   0.662    1.00   0.826       5       3       0       0    4.55       6
    # … with 2,089 more rows, 48 more variables: data_channel_is_lifestyle <dbl>,
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

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAqAAAAHgCAMAAABNUi8GAAABblBMVEUAAAAAADoAAGYAOpAAZrYHrbEMwscTjZAUxMkfa20fxckhx8wzMzMzycw3zdE6AAA6ADo6AGY6OpA6kNtNTU1NTW5NTY5NbqtNjshVz9JX0tVc1tlmAABmADpmAGZmOpBmZmZmkJBmtrZmtv9uTU1uTW5uTY5ubo5ubqtuq+SCTkqN2duOTU2OTW6OTY6Obk2ObquOyP+QOgCQOjqQkDqQkGaQtpCQ27aQ2/+R3uCZ5eerbk2rbm6rbo6ryKur5OSr5P+xXli2ZgC2tma225C22/+2/9u2///Ijk3IyI7I///NaGDbkDrb/7bb/9vb///ebmXkq27k///ocWjr6+vuc2rwvLnydGvy8vLzoJv0dWz0wL31j4n2dWz2hX72op33dWz3d273eG/3eXH3e3P3f3f5d275eG/5enH5fHT5gHj5h4D5k436p6L8yMX/tmb/yI7/25D/27b/29v/5Kv//7b//8j//9v//+T///8iL7evAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAgAElEQVR4nO2dj4PbxrHfJVupG+ssP1dybEXOa/uUl0Znx63dJk3s1E9Uf1j1qfXJR50Kh0Ge7sg7giAludUv/vfdmf2BXWCBxYILYIHbrxMdDwQXXPJzszOzs4tL26Agj3Wp7zcQFFSlAGiQ1wqABnmtAGiQ1wqABnmtAGiQ13IB6NQX+fNO2pQ3vXSAjlkB0MHJm146QMesAOjg5E0vHaBjVgB0cPKmlw7QMSsAOjh500sH6JgVAB2cvOmlA3TMCoAOTt700gE6ZgVABydveukAHbMCoIOTN710gI5ZAdDByZteOkDHrADo4ORNLx2gY1YAdHDyppcO0DErADo4edNLB+iYFQAdnLzppQN0zAqADk7e9NIBOmYFQAcnb3rpAB2zAqCDkze9dICOWf4CGkWR5Sv29vZaeSeeKQBqq1Z6Hx0fH9sRurd3MQgNgNqqld4HQMsUALVVK70PgJYpAGqrdroffNASBUBt1fcHJeTPO2lT3vTSATpmBUAHJ2966QAdswKgg5M3vXSAjlkB0MHJm146QMesAOjg5E0vHaBjVgB0cPKmlw7QMSsAOjh500sH6JgVAB2cvOmlA3TMCoAOTt700gE6ZgVABydveukAHbMCoIOTN710gI5ZAdDByZteOkDHrADo4ORNLx2gY1YAdHDyppcO0DErADo4edNLB+iYNSZAHdaD2hejdidvPm8H6Jg1IkAdVtTbl/N3KF8+7wCopQKgHcsBOmYFQHUKgNaRA3TMGhGgwQftWA7QMWtMgPrz1bUqb3rpAB2zAqCDkze9dICOWQHQwcmbXjpAx6wA6ODkTS8doGNWAHRw8qaXDtAxKwA6OHnTSwfomBUAHZy86aUDdMwKgA5O3vTSATpmBUAHJ2966QAdswKgg5M3vXSAjlmVgL74zXf5Q68+u/HRD9vtwxs3bvyCP9n3ByXkzztpU970shUg86oC9HnGINebr7/YPvx4u73/hXSw7w9KyJ930qa86WULOBZVAej9D78BC0psJnL66vPv6D/Err75813pxL4/KCF/3kmb8qaXbbOJMg/x9++gzaSAvvjtD9tXv7tLoL1xA40olLh18kaDLqaMgBIcgc3nN0B3nn+EgL74x7vbzIr2/Zcs5M87aVPe9LIDPOsACsbyw7uqBcVnhR/a9wcl5M87aVPe9LJtNlFmQD9ngZLsg+KBAGg/8qaXbXIpVMsHhYGd6s3X6JHCgTf/JaSZepE3vWyXTCYzoGSM/zCL2bM8aHaw7w9KyJ930qa86WWLWGYKM0mDkze9dICOWQHQwcmbXjpAx6wA6ODkTS8doGPWmAB1fitEPxcfe/N5O0DHrBEB6vxmsp5u3+DL5x0AtVQAtGM5QMesAGi5AqDVcoCOWSMCNPigHcsBOmaNGFA/8dpd3nzeDtAxa0SA5oZ4Twfo3eXL5x0AtVQAtGM5QMesAOjg5MvnHQC1VfBBu5UDdMwaE6D+fHWtypteOkDHrADo4ORNLx2gY1YAdHDyppcO0DErADo4edNLB+iYFQAdnLzppQN0zAqADk7e9NIBOmYFQAcnb3rpAB2zAqCDkze9dICOWWMCtHE107BS+t583g7QMWtEgDauBx3YpKgvn/doAW3LXgVAO5YDdMzqHtDWcAiAdiwH6JgVAJ0GH7ShHKBjVgB0cAqA2sqyX63Zq4vBZwDUWn1/UEL+vJM25U0vHaBjVgB0cPKmlw7QMSsAOjh500sH6JgVAB2cvOmlA3TMGhGg0WQSgqQu5QAds8YDaLS/v38hCPXk8w6AWmrMgN68eVM89ieZ5gAdswKgA9DNTz/9lBPq0XSEA3TMGg+gWh80iuJBTWPqFQDdTX1/UEyary46nkUzmFgd1mx7XgHQ3dT3B8VUAWjz+X8/yA4+6E7q+4NiagNQHyvxfPm8A6CW0g1+zAcNgLYhB+iYNXJAuZqO1AHQCjlAx6wRAdqKd+aHD6rIm8/bATpmeQToziyEPeq7lQN0zPIH0J1H03CXj47lAB2zAqDlCoBWywE6ZgVAyxUArZYDdMzyB9DmkTZ/XfBBu5UDdMzyCFBLcXqEnWsjzeSjAqC26uXTEVzWAdTTwbqZAqC26uXTCYD2LgfomOUC0F60efr06YY+2tCfCKjp5KCBabAWVONWVgRJ5T7o8LzTYEFt1fcHxdQozTS8wb/QSbkWr1M5QMesAOjAAC30Uq5m7lYO0DFrzIDWGb0DoM3lAB2zhgOoEbf8V8fYM7xuaD5oANRenXwaZlOnB7SJifQa2uCDWquTT2M3QDXIVQT2fg/7vrhUAVBF9oBSBPF1mhdXtBcArScH6Jg1GEBr+aCTSfEceF0AtA05QMes4QBqFOFzf18fFmmQi2ezUgoLDXjllPryeQdALcUB1RnAInLHs1lct2W/TKovn3cA1FJVgBZkxVwAVCsH6Jg1KkCpD5rhVDEyB0B3lwN0zBoXoDSKL5Qy62TlVvrkg7JO9pb9zOQAHbPGCCiXveHzCcQSsV72N3+UyQE6Zg0C0Hrc7A5o7gVe4hoAtVfbH0RN0IrVTLaEqRfyy/PkCoDaq53uY4IdCcuTUsLd7vfqHAKgwQe1Vyu9BzxiVo+UG3lLqpTKATUVNOnDfk8BDVG8tVrpvQRoDrCyKqWSqU55fZ0e1DISvfRBA6D2aqX3MqDFZ/SAHh4c6Ejjp5aC6KmpLFEA1FbtdD/zQXXP6ACdHEwmswaAej73nlcA1Fb9fDxFH7QMUH5qbUvpt0kNgNqq7w+KaW+yf3BQWQBS1zAGQGvJATpm9QFoSwMoxEgTJy0FQGvJATpmdQ5oFOlDH/mMZnA43H4x+KB15AAds7oGlBin2awS0Mbmy6NbXLWqAKitbDoVAN1Vxk52NsfkAB2zegD0uPr2mRcJUGTJDihjL7ubpXeAjlk9+KAm+ho7gMPjE1iyBCoAaq9OPo0a2glQnivtMjzqANA2x3sH6Jg1qjTTDoRGxbqU9lltBVCFyVbNqQN0zOoB0LayjI4B7SIZ2oYPql4gALptA9BGxmuAgDZQANRelv0StRuON0dqtP1i/uTsNZ4CauFpg2kOPui2qQ8KGdFYT0BDNnZeMye/vek0jmvv7NCp6n7erYfzDtAxq78oPjqeRSW7zzRFK7ciqVkrxuK8vlXbgAZAmZp1rwLQpgF0AFRWAJSrYf+iuHrO0165r64Z5qMBtPU5TwfomNVron7nu3PmDmtXJFk3LNZ4elrS5M10mQN0zBriTFKJbYuO93c0ed4aTUUBUFt1/cFYAGpnBUcBaHcL5h2gY5bPgJZNj1cCusvS9jEA2uGWIw7QMctjQDXT4/wZPbngg+62OYivbqei+oC2bEwdoGPWIAFVnpe0lzvoPk/gg2oD2rYxdYCOWb0BWr7snYvtIt8c0Iq5Ktt36pNq+6ABUKYGfUPbVrJ6TqxiZ7vIlwGiBVQ+O5rNsmXy5j+Isrfqm2NaPw9qC6ilS+AAHbP6AZTOIlXtbFMFRmmiMvfVxeQEPp1evpOO+b0OFVBb4GyBdoCOWf0s+VAAjVDZCcaNasSypjyh+ZkkyYJeSEAtFQCd8q+beYd8k6VsnWcUxwKjiqGdvqCATh5Q1R8lgBKnwX6YH5gP2lwB0GkWmkueogRoNIuiWdmiT2mb2QxQ5eT8V6cYZvKYhF2GNc9DUHszScEH1Q2YBUBL+JG3mY2FHVZ4M3115kX5Q1CY6rSVVa809ynMfNB6gIpW8tvolHx14pI1AfVtTM8pACr04jff5Q+9+uzGRz/Agzdff8GP7dBH4nNGut91t8/WBStRDUDldUZyPFY/feWXAqBcz2/8Ig8oYPnwY3j08IYDQPMWs/IWXFqgoiofdFremNUEgF8KgDLd//AbsKDEZiKnrz7/jv6DdvXFv/v37gHNNpNvuChJfxH9bjt1AO1jNwejAqBCiOL9O9RmIqAvfvvD9tXv7m7f/Pmf6BAPKymbX32z3pD/Zb8+ffp0ozywU8k72WxSTXvl19hsNsopDd9NW7L6vG/dutXW++hGRkABR8Lm8xugO88/ooA+vNOGD1rrNrAVKrUt1S5D6cVM5Sr9yMaCjnxdPAL6GQHzw7uqBSU/3ACa045jafGrY0uHKxErvwFiALRS7dO5rQPo5yxQkn3Qh9SestPa+gCsVfjqxGx8FfkVJaSswsQXH5Qm0gOgQtwHfU4zS1uI4plH6ijNlJc5Uq9SOaBVbSlFTwVz6ZH5ZLRZBUnj3lnkBYviYYRncpwHzalAA5owDSJ6Zs2AatsaM6BtqjUoZflSUa/cNlae+jmOdGs+9NSU+qCVLyz3QSsu1YdqANrpLWYdoGOWJ4Aq4YgUzNsAGkXmm9Dk/M3CzZR1HoAnDui0hg/a7U26HaBjll+A5u9yyIAtTt/rDeG+GSW5LbamJLejXfUO+h4oAGorB31VY+fCVE7xfO3MUCmg+tirWJkyiHKnAKitXHSWBDNS/lHegaZ2CxpAK2/SaQCUF0x5R2vwQW21a0e1dy+2D06KPmj16hGxKk9pg5WaZiWn3tnTEMXbqlHvMpPJHE0l2WMMXbTKf3XCyaxcPqo5Wr6qpLHc2bYAqK0s+yUtm5MG4HzKUnZE9QawiFdh0Rwfwyt2G9dDSgGNjfcVrS2H3mEA1FZ23aKpI2LccoAuFqpDmJW6aWN23aYhe8ortWO47s0Uj8aCTlcx/cUB9PWXl0CX/yiO/PR3f+Q/+UPpqKJnb32bO9IPoDGxnwuxvzIOqiWLPUqWC+u3Z95Tvdka43NZmT7uSOLSAb1IgF6HHw8y1CRApfM8B5QgoBinMmtH7W0hqo+OF/GiQM8kn+c333ZRl9Eybx3RQBfGB2WAvvzkdh7FgQBKB+08jhmI0+Jx5QE9PIviRQHoPKD13kzuQvI1/csxTQcEKCKI4/rvL116+3s+xP/0PvEAbm/xKPmJPgFw+fKTS5d/7wOgIB5fZyrxNcuWKUEDBf9wwqfy1WfyK/O0apI16EcIaKcJzxJVAnrvrW8FoO+//f3rL68wQOnR92/DUXAE4Jntg7e/f/nJdcKoL4DWWKIpHdfkSaPZbFEIk/bkxHxmG6l7W0ldFM+9n0HiAkAbubSuoS4DFIMkQloG6O1tRudPH1AG+dFn1Hrexp8Phggo8TcX87xZ0wMqNZRFVhTQylxVRDziU8XMemxE84DW5c75PGgZoNfZIwHoB9/yIR8O3bt06Yr07APk+dJ1YkTJ7x94Aqi6G2LpdnX06II4rIUpH92seR1AtVuEFy7h4wwSVw7Q2txVnNjMtjYEFL3NzAFAMLc4yvsEqJzJNNBQBqjigyJ3e/wR8TrnmZeLPmh+fZHiN0iXoAAXfWR/lPNBHQDa0LbWBjT7yUN3KYR6xjKmOMQbonjyMoS7C0ALU0nT0nF1TgATgOqtLW1ib8ryVdD4QsoT4M5hSKCaQhJXFtMEfN61fAue3pWL4uvTVWonWwIUwp7XX17OBUnIoITt6y+J6SSUvvzkijFIuncFvNQHV3oCtNSSZnXxuQmkXJIIAcUN8lRApSE/dy0R8KvJgkhs1FjtffSifJpp99inJUAxofQPv6JppiuCymd0nokDilEVWFFzmokYUAC9aGbbAVRsIC82ZDJm2HMTSPnKZhlQ0qZ299pcBZ6+iEq8gHsSPvmkLeRBXfqgjpUDFKxyN4BqUuTmOUrZ7KrYZD4ouo9RNBfl8mxSPbecuKxUVJSB8uUmGIs1ALS1TKXniXrHkgElxhk81nudDPGZioazbFpJMrva1Up7UisiKMLNxiMlD2qslJKv0BDQ9orbLy6g4DNc2d5jYX997dhPOUbK4NJViEhbKPDVSkokr9xMlofjtCiFvVa/TK68MFSqYLY1oNaA1jW5FxjQhmreRWVZhZTa1M576tYtKajp7tU5Iw4uDPnHs8WC+5X5Kk/DUrlm8ZH9PWDqvoAC6sFcpwN0zOr3dtzqlKSSey9ELzmsNLZwdlBIDUE4PqfVfATU2ZzdnSk3V9/KUjlbguwArUhq2pPbEHYH6JilAvrg0qXbD7ob4nMzPionquEquf9BJI2/MRniC/n82WyBpZ2zaD4/xRpUifOi6Rav6z6r5AjQBr5vU3fZHYUVUvOgb/8vmmmyU4O+UeV8TdnHlM/i9cy6YVgK5rUWdHY6x7rReBHHpwsIseTclLiXnWbQ18T27crKB72QgGKa6XbLaSYprsGHkSkGwcg9lqd28icLf7RwO26oAiH/0WiJm+B8mRM+VCvydl9i2qKqfdDeAf0/eg0F0OIEUi6hqX8FSL6roUiFygf47bjlFfYC0PwTilk2AdkRoPVsaO2byTq+bkGdA7p9AEM85OrtZNMpaZa8VjZSzmRO1ZOLq0EmUZT3J+MZn/LUlDEJq6ob0uXzuwG0piXzPM3UJqA4TXrJlk9bQPkkpOQM6pZoZiNx7lkZUHV+aJ+udtJO1+uKSzT7M+Tnt7K1pTa9bKYAqEY93MhLFMJJQ3Txvu4VSzBE8A15I77dA1i8fV2Ws9jcdMq2icjSrcWFJblypy4UANVIneq8XXpelSz7VRxPbdZ/SIoxhxQJfyHe19Qk65tDQDUzqr0C6sYH7U56GtoNkhq1YduxkihcfdYY3VPLu5hldZzxYdEO56dGs1ssmzYe1a2E6kBmSOsB2sFMk56GdoMk2xw9aueeauORLLovL75TAJ3NClOdOd4yr5XmriTXouwejF1n7GsM87UA7WIjRj0NrVrQS3xBXreAyioCWlrbNMUddIQPGhfn4vMDu1S4jLvbxKW3WS6vIWlXnQDqyLp2DmhTNeyf/vtXdqTDf3AJfNXGI+Lx/nHOCuYssFK4rAzyeUDpNXvIzu8EqAReVTuurKuehmpAcbGxZm1cqfoBtDw5n00/crZoOl0CqDRBycrtCsV0uXFeXjvPjXO0iGNpI7yYBF+zzgBVDNoOPqgCXkU7N9977z3lyZYS9X/72980gOKSpIaA4qYkHQzxZSHKVB7hswewPkialdSFVFR7mhNKAx2e4qdvZrZYZH8XdP5JKmNpday3NWj1AK3QuwTId3d4A1wGQP/2l7/85W8FQD/4r1cooDWXZ+Yq6l9/eds+lrfuWZbkKT4l8pJqajJbB1xRyLGXtV5ssvTNsHiJmVLwAuIF7vxUTI62os4BzVvQbgH99t5tBPTe9e2zGkF5Ps1U82W7AUo3q81voTTNuFRH7hjPLyxhmhZ+1wFaUiKVPR3Tuf5slRy8XF6z3BzQvVp65+c///k79U41tfROdTvs+fwF8fcG3WsI6Mt//T38+/fEiP5Ks8GdAdAHXazqZAjJszgql4rbGPPtjvM+aK5mme9RjzWgcYn1y/1VUIM5O57NY7blHr1errbJuBFuQWQQvXmz5o2zu7pl9q2vvvrqlu6C5Pcm2X/9VQw+KLGdD66Tf+HB6/9oBygslyN0WmdDrXvGAiBM8rB/1XkbaaBHOun/9EtAGD7QDr3LR0wenkolUwAfewU1l1LlCV0CSiusuJ+bm/2cNtln5Oan791879N37D5HUJuwCkA1agNQbRSPXP6hmQXFNff35M2b68m+a9TbQ1YYHLqaDZYVMgAqQbbPUkaLeJEBmq2QZ8O3VJrPN76j+VDlxl5qAst2jG8KaBVDO8sXQGko38AHbSrLfmW1Hos5BYsFKflwmactwQUtloAwqtgzMqDq/uIs4pnKgPIhmw/emon3EQKK5rnERHcKKO6y2CCKbyq7bglXj286R5eyRQU+lYJPMm4Xit5ncXbDGPx1wleJxpKnma9ZjqMsqSot+hCmU764+MU6z2Tjg0pqF9CKC3QFqLW6z4OyvWmOj2nZnbTCuDSBFB0rAzM7xjxQCe6JPnM1X+Tq+zKfssK7dJD8tAe09YBp0IDaL5ejsuuWADTOhURlc0tRpAKqBO/Ka/KAKoVR8nFxZV2ltPzS3dQAUKGWSB00oB2V280XC2o9c/kiTUoooimpWAaU20xNrftETdHH+cpotWVmmbXlUmqBSlNaJUBLeCvFsLWxvmcf1FrdFyxjIbw+s6grHmZJ+ljk26PybRZUQM2bfGZ+rK4MqmDhrZUBWsJbOYatO6M5DQJQ+xQ9lV236He/vz+h0xiTyaRk3uPw4ICcdEhOOJQPT/b3H//18YHuVZOjo6MJa5G86mAyOTgsbR7OOTiAduiF1Gf29/cP99mbHDSgNV0F/wHlxaANgiQ7bZ4+fZo+3X+6yX7bbHTnrTfkf+THes1OZadtkvM0TVLpCFdCzk2gxQ20u4bf4BfpNHwI/+CDdLXCK9ALyY1tUvKmSAtwlT3aop2Qix0AdeGDYlbJADq/zC7usqo2LWhDWf7hYZZ+wr5xBEn7/XM+BJcCk5SAtdzIR5hSkAAUwKd/DeI0fE4c42TihZTG6C8peWcbMC4NskxYf7GDD+pAyKYBUPG0/xZ0BzXom/juANDVapUWW2WgCbsmA7peryig65SjR8jcApEpxYoZXgYjP40CSp6SAN2kaxXQDR5ikG/Yd2fJaAHQtqQSrvw2OkAfXP4jDvStrovnEt/dZpMw3vLCkThn/ejDNEk2eGS9WdNjzBiiAUXDyz0DGN+l06ANwJgO/XAqOUQGempX+Tnk7VDTKgC1dUO7AlTlT/dbtY0eEqCwuTJkQtvdWYRrTxq7V8n5MuHO4Zb/oO4iw0a4jUzslGS1plaWAboVr5B8202arCXrSNglFjtzRrmPIbkS67XsXTQBlBapm4f4BipayZLf6JmGCwsftMF3qG+xLUDx5gy4YqT9aqYpfHeZySK8LJPMiGVO5GarHMrED9MxGljUAMp824KXm8HMzs89nT/QCFDWSS53WSOzzaw4vVz+A4pZerypUic3UdijHiQaOYInGebzgMIYDS5lmh2S/dFVksrhDfqgKPIKPGXDfM9iniBZrZ4qxli1zelmIx3bbLDKtFGu3g7QekZWZyUrmhgZoGg8OwN0vVltaEADoU0OUOYpsuGXR9/CH10R9lLFym75U2I4p75nIdZXLWhOwqfIfu43nvS0ArQmSpa2eDyAwjQSnYy3vouCfdeiaAKhDqEME5FpQk0ps1oYA7FYm7mD8AzL+qDS8wRMHTWbagZTwjhdq4ZXzW9q1RKgRdtWPFATJUtv1q9EPSPMouYjC5KI9UQX9Nml9hfNHR/vQzpos2R2cJ2kYvQmWG3SVcoTRCvhXEqGDy1oep7jj47OzAzLIVYWAEEbaSH1z1++gTbB6KJFdwpoXkUc5SN1Iaw8z4rkNgD95S9/WbCgcGs5i0XHSprpHmSY4N6K9V9NZd0zAugBgWS9JjYUghzwRTkzwGS6hqCHBu7CbsqGD3zQ81VuBOdDuoQmTwsIUBVAC77BinAJfzPQkEidUh+0kawAlYCqbUyrzrPzBVoA9Jd/+tOffpkHFKznvetbXq78zDhv2UuingNKc+gpBxTCmwxQ1riYUEKbxp2A9WqdwHly/jJdi3wnZAZWGx4vsYw+8SQSsMfnLEbapFKwjjHVingdy6dy4hTUfDc5O0BrPum0EfFH0RmgL3/1h39FXEgC6YMrW1iYZLg1bF87ixyyEBsgSVMcx3EeCEd2mt5kErM6wBgPo1Yp5DLTZCM5izzmAuGsPDa4Zc+tkXsS+ydiHkrCkOaWVglBdN0JoJUDcGeAZud0Buj2AbiQsFyO0Flj1VxvU53K6JtNVGblHFzatCgCJ+aK2GksawVK6bQ8AxT/DrhhhtAq4S+Q51HJ6cSA0pBMzku1A2iluvJBWwVU64OyVUlYmgS3PH7ftEazx7l4WlC0Xq7OUuSSAZoK5092J0VydJWk1MSt1QE6Xa2l3BGdlReACs9hBXVQ5P+bzUaJoNQULOWTvhNnPmhXq9/LpLt+Bug7DbZn0l/HlGaigP698DwNSzv7A5TlNoHPhM6Now/KY3VpKkia+UQ+1xueTWdvAId3zFgJofvJfVD6cvBBwU1dLldryZ9VJgEorDTY4tNUbqL4riuQ89Jfn1N76+cNdr/RX6gWoGzRMcA5IEDRjK7SHKDU0LLpIeImJumKs8etLfM/V4nMo+6d4okkRmLo00ZEUM8N5zoDFNJNbQHarUm9de3atQqvt2tAyRgPY/s9P6P4aQYoCWXOkoRXF0kRPAdUFCBhKE8G6eUq5QFVZm0BUEyq0ndUVmKMGS3IwK75ZFW6FW3ziScWbEHr4DasWwK0Y5N6lfw9XC19tkNALdXXxg0aH5TVEa0SajVpkJNVyOFvhM+z5ZrE+akCKJxLBnB0LuEdUauoMaMkDiJXOE9oDcAG57BW5K9iIwO6SrACAFqFQGoybbpsjgLKLGVhQ6SdAM21ZrbG1Ra0Qx/UUn1s3ACFQVLBchbqyFPvqUgfySWcwBSM0HQqngHK2gD0lvRFImNVNKPStABpYr0k5pJVBEiup3LxvcbL5rCTZSDuBGi+ZGTnqX7/5+J3kF236Jc94ZkcNmFEg5h0w8zqOgMU/UwwaVjeBFPzkFNfniewOCkRGBGCz87O+AQlFOmnJUtJ0hX53zm4n8n5kkC5Ol+xYCzByAomAXjOCt7ODoDqNjvMb4Zokva0XKN1dnA0XG5qv9GynoZxABrtF7LkuVn3NF8JKllFauxSKeAnPMO8abISFjRdKdl2STDZeb7CIoA12k+e3+epLOp7iqx/W4DWk/7lDQA1qME+tnoaBg8oXTRXCSgt89zIVUWqX0knoLIiZVzXkUJ8L3zQ1VrKw6ui+XhapQIhEz+RXQvttzRvujd14oM2VNl6UFsf1CB3gDpWP3Px0fxgJQFKcCKRCgMUZ8VFiXGWBEIm2VR8ek4APF8JImFVh1RxsmULjSArn02ZphhY4cD9dElCsUI5qZgGeKoAOokL9werKRdrkujSN0NZct22bl0te2kAVBLsOHO0TrI8OwK6zorn0cvk9UdrkXVK2VEIbs7S5WaZLFdrMamUePMAAB2/SURBVCqnaZrRiEs1k7VUdcJGffp3AbmDRJkCoNcS0wDSvOnmwLRBSamcLJoDOk0LO2q29NW1W9dKXurOB3WsvgA9KFsFlDNrSgHxJgOURd9rAWiuRp4uVCoD1BTgK7mFngHd1lh5VLeZakBt1awzluodUFySuVryQJpVMmG0niaifikDlI7TAGi6TFYrGdBsGREtvyexOjmFjfLEvp4vV3lAsxwCXmN1fnZ2loq8gBsLqhmRK0uZNKcrw3xVKWl19YgGUL7yMwAqK4piaWeRp1DCwXPlaYozmTjqi7plPHEj/FMoR4LqkBWsGdmIXJTMcopL3lfJ+dmSh/qrJYT5LLslzcOnmf1OV4TP5WrDwq6nTnxQy6WW2ufUYb58tYhpm4aCDyo2d3B3lw/H6nEmCcUB5VOWbIwFF5IAla4SvsaSEcpKRbF8CQuWszKPhDCdcC8W176vN+lyuUHiWYkemFMRKuFMEQc0RcOcJMlyCaeTvwHO+ySaRvO55W0+xLr4W1evfXXtav1JpLKijquFqdKMNS2gtQIrfMHVa9cCoJmKM0liaxEBKIzZwCfMSUK+aC12U6JeJdC2hJp6aSnomngHq5RtCIJNwrmEOOqH0oqnFBKs1BNNMd/JAV3jEpRVkpyTF2yox8oa3j+OF7CNvk0nxc4iMKz+y/zAam9Bv/qKQKQcV1jUAFrPb4XjV6/dunUtACqkAsp8ULY5U7YOHmLw1fJ8tckBSu0hq69bZQM7IpskLFGFQf0aCpDX63NWno9Gd6MCuk65D5rS3H96DlP9bNEzc0x3BPSra//iWp4OSx+UcnSrHHKND1ozsELn4dq1q8EH5WK7bk/kmnkKqFTHjoCywX+5XGESCkBMlgkZ9cG6nSVLmqdka0KZgUw56XzjOmohExopIbYEfAiwVom8SjRhS/DAhyCO7RbWQcNsKCRYdwWUmKjKOo2CRJGmjrarV6+qh7Swo0sgeRY6QOkLmfMQAGXimxrv72d7xk6ODmGz2f2DidhIFvaUha1rD44ePz48fHx0QJ6fTA4nhz/+9WhycHD06OjHo0d0b9rJ4RE5jz776Ii3MDk8pNvYTuCEw4ND2KmWNHf0aP/g4NEhafTgkJ6Cb4AcewR73ZKGHj062j/cPzr6Z/LaR6Tdo8PdfFAiO0A5TFqHMqua40VSJS7BV1evXtPZ2NxluG0OgDLxex8ogB4gYTKgE/o8+XFA8CPY4RMEocOjAwCUESe9XH5ZTpMDDijfN1l6CQf08JC1RdDFkx4xQA92WPLRaKacn6592c/eeeedn+nOLjZhuCx9WpzUoHsO0DGrN0ClTDlfXKFOz/Pxm7qhSg1IbmFyNlaXJOB5wl6U8eUy+xucx2JtweQ8nATrltANaA4ok+UcIj9d+7J3b958513d2cUmDJelTze90zHIATpmde+D0pvIHJJoGdevpXTBOs365PbqJjEL5NfPEhY6bRI6n04r8+hp9DcIvsVCN3UrnA3dW2fDiqD5gfMkzTL7kC7Ac0lD5NxkQ/9PfNHzc6gHncZ2LmhOlnOI/HS8GVj+yXff/Vll4/RX/NdwWenMZnKAjlk9rYs/Plonq3MIXvgCDI3xg8Tkii7GLDlDFBknJOpZ5Uqd2RnSnKlUhwxVJomU2WczSSSsT1gRHg/m0z1+//DOpTdvlaPxLhbRVg7QMSsAGgBtKgfomNXDEA/f9uzx6nx5tjyD0ZsBSmvl6YBN00JknBWAwiQRz0bRmSRwCVIdoAnu/0XH+lQU6fGME650erqGLZ3P13QHps1quUzoDP8qTc9WtIiZvDvINDkDVDeWmgZhDW3EBy1/HXEKqgDNfIeb2uOWcoCOWd0HSXgT7tnB2ZLgSf7P5jK3bKsQCIAILzAlRAza6pz5m+B8JjT5TqtG+LQQXyrMfFCcrQfs1iwlvxZFetT3pGWeKU4awe0bcHVnAvP0+AaW5zA1CrSerZbp2Qaq8nb3QUFa2EzmrkgOecnPS8MfOK5xW/OXy7+8qdV1gI5ZPQF6vI9bIUl3T6BLOlVAs6E65SF1DlBNyfxGhOncvirr8rJDosqPcL9KWO2eKNOHvcnOcJxvvvWNrEaAapupBtQYtwdAKxUANRwzNxMAtZVVr+J4TsbL+BA2iz0/S0QtHfxOXFI8THQGWygTX3TDdlmCvBD6puSpFFdwwm8bPnuPWy7xXUiS85QeTlIo76RtJynLL4F7i6fQX8BFII0mkGECP4G2Tw7SjNNml72ZshGaOIfvvnuz8FRN54+djC0YfNDK9sh70J4WfNBMeCtYYkT3U7rNPDZAbdlymaZL6jfCvb1gBwcoTF7jajqsjifhy3myTJewNGOFKzhZ/VOCjuO6UPFEAp3kbI1BFJ7PbCqmB/jeIbwQGponsRbM1Wf3B4G4qvHOIplluvnpezffk62UldFiKfX3bpL/TQ1RfL3340YO0DErABoAbSoH6JgVAA2ANpUDdMzqxQedz+eHxOc7Q08QZzTBMwQf9IwcQVcT1walKTmFOJzn5B/wE9FtJb+kOFPJE6LgRibotdKpTOpm0qnTM3BrqQ8K06Ep29g2oZs4wRQruqOYeoVzE3gPCXNhWS71EHzmRqs+ND5oWSqyRjs3mRfbPGirumgDP9QBOmb1EcUvyH8HsLUHXS+UCvNHbSjUa7AQXexDm1DDSgvuC1NKtMA+xakhZVslaf4IDGuCdSDKnTu5ZU5WxDavl8Q4LxNWvMJKVDYHEfmbarpuTmj32gwuN1mFnJq8MQfomBUADYCCAqBMAdAAqJW690HnJydPnjz5ER1O4u9hTV3C6uHIgXPIR55hgpI6jNstJDzJQUpryqrn4MK4/DiBujnwWc9x5lzMfZ5jlhT2DEVHFPfCo00k4m6edOafur8JpF+TM3By8U+CObm47LihD6ooy3xq3L2bqHoNVQHaPMMZfFAqYonmp6fzJ4+XS5iIX6U42y42loMNlPlCzGzrY/XWSaKyGcs7YG18ijdMPk+zPfEgbE/pHbmWSwI8bPzETaoUo2/EdeG/p3DzpTPS3EopiXJtsTTGihx67726Jqzi/biaI6onB+iY1RugoL8+Ojr8EVYTsbUak4PDo8dHjx49whUah/gMW/chrfEQa0MOJ4cHjx8dHRweTo6ODh//eEhez5aKHDw6PCKH4czHj3/88Z+PjibsEqSxA76cZH8irgv/7R8dPDr4K2nuiK0MYYsjHH+vAVAb9QXoKejJfBGfYCUbXQkSzeLF6WI+n89i4vLxGjdInS5iPESbwOn8CIrg4tnpfDEj4+9iEZ+exJNZzFaUzObxghyGM09PiU+xWETsEpCHpefgPqX8uvDf8WI2nz0hzS2Oj+NmO4LWUQDURpWAvvjNd/lDrz678dEP2+3zGzd+IZ6z6lUUx/P5yZzqZB6zSja2EgRSpDGkSuE3XuMWAanzzAvEktIpnjCHV5CzImgqhvWX9JkoPsHDcOb85MnJPBKXQE35JcV1YalpNCcNknZwB9NGO4LWkpc+aAO1wWNBVYA+lyBkevP1F9uHHyO55AdTw/4BAkqdJa1ljjCVT44LDqeINQOPkiSiFjyfU76X7TTL6ItVzOBALOEp70yrPMowloj2RBzQVuGro3aIzKkC0PsffgMWlNhM5PTV59/Rf5hdzcyrXbcitFA42B7P6fjOWIEBmSiez04WcTTnI/kUHQPM8/CxGEZ1HPFJI+TUiPoJ00kU02X3U2goiqQWpvwKi5j4BOTsxQIaiGfiEmJMp14AcwSogzHbNcnkUgzQLhd36NU+nds6Q/z9O9RYIqAvfvvD9tXv7sKT1IJCEGF1QajjXGFGk0TTiXw3jg3PdSa4hTyUuYubF9PMZJrAhk3rNLtRB1tddI75qM0+lJTiHefYhva5berTNd5NCe4TcgZ3WdCvWMaswZovdd6sV1AEmGgqTztSfs8F9nn3feu6jmQEFHAkbBKnk+jO848YoC9+/eFdfprVn11MjNYpCVkgbJmBBZ2TMIfZKmLfiGGbn5w+OY2jJ7PF/MkMvQBi7yIwnhBfEfvKLCiM1jG1oE+IwZxPo31i98A+EkcSTCppMF5Ito8Y3Tg+xSBocQKOhLDM02zBfhRRqwyREnWESZg1ny3aCpmMKljKYEGFENDPCJgAY96Csh/bpoDCYA5pexKHY4AORM0BtMXpCUECQqXT01mEw/ExicoBpXj+5MkJ80FjWptP/VECNkH5iNA5R7boqBzFyuBMgIXonjx3vJgvFqcRHmFOMHq3dOMo+DEDPwBxXZAw7DSeeQdo8EEZoJ8zVzPvg27vf8FOs+pVNFssAFLq40XHBK3FacwsGHiGMfMcCa4LyPlE3JghoMT8xexGIcLDjCJMCkWzQ7S0AOAxDYWU28dQ7KYINJrFqRTJR8en81MsBBQpKPqD/PFEpyeL1pJORpUC2rva5FKolg8KAzvVm6/RIxUjPcquW5wJ+hMAnS1YWIO7yIngaH56Qob1eQYoRPeLGIdl2G1OpgnN3WwC4zXDlV5LAhRGbnAmMH4i0dFC2E6km/zZLE5nGfOCb3LZGY28HKiJ1cu/JgAq9IJF8Zm7yfOgD2/caOiDsi8fUpgI1yw+BZuIafk58T+fxDw5ROBFjxHMZiRMLADKhv2Yn4eGkVjFCRmPlSSUnGjiKXqa/897nwxQiUTqjUr21IF29RvpnnlO3ooDtYhlpu53FsHMDg6ys1giiFpQQskiM3k0m8Rme9C8EmZJuALQZoNu/ORkjlNI8SH6sGKuiDaiZo/0gEJgBfZZSnhSbIuOwk7aEVC266iTt+JADtAxq/udRZAMiGTm6E6K42ggSXCURTVgUvmYHJHICnKjwBLs1nlyKhKYC+I9LnBY34PGFzSHybnP4ELDGtEUqZwBZXvqzk9OZArZRqbshY4c0ACotfoAFKfJ48XJLJbz3xiqQPykZNaP0V7SVNMpnWonlnX+ZJ65kIsFie3nxMGcS4BmefaZ4mtKk1KKtZzNIbMggchisGygd6LdIu8AaDNZ9Srio/TJQq4CZoMphPjyxCKbDuWAsikoKOpYiAF4sTg5OZmdkFMO0S7S+VJOVX6uiOMmZuanfIaJaMZToXAZsKvoObRXN2Kr4IM2kl23WLZHGWSzvA76kCoP6DQSdOcs6Y6BVTyj8MBzT56cYLQfPZJm0HkrwoSyzfG5R5v9EtHEJwIKDgT3YSMKJ7GtXcx01retAVBbWfZLTKxLrh0HlA7RbAqHD83oNEZ8womiNkN7R8fyBXFVF5COejzLm2Tpasc07GdVdnT85kYSqZzPZ3RbHlGQF0V89r51QC280wCorWw7Rk1nZtqibOAVGXx5x0OaMZ1JPiJDB3LykEYlgoKmk4m0SaJwFJihjvhgjV7DbIEoApBz+m7wGgxYOQsg0q3tygJQ68+7LTlAx6x+7tVJq4SFaTvO6jiPefzNABXFbgTIhTyfgxZxDhE9TUDBSw6z2tIssskDOhWwxzTfn92Kk890yvV1zGdu/jXWUwC0RD3dqzNSxt5jkU2XDB8CmlnUSDFsPE85Aws6o0aQAyqVykM7fMpIisdZah/fgBrmz7IyU34hac6pTdX3QQOgtrLsF//yuWmDgXpWZABgk31SeQoTm4lFQBND8E+OHMyESY4kY1lwTBmgkJlSEqWC1dwUqS9BPFUA1FZ23crsFBuQwQqW3PFaBnSq2LVsqgdr6mcwnw/ldnEWp8/jKA8oV0wnAHCglyrpxbkB0DpygI5ZfQCaLxmaLU7LAD2m6R99O9lcJMvvT+JTmCmVPQhpBM+/loVK0nVF4kutgvJqwUcA1F523SoACvVsi1ygLApGyidypKiHm749nItnUZImmaW8lhXszZTZIzFx7xmUsgKgtrLsV3RyupCLhNjsj3KKvB6pbIiVox5KIQOUxU9ykkDz2il1DdT6uvwaOx8xDYDayrJfMazbhAdSaikHQi1Ai8/t4aSocELjqOrlrNhTWiRvaN0XBUBtZdmvwk2HioZKWY9ZZcfU5/amWZ5JnDErmahUpuYDoA3kAB2z+gRUO6xSZYXGNsMsnwRUyk0qAMWYv7zkMwBaLQfomNXLVCcNy9XqIo3UGSGxfKhc2Sy1lDsqbZ8P77kX5N6AfwqA2sqqV3l0KgBSZoT4zFFJ3QY2u6e8VG5FS5ommeQnkqoCoLay6VQenSKggpH8lOWML9cobVYHqDZTVRzXjebcHwVAbWXTqRw604LRUucbs62U2EoRK0ALxaHZ03SDnNwSpAColRygY1YvgFbG5dJqNmUBMa3vKAzxsjHM+aCqe6C8iUIJXQDUXg7QMasPH7SIgWzK5MlzZU3mcVQwt9kZig9aSLAWrXShxlPeBdJvBUBtZduxoksoT5hrVoLgQ30Qo7S1px6rGcDr35O/CoDayrZjRUB1NXGFx7pXVgJaZQ/zTwVA7eUAHbP6K1iWf9fWxOleqJkVldrKA2rxPgpuqr9jfQDUVrt3VR7WS8W913J2dDNJVQ1qi+rU+MpDBUBt5aCvNZASBcrl7OxpWqoa5nWA+h/OB0Bt5arD1ZSaQx/co76Y8tRXk+LaTk04FgCtLQfomOURoAYoioAWgM4DWm5vabWzlDvI50yDD2qWA3TM8gvQ4jacchyTq28qsrenNiLV3GuupT41jGJ6VADUVk07yPPpArhi+tyiWnnKfNBYXQVaXieSWySav2WNtwqA2qph/wq1wsX0eQNApWZnheakF0dRbrlS5fyWTwqA2qph/4rF7IY8fKEBjQ+qNGuwiWrjmvktPwOlAKitGvaPl7QX6puUk2ys2J70khp4BUB3kwN0zOrVB2V7IBbm15sOrXvyq82t5AgcyuxnANRWjXuYM2Gl0Xld7ZlebbesOPig1XKAjln+AFpavVlfJkB9tYl2CoDaqnkXlcKlmoBW2LUAaKdygI5Z/iTqa6bK9W4B1V7xUMVrTVfyVQFQWznqbz1a9G4BlbQ5dkl+3lReOgQFQG3V6adSD9B66AVAd5IDdMwaHKB6v5Vqd0CHMOYHQG3V42ek8UHp8Xq2cSipT0UBUFs573lTO2b0QY0XDoBayAE6ZvkIaGNMdr6DUADURg7QMSsAql46+KD15QAdswKgg1MA1FbOe+7ABx2xAqC26vuDEgqAdioH6JjlAlBvtFc8tNlsun8fQe40cgs6iLDcUt583g7QMcuDRXPuFADtVA7QMav/NUkOFQDtVA7QMWvkgA4isWmpAKitGvavE0BHqACorZp2sAMf1FZDMLgBUFu19xFY8hLm4juVA3TM8hpQW14CoJ3KATpmBUDzF/R+i6YAqK1a+wQ6B1S5842vCoDaqr2PoGsfdDqEUT4Aaqsd+ug2ag6AdioH6JjV88YNbmlwkgf1PtMUALVV8y7WB7QWNiFR36kcoGOWx4BWrC8uUQC0UzlAxyx/fdCqHRpKFADtVA7QMcvfKL4BoN58da3Km146QMesgQBazwf15qtrVd700gE6ZvkLaINw2puvrlV500sH6JjlMaD28uedtClveukAHbMCoIOTN710gI5ZAdDByZteOkDHrADo4ORNLx2gY1YAdHDyppcO0DHL30S9vfb2LkSmPgBqq+ZddFossrd3MQgNgNqqeRcDoA0UALVV8y76B6j3xXYBUHvt0EeXPLgA1P9y5QCovfr+oJgCoB3LATpmBUAVBUAt5AAds0YEqJM0U/BB68sBOmaNCVB/vrpW5U0vHaBj1pgAdZVl8tyKevN5O0DHrBEB6ioP6rsf6svnHQC1VAC0YzlAx6wAaEEB0JpygI5ZIwI0+KAdywE6Zo0JUH++ulblTS8doGNWAHRw8qaXDtAxKwA6OHnTSwfomBUAHZy86aUDdMwaE6C6IMku4PE8PKLy5vN2gI5ZIwJUl2aySxn5nmCi8uXzDoBaKgDasRygY1YAtPHZfcmXzzsAaqvgg3YrB+iYNSZA/fnqWpU3vXSAjlkB0MHJm146QMesAOjg5E0vHaBj1uABldzGi7EsPgBqrT4/JCnwDhs3dCwH6JgVAB2cAqBCL37zXf7Qq89ufPQDeebXN258wY/1+SEFQPtTGzwWVAXo8xu/yAP65usvtg8/3r763d3ti3+8yw72+ikFH7Q3tYSkqgpA73/4DVhQYjOR01eff0f/IXb1+cfwPDehfX9QQv68kzblTS87wLPOEH//DthMBuiL3/6A5hN+xx8wrHbxPoMuqIyAAoeEzec3QHeef8QBffP1HX5a33/JXGKIH8SMZWN583m3DifIDOhnBMwP7+Yt6KvPBJ++fGAiSBpGzUdj+fJ5+wLo5yxQkn1QEsV/kZ3W9wfFFADtWG1yKVTLB4WBnQoGduKRKnz68oEFQDtWe1RKMgNKxvgP74pDNA/6ED1S36L44IN2qza5FBr6TJIif95Jm/Kmlw7QMSsAOjh500sH6JgVAB2cvOmlA3TMCoAOTt700gE6ZgVAy+VprOXN5+0AHbPGBKjjYhFfs1XefN4O0DFrRIC6LrcLgBrkAB2zAqClCoAa5AAdswKg5Qo+aLUcoGPWiAANBcsdywE6Zo0JUH++ulblTS8doGNWAHRw8qaXDtAxKwA6OHnTSwfomBUAHZy86aUDdMwKgA5O3vTSATpmBUAHJ2966QAdswKgg5M3vXSAjlkB0MHJm146QMesAOjg5E0vHaBjVgB0cPKmlw7QMSsAOjh500sH6JgVAB2cvOmlA3TMCoAOTt700gE6ZgVABydveukAHbMCoIOTN710gI5ZAdDByZteOkDHLBeAeqOLsVPpxeglVwB0cLoYveQKgA5OF6OXXAHQweli9JJrVIAGjU8B0CCvFQAN8loB0CCvFQAN8lqjAJTe00FzZ9HR6M3XeG+/j/t+H91rJIDCzRrHDCjeGXXUHSzTOAD9zf/8WNx2rHAD3HGIWM/7d8SdU5/fGGs/8xoJoN/d/wIBVW7qNCq9+t03v/2B3zkV7qf28GKM92MB9NV/+AH+/fw7fq/b0ekh3JeK3Tl1rH3UaCyAbh/eIf/Cgzd/HueXx++qhndOffFr+e5qY9ZoAH3z52/GbUEpoJ8Lz3OkrkxeowGUhvLj9UFZDE87CH0caz9zGg+g24e/GHMUzzrJ7px6P0TxQUE+KAAa5LUCoEFeKwAa5LUCoEFeKwAa5LXGDuiDS9fF4//737c//d0f+W/SQ1mvv7wEupw9yU8kP00vf/bWt1VvRWkW349lExdQIwf09Zf/RnzhOaRKAUWiH2ScSICaXl5FF7b47NJtwxsIgKoaOaDP3vpv73MkrAB9+cnt/Im7Afr6S2zw3tvfV7+BAKiqkQN67+3//eUVwsIH/wkH7usABQziVygf8BCA+Ol98iQlMgMUAcJx/feXLhGu2BDPzsWj8BrexstPLl3+PaNLXOIP7+faBWEL1+Hf6+Ia5A2+9S1vgp6wvUea2D640vVn5pfGDejLT67j0PrT+4xI8v/XhFiwj+zh9sHb31NMqKllIN1761sBz/tvfw9nUkD5uXAU2uZtwKVefkIBhWP4CnYOvpdnl5g7jMb5AW0/u8YV+m6hCX4CGFNmeC+uxg3oM4TzNoWPASGN2M+o5bv90wfZsMqCJHihgOf2NqOTn8uP8jbwJ4MRH5N/xGWpIEoiHP6/77ci4lKuwZvgJ+Cf0QcXfMQfN6AwSDLjJwDlTh55+OASHfi395AcVDYUZ8Pvt3zIh0PsXP4sb+MBOJcMp2f4mFtb2dV8+Qk89QzjeQVQ+Jk1QU+A4f2ij/DjBpT4dNQalgGaRSzkVD48GwBl5wpAWRv1AKWG8fIfCxZUBpSfQB7/j4s+wo8bUDrigsMoASoP8ZcV4yb7oNutCo/kgG6VEIq3wYd1fAzHnkl/F1v5B+L7TGNBeRP8BPJe/u1FH+FHDSjGL/gDv38pMmLD/usvCQqEBCSDEZQBCjHL6y8v54Ikfi5Hi7fx8pMrxSBJtqD3gFo4Cuj99P5ldDHFNegbpE3wE8Brvegj/KgBZXH59sHlPyAk9y5d0aSZ0Nplkzy5dNA//Iqmma4IKtm5Aj7ehjbNJA/xD6i/C+/j0uX/TOgk7ye7BvMdsAl+gujBBdaYAR2+LnwMHwD1Ww+um88ZuQKg/grz/BddAdAgrxUADfJaAdAgrxUADfJaAdAgrxUADfJaAdAgr/X/AbLIHvpzQDljAAAAAElFTkSuQmCC)<!-- -->

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
#shares_corr_tibble <- as_tibble(shares_corr)
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
       is_weekend         LDA_00            LDA_01            LDA_02            LDA_03       
     Min.   :0.0000   Min.   :0.01818   Min.   :0.01819   Min.   :0.01819   Min.   :0.01820  
     1st Qu.:0.0000   1st Qu.:0.02250   1st Qu.:0.02222   1st Qu.:0.02222   1st Qu.:0.02260  
     Median :0.0000   Median :0.02913   Median :0.02507   Median :0.02523   Median :0.02925  
     Mean   :0.1895   Mean   :0.17892   Mean   :0.06751   Mean   :0.07769   Mean   :0.14188  
     3rd Qu.:0.0000   3rd Qu.:0.25060   3rd Qu.:0.04001   3rd Qu.:0.06667   3rd Qu.:0.19724  
     Max.   :1.0000   Max.   :0.91980   Max.   :0.68825   Max.   :0.67623   Max.   :0.91892  
         LDA_04        global_subjectivity global_sentiment_polarity
     Min.   :0.02014   Min.   :0.0000      Min.   :-0.30000         
     1st Qu.:0.32329   1st Qu.:0.4265      1st Qu.: 0.09929         
     Median :0.56851   Median :0.4780      Median : 0.15023         
     Mean   :0.53400   Mean   :0.4734      Mean   : 0.15143         
     3rd Qu.:0.79956   3rd Qu.:0.5273      3rd Qu.: 0.20511         
     Max.   :0.92707   Max.   :0.7778      Max.   : 0.51389         
     global_rate_positive_words global_rate_negative_words rate_positive_words
     Min.   :0.00000            Min.   :0.00000            Min.   :0.0000     
     1st Qu.:0.03493            1st Qu.:0.01025            1st Qu.:0.6667     
     Median :0.04424            Median :0.01521            Median :0.7399     
     Mean   :0.04457            Mean   :0.01632            Mean   :0.7235     
     3rd Qu.:0.05378            3rd Qu.:0.02094            3rd Qu.:0.8125     
     Max.   :0.10791            Max.   :0.06180            Max.   :1.0000     
     rate_negative_words avg_positive_polarity min_positive_polarity max_positive_polarity
     Min.   :0.0000      Min.   :0.0000        Min.   :0.00000       Min.   :0.0000       
     1st Qu.:0.1852      1st Qu.:0.3358        1st Qu.:0.05000       1st Qu.:0.7000       
     Median :0.2560      Median :0.3836        Median :0.10000       Median :0.9000       
     Mean   :0.2657      Mean   :0.3824        Mean   :0.09207       Mean   :0.8297       
     3rd Qu.:0.3333      3rd Qu.:0.4335        3rd Qu.:0.10000       3rd Qu.:1.0000       
     Max.   :1.0000      Max.   :0.7553        Max.   :0.50000       Max.   :1.0000       
     avg_negative_polarity min_negative_polarity max_negative_polarity title_subjectivity
     Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000       Min.   :0.0000    
     1st Qu.:-0.3250       1st Qu.:-0.7143       1st Qu.:-0.1250       1st Qu.:0.0000    
     Median :-0.2625       Median :-0.5000       Median :-0.1000       Median :0.1389    
     Mean   :-0.2671       Mean   :-0.5633       Mean   :-0.1046       Mean   :0.2928    
     3rd Qu.:-0.2039       3rd Qu.:-0.4000       3rd Qu.:-0.0500       3rd Qu.:0.5000    
     Max.   : 0.0000       Max.   : 0.0000       Max.   : 0.0000       Max.   :1.0000    
     title_sentiment_polarity abs_title_subjectivity abs_title_sentiment_polarity
     Min.   :-1.0000          Min.   :0.0000         Min.   :0.0000              
     1st Qu.: 0.0000          1st Qu.:0.1667         1st Qu.:0.0000              
     Median : 0.0000          Median :0.5000         Median :0.0000              
     Mean   : 0.1101          Mean   :0.3438         Mean   :0.1803              
     3rd Qu.: 0.2143          3rd Qu.:0.5000         3rd Qu.:0.3000              
     Max.   : 1.0000          Max.   :0.5000         Max.   :1.0000              
         shares      
     Min.   :    78  
     1st Qu.:  1100  
     Median :  1700  
     Mean   :  3737  
     3rd Qu.:  3225  
     Max.   :208300  

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
