# library(matlib)

cos_xy   <- function(x,y){
  drop(x %*% y)/(drop(sqrt(x %*% x)) * drop(sqrt(y %*% y)))
}

calculate_sblm_summary <- function(nb_sbp,
                                   lm_ilr,
                                   lm_psi,
                                   lm_res){
  lm_coef <- coefficients(lm_res)[2,]
  lm_coef_clr <- drop(lm_coef %*% lm_psi)
  lm_coef_norm <- drop(sqrt(lm_coef %*% lm_coef))

  balancing_elements_clr <- apply(nb_sbp, 2, function(x){
    r <- sum(x>0)
    s <- sum(x<0)
    res <- rep(0, length(x))
    res[x>0] <- sqrt(r*s/(r+s))/r
    res[x<0] <- -sqrt(r*s/(r+s))/s
    res
  })
  cos_for_elem <- apply(balancing_elements_clr, 2, cos_xy, lm_coef_clr)
  sb_coefficient <- lm_coef_norm * cos_for_elem %*%
    t( balancing_elements_clr)  %*% t(lm_psi)

  mm = model.matrix(lm_res)
  y <- lm_ilr- matrix(mm[,2]) %*% sb_coefficient
  if(ncol(mm) > 2){
    other_coefficients <- coefficients(lm(y ~ ., data.table(mm)[,-c(1,2)]))
  } else {
    other_coefficients <- coefficients(lm(y ~ 1))
  }
  sblm_coefficients <- rbind(sb_coefficient, other_coefficients)
  rownames(sblm_coefficients)[1] <- colnames(mm)[2]
  sblm_coefficients <- sblm_coefficients[colnames(mm),]

  prediction <- as.matrix(mm) %*% sblm_coefficients
  residuals <- lm_ilr - prediction

  R2 <- 1 - sum(apply(residuals, 2, var))/sum(apply(lm_ilr, 2, var))

  summary = list(coefficients = sblm_coefficients,
                 residuals = residuals,
                 R2=R2,
                 prediction = prediction)
}


nb_lm <- function(abundance, metadata, pred,
                  cov = NULL,
                  sbp = sbp.fromRandom(abundance),
                  type = c("one_balance", "two_balances", "tree")){

  if(class(metadata[[pred]]) %in% c("caracter", "factor") &
     length(unique(metadata[[pred]])) != 2){
    stop("the factor of interest should be countinious or factor with two levels")
  }
  type <- match.arg(type)

  ilr <- balance.fromSBP(abundance, sbp)
  if(!is.null(cov)){
    lm_res = lm(ilr ~ ., as.data.frame(metadata)[, c(pred, cov)])
  } else{
    lm_res = lm(ilr ~ metadata[[pred]])
  }

  lm_coef <- drop(coefficients(lm_res)[2,])

  psi <- make_psi_from_sbp(sbp)
  nb <- find_nearest_balance(lm_coef, psi)

  summary = calculate_sblm_summary(nb_sbp = nb$sbp,
                                   lm_ilr = ilr,
                                   lm_psi = psi,
                                   lm_res = lm_res)
  if (type == "two_balances"){
    nb = find_two_nearest_balances(lm_coef, psi)
  } else if (type == "tree"){
    nb = find_nearest_balance_tree(lm_coef, psi)
  } else if (type != "one_balance"){
    stop("incorrect type of analysis")
  }

  # sigma_sq <- sum(diag(cov(lm_res$residuals)))
  # X <- model.matrix(lm_res)
  # coef_var <- sigma_sq * inv(t(X) %*% X)[2,2]
  coef_var <- sum(sapply(summary(lm_res), function(x) x$coefficients[2,2]**2))
  noise = sqrt(coef_var/ drop(lm_coef %*% lm_coef))

  return(list(nb = nb,
              lm_res = lm_res,
              coord = list(ilr=ilr, sbp=sbp),
              sblm_summary = summary,
              noise = noise))
}


