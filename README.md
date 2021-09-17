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

## R packages:

data.table
partitions
stringr
balance
data.tree

## R packages required for the examples below:
selbal
zCompositions

# Quick start quide

## Get test data
```
library(NearestBalance)
library(selbal)
library(zCompositions)
test_data <- selbal::HIV[1:60]
abundance <- cmultRepl(test_data)
```
## Find two best microbial balances associated with HIV status (selbal package) using linear regression in ilr space
```
nb <- nb_lm(abundance,
            f = HIV$HIV_Status,
            cov = NULL,
            type = "two_balances")
# best balance 
nb$b1
# second balance
nb$b2
```
## Find two best microbial balances associated with HIV status (selbal package) using SVM in ilr space

