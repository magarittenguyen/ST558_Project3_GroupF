ST558 Project 3 Group F
================
Magaritte Nguyen and Matthew Sookoo
2022-11-12

<!-- In the repo’s README.md file (which doesn’t need to be created from a .Rmd file, just use the one you initialize into the repo if you want) give a brief description of the purpose of the repo, a list of R packages used, links to the generated analyses, and the code used to create the analyses from a single .Rmd file (i.e. the render() code). -->

The purpose of this repository is for the collaborative efforts of Group F (members: Magaritte Nguyen and Matthew Sookoo) on the NC State ST558 Project 3, Fall 2022. Here, we will be reading in data pertaining to Mashable article sharing informatoin collected over the past 2 year. We will the create a summary report based on 4 different models (MLR model #1, MLR model #2, Random Forest, and Boosting) to be able to see which model has the best prediciton ability for sharing articles for 6 different channels. These channels cover topics like Lifestlye, Entertaiment, Business, Social Media, Tech, and World. 

Please see the introduction below for more information.

<!-- TOC -->

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
-   <a href="#our-render-code:" id="toc-our-render-code">Our Render Code</a> 

<!-- setup -->

# Introduction 

Our goal with this project is to take the data about articles published by [Mashable](https://www.mashable.com) and create predictive models for the number 
of shares in social networks (popularity) then automating our Markdown reports. 

This dataset summarizes a heterogeneous set of features in a period of two years. 

Then we will do an Exploratory Data Analysis (EDA) and summarize the data and try to predict the number of shares in two linear regression models, a random
forest model, and a boosting model. Lastly we will compare the four models and declare a winner (the model with the lowest root mean squared error (RMSE)).  

The dataset we will be using is [Online News Popularity Data Set](https://archive.ics.uci.edu/ml/datasets/Online+News+Popularity).

<!-- 6 Links for the Rendered Files -->

[Lifestyle articles is available here](./Lifestyle_Summary.html)

[Entertainment articles is available here](./Entertainment_Summary.html)

[Business articles is available here](./Business_Summary.html)

[Social Media articles is available here](./SocialMedia_Summary.html)

[Tech articles is available here](./Tech_Summary.html)

[World articles is available here](./World_Summary.html)

# Required Packages

The following packages are used for our data manipulation, prediction, etc.:

* `tidyverse`: Tons of useful features for data manipulation and visualization!
* `caret`    : Used for predictive modelling.
* `shiny`    : makes it easy to build interactive web apps straight from R
* `rmarkdown`: create dynamic analysis documents that combine codes and rendered output
* `corrplot` : provides a visual exploratory tool on correlation matrix
* 
<!-- Render Code -->

# Our Render Code:

```r
#THIS IS THE AUTOMATION CODE BELOW!!!
#dr.post way - automation
#list of channels and lables i want for my summary / usable vars in report
channel_list <- c("data_channel_is_lifestyle", "data_channel_is_entertainment", "data_channel_is_bus", "data_channel_is_socmed", "data_channel_is_tech", "data_channel_is_world")
is(channel_list)

label_list <- c("Lifestyle", "Entertainment", "Business", "Social Media", "Tech", 
                "World") 
is(label_list)
#name for .md files
md_file <- paste0(str_replace_all(label_list, " ", ""), "_Summary.md")
is(md_file)

p <- lapply( 1:length(channel_list), FUN = function(x) { 
                                             list(channel = channel_list[x],
                                                     label= label_list[x] )  
  } #end of the function(x)
  ) #end of the lapply()

reports <- tibble(md_file, p)
reports

apply(reports, MARGIN = 1,
      FUN = function(x){
        rmarkdown::render(input = "ST558 Project 3.Rmd",
                          output_format = "github_document",
                          output_file = x[[1]], 
                          output_options = list(html_preview = FALSE, keep_html = FALSE,
                                                toc = TRUE, toc_depth = "6", 
                                                df_print = "tibble"), 
                          params = x[[2]])
      }) #end of function and apply()

```

