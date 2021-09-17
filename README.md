# Content
[TOC]


# Installation
```
library(devtools)
install_bitbucket('knomics/nearestbalance', auth_user = '<username>', password = '<password>')
library(NearestBalance)
```

where `<username>` and `<password>` - your username and password 

# Requirements
...

# Quick start quide
```
library(NearestBalance)
library(selbal)
library(zCompositions)

# get test data
test_data <- selbal::HIV[1:60]
abundance <- cmultRepl(test_data)
nb <- nb_lm(abundance,
            f = HIV$HIV_Status,
            cov = NULL,
            type = "two_balances")

# best balance 
nb$b1
```

