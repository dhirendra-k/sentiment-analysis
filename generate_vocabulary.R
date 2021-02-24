library(tm)
library(Matrix)
library(SnowballC)
library(glmnet)
library(wordcloud)
library(ggplot2)
j = 1

#setwd(paste("split_", j, sep=""))
train = read.table("alldata.tsv", stringsAsFactors = FALSE,header = TRUE)
train$review = gsub('<.*?>', ' ', train$review)

stop_words = c("i", "me", "my", "myself", 
               "we", "our", "ours", "ourselves", 
               "you", "your", "yours", 
               "their", "they", "his", "her", 
               "she", "he", "a", "an", "and",
               "is", "was", "are", "were", 
               "him", "himself", "has", "have", 
               "it", "its", "the", "us")
it_train = itoken(train$review,
                  preprocessor = tolower, 
                  tokenizer = word_tokenizer)
tmp.vocab = create_vocabulary(it_train, stopwords = stop_words, ngram = c(1L,4L))
tmp.vocab = prune_vocabulary(tmp.vocab, term_count_min = 10,
                             doc_proportion_max = 0.5,
                             doc_proportion_min = 0.001)
dtm_train  = create_dtm(it_train, vocab_vectorizer(tmp.vocab))

set.seed(6017)
tmpfit = glmnet(x = dtm_train, 
                y = train$sentiment, 
                alpha = 1,
                family='binomial')
tmpfit$df
myvocab = colnames(dtm_train)[which(tmpfit$beta[, 34] != 0)] # Change index number of tmpfit$df list less than 1000 to get full credit
myvocab
write(myvocab, file="myvocab.txt")
