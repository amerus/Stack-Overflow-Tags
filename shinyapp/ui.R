
# Define UI
shinyUI(
    dashboardPage(
        dashboardHeader(title = 'Stack Overflow Tags'),
        dashboardSidebar(
                selectInput("selectYear", 
                            label = "Years:", 
                            choices = dropDownYears,
                            multiple = TRUE,
                            selected = c(2014,2015,2016,2017,2018)
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
    
