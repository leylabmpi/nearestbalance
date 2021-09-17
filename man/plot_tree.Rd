\name{plot_tree}
\alias{plot_tree}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Plot nearest balance tree
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Plot result of get_tree_structure() function
}
\usage{
plot_tree(ilr_tree)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ilr_tree}{
  a data.tree object, get_tree_structure() output
%%     ~~Describe \code{x} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
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
res_tree <- get_tree_structure(nb_all$nb_tree, do.nice.names = F)
plot_tree(res_tree)
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
