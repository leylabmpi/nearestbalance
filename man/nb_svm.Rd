\name{nb_svm}
\alias{nb_svm}
\title{
Application of nearest balance to supprort vector machine (SVM)
}
\description{
The function peformes SVM, and applies nearest balance to the discriminative direction.
}
\usage{
nb_svm(abundance, f, type = c("one_balance", "two_balances", "tree"), sbp = sbp.fromRandom(abundance))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{abundance}{table of taxa propotions without zeroes with samples as rows and taxa as colums}
  \item{f}{vector of sample classes}
  \item{type}{type of output}
  \item{sbp}{a sequential binary partition to construct ILR-coordinates where the SVM will be peformed}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
  \item{nb }{the nearest balance (for \code{type == "one balance"}), two nearest balances (for \code{type == "two_balances"})  or nearest balance tree  (for \code{type == "tree"}) constructed for the discriminative direction obtained by LDA}
  \item{lda }{result of the linear discriminant analysis}
  \item{coord}{ilr coordinates of all samples and sequntial binary partition used to fit SVM}
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
  library(selbal)
  abundance <- cmultRepl(selbal::HIV[1:60])
  nb <- nb_svm(abundance,
              f = HIV$HIV_Status,
              cov = NULL,
              type = "two_balances")
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
