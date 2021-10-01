\name{find_nearest_balance_tree}
\alias{find_nearest_balance_tree}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
find nearest balance tree
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Find sequncial binary partition based on nearest balance principal
}
\usage{
find_nearest_balance_tree(ilr_vect, psi)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ilr_vect}{
  coordinates of a vector in an ILR space
}
  \item{psi}{
    contrast matrix of the ILR space
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
  \item{nb_tree}{data.table with components of each balance}
  \item{balances}{list with numerator and denumenator for each balance in the tree. }
  \item{sbp}{sequential binary partition describing the tree structure}
  \item{impacts}{impacts of each balance in the tree. It is calculated as squared ratio between lenght of the \code{ilr_vect} projection on the balancing element and length of \code{ilr_vect} itself.  The nearest balance is the one with the highest impact}
  \item{coord}{coordinates of \code{ilr_vect} in ILR coordinates associated
  with the found sequential binary partition}
  \item{nb_name}{the nearest balance name}
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
vect_clr <-c(v1=-0.1, v2=-0.8, v3=-0.1, v4=0.6, v5=0.1, v6=0.9, v7=-0.6, v8=0.9)
psi <- make_default_psi(names(vect_clr))
vect_ilr <- drop(vect_clr %*% t(psi))
nb_all <- find_nearest_balance_tree(vect_ilr, psi)
res_tree <- get_tree_structure(nb_all$nb_tree, do_nice_names = F)
plot_tree(res_tree)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
