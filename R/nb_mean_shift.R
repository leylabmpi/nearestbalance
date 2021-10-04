source("R/nb_shift.R")
library(balance)
nb_mean_shift <- function(abundance,
                          samp_1,
                          samp_2,
                          type = c("one_balance", "two_balances", "tree"),
                          bal_list = F, plot_list = T){
  sbp = sbp.fromRandom(abundance)
  ilr <- balance.fromSBP(abundance[c(samp_1, samp_2),], sbp)
  rownames(ilr) <- c(samp_1, samp_2)
  diff <- ilr[samp_2,] - ilr[samp_1,]
  mean_diff <- colMeans(diff)
  nb <- nb_shift_ilr(v = mean_diff, sbp = sbp, type = match.arg(type),
                     bal_list = bal_list, plot_list = plot_list)
  coord <- balance.fromSBP(abundance, nb$sbp)
  rownames(coord) <- rownames(abundance)
  return(list(nb=nb,
              coord = data.frame(coord)))
}
