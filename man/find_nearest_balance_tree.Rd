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
  \item{sbp}{sequential binary partition describing the tree structure}
  \item{impacts}{impacts of each balance in the tree. It is calculated as squared ratio between lenght of the \code{ilr_vect} projection on the balancing element and length of \code{ilr_vect} itself. }
  \item{coord}{coordinates of \code{ilr_vect} in ILR coordinates associated
  with the found sequential binary partition}
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
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (ilr_vect, psi)
{
    clr_vect <- drop(ilr_vect \%*\% psi)
    nb_tree <- get_nb_tree(clr_vect)
    nb_sbp <- nb_tree_to_sbp(tree = nb_tree, components = colnames(psi))
    nb_psi <- make_psi_from_sbp(nb_sbp)
    coord <- drop(t(nb_psi \%*\% clr_vect))
    impacts <- sort(coord^2/drop(clr_vect \%*\% clr_vect), decreasing = T)
    return(list(nb_tree = nb_tree, sbp = nb_sbp[, names(impacts)],
        impacts = impacts, coord = coord[names(impacts)]))
  }
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
