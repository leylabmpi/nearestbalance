\name{nb_pca}
\alias{nb_pca}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Approximation two first PCA coordinates with two orthogonal balances
}
\description{
The fist balance is the nearest one to PC1 direction, the second balance is the nearest one to PC2 direction among all balances orthogona to the first balance
}
\usage{
nb_pca(abundance)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
   \item{abundance}{table of taxa propotions without zeroes with samples as rows and taxa as colums}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
\item{nb}{output of \code{find_two_nearest_balances()} for type = "two_balances"}
\item{coord}{values of balances for all samples}
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
require(selbal)

abundance <- cmultRepl(selbal::HIV[1:60])
nb <- nb_pca(abundance)
plot_nb_pca(nb, colour = HIV$HIV_Status, pch = HIV$MSM)
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
