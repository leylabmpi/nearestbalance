make_default_psi <- function(components) {
  D <- length(components)
  psi <- matrix(0, ncol = D, nrow = D - 1)
  for (i in 1:(D - 1)) {
    psi[i, i] <- -sqrt((D - i) / (D - i + 1))
    for (j in (i + 1):D) {
      psi[i, j] <- 1 / (sqrt((D - i) * (D - i + 1)))
    }
  }
  colnames(psi) <- components
  rownames(psi) <- paste0("z", 1:nrow(psi))
  return(psi)
}

balance_to_clr <- function(balance, components_names = names(balance)) {
  clr_vect <- rep(0, length(components_names))
  names(clr_vect) <- components_names
  r <- length(balance$num)
  s <- length(balance$den)
  clr_vect[balance$num] <- sqrt(r * s / (r + s)) / r
  clr_vect[balance$den] <- -sqrt(r * s / (r + s)) / s
  return(clr_vect)
}

make_psi_from_sbp <- function(sbp) {
  res <- t(apply(sbp, 2, function(col) {
    r <- sum(col > 0)
    s <- sum(col < 0)
    col[col > 0] <- sqrt(r * s / (r + s)) / r
    col[col < 0] <- -sqrt(r * s / (r + s)) / s
    col
  }))
  if (ncol(sbp) == 1) {
    res <- res
  }
  return(res)
}
