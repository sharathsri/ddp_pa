---
title       : Confusion matrix is the key to choose a classification model 
subtitle    : 
author      : 
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Confusion matrix

1. Confusion matrix is a table to represent the performance of a classifier.
2. Maximum values in the diagonal of the table indicates a good classifier.
3. Confusion Matrix in R also outputs classifier parameters like accuracy, p-value, etc 

--- .class #id 

## Diamonds data-set & lda classifier

1. Diamonds dataset contains price and other attributes of 54,000 diamonds.
2. 20% of the data is chosen for testing the classifier.
3. 'cut', 'color' and 'clarity' are factor variables.
4. Using lda classifier we will predict 'cut', 'color' and 'clarity' from all other numeric variables.
5. We will infer performance by understanding the confusion matrix of the classifier.

--- .class #id

## R code to build a classifier


```r
library(ggplot2)
library(caret)
dataset<-diamonds[ ,-c(3,4)]
inTrain <- createDataPartition(y=dataset$cut,
                              p=0.80, list=FALSE)
training <- dataset[inTrain,]
testing <- dataset[-inTrain,]
ldaModFit <- train(cut ~.,data=training, method="lda")

pred1 <- predict(ldaModFit,newdata=testing)
tbl<-confusionMatrix(pred1,testing$cut)$table
```




--- .class #id

## Example output

Confusion Matrix of 'cut' value prediction using lda:


```
##            Reference
## Prediction  Fair Good Very Good Premium Ideal
##   Fair       187  110        31      11     6
##   Good        20  137        93      18     0
##   Very Good   17  198       626     362   107
##   Premium     50  277       640    1782   168
##   Ideal       48  259      1026     585  4029
```



