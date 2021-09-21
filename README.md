
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NearestBalance

<!-- badges: start -->
<!-- badges: end -->

The goal of NearestBalance is to …

## Installation

You can install the released version of NearestBalance from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("NearestBalance")
```

## Quick start guide

Load data for the example

``` r
library(NearestBalance)
library(zCompositions)
#> Loading required package: MASS
#> Loading required package: NADA
#> Loading required package: survival
#> 
#> Attaching package: 'NADA'
#> The following object is masked from 'package:stats':
#> 
#>     cor
#> Loading required package: truncnorm
library(selbal)
test_data <- selbal::HIV[1:60]
abundance <- cmultRepl(test_data)
#> No. corrected values:  820
```

## Principal balance analysis with NearestBalance

``` r
nb_1 <- nb_pca(abundance)
plot_nb_pca(nb_1, colour = HIV$MSM, pch = HIV$HIV_Status)
```

<img src="man/figures/README-PBA-1.png" width="100%" />

``` r
# first principal balance
nb_1$nb$b1
#> $num
#>  [1] "g_Alistipes"                         
#>  [2] "g_Barnesiella"                       
#>  [3] "g_Bacteroides"                       
#>  [4] "g_Odoribacter"                       
#>  [5] "g_Parabacteroides"                   
#>  [6] "f_Porphyromonadaceae_g_unclassified" 
#>  [7] "g_Thalassospira"                     
#>  [8] "g_Butyricimonas"                     
#>  [9] "g_Anaerostipes"                      
#> [10] "g_Paraprevotella"                    
#> [11] "f_Erysipelotrichaceae_g_unclassified"
#> [12] "g_Streptococcus"                     
#> [13] "g_Bifidobacterium"                   
#> [14] "g_Blautia"                           
#> [15] "g_Collinsella"                       
#> 
#> $den
#>  [1] "g_Alloprevotella"                      
#>  [2] "g_RC9_gut_group"                       
#>  [3] "g_Prevotella"                          
#>  [4] "f_vadinBB60_g_unclassified"            
#>  [5] "g_Succinivibrio"                       
#>  [6] "g_Oribacterium"                        
#>  [7] "o_Bacteroidales_g_unclassified"        
#>  [8] "k_Bacteria_g_unclassified"             
#>  [9] "g_Dialister"                           
#> [10] "g_Solobacterium"                       
#> [11] "g_Catenibacterium"                     
#> [12] "g_Victivallis"                         
#> [13] "g_Anaerovibrio"                        
#> [14] "g_Intestinimonas"                      
#> [15] "f_Erysipelotrichaceae_g_Incertae_Sedis"
#> [16] "f_Rikenellaceae_g_unclassified"        
#> [17] "g_Anaerotruncus"                       
#> [18] "g_Megasphaera"                         
#> [19] "g_Phascolarctobacterium"               
#> [20] "g_Mitsuokella"
```

## Regression analysis

``` r
nb_2 <- nb_lm(abundance = abundance,
              metadata = HIV,
              pred = "MSM",
              cov = "HIV_Status")
```

Statistical significance of the association

``` r
summary(manova(nb_2$lm_res))
#>             Df  Pillai approx F num Df den Df  Pr(>F)    
#> MSM          1 0.82537   7.5300     59     94 < 2e-16 ***
#> HIV_Status   1 0.45820   1.3474     59     94 0.09761 .  
#> Residuals  152                                           
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

nearest balance interpretation of the regression coefficient

``` r
nb_2$nb$b1
#> $num
#>  [1] "g_Alloprevotella"                      
#>  [2] "g_Prevotella"                          
#>  [3] "g_Succinivibrio"                       
#>  [4] "g_RC9_gut_group"                       
#>  [5] "g_Dialister"                           
#>  [6] "f_vadinBB60_g_unclassified"            
#>  [7] "g_Phascolarctobacterium"               
#>  [8] "g_Oribacterium"                        
#>  [9] "f_Erysipelotrichaceae_g_Incertae_Sedis"
#> [10] "k_Bacteria_g_unclassified"             
#> [11] "g_Catenibacterium"                     
#> [12] "o_Bacteroidales_g_unclassified"        
#> [13] "g_Intestinimonas"                      
#> [14] "g_Megasphaera"                         
#> [15] "g_Mitsuokella"                         
#> [16] "g_Solobacterium"                       
#> [17] "g_Victivallis"                         
#> [18] "g_Anaerovibrio"                        
#> 
#> $den
#>  [1] "g_Alistipes"                         "g_Barnesiella"                      
#>  [3] "g_Bacteroides"                       "g_Odoribacter"                      
#>  [5] "g_Parabacteroides"                   "f_Porphyromonadaceae_g_unclassified"
#>  [7] "g_Thalassospira"                     "g_Butyricimonas"                    
#>  [9] "g_Anaerostipes"                      "g_Paraprevotella"                   
#> [11] "g_Streptococcus"                     "g_Bifidobacterium"                  
#> [13] "g_Escherichia-Shigella"
```

## Interpretation of the SVM results

``` r
nb_3 <- nb_svm(abundance = abundance,
               f = HIV$HIV_Status)
```

The nearest balance for the discriminating direction

``` r
nb_3$nb$b1
#> $num
#>  [1] "f_Ruminococcaceae_g_unclassified"    
#>  [2] "g_Bacteroides"                       
#>  [3] "f_Erysipelotrichaceae_g_unclassified"
#>  [4] "g_Subdoligranulum"                   
#>  [5] "g_Megasphaera"                       
#>  [6] "g_Succinivibrio"                     
#>  [7] "g_Alloprevotella"                    
#>  [8] "o_Clostridiales_g_unclassified"      
#>  [9] "g_Alistipes"                         
#> [10] "g_Blautia"                           
#> [11] "f_Rikenellaceae_g_unclassified"      
#> [12] "g_Anaerovibrio"                      
#> [13] "o_NB1-n_g_unclassified"              
#> [14] "g_Lachnospira"                       
#> [15] "f_Defluviitaleaceae_g_Incertae_Sedis"
#> [16] "f_Lachnospiraceae_g_Incertae_Sedis"  
#> [17] "g_Odoribacter"                       
#> [18] "g_Solobacterium"                     
#> [19] "g_Anaerotruncus"                     
#> 
#> $den
#>  [1] "f_Ruminococcaceae_g_Incertae_Sedis"      
#>  [2] "g_Butyricimonas"                         
#>  [3] "g_Oribacterium"                          
#>  [4] "g_Streptococcus"                         
#>  [5] "g_Dorea"                                 
#>  [6] "f_vadinBB60_g_unclassified"              
#>  [7] "g_Brachyspira"                           
#>  [8] "g_Dialister"                             
#>  [9] "g_Coprococcus"                           
#> [10] "g_RC9_gut_group"                         
#> [11] "g_Anaeroplasma"                          
#> [12] "g_Paraprevotella"                        
#> [13] "g_Thalassospira"                         
#> [14] "f_Peptostreptococcaceae_g_Incertae_Sedis"
#> [15] "g_Acidaminococcus"
```

## Interpretation of the LDA results

``` r
nb_4 <- nb_lda(abundance = abundance,
               f = HIV$HIV_Status)
```

The nearest balance for the discriminating direction

``` r
nb_4$nb$b1
#> $num
#>  [1] "f_Ruminococcaceae_g_unclassified"    
#>  [2] "g_Blautia"                           
#>  [3] "g_Bacteroides"                       
#>  [4] "f_Erysipelotrichaceae_g_unclassified"
#>  [5] "g_Anaerovibrio"                      
#>  [6] "g_Solobacterium"                     
#>  [7] "g_Bifidobacterium"                   
#>  [8] "g_Subdoligranulum"                   
#>  [9] "g_Roseburia"                         
#> [10] "g_Alistipes"                         
#> [11] "f_Defluviitaleaceae_g_Incertae_Sedis"
#> [12] "g_Succinivibrio"                     
#> 
#> $den
#> [1] "f_Lachnospiraceae_g_Incertae_Sedis" "g_Oribacterium"                    
#> [3] "f_Ruminococcaceae_g_Incertae_Sedis" "g_Butyricimonas"                   
#> [5] "f_Lachnospiraceae_g_unclassified"   "g_RC9_gut_group"
```

## Interpretation of differences between two samples

``` r
nb_5 <- nb_shift(abundance = abundance[,1:15],
                 samp_1 = rownames(abundance)[1],
                 samp_2 = rownames(abundance)[2],
                 type = "two_balances")
```

The nearest balance

``` r
nb_5$b1
#> $num
#> [1] "g_Succinivibrio"                       
#> [2] "f_Erysipelotrichaceae_g_Incertae_Sedis"
#> 
#> $den
#> [1] "g_Dorea"                            "g_Alloprevotella"                  
#> [3] "f_Ruminococcaceae_g_unclassified"   "f_Lachnospiraceae_g_Incertae_Sedis"
#> [5] "g_Lachnospira"                      "f_Lachnospiraceae_g_unclassified"  
#> [7] "g_Blautia"
```

Impacts of the balances

``` r
nb_5$impactsdthf
#> NULL
```
