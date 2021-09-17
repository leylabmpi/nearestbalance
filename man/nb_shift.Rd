\name{nb_shift}
\alias{nb_shift}
\title{
  nearest balance for a compositional shift approximation
}
\description{
  Finds one, two or (number_of_taxa - 1) orthogonal balances to explain the difference between two compositional vectors.
}
\usage{
  nb_shift(abundance, samp_1, samp_2, type = c("one_balance", "two_balances", "tree"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{abundance}{table of taxa propotions without zeroes with samples as rows and taxa as colums}
  \item{samp_1}{name of the first sample}
  \item{samp_2}{name of the second sample}
  \item{type}{type of output: "one_balance", "two_balances", or "tree".}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
  \item{sbp}{binary partition table with found balances as columns and taxa as rows. Value "1" means that the taxon corresponds to the numerator of a balance, "-1" to the denuminator, and "0" - is not included in the balance. The table is compatible with \code{balance.fromSBP} function from the library \code{balance}}
  \item{impacts}{impacts of each balance. For tree the sum is 1.}
  \item{coord}{projection of the shift on the found balances.}
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
%  \code{\link{nb_shift_ilr}}}, \code{\link{find_nearest_balance}}}, %\code{\link{find_two_nearest_balances}}}, \code{\link{find_nearest_balance_tree}}
}
\examples{
abundance = cmultRepl(HIV[,1:30])
samp_1 <- rownames(abundance)[1]
samp_2 <- rownames(abundance)[2]

nb_1 <- nb_shift(abundance, samp_1, samp_2)
nb_2 <- nb_shift(abundance, samp_1, samp_2, type = "two_balances")
nb_tree <- nb_shift(abundance, samp_1, samp_2, type = "tree")
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
