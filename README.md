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

<!-- 6 Links for the Rendered Files -->

[Lifestyle articles is available here](./Lifestyle_Summary.html)

[Entertainment articles is available here](./Entertainment_Summary.html)

[Business articles is available here](./Business_Summary.html)

[Social Media articles is available here](./SocialMedia_Summary.html)

[Tech articles is available here](./Tech_Summary.html)

[World articles is available here](./World_Summary.html)

<!-- Render Code -->

```r
# 13. data_channel_is_lifestyle: Is data channel 'Lifestyle'?
rmarkdown:: render("ST558 Project 3.Rmd",
                   output_format = "github_document",
                   output_file = "Lifestyle_Summary.md",
                   output_options = list(html_preview = FALSE, keep_html = FALSE, 
                                         toc = TRUE, toc_depth = "6", 
                                         df_print = "tibble"), 
                   params = list(channel="data_channel_is_lifestyle", 
                                 label  ="Lifestyle" ))

# 14. data_channel_is_entertainment: Is data channel 'Entertainment'?
rmarkdown:: render("ST558 Project 3.Rmd",
                   output_format = "github_document",
                   output_file = "Entertainment_Summary.md",
                   output_options = list(html_preview = FALSE, keep_html = FALSE, 
                                         toc = TRUE, toc_depth = "6", 
                                         df_print = "tibble"), 
                   params = list(channel="data_channel_is_entertainment",
                                 label  ="Entertainment"))

# 15. data_channel_is_bus: Is data channel 'Business'?
rmarkdown:: render("ST558 Project 3.Rmd",
                   output_format = "github_document",
                   output_file = "Business_Summary.md",
                   output_options = list(html_preview = FALSE, keep_html = FALSE, 
                                         toc = TRUE, toc_depth = "6", 
                                         df_print = "tibble"), 
                   params = list(channel="data_channel_is_bus",
                                 label  ="Business"))

# 16. data_channel_is_socmed: Is data channel 'Social Media'?
rmarkdown:: render("ST558 Project 3.Rmd",
                   output_format = "github_document",
                   output_file = "SocialMedia_Summary.md",
                   output_options = list(html_preview = FALSE, keep_html = FALSE, 
                                         toc = TRUE, toc_depth = "6", 
                                         df_print = "tibble"), 
                   params = list(channel="data_channel_is_socmed", 
                                 label  ="Social Media"))

# 17. data_channel_is_tech: Is data channel 'Tech'?
rmarkdown:: render("ST558 Project 3.Rmd",
                   output_format = "github_document",
                   output_file = "Tech_Summary.md",
                   output_options = list(html_preview = FALSE, keep_html = FALSE, 
                                         toc = TRUE, toc_depth = "6", 
                                         df_print = "tibble"), 
                   params = list(channel="data_channel_is_tech",
                                 label  ="Tech"))

# 18. data_channel_is_world: Is data channel 'World'?
rmarkdown:: render("ST558 Project 3.Rmd",
                   output_format = "github_document",
                   output_file = "World_Summary.md",
                   output_options = list(html_preview = FALSE, keep_html = FALSE, 
                                         toc = TRUE, toc_depth = "6", 
                                         df_print = "tibble"), 
                   params = list(channel="data_channel_is_world",
                                 label  ="World"))
```

