
# Define server logic required to draw a plot
shinyServer(function(input, output) {
  
  output$tagbars <- renderPlotly({
   ggplotly({
    # filter years and tags upon user selections
    data <- bothLangData %>%
        filter(Year >= input$selectYear[1] & Year <= input$selectYear[2]) %>%
        filter(Tag %in% input$selectTag | Tag %in% unlist(head(dropDownTags, n = input$selectNumTags)))
    
    # create plot from filtered data
      ggplot(data, aes(x = Year, y = TagProp, color = Tag)) +
      geom_line(aes(group = Tag)) +
      facet_grid(. ~ Language) +
      theme(text = element_text(size=20),
            axis.text.x = element_text(hjust = 1, size = 7),
            axis.ticks.y = element_blank(),
            axis.text.y = element_blank(),
            plot.margin = (unit(c(0.5, 0.5, 0.5, 1), "cm")),
            panel.spacing = unit(1.5, "lines"),
            legend.text = element_text(size = 7),
            legend.title = element_blank()) +
      scale_x_discrete(expand = c(0, 0)) +
      xlab("Years") +
      ylab("Tag Proportion")
    }) %>%
      layout(legend = list(x = 1, y = 1.1))
  })
  
  output$engSpecific <- renderPlotly({
    ggplotly({
      
      data <- englishOnly %>%
        filter(Year >= input$selectYear[1] & Year <= input$selectYear[2]) %>%
        filter(Tag %in% input$selectTag | Tag %in% unlist(head(engSpecTags, n = input$selectNumTags))) %>%
        group_by(Tag) %>%
        mutate(TagPropTotal = sum(TagProp)) %>%
        arrange(desc(TagPropTotal))
      
      ggplot(data, aes(x = reorder(Tag, TagPropTotal), y = TagProp)) +
        geom_col() +
        coord_flip()
    })
  })

  output$rusSpecific <- renderPlotly({
    ggplotly({
      
      data <- russianOnly %>%
        ungroup(Year) %>%
        filter(Year >= input$selectYear[1] & Year <= input$selectYear[2]) %>%
        filter(Tag %in% input$selectTag | Tag %in% unlist(head(rusSpecTags, n = input$selectNumTags))) %>%
        group_by(Tag) %>%
        mutate(TagPropTotal = sum(TagProp)) %>%
        arrange(desc(TagPropTotal))
      
      ggplot(data, aes(x = reorder(Tag, TagPropTotal), y = TagProp)) +
        geom_col() +
        coord_flip()
    })
  })  
  
})


