library(shinydashboard)
library(tidyverse)
library(ggplot2)

# load the dataset of the most popular Russian tags and their proportions
russianData <- readRDS('./data/RussianMostPopWProp.RDS')
englishData <- readRDS('./data/EnglishMostPopWProp.RDS')

# adding Language column for facet grid 
russianData <- russianData %>%
  mutate(Language = "Russian")
englishData <- englishData %>%
  mutate(Language = "English")

# joining two data sets into one
russianData <- bind_rows(russianData, englishData)

# create sorted years for dropdown
russianYears <- as.data.frame(russianData) %>% 
    select(Year) %>% 
    unique()

russianYears <- sort(russianYears$Year)

# create sorted tags for multiple checkbox selection
russianTags <- as.data.frame(russianData) %>%
  select(Tag) %>%
  unique()

russianTags <- sort(russianTags$Tag)

# save 10 most popular Russian tags in a vector
russianTopTags <- as.data.frame(russianData) %>%
  group_by(Tag) %>%
  summarize(Total = sum(Number)) %>%
  arrange(desc(Total)) %>%
  select(Tag) %>%
  head(n = 10)