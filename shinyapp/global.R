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
bothLangData <- bind_rows(russianData, englishData)

# create sorted years for dropdown
dropDownYears <- as.data.frame(bothLangData) %>% 
  select(Year) %>% 
  unique()

#russianYears <- sort(russianYears$Year)
dropDownYears <- sort(dropDownYears$Year)

# create sorted tags for multiple checkbox selection
dropDownTags <- as.data.frame(bothLangData) %>%
  group_by(Tag) %>%
  arrange(desc(TagProp)) %>%
  select(Tag) %>%
  unique()