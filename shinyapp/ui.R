
# Define UI
shinyUI(
    dashboardPage(
        dashboardHeader(title = 'Popularity of Tags'),
        dashboardSidebar(
          tags$style(HTML("
              @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                  h4 {
                        font-family: 'Lobster';
                        font-weight: 10;
                        line-height: 1.1;
                        padding: 0px 10px 0px 10px;
                      }
                  h5 {
                        font-family: 'Courier';
                        font-weight: 6;
                        padding: 0px 10px 0px 10px;
                      }        
                          ")),
          tags$h4('Visual Tag Analysis of Russian and English Stack Overflow Communities'),
          tags$p(),
                sliderInput("selectYear", 
                            label = "Years:",
                            min = min(as.numeric(dropDownYears)),
                            max = max(as.numeric(dropDownYears)),
                            value = c(min, max),
                            sep = ""
                        ),
                
                sliderInput("selectNumTags", 
                            label = "Number of Tags:",
                            min = 1,
                            max = 100,
                            value = 5
                ),
                selectInput("selectTag",
                            label = "Additional Tags:",
                            choices = dropDownTags,
                            multiple = TRUE,
                            selected = unlist(head(dropDownTags, n = 5))),
          tags$h5('Brief instructions: Use controls on the left to interact with the graphs on the right.
                  Right panel has three graphs separated by tabs. Use the same controls to interact with all of them.'),
          
          tags$h5('Note: Right panel graphs also have several interactive features. 
                    Try hovering your mouse over the graph lines or the icons directly above the graphs.' )
                ),
        dashboardBody(
           tabsetPanel(
             tabPanel(
                title = "All Tags (2014-2018)", status = "primary", solidHeader = TRUE,
                plotlyOutput("tagbars", height = 600)
              ),
            tabPanel(
                title = "English-Specific Tags (2014-2018)",
                plotlyOutput("engSpecific", height = 600)
              ),
            tabPanel(
              title = "Russian-Specific Tags (2014-2018)",
              plotlyOutput("rusSpecific", height = 600)
            )
           )
         )
      )
   )
