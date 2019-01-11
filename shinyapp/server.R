
# Define server logic required to draw a plot
shinyServer(function(input, output) {
  
  output$tagbars <- renderPlot({
   
    # filter years and tags upon user selections
    data <- bothLangData %>%
        filter(Year >= input$selectYear[1] && Year <= input$selectYear[2]) %>%
        filter(Tag %in% input$selectTag | Tag %in% unlist(head(dropDownTags, n = input$selectNumTags)))
    
    # create plot from filtered data
      ggplot(data, aes(x = Year, y = TagProp, color = Tag)) +
      geom_line(aes(group = Tag)) +
      facet_grid(. ~ Language) +
      theme(text = element_text(size=20),
            axis.text.x = element_text(hjust = 1, angle = 45),
            axis.ticks.y = element_blank(),
            axis.text.y = element_blank(),
            panel.spacing = unit(2, "lines")) +
      scale_x_discrete(expand = c(0, 0)) +
      xlab('Years') +
      ylab('Tag Proportion')
  })
  
})


