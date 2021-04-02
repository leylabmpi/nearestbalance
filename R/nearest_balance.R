find_nearest_balance_clr <- function(clr_vect){
  D <- length(clr_vect)
  if (D < 2) return(NA)

  clr_vect_pos <- sort(clr_vect, decreasing = T)
  clr_vect_neg <- sort(clr_vect)
  equiv_groups = sapply(unique(clr_vect), function(x) names(clr_vect)[clr_vect == x])
  equiv_groups <- equiv_groups[sapply(equiv_groups, function(x) length(x) > 1)]
  proj_vals <- matrix(NA, nrow = D-1, ncol = D-1)
  for (r in 1:(D-1)){
    for (s in 1:(D-r)){
      proj_vals[r,s] <- sqrt(r*s/(r+s))*
        (mean(clr_vect_pos[1:r]) - mean(clr_vect_neg[1:s]))
    }
  }
  impacts = proj_vals**2/drop(clr_vect %*% clr_vect)
  best_impact = max(impacts, na.rm = T)
  r_s <- which(impacts == best_impact, arr.ind = T)

  pos <- clr_vect_pos[1:r_s[1,"row"]]
  neg <- clr_vect_neg[1:r_s[1,"col"]]
  impact <- impacts[r_s[1,"row"], r_s[1,"col"]]

  return(list(
    num = names(pos),
    den = names(neg),
    impact = impact
  ))
}


find_nearest_balance <- function(ilr_vector, psi){
  clr_vect <- drop(ilr_vector  %*% psi)
  names(clr_vect) <- colnames(psi)
  find_nearest_balance_clr(clr_vect)
}

nearest_balances_list <- function(clr_vect, plot= F){
  D <- length(clr_vect)
  if (D < 2) return(NA)

  clr_vect_pos <- sort(clr_vect, decreasing = T)
  clr_vect_neg <- sort(clr_vect)
  proj_vals <- matrix(NA, nrow = D-1, ncol = D-1)
  for (r in 1:(D-1)){
    for (s in 1:(D-r)){
      proj_vals[r,s] <- sqrt(r*s/(r+s))*
        (mean(clr_vect_pos[1:r]) - mean(clr_vect_neg[1:s]))
    }
  }
  clr_norm <- drop(clr_vect %*% clr_vect)
  best_balances <- lapply(2:D, function(n){
    proj_vals_n <- sapply(1:(n-1), function(i) proj_vals[i,n-i])
    i <- which.max(proj_vals_n)
    proj <- proj_vals[i, n-i]
    list(num=names(clr_vect_pos[1:i]),
         den=names(clr_vect_neg[1:(n-i)]),
         impact = proj**2/clr_norm)
  })
  names(best_balances) <-  paste0("n=",2:D)
  if (plot){
    plot(2:D, sapply(best_balances, function(x) x$impact),
         type = "l", ylab = "impact", xlab = "number of parts in balance")
  }
  return(best_balances)
}



#
#
# find_all_nearest_balances_clr <- function(clr_vect, eps = 10**(-15)){
#   D <- length(clr_vect)
#   if (D < 2) return(NA)
#
#   clr_vect_pos <- sort(clr_vect, decreasing = T)
#   clr_vect_neg <- sort(clr_vect)
#   equiv_groups = sapply(unique(clr_vect), function(x) names(clr_vect)[clr_vect == x])
#   equiv_groups <- equiv_groups[sapply(equiv_groups, function(x) length(x) > 1)]
#   proj_vals <- matrix(NA, nrow = D-1, ncol = D-1)
#   for (r in 1:(D-1)){
#     for (s in 1:(D-r)){
#       proj_vals[r,s] <- sqrt(r*s/(r+s))*
#         (mean(clr_vect_pos[1:r]) - mean(clr_vect_neg[1:s]))
#     }
#   }
#   impacts = proj_vals**2/drop(clr_vect %*% clr_vect)
#   best_impact = max(impacts, na.rm = T)
#   r_s <- which(abs(impacts - best_impact) <= eps, arr.ind = T)
#
#   best_balances = apply(r_s, 1, function(x){
#     pos <- clr_vect_pos[1:x["row"]]
#     neg <- clr_vect_neg[1:x["col"]]
#     impact <- impacts[x["row"], x["col"]]
#     equivalence <- lapply(equiv_groups, function(gr) {
#       ret = NULL
#       if (any(gr %in% names(pos)) & !all(gr %in% names(pos))) {
#         ret = gr
#       }
#       if (any(gr %in% names(neg)) & !all(gr %in% names(neg) )) {
#         ret = gr
#       }
#       ret
#     })
#     equivalence <- equivalence[!sapply(equivalence, is.null)]
#     if (length(equivalence) == 0) {
#       equivalence <- NULL
#     }
#     list(num = names(pos), den = names(neg),
#          impact = impact,
#          equivalence = equivalence)
#   })
#
#   return(list(
#     nearest_balances = best_balances,
#     impact = best_impact
#   ))
# }













