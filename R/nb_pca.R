library(zCompositions)
library(balance)

nb_pca <- function(abundance){
  sbp <- sbp.fromRandom(abund)
  ilr <- balance.fromSBP(abund, sbp)
  psi <- make_psi_from_sbp(sbp)

  pca <- prcomp(ilr)
  nb_pca <- find_two_nearest_balances(
    vect_ilr = pca$rotation[,1],
    psi = psi,
    vect_ilr_2 = pca$rotation[,1]
  )
  return(nb = nb_pca,
         coordinates = balance.fromSBP(abund, nb_pca$sbp))
}
