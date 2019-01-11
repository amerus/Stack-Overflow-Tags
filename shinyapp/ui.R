
# Define UI
shinyUI(
    dashboardPage(
        dashboardHeader(title = 'Stack Overflow Tags'),
        dashboardSidebar(
                sliderInput("selectYear", 
                            label = "Years:",
                            min = min(dropDownYears),
                            max = max(dropDownYears),
                            value = c(min, max),
                            sep = ""
                        ),
                
                sliderInput("selectNumTags", 
                            label = "Number of Tags:",
                            min = 1,
                            max = 50,
                            value = 5
                ),
                         
                selectInput("selectTag",
                            label = "Additional Tags",
                            choices = dropDownTags,
                            multiple = TRUE,
                            #selected = unlist(bothLangTopTags))
                            selected = unlist(head(dropDownTags, n = 5)))
                         ),
        dashboardBody(
                fluidRow(
                    box(width = 12,
                        title = "English vs. Russian Tag Discovery (2014-2018)", status = "primary", solidHeader = TRUE,
                        plotOutput("tagbars", height = 600)
                    )
                    )
                )    
            )
        )
    

