calc_bal <- function(data, balance){
  S1 <- log(data[, balance$num])
  S2 <- log(data[, balance$den])
  if (!is.vector(S1)){
    S1 = rowMeans(S1)
  } else{
    names(S1) = rownames(data)
  }
  if(!is.vector(S2)){
    S2 = rowMeans(S2)
  }else{
    names(S2) = rownames(data)
  }
  s1 <- length(balance$num)
  s2 <- length(balance$den)
  bal <- sqrt((s1 * s2)/(s1 + s2)) * (S1 - S2)
  return(bal)
}

make_default_psi <- function(components){
  D <- length(components)
  psi <- matrix(0, ncol = D, nrow = D-1)
  for (i in 1:(D-1)){
    psi[i, i] <- -sqrt((D-i)/(D-i +1))
    for (j in (i+1):D){
      psi[i, j] <- 1/(sqrt((D-i)*(D-i+1)))
    }
  }
  colnames(psi) <- components
  return(psi)
}

balance_to_clr<-function(balance, components_names){
  clr_vect <- rep(0,length(components_names))
  names(clr_vect) <- components_names
  r<-length(balance$num)
  s<-length(balance$den)
  clr_vect[balance$num] <- sqrt(r*s/(r+s))/r
  clr_vect[balance$den] <- -sqrt(r*s/(r+s))/s
  return(clr_vect)
}
