library(tidyverse)
library(tidytext)
library(ggwordcloud)
library(gutenbergr)
library(textdata)

BostonMagazineClimate <- tibble(text = read_lines('BostonMagazineClimate.txt'))

BM_Words <-  BostonMagazineClimate %>% unnest_tokens(word, text)
BM_Words_SW <- BM_Words %>% anti_join(stop_words)
BM_Count <- BM_Words_SW %>% count(word, sort=TRUE)

BMSentiment_affin <- BM_Words %>%
  inner_join(get_sentiments("afinn"))

BMSentiment_nrc <- BM_Words %>%
  inner_join(get_sentiments("nrc"))

BMSentiment_bing <- BM_Words %>%
  inner_join(get_sentiments("bing"))

table(BMSentiment_bing$sentiment)
table(BMSentiment_nrc$sentiment)

(ggplot(data = BMSentiment_affin, 
       aes(x=value))+
  geom_histogram()+
  ggtitle("Boston Magazine Climate Sentiment Range")+
  theme_minimal())



ChicagoHeraldClimate <- tibble(text = read_lines('ChicagoHeraldClimate.txt'))

CH_Words <-  ChicagoHeraldClimate %>% unnest_tokens(word, text)
CH_Words_SW <- CH_Words %>% anti_join(stop_words)
CH_Count <- CH_Words_SW %>% count(word, sort=TRUE)

CHSentiment_affin <- CH_Words %>%
  inner_join(get_sentiments("afinn"))

CHSentiment_nrc <- CH_Words %>%
  inner_join(get_sentiments("nrc"))

CHSentiment_bing <- CH_Words %>%
  inner_join(get_sentiments("bing"))

table(CHSentiment_bing$sentiment)
table(CHSentiment_nrc$sentiment)

(ggplot(data = CHSentiment_affin, 
        aes(x=value))+
    geom_histogram()+
    ggtitle("Boston Magazine Climate Sentiment Range")+
    theme_minimal())

# term frequency - inverse document frequency tf-idf. Here we are going to treat
# each of our speeches as a document in a corpus and explore the relative 
# importance of words to these speeches as compared to the overall corpus. 


