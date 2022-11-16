#THIS IS THE AUTOMATION CODE BELOW!
#tibble with channels and lables

#function to render channels 1 at a time
#dr.post way - automation
#list of channels and lables i want for my summary / usable vars in report
channel_list <- c("data_channel_is_lifestyle", "data_channel_is_entertainment", "data_channel_is_bus", 
                  "data_channel_is_socmed", "data_channel_is_tech", "data_channel_is_world")

label_list <- c("Lifestyle", "Entertainment", "Business", "Social Media", "Tech", 
                "World") 

#name for .md files
md_file <- paste0(str_replace_all(label_list, " ", ""), "_Summary.md")

p <- lapply( 1:length(channel_list), FUN = function(x) { 
                                             list(channel = channel_list[x],
                                                     label= label_list[x] )  
  } #end of the function(x)
  ) #end of the lapply()

reports <- tibble(md_file, p)

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
