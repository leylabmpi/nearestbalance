nb_pca <- function(abundance){
  sbp <- sbp.fromRandom(abundance)
  ilr <- balance.fromSBP(abundance, sbp)
  psi <- make_psi_from_sbp(sbp)

  pca <- prcomp(ilr)
  nb_pca <- find_two_nearest_balances(
    vect_ilr = pca$rotation[,1],
    psi = psi,
    vect_ilr_2 = pca$rotation[,2]
  )
  coord = as.data.frame(balance.fromSBP(abundance, nb_pca$sbp))
  rownames(coord) <- rownames(abundance)

  totVar <- sum((apply(ilr,2,var)))
  var_prop <- 100*apply(coord,2, var)/totVar
  return(list(nb = nb_pca,
              coord = coord,
              var_prop = var_prop))
}

plot_nb_pca <- function(nb_pca_obj, ...){
  ggplot(nb_pca_obj$coord, aes(b1, b2, ...)) +
    geom_point() + coord_fixed() + theme_minimal() +
    xlab(paste("b1 (", round(nb_pca_obj$var_prop["b1"], 1), "%)")) +
    ylab(paste("b2 (", round(nb_pca_obj$var_prop["b2"], 1), "%)"))
}
