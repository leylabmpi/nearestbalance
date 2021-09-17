\name{get_tree_structure}
\alias{get_tree_structure}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Get tree structure
%%  ~~function to do ... ~~
}
\description{
Make a data.tree object from balance table
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
get_tree_structure(dt_tree, do_nice_names = F, nice_function=make_nice_names)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dt_tree}{a data.table object - balance table obtained from find_nearest_balance_tree() nb_tree output}
  \item{do_nice_names}{a logical indicating whether taxa names (t1, t2 columns) should be changed by user defined function nice.function}
  \item{nice_function}{a function to change taxa names in the tree. Default - make_nice_names function.
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
