library(tidyverse)

setwd('~/Desktop/DataScience/')

# using glob function to get paths of multiple csv files at the same time
englishFiles <- Sys.glob(file.path(getwd(), "Stack_Overflow_Data", "English*.csv"))
russianFiles <- Sys.glob(file.path(getwd(), "Stack_Overflow_Data", "Russian*.csv"))

# reading multiple csv files from glob paths iteratively and binding them into a single tibble  
EnglishAll <- lapply(englishFiles, read_csv) %>% bind_rows
RussianAll <- lapply(russianFiles, read_csv) %>% bind_rows

# pulling top 1000 tags from each year to standardize the view
RussianAll <- RussianAll %>% 
  group_by(Year) %>%
  top_n(1000, Number)

EnglishAll <- EnglishAll %>%
  group_by(Year) %>%
  top_n(1000, Number)

# updating Total to be the new per year total with only 1000 most popular tags
RussianAll <- RussianAll %>%
  group_by(Year) %>%
  mutate(Total = sum(Number))

EnglishAll <- EnglishAll %>%
  group_by(Year) %>%
  mutate(Total = sum(Number))

# adding proportion column for each recorded tag
RussianAllWProp <- RussianAll %>%
  mutate(TagProp = Number / Total)
  
EnglishAllWProp <- EnglishAll %>%
  mutate(TagProp = Number / Total)

# sorting tibble by tag popularity and saving 100 most popular tags
RussianMostPopTags <- RussianAll %>% 
  group_by(Tag) %>%
  summarize(TagsAll = sum(Number)) %>%
  arrange(desc(TagsAll)) %>%
  head(n = 100)

EnglishMostPopTags <- EnglishAll %>%
  group_by(Tag) %>%
  summarize(TagsAll = sum(Number)) %>%
  arrange(desc(TagsAll)) %>%
  head(n = 100)
  
# filtering totals with proportion tibble to keep only the most popular tags
RussianMostPopWProp <- RussianAllWProp %>%
  filter(Tag %in% RussianMostPopTags$Tag) 

EnglishMostPopWProp <- EnglishAllWProp %>%
  filter(Tag %in% EnglishMostPopTags$Tag)

# converting year to character for ploting as factor
RussianMostPopWProp$Year <- as.character.Date(RussianMostPopWProp$Year)
EnglishMostPopWProp$Year <- as.character.Date(EnglishMostPopWProp$Year)

# visualizing the proportion tibble with the most popular tags
ggplot(RussianMostPopWProp, aes(x = Year, y = TagProp, color = Tag)) +
  geom_line(aes(group = Tag))

ggplot(EnglishMostPopWProp, aes(x = Year, y = TagProp, color = Tag)) +
  geom_line(aes(group = Tag))

# saving the proportion tibble with the most popular tags as RDS for R Shiny
# users will be interacting with the RussianMostPopWProp tibble
saveRDS(RussianMostPopWProp, 'midstone/shinyapp/data/RussianMostPopWProp.RDS')
saveRDS(EnglishMostPopWProp, 'midstone/shinyapp/data/EnglishMostPopWProp.RDS')