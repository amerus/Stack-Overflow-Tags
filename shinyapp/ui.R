
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
                         
                selectInput("selectTag",
                            label = "Additional Tags",
                            choices = dropDownTags,
                            multiple = TRUE,
                            selected = unlist(bothLangTopTags))
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
    

