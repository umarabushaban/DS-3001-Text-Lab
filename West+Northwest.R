library(tidyverse)
library(tidytext)
library(ggwordcloud)
library(gutenbergr)
library(textdata)

LATimesClimate <- tibble(text = read_lines('LA_Times_Climate.txt'))

LA_Words <-  LATimesClimate %>% unnest_tokens(word, text)
LA_Words_SW <- LA_Words %>% anti_join(stop_words)
LA_Count <- LA_Words_SW %>% count(word, sort=TRUE)

LASentiment_affin <- LA_Words %>%
  inner_join(get_sentiments("afinn"))

LASentiment_nrc <- LA_Words %>%
  inner_join(get_sentiments("nrc"))

LASentiment_bing <- LA_Words %>%
  inner_join(get_sentiments("bing"))

table(LASentiment_bing$sentiment)
table(LASentiment_nrc$sentiment)

(ggplot(data = LASentiment_affin, 
        aes(x=value))+
    geom_histogram()+
    ggtitle("Los Angeles Times Climate Sentiment Range")+
    theme_minimal())


SeattleTimesClimate <- tibble(text = read_lines('Seattle_Times_Climate.txt'))

Seattle_Words <-  SeattleTimesClimate %>% unnest_tokens(word, text)
Seattle_Words_SW <- Seattle_Words %>% anti_join(stop_words)
Seattle_Count <- Seattle_Words_SW %>% count(word, sort=TRUE)

SeattleSentiment_affin <- Seattle_Words %>%
  inner_join(get_sentiments("afinn"))

SeattleSentiment_nrc <- Seattle_Words %>%
  inner_join(get_sentiments("nrc"))

SeattleSentiment_bing <- Seattle_Words %>%
  inner_join(get_sentiments("bing"))

table(SeattleSentiment_bing$sentiment)
table(SeattleSentiment_nrc$sentiment)

(ggplot(data = SeattleSentiment_affin, 
        aes(x=value))+
    geom_histogram()+
    ggtitle("The Seattle Times Climate Sentiment Range")+
    theme_minimal())


