
Coursera Data Science Specialization Capstone Project
========================================================
author: Lee Wittschen
date: 21 July 2018
autosize: true

Project Objective
========================================================
The overall goal of the project is to create an application that predicts the next word in a given string of words. The project was comprised of the following steps:
- Leverage SwiftKey text documents from blogs, news and twitter feeds which can be found:
  - https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip
- Complete initial data cleansing and analysis of the text data
- Develop prediction routine for the next word using the provided data sets
- Develop a Shiny application as the predictive text product

Data Processing Description
========================================================
The text documents from SwiftKey were read into R, with initial data cleansing converting the text to UTF-8/ASCII and taking out special characters.

A 20% sample is taken and the 'tm' R package is used to sample the data and further cleanse, removing punctuation, white space, numbers, url's and set characters to all lower case.

The 'quanteda' R package is used to create n-grams (I found this to be a faster and less memory-intesive package to use for creating the n-grams than 'tm').

The n-grams were created where n=(2, 3, 4, 5, 6) and then converted to term frequency data frames and stored in descending order of frequency.


Prediction Description
========================================================
The prediction algorithm is based off the Katz back-off approach that estimates the conditional probability of a word given it's history in an n-gram. The estimation is completed by 'backing off' through progressively shorter n-grams.

The algorithm begins with a 6-gram, matching the first 5 words of the 6-gram with the last 5 words of the entered sentence and taking the 6th word of the 6-gram with the greatst frequency value as the predicted word.

If not match is found with the 6-gram, the algorithm moves to the 5-gram, searching for a match in a similar manner as described above.

The algorithm continues this process, where if no match is found it moves to the next n-gram to search for the predicted word.

If no match is found in the n-grams, then the word 'the' is suggested as it was found to be the most frequent word in the 1-gram.


Project Links
========================================================
- The Shiny word prediction application can be found here:
  https://rwitts.shinyapps.io/Word/
  
- Github repository containing the shiny application, the n-gram data and the prediction code can be found here:
  https://github.com/rwittschen/Data-Science-Capstone
  


