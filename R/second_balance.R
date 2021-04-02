find_two_nearest_balances <- function(vect_ilr, psi,  vect_ilr_2 = vect_ilr){
  #find first balance
  first_bal <- find_nearest_balance(vect_ilr, psi)

  # find second balance
  clr_vect <- drop(vect_ilr_2 %*% psi)
  names(clr_vect) <- colnames(psi)

  features_not_in_balance <- clr_vect[setdiff(colnames(psi),
                                              c(first_bal$num, first_bal$den))]
  features_not_in_balance <- sort(features_not_in_balance, decreasing = T)

  best_bal_pos <- find_nearest_balance_clr(clr_vect[first_bal$num])
  best_bal_neg <- find_nearest_balance_clr(clr_vect[first_bal$den])
  balances <- list(pos = best_bal_pos, neg = best_bal_neg)
  balances <- balances[!is.na(balances)]
  # the impact in balances is unrelevant
  balances <- lapply(balances, function(bal){
    r <- length(bal$num)
    s <- length(bal$den)
    proj <- sqrt(r*s/(r+s))*(mean(clr_vect[bal$num]) - mean(clr_vect[bal$den]))
    bal$impact <-  drop(proj**2/(clr_vect %*% clr_vect))
    bal
  })

  if (length(features_not_in_balance) >0){
    best_bal_other <- find_nearest_balance_clr(features_not_in_balance)
    first_bal_mean_clr <- mean(clr_vect[c(first_bal$num, first_bal$den)])
    n_first <- length(c(first_bal$num, first_bal$den))
    replacing_features <- rep(first_bal_mean_clr,n_first)
    names(replacing_features) <- c(first_bal$num, first_bal$den)
    ll <- list(
      a = list(features  =  c(replacing_features, features_not_in_balance),
               min_pos = n_first, min_neg = 1),
      b = list(features  =  c(features_not_in_balance, replacing_features),
               min_pos = 1, min_neg = n_first))

    D <- length(clr_vect)
    ll_best <- lapply(ll, function(x){
      proj_vals <- matrix(NA, nrow = D-1, ncol = D-1)
      for (r in x$min_pos:(D-x$min_neg)){
        for (s in x$min_neg:(D-x$min_pos)){
          proj_vals[r,s] <- sqrt(r*s/(r+s))*(mean(x$features[1:r])- mean(x$features[D:(D-s+1)]))
        }
      }
      best_proj = max(proj_vals, na.rm = T)
      r_s <- drop(which(proj_vals == best_proj, arr.ind = T))
      pos <- x$features[1:r_s["row"]]
      neg <- x$features[D:(D - r_s["col"]+1)]
      impact <- best_proj **2/(clr_vect %*% clr_vect)
      list(num = names(pos),den = names(neg), impact = impact)
    })
    balances[["mixed_a"]] <- ll_best$a
    balances[["mixed_b"]] <- ll_best$b
  }
  impacts <- sapply(balances, function(bal) bal$impact)
  best_bal <- balances[[which.max(impacts)]]
  list(b1 = first_bal, b2 = best_bal)
}
