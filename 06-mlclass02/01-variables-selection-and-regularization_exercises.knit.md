
<!-- rnb-text-begin -->

---
title: "ML Algorithms for classification"
subtitle: "Exercises and solutions Logistic regression"
venue: "ITViate data science courses"
author: "Hicham Zmarrou"
date: "Notebook -- <http://bit.ly/2q9NPSU>  <br /> <br />"
output:
  html_notebook:
    highlight: pygments
    theme: cosmo
    toc: true
    toc_float: true
    number_sections: FALSE
---


<hr>

[Visit my website](http://trefoil.ml/) for more like this!

__References__

Most of this material is borrowed from:

* Textbook: [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)

Chapter 6 page 262-269


# Exercise 8 

In this exercise, we will generate simulated data, and will then use this data to perform best subset selection.

a. Use the rnorm() function to generate a predictor $X$ of length $n = 100$, as well as a noise vector $\varepsilon$ of length $n = 100$.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuc2V0LnNlZWQoMSlcbnggPC0gcm5vcm0oMTAwKVxuZXBzIDwtIHJub3JtKDEwMClcbmBgYFxuYGBgIn0= -->

```r
```r
set.seed(1)
x <- rnorm(100)
eps <- rnorm(100)
```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


b. Generate a response vector $Y$ of length $n = 100$ according to the model $$Y = \beta_0 + \beta_1X + \beta_2X^2 + \beta_3X^3 + \varepsilon$$ where $\beta_0$, $\beta_1$, $\beta_2$ and $\beta_3$ are constants of your choice.

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuYjAgPC0gMlxuYjEgPC0gM1xuYjIgPC0gLTFcbmIzIDwtIDAuNVxueSA8LSBiMCArIGIxICogeCArIGIyICogeF4yICsgYjMgKiB4XjMgKyBlcHNcbmBgYFxuYGBgIn0= -->

```r
```r
b0 <- 2
b1 <- 3
b2 <- -1
b3 <- 0.5
y <- b0 + b1 * x + b2 * x^2 + b3 * x^3 + eps
```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



c. Use the regsubsets() function to perform best subset selection in order to choose the best model containing the predictors $X,X^2,\cdots,X^{10}$. What is the best model obtained according to $C_p$, BIC, and adjusted $R^2$ ? Show some plots to provide evidence for your answer, and report the coefficients of the best model obtained. Note you will need to use the data.frame() function to create a single data set containing both $X$ and $Y$.


<!-- rnb-text-end -->


































































