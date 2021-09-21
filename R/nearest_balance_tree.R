library(partitions)
library(data.table)
library(stringr)
library(data.tree)

get_blocks <- function(rs.i, sorted.taxa.i, blocks, k, k.vars.nams.num, type) {
  parts.s <- as.matrix(blockparts(blocks, rs.i), rownames=names(blocks))
  ind.1 <- sapply(rownames(parts.s), function(row.i) parts.s[row.i, ]%%k.vars.nams.num[row.i]==0)
  ind.1 <- as.matrix(ind.1)
  parts.s <- parts.s[, apply(ind.1, 1, all), drop=F]
  if (dim(parts.s)[2] !=0 ) {
    parts.ss <- sapply(1:ncol(parts.s), function(col.i) {
      lal <- unlist(lapply(rownames(parts.s), function(nam.i) {
        n <-  parts.s[nam.i, col.i]%/%k.vars.nams.num[nam.i]
        rep(nam.i, n)
      }))
      c(lal, rep('num0', length(k)-length(lal)))
    })
    i <- 0
    s.bal.vars <- rbindlist(apply(parts.ss, 2, function(var.i) {
      i <<- i+1
      var.i <- var.i[var.i!='num0']
      var.i.num <- table(var.i)
      res <- unlist(lapply(unique(var.i), function(i) sorted.taxa.i[[i]][1:var.i.num[i]]))
      data.table(na=names(res), val=res, i=i, type = type, k.num = k[names(res)])
    }))
  } else {
    s.bal.vars <- data.table()
  }
  s.bal.vars
}

find_nearest_balance_clr_k <- function(clr_vect, k){
  D <- sum(k)
  names(k) <- names(clr_vect)
  if (length(k) < 2) return(NA)
  k.str <- paste0('num', k)
  k.vars <- table(k.str)
  k.vars.nams.num <- as.numeric(str_remove(names(k.vars), 'num'))
  names(k.vars.nams.num) <- names(k.vars)
  blocks <- k.vars*k.vars.nams.num
  sorted.taxa <- sapply(names(k.vars), function(k.i) sort(clr_vect[k.str==k.i]), simplify = F)
  sorted.taxa.dec <- sapply(names(k.vars), function(k.i) sort(clr_vect[k.str==k.i], decreasing = T), simplify = F)
  proj_vals <- matrix(NA, nrow = D-1, ncol = D-1)
  dt.res <- rbindlist(lapply(1:(D-1), function(r) {
    sorted.vars.r.s.1 <- get_blocks(r, sorted.taxa.i = sorted.taxa.dec, blocks, k.vars.nams.num = k.vars.nams.num, k=k, type = 'high')
    rbindlist(lapply(1:(D-r), function(s) {
      # message(r)
      #  message(s)
      # get table of all possible num and den compositions
      sorted.vars.r.s.2 <- get_blocks(s, sorted.taxa.i = sorted.taxa, blocks, k.vars.nams.num = k.vars.nams.num, k=k, type = 'low')
      sorted.vars.r.s <- rbind(sorted.vars.r.s.1, sorted.vars.r.s.2)
      sorted.vars.r.s$r <- r
      sorted.vars.r.s$s <- s
      # parts.ss <- parts.ss[, apply(parts.ss, 2, function(x) all(x %in% c(names(k.vars), 'num0'))), drop = F]
      # parts.ss <- parts.ss[, apply(parts.ss, 2, function(x) all(table(x[x!='num0']) <= k.vars[names(table(x[x!='num0']))])), drop = F]

      # for each composition calculate mean
      if (nrow(sorted.vars.r.s.1)>0 | nrow(sorted.vars.r.s.2)>0) {
        vars.high.mean <- sorted.vars.r.s[type =='high', sum(.SD$val*.SD$k.num)/(sum(.SD$k.num)), by = i]
        vars.low.mean <- sorted.vars.r.s[type =='low', sum(.SD$val*.SD$k.num)/(sum(.SD$k.num)), by = i]
        # compare only those means for num and den that do not intersect
        best.diff <- rbindlist(lapply(vars.high.mean$i, function(x) {
          taxa <- sorted.vars.r.s[type=='high' & i==x]$na
          i.low.for.comp <- sorted.vars.r.s[type=='low', any(na %in% taxa), by = i][V1==F]$i
          if (length(i.low.for.comp) >0 ){
            res <- sapply(i.low.for.comp, function(y) {
              vars.high.mean[i==x]$V1 - vars.low.mean[i==y]$V1 })
            data.table(i.low=i.low.for.comp[which.max(res)], i.high = x, maxa = max(res))
          } else {
            data.table()
          }}))
      } else {
        best.diff <- data.table()
      }

      # select the best combination
      if (nrow(best.diff) >0) {
        sel.i <- best.diff[which.max(maxa)[1]]
        selected.low <- sorted.vars.r.s[type =='low' & i==sel.i$i.low]
        selected.high <- sorted.vars.r.s[type =='high'& i==sel.i$i.high]
        proj_vals[r,s] <<- sqrt(r*s/(r+s)) * sel.i$maxa
        rbind(selected.low, selected.high)
      } else {
        data.table()
      }
    }))
  }))
  impacts = proj_vals**2/drop(clr_vect %*% clr_vect)
  best_impact = max(impacts, na.rm = T)
  dt.res.best <- dt.res[r==which(impacts==best_impact, arr.ind = T)[1, 'row'] &
                          s==which(impacts==best_impact, arr.ind = T)[1, 'col']]
  return(list(
    num = dt.res.best[type=='high']$na,
    den = dt.res.best[type=='low']$na,
    impact = best_impact
  ))
}

get_nb_tree <- function(clr_vect, i=1, do.log =T,  k = rep(1, length(clr_vect))){
  vect.i <- copy(clr_vect)
  dt.tree <- data.table()

  while (length(vect.i)>2) {
    message(i)
    taxa <- find_nearest_balance_clr_k(clr_vect = vect.i, k = k)
    taxa.1 <- taxa$num
    taxa.2 <- taxa$den
    k1.vec <- sapply(taxa.1, function(x) ifelse(x %in% dt.tree$bal,
                                                dt.tree[bal==x]$taxa.in.bal,
                                                k[names(vect.i)==x]))
    k2.vec <- sapply(taxa.2, function(x) ifelse(x %in% dt.tree$bal,
                                                dt.tree[bal==x]$taxa.in.bal,
                                                k[names(vect.i)==x]))
    k1 <- sum(k1.vec)
    k2 <- sum(k2.vec)
    cur.clr.1 <- sum(vect.i[taxa.1]*k1.vec/k1)
    cur.clr.2 <- sum(vect.i[taxa.2]*k2.vec/k2)

    final.bal <- (1/(k1+k2)) * (k1*cur.clr.1 + k2*cur.clr.2)
    bal.1.name <- paste0('bal', length(taxa.1)+i-2)
    bal.2.name <- paste0('bal', length(taxa.1)+length(taxa.2)+i-3)
    dt.tree <- rbind(dt.tree, data.table(
      t1=ifelse(length(taxa.1)>1, bal.1.name, taxa.1),
      t2=ifelse(length(taxa.2)>1, bal.2.name, taxa.2),
      bal = paste0('bal', i+length(taxa.1)+length(taxa.2)-2),
      taxa.in.bal = k1+k2))
    if (length(taxa.1)==2) {
      dt.tree <- rbind(dt.tree, data.table(
        t1=taxa.1[1],
        t2=taxa.1[2],
        bal = bal.1.name,
        taxa.in.bal = k1))
    } else if (length(taxa.1)>2) {
      k.sub = sapply(taxa.1, function(t.ii) ifelse(t.ii %in% dt.tree$bal,
                                                   dt.tree[bal==t.ii]$taxa.in.bal,
                                                   k[names(vect.i)==t.ii]))
      dt.tree.sub <- get_nb_tree(clr_vect = vect.i[taxa.1],
                                 i=i, do.log =F, k = k.sub)
      dt.tree <- rbind(dt.tree, dt.tree.sub[, !'iter', with=F])
    }
    if (length(taxa.2)==2) {
      dt.tree <- rbind(dt.tree, data.table(
        t1=taxa.2[1],
        t2=taxa.2[2],
        bal = bal.2.name,
        taxa.in.bal = k2))
    } else if (length(taxa.2)>2)  {
      k.sub <- sapply(taxa.2, function(t.ii) {
        ifelse(t.ii %in% dt.tree$bal,
               dt.tree[bal==t.ii]$taxa.in.bal,
               k[names(vect.i)==t.ii])
      })
      dt.tree.sub <- get_nb_tree(clr_vect = vect.i[taxa.2],
                                 i=i+length(taxa.1)-1, do.log =F, k = k.sub)

      dt.tree <- rbind(dt.tree, dt.tree.sub[, !'iter', with=F])
    }
    vect.i[paste0('bal', i+length(taxa.1)+length(taxa.2)-2)] <- final.bal
    vect.i <- vect.i[!names(vect.i) %in% c(taxa.1,taxa.2)]
    i <- i + length(taxa.1)+length(taxa.2) -1
    k <- sapply(names(vect.i), function(t.ii) {
      ifelse(t.ii %in% dt.tree$bal,
             dt.tree[bal==t.ii]$taxa.in.bal,
             k[names(vect.i)==t.ii])
    })
    dt.tree
  }
  if (length(vect.i)==2) {
    taxa.in.bal.last = sum(sapply(names(vect.i), function(t.ii){
      ifelse(t.ii %in% dt.tree$bal,
             dt.tree[bal==t.ii]$taxa.in.bal,
             k[names(vect.i)==t.ii])
    }))
    dt.tree = rbind(dt.tree, data.table(t1 = names(vect.i)[1],
                                        t2 = names(vect.i)[2],
                                        bal =  paste0('bal', i),
                                        taxa.in.bal = taxa.in.bal.last))
  }
  dt.tree[, iter := as.numeric(str_remove(bal, 'bal'))]
  dt.tree
}

nb_tree_to_sbp <- function(tree, components){
  conv.metr <- matrix(0, nrow = length(components), ncol = nrow(tree))
  dim(conv.metr)
  rownames(conv.metr) <- components
  colnames(conv.metr) <- tree$bal
  tmp <- lapply(colnames(conv.metr), function(i) {
    message(i)
    bact <- tree[bal==i]$t1
    while(any(bact %in% tree$bal)) {
      bact <- c(bact[!(bact %in% tree$bal)],
                tree[bal %in% bact]$t1,
                tree[bal %in% bact]$t2)
    }
    bact2 <- tree[bal==i]$t2
    while(any(bact2 %in% tree$bal)) {
      bact2 <- c(bact2[!(bact2 %in% tree$bal)],
                 tree[bal %in% bact2]$t1,
                 tree[bal %in% bact2]$t2)
    }
    conv.metr[rownames(conv.metr) %in% bact, i] <<- 1
    conv.metr[rownames(conv.metr) %in% bact2, i] <<- -1
    message('end')
  })
  conv.metr
}

find_nearest_balance_tree <- function(ilr_vect, psi){
  clr_vect <- drop(ilr_vect %*% psi)
  nb_tree <- get_nb_tree(clr_vect)
  nb_sbp <- nb_tree_to_sbp(tree=nb_tree, components = colnames(psi))
  nb_psi <- make_psi_from_sbp(nb_sbp)
  coord <- drop(t(nb_psi %*% clr_vect))
  impacts <- sort(coord**2 / drop(clr_vect %*% clr_vect), decreasing = T)
  sbp = nb_sbp[, names(impacts)]
  balances_list <- apply(sbp, 2, function(x) {
    list(num = names(x==1), den = names(x==-1))
  })
  return(list(nb_tree = get_tree_structure(nb_tree),
              balances = balances_list,
              sbp = sbp,
              impacts = impacts,
              coord = coord[names(impacts)],
              nb_name = names(which.max(impacts))))
}

make_nice_names <- function(x) {
  str_remove(str_replace(str_replace_all(str_replace_all(x, '[gsfoc]__;', '-u;'), ';[gsfoc]__$', ';-u'), ';s__', '-'), '.*_')
}

get_tree_structure <- function(dt_tree, do_nice_names = F, nice_function=make_nice_names) {
  if (do_nice_names) {
    dt_tree[, t1.nice.names := nice_function(t1)]
    dt_tree[, t2.nice.names := nice_function(t2)]
  } else {
    dt_tree[, t1.nice.names := t1]
    dt_tree[, t2.nice.names := t2]
  }
  root <- Node$new(dt_tree[iter==max(iter)]$bal)
  ch1 <- root$AddChild(dt_tree[bal == root$name]$t1.nice.names)
  ch2 <- root$AddChild(dt_tree[bal == root$name]$t2.nice.names)
  iter.tree <- function(i, dt_tree) {
    message(i$name)
    message(((nrow(dt_tree[bal == i$name])>0)))
    if ((nrow(dt_tree[bal == i$name])>0)) {
      k <- i$AddChild(dt_tree[bal == i$name]$t1.nice.names)
      n <- i$AddChild(dt_tree[bal == i$name]$t2.nice.names)
      iter.tree(k, dt_tree)
      iter.tree(n, dt_tree)
    }
  }
  iter.tree(ch1, dt_tree)
  iter.tree(ch2, dt_tree)
  root
}

plot_tree <- function(ilr_tree) {
  SetGraphStyle(ilr_tree)
  SetEdgeStyle(ilr_tree, arrowhead = "vee", color = "grey35", penwidth = 2)
  SetNodeStyle(ilr_tree, style = "filled,rounded", shape = "egg",
               fillcolor = 'white', fontcolor = 'grey33',
               fontname = "helvetica")
  Do(ilr_tree$leaves, function(node) SetNodeStyle(node, fontcolor = 'black', shape = "box"))
  plot(ilr_tree)
}

