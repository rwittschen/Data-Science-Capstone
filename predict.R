## predict.R
## Lee Wittschen
## 29 June 2018
##Word prediction code

library(dplyr)
library(stringr)
library(RWeka)
library(tm)

##read in the n-gram frequency data frames used for prediction
bigram <- readRDS("n.bigram.20.df.RDS")
trigram <- readRDS("n.trigram.20.df.RDS")
quadgram <- readRDS("n.quadgram.20.df.RDS")
pentgram <- readRDS("n.pentgram.20.df.RDS")
hexgram <- readRDS("n.hexgram.20.df.RDS")

##Word.6 is used when entered word string is more than 5 words
select.word.6 <- function(input){
  input_count <- str_count(input, boundary("word"))
  input_words <- unlist(strsplit(input," "))
  input_words <- tolower(input_words)
  test <- filter(hexgram, 
                 Word1==input_words[input_count-4], 
                 Word2==input_words[input_count-3], 
                 Word3==input_words[input_count-2],
                 Word4==input_words[input_count-1],
                 Word5==input_words[input_count])
  test <- test[order(test$Freq, decreasing = TRUE),]
  out <- test$Word6[1]
  
  ## If out = NA (no match found), then call select.word.5
  if(is.na(out[1])){select.word.5(input)
  } else{
    return(out)
  }
}

##Word.5 is used when entered word string is equal to 4 words
select.word.5 <- function(input){
  input_count <- str_count(input, boundary("word"))
  input_words <- unlist(strsplit(input," "))
  input_words <- tolower(input_words)
  test <- filter(pentgram, 
                 Word1==input_words[input_count-3], 
                 Word2==input_words[input_count-2], 
                 Word3==input_words[input_count-1],
                 Word4==input_words[input_count])
  test <- test[order(test$Freq, decreasing = TRUE),]
  out <- test$Word5[1]
  ## If out = NA, then call select.word.3
  if(is.na(out[1])){select.word.4(input)
  } else{
    return(out)
  }
}

##Word.4 is used when entered word string is equal to 3 words
select.word.4 <- function(input){
  input_count <- str_count(input, boundary("word"))
  input_words <- unlist(strsplit(input," "))
  input_words <- tolower(input_words)
  test <- filter(quadgram, 
                 Word1==input_words[input_count-2], 
                 Word2==input_words[input_count-1], 
                 Word3==input_words[input_count])
  test <- test[order(test$Freq, decreasing = TRUE),]
  out <- test$Word4[1]
  ## If out = NA, then call select.word.2
  if(is.na(out[1])){select.word.3(input)
  } else{
  return(out)
  }
}

##Word.3 is used when entered word string is equal to 2 words
select.word.3 <- function(input){
  input_count <- str_count(input, boundary("word"))
  input_words <- unlist(strsplit(input," "))
  input_words <- tolower(input_words)
  test <- filter(trigram, 
                 Word1==input_words[input_count-1], 
                 Word2==input_words[input_count])
  test <- test[order(test$Freq, decreasing = TRUE),]
  out <- test$Word3[1]
  ## If out = NA, then call select.word.2
  if(is.na(out[1])){select.word.2(input)
  } else{
  return(out)
  }
}

##Word.2 is used when entered word string is equal to 1 word
select.word.2 <- function(input){
  input_count <- str_count(input, boundary("word"))
  input_words <- unlist(strsplit(input," "))
  input_words <- tolower(input_words)
  test <- filter(bigram, 
                 Word1==input_words[input_count])
  test <- test[order(test$Freq, decreasing = TRUE),]
  out <- test$Word2[1]
  return(out)
}

##Main code - cleans the entered word string and based on the number of words
##calls the appropriate prediction routine
word.entry <- function(sentence){
  corpus <- Corpus(VectorSource(sentence))
  corpus <- tm_map(corpus, tolower)
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, PlainTextDocument)
  sentence.clean<- as.character(corpus[[1]])
  word.count <- str_count(sentence.clean, boundary("word"))

  if(word.count>=5){
    suggest <- select.word.6(sentence.clean)
  }
  else if(word.count==4){
    suggest <- select.word.5(sentence.clean)
  }
  else if(word.count==3){
    suggest <- select.word.4(sentence.clean)
  }
  else if(word.count==2){
    suggest <- select.word.3(sentence.clean)
  }
  else if(word.count==1){
    suggest <- select.word.2(sentence.clean)
  }
  else{
    suggest <- "the"  ##The most frequently found word in the unigrams
  }
  return(suggest)
}

