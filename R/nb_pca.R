nb_pca <- function(abundance){
  sbp <- sbp.fromRandom(abundance)
  ilr <- balance.fromSBP(abundance, sbp)
  psi <- make_psi_from_sbp(sbp)

  pca <- prcomp(ilr)
  nb_pca <- find_two_nearest_balances(
    vect_ilr = pca$rotation[,1],
    psi = psi,
    vect_ilr_2 = pca$rotation[,1]
  )
  return(list(nb = nb_pca,
              coord = balance.fromSBP(abundance, nb_pca$sbp)))
}
