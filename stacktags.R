library(tidyverse)

setwd('~/Desktop/DataScience/')

# using glob function to get paths of multiple csv files at the same time
englishFiles <- Sys.glob(file.path(getwd(), "Stack_Overflow_Data", "English*.csv"))
russianFiles <- Sys.glob(file.path(getwd(), "Stack_Overflow_Data", "Russian*.csv"))

# reading multiple csv files from glob paths iteratively and binding them into a single tibble  
EnglishAll <- lapply(englishFiles, read_csv) %>% bind_rows
RussianAll <- lapply(russianFiles, read_csv) %>% bind_rows

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

#----------------------------
# working with 2018 data only below this line
# loading data from csv files
English2018 <- read_csv('Stack_Overflow_Data/English2018.csv')
Russian2018 <- read_csv('Stack_Overflow_Data/Russian2018.csv')

# sorting by the number of tags in descending order
English2018 <- English2018 %>%
  arrange(desc(Number))

Russian2018 <- Russian2018 %>%
  arrange(desc(Number))

# top50 tags
RussianTopTags <- head(Russian2018, n = 50)

# sorted histogram of Russian counts
ggplot(RussianTopTags, aes(x = reorder(Tag, Number), y = Number)) +
  geom_col() + 
  coord_flip()

# top50 tags
EnglishTopTags <- head(English2018, n = 50)

# sorted histogram of English counts
ggplot(EnglishTopTags, aes(x = reorder(Tag, Number), y = Number)) +
  geom_col() +
  coord_flip()

# tags, which do not exist in Russian top tags but do in English
EnglishOnly <- anti_join(EnglishTopTags,RussianTopTags, by = "Tag")

# sorted histogram of English tags only
ggplot(EnglishOnly,aes(x = reorder(Tag, Number), y = Number)) +
  geom_col() +
  coord_flip()

# tags, which do not exist in English top tags but do in Russian
RussianOnly <- anti_join(RussianTopTags, EnglishTopTags, by = "Tag")

# sorted histogram of Russian tags only
ggplot(RussianOnly, aes(x = reorder(Tag, Number), y = Number)) +
  geom_col() +
  coord_flip()