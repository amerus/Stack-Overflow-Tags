library(tidyverse)

# loading data from csv files
English2018 <- read_csv('datascience/Stack_Overflow_Data/English2018.csv')
Russian2018 <- read_csv('datascience/Stack_Overflow_Data/Russian2018.csv')

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

