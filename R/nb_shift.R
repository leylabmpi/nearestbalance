source("R/compositional_analysis_functions.R")
source("R/nearest_balance.R")
source("R/nearest_balance_tree.R")
source("R/second_balance.R")

nb_shift_ilr <- function(v,
                         sbp,
                         v2 = v,
                         type = c("one_balance", "two_balances", "tree"),
                         bal_list = F, plot_list = T){
  psi <- make_psi_from_sbp(sbp)
  type = match.arg(type)
  if(type == "one_balance"){
    res <- find_nearest_balance(v, psi, bal_list = bal_list,
                                plot_list = plot_list)
  } else if (type == "two_balances"){
    res <- find_two_nearest_balances(v, psi, v2)
  } else if (type == "tree"){
    res <- find_nearest_balance_tree(v, psi)
    res$bal_list <- lapply(res$sbp, )
  } else{
    stop("incorrect type of analysis")
  }
  return(res)
}

nb_shift <- function(abundance,
                     samp_1,
                     samp_2,
                     type = c("one_balance", "two_balances", "tree"),
                     bal_list = F, plot_list = T){
  sbp = sbp.fromRandom(abundance)
  ilr <- balance.fromSBP(abundance[c(samp_1, samp_2),], sbp)
  rownames(ilr) <- c(samp_1, samp_2)
  diff <- drop(ilr[samp_2,] - ilr[samp_1,])
  nb <- nb_shift_ilr(v = diff, sbp = sbp, type = match.arg(type),
                     bal_list = bal_list, plot_list = plot_list)
  return(nb)
}

# #
# abundance = cmultRepl(HIV[,1:30])
# samp_1 <- rownames(abundance)[1]
# samp_2 <- rownames(abundance)[2]
# nb_1 <- nb_shift(abundance, samp_1, samp_2)
# nb_2 <- nb_shift(abundance, samp_1, samp_2, type = "two_balances")
# nb_tree <- nb_shift(abundance, samp_1, samp_2, type = "tree")


