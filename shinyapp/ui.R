
# Define UI
shinyUI(
    dashboardPage(
        dashboardHeader(title = 'Stack Overflow Tags'),
        dashboardSidebar(
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
                            label = "Additional Tags",
                            choices = dropDownTags,
                            multiple = TRUE,
                            selected = unlist(head(dropDownTags, n = 5)))
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
