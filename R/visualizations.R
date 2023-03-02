heatmap_with_split <- function(abundance, metadata, formula=NULL,
                               balance = NULL, type = c("perc", "clr"),
                               num_name = "num", den_name = "den",
                               others_name = "others",
                               abund_limits = range(abundance),
                               sample_col = NULL,
                               show_samp_names = T){

  pl_type <- match.arg(type)
  bal_list = list(" " = balance)
  if (pl_type == "clr"){
    clr <- t(apply(abundance, 1, function(x) log(x) - mean(log(x))))
    dat <- clr
  }  else {
    dat <- abundance*100
  }

  abund_melted <- reshape2::melt(as.matrix(dat))
  abund_melted$Var1 <- as.character(abund_melted$Var1)
  if (is.null(sample_col)) {
    sample_col = "SAMPLE_COL"
    metadata$SAMPLE_COL <- rownames(abundance)
  }
  abund_merged <- data.table(merge(abund_melted, metadata,
                                   by.x = "Var1", by.y = sample_col))

  if(!is.null(balance) > 0){
    taxa_descr <- rbindlist(lapply(bal_list, function(x){
      rbind(data.frame(Var2 = x$num, taxa_gr=num_name),
            data.frame(Var2 = x$den, taxa_gr=den_name))
    }), idcol = "bal")
    taxa_descr[, taxa_gr := paste(bal, taxa_gr)]
    abund_merged   <- merge(abund_merged, taxa_descr[,.(Var2, taxa_gr)],
                            all.x=T, by = "Var2")
    abund_merged[is.na(taxa_gr), taxa_gr := others_name]

    formula <- as.formula(paste(c("taxa_gr ", as.character(formula)),
                                 collapse = ""))
    abund_merged
  }
  abund_merged[ , max_abund := max(value), by = .(Var2)]
  abund_merged[, Var2 := fct_reorder(Var2, max_abund)]
  # abund_merged  %<>% mutate(Var2 = Var2  %>% fct_reorder(max_abund))
  yticks  <- unique(abund_merged$Var2)

  pl <- ggplot(abund_merged, aes(Var1, Var2, fill=value)) +
    geom_tile() +
    theme(axis.text.x = element_text(angle = 90)) +
    facet_nested(formula, drop = T, scales = "free", space = "free") +
    xlab("") + ylab("")

  # if (length(taxa_colors)>0){
  #   yticks <-
  #     ggplot_build(pl)$layout$panel_scales_y[[1]]$get_labels()
  #   colors <- taxa_colors[yticks]
  #   pl <- pl +
  #     theme(axis.text.y = element_text(colour = colors))
  # }

  if (pl_type == "perc"){
    pl <- pl +
      scale_fill_gradientn(colors = c("#0072B2", "#009E73", "#F0E442", "#D55E00"),
                           breaks=c(0.001, 1, 10, 50,100), trans="log",
                           limits=abund_limits*100) +
      labs(fill="abundance, %")
  } else if (pl_type == "clr"){
    pl <- pl +
      scale_fill_gradientn(colors = c("#0072B2", "#009E73", "#F0E442", "#D55E00"))+
      labs(fill="CLR-components")
  }
  if (!show_samp_names){
    pl <- pl + theme(axis.text.x = element_blank())
  }
  pl
}
