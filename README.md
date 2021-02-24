# Movie Review Sentiment Analysis

Name – Dhirendra Kumar
Net ID – DK21

## Introduction:

We have been provided with a dataset consisting of 50,000 IMDB movie reviews, where each
review is labelled as positive or negative. The goal is to build a binary classification model to
predict the sentiment of a movie review with a vocabulary size less than or equal to 2000. We
can use the same vocabulary for all five training/test datasets.

Evaluation metric is area under the curve (AUC) on the test data. Given target AUC is 0.96 and
we should try to produce AUC equal to or bigger than 0.96 over all five-test data.

## Technical detail of model:

1. Preprocessing
    - Removed punctuation from data because in sentiment analysis punctuation does
       not have any values.
    - Converted text data to lower case to avoid distinguish between words upper and
       lower case.
    - Tokenize the sentence into words, we are implementing bag of words based
       sentiment analysis that’s why we need words rather than sentences.
2. Model selection

```
Generalized linear model with Lasso/Ridge to ElasticNet with various choices of
alpha values have been explored. The Ridge regularization was selected in the
final code because of better AUC and model execution time.
```

#### ❖ RIDGE

- The _family=” binomial”_ was used to perform the simple logistic
    regression. In this setting it allows to estimate the parameters of the
    binomial GLM by optimizing likelihood whilst imposing the Ridge penalty
    on the parameter estimates.
- After data preprocessing we used training and testing and _cv.glmnet_
    function with argument _type.measure="auc"_ to build the Ridge model
    which can automatically tune the parameter and choose the best lambda.
- Argument _type.measure="auc"_ is for two-class logistic regression only,
    and gives area under the ROC curve.
- We used same approach to preprocess test data by converting all text to
    lower case, removing punctuation from data and tokenize sentence into
    the words.
- Created a document-term matrix of test data to use in the prediction.
- Then we made prediction by estimating the probability that a new set of
    input belongs to which class.
- Once we found suitable parameters, we than generate predictions for the
    data and save in the mysubmission.txt file along with the test id’s.

## Performance summary and conclusion:

In following evaluation metrics table, we provided the LASSO models execution time and AUC
of 5 training/test datasets. The AUC values of LASSO models are above 0.96 which has also a
very good performance under 2 minutes execution time for all splits training data.

```
Split # AUC Model Run Time
```
```
Performance for Split 1 0.9693 1.657999 mins
Performance for Split 2 0.9685 1.668663 mins
Performance for Split 3 0.9689 1.665748 mins
Performance for Split 4 0.9695 1.665375 mins
Performance for Split 5 0.
1.679069 mins
```
```
Total execution time 8.33 minutes
```

## Limitation & Future steps to improve:

- The limitation of the model is that we used linear decision boundary and I think
    nonlinear decision boundary could have helped better. We use simple words as feature
    and do not make use of latent structure that is the order of words which is not always
    good for the prediction models. Some reviews are hard to predict just by bag-of-word
    approach.
- The model seems to make wrong prediction in case where the frequency of words terms
    that we have in the vocabulary list is very less or the review conveyed by not using strong
    positive or negatives words. It depends on person who express their opinion by
    elaborating the information and do not directly they like or dislike. In this situation our
    model unable to capture such intents for prediction.
- Prune vocabulary size further using methods of variable selection
- Upon a closer look in the vocabulary list, there are many single words unrelated to
    negative/positive sentiment, eg. “email”, “hairy”, “dorm”, “dvd”, “dialog”, “just”,
    “ladder”. These words can be added to list of stop_words

## Testing Specs:

### 1.) Windows 10 Pro, Intel i5-7300HQ CPU @ 2.50 GHz, 16GB RAM

## References :

### 1. https://piazza.com/class/kdf6l5f8bb78j?cid=

### 2. https://www.kaggle.com/c/word2vec-nlp-tutorial/overview/part- 2 - word-vectors

### 3. https://cran.r-project.org/web/packages/text2vec/vignettes/text-vectorization.html


