source("R/nb_shift.R")
library(balance)
nb_mean_shift <- function(abundance,
                          samp_1,
                          samp_2,
                          type = c("one_balance", "two_balances", "tree"),
                          cov = NULL,
                          bal_list = F, plot_list = T){
  sbp = sbp.fromRandom(abundance)
  ilr <- balance.fromSBP(abundance[c(samp_1, samp_2),], sbp)
  rownames(ilr) <- c(samp_1, samp_2)
  diff <- ilr[samp_2,] - ilr[samp_1,]

  if (is.null(cov)){
    lm_res = lm(diff ~ 1)
  } else{
    lm_res = lm(diff ~ cov)
  }

  mean_diff <- coefficients(lm_res)[1,]
  nb <- nb_shift_ilr(v = mean_diff, sbp = sbp, type = match.arg(type),
                     bal_list = bal_list, plot_list = plot_list)

  summary = calculate_sblm_summary(nb_sbp = nb$sbp,
                                   lm_ilr = diff,
                                   lm_psi = make_psi_from_sbp(sbp),
                                   lm_res = lm_res,
                                   row_i = 1)
  summary$R2 <- NULL

  coord <- as.data.frame(balance.fromSBP(abundance, nb$sbp))
  rownames(coord) <- rownames(abundance)

  coef_var <- sum(sapply(summary(lm_res), function(x) x$coefficients[1,2]**2))
  noise = sqrt(coef_var/ drop(mean_diff %*% mean_diff))

  return(list(nb=nb,
              coord = data.frame(coord),
              noise = noise,
              lm_res = lm_res))
}
