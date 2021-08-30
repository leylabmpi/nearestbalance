nb_svm <- function(abundance, f,
                   type = c("one_balance",
                            "two_balances",
                            "tree"),
                   sbp = sbp.fromRandom(abundance)){
  ilr <- balance.fromSBP(abundance, sbp)
  svm_res <- svm(as.factor(f) ~ ., ilr_table, kernel = "linear")
  ilr_vect <- drop(t(svm_res$coefs) %*% svm_res$SV)

  if (type != "one_balance"){
    nb <- find_nearest_balance(ilr_vect, psi)
  } else if (type == "two_balances"){
    nb = find_two_nearest_balances(ilr_vect, psi)
  } else if (type == "tree"){
    nb = find_nearest_balance_tree(ilr_vect, psi)
  } else {
    stop("incorrect type of analysis")
  }

  return(list(nb = nb,
              svm_res = svm_res,
              coordinates_for_svm = list(ilr=ilr, sbp=sbp))
}

nb_lda <- function(abundance, f,
                   type = c("one_balance",
                            "two_balances",
                            "tree"),
                   sbp = sbp.fromRandom(abundance)){
  ilr <- balance.fromSBP(abundance, sbp)
  lda_res <- lda(f~., ilr_table)
  ilr_vect <- drop(t(lda_res$scaling))

  if (type != "one_balance"){
    nb <- find_nearest_balance(ilr_vect, psi)
  } else if (type == "two_balances"){
    nb <- find_two_nearest_balances(ilr_vect, psi)
  } else if (type == "tree"){
    nb <- find_nearest_balance_tree(ilr_vect, psi)
  } else {
    stop("incorrect type of analysis")
  }

  return(list(nb = nb,
              lda_res = lda_res,
              coordinates_for_lda = list(ilr=ilr, sbp=sbp))
}
