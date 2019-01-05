
# Define server logic required to draw a plot
shinyServer(function(input, output) {
  
  output$tagbars <- renderPlot({
    
    # filter years and tags upon user selections
    data <- bothLangData %>% 
        filter(Year %in% input$selectYear) %>%
        filter(Tag %in% input$selectTag)
    
    # create plot from filtered data
      ggplot(data, aes(x = Year, y = TagProp, color = Tag)) +
      geom_line(aes(group = Tag)) +
      facet_grid(. ~ Language) +
      theme(text = element_text(size=20),
            axis.text.x = element_text(hjust = 1),
            axis.ticks.y = element_blank(),
            axis.text.y = element_blank()) +
      xlab('Years') +
      ylab('Tag Proportion')
  })
  
})


