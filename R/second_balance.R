find_two_nearest_balances <- function(vect_ilr, psi, vect_ilr_2 = vect_ilr) {
  # find first balance
  first_bal <- find_nearest_balance(vect_ilr, psi, "b1")

  # find second balance
  clr_vect <- drop(vect_ilr_2 %*% psi)
  names(clr_vect) <- colnames(psi)

  features_not_in_balance <- clr_vect[setdiff(
    colnames(psi),
    c(first_bal$num, first_bal$den)
  )]
  features_not_in_balance <- sort(features_not_in_balance, decreasing = T)

  best_bal_pos <- find_nearest_balance_clr(clr_vect[first_bal$num], "b2")
  best_bal_neg <- find_nearest_balance_clr(clr_vect[first_bal$den], "b2")
  balances <- list(pos = best_bal_pos, neg = best_bal_neg)
  balances <- balances[!is.na(balances)]


  if (length(features_not_in_balance) > 0) {
    # other taxa
    best_bal_other <- find_nearest_balance_clr(features_not_in_balance, "b2")
    balances[["other"]] <- best_bal_other

    # mixed balance
    balances <- balances[!is.na(balances)]
    first_bal_mean_clr <- mean(clr_vect[c(first_bal$num, first_bal$den)])
    n_first <- length(c(first_bal$num, first_bal$den))
    replacing_features <- rep(first_bal_mean_clr, n_first)
    names(replacing_features) <- c(first_bal$num, first_bal$den)
    ll <- list(
      a = list(
        features = c(replacing_features, features_not_in_balance),
        min_pos = n_first, min_neg = 1
      ),
      b = list(
        features = c(features_not_in_balance, replacing_features),
        min_pos = 1, min_neg = n_first
      )
    )

    D <- length(clr_vect)
    ll_best <- lapply(ll, function(x) {
      proj_vals <- matrix(NA, nrow = D - 1, ncol = D - 1)
      for (r in x$min_pos:(D - x$min_neg)) {
        for (s in x$min_neg:(D - x$min_pos)) {
          proj_vals[r, s] <- sqrt(r * s / (r + s)) * (mean(x$features[1:r]) - mean(x$features[D:(D - s + 1)]))
        }
      }
      best_proj <- max(proj_vals, na.rm = T)
      r_s <- drop(which(proj_vals == best_proj, arr.ind = T))
      pos <- x$features[1:r_s["row"]]
      neg <- x$features[D:(D - r_s["col"] + 1)]
      impact <- best_proj**2 / drop(clr_vect %*% clr_vect)
      bal_sbp <- balance_to_sbp(names(clr_vect), names(pos), names(neg), "b2")
      list(num = names(pos), den = names(neg), impact = impact, sbp = bal_sbp)
    })
    balances[["mixed_a"]] <- ll_best$a
    balances[["mixed_b"]] <- ll_best$b
  }

  # the impact in balances is unrelevant
  balances <- lapply(balances, function(bal) {
    r <- length(bal$num)
    s <- length(bal$den)
    proj <- sqrt(r * s / (r + s)) * (mean(clr_vect[bal$num]) - mean(clr_vect[bal$den]))
    bal$impact <- drop(proj**2 / (clr_vect %*% clr_vect))
    bal$coord <- proj
    bal
  })

  impacts <- sapply(balances, function(bal) bal$impact)
  best_bal <- balances[[which.max(impacts)]]
  sbp <- data.frame(
    b1 = first_bal$sbp[names(clr_vect), ],
    b2 = best_bal$sbp[names(clr_vect), ]
  )
  rownames(sbp) <- names(clr_vect)
  sbp[is.na(sbp)] <- 0

  list(
    b1 = first_bal, b2 = best_bal, sbp = sbp,
    impacts = c(b1 = first_bal$impact, b2 = best_bal$impact),
    coord = c(b1 = first_bal$coord, b2 = best_bal$coord)
  )
}
