##### Midterm Capstone Project for Nashville Software School Data Science Program
### Visual Tag Analysis of Two Language-Specific Stack Overflow Communities: English and Russian

### Overview

Stack Overflow has many groups separated by interests. Search of Stack Overflow is facilitated by proper topic tagging. Stack Exchange can be used to query Stack Overflow tags (and explore their popularity). Russian Stack Overflow is also a large and active community. Comparing tags of the English-speaking Stack Overflow to the Russian counterpart may reveal interesting trends.

### Motivation

As an IT professional, I use Stack Overflow frequently. Sometimes there are answers on the Russian site, which cannot be found within the English-speaking community. Data Camp has a project, which explores Stack Overflow tags as a way of finding the most popular programming languages. However, the Data Camp project lacks:
* R Shiny app to facilitate interactive trend discovery and 
* tag analysis of the Russian-speaking community

### Null and Alternative Hypotheses

**Null Hypothesis**:
Russian and English tags of Stack Overflow belong to the same population group (Russian Stack Overflow is simply a smaller subset of the same tag space).\
**Alternative Hypothesis**:
Russian and English tags of Stack Overflow represent two different population groups (with distinct tags and popularity).  

### Data Collection and Preparation

Stack_Overflow_Data data folder contains .csv files, which were collected in several rounds (one per language per year) from [StackExchange Data Explorer](https://data.stackexchange.com/) using the [query](https://github.com/amerus/Stack-Overflow-Tags/blob/master/query)

### Widget Controls and Graphs

Left panel widgets interact with the graphs on the right. Right panel has three graphs separated by tabs. The same widgets interact with all of the application graphs. Note: Right panel graphs also have several interactive features. Try hovering your mouse over the graph lines, the icons directly above the graphs, or clicking on individual legend items.

### Preliminary Findings

Visual inspection alone is not enough to reject the stated null hypothesis. Although some differences are apparent, such as the absence of **r** and **pandas** tags in the Russian-speaking community, many other trends are very similar.

### Live Demo

Previously deployed version of this project can be found [here](https://amerus.shinyapps.io/Stack_Overflow_English_Russian/)
