\name{nb_lda}
\alias{nb_lda}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Application of nearest balance to linear discriminative analysis (LDA)
}
\description{
The function peformes LDA, and applies nearest balance to the discriminative direction.
}
\usage{
nb_lda(abundance, f, type = c("one_balance", "two_balances", "tree"), sbp = sbp.fromRandom(abundance))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{abundance}{table of taxa propotions without zeroes with samples as rows and taxa as colums}
  \item{f}{vector of sample classes}
  \item{type}{type of output}
  \item{sbp}{a sequential binary partition to construct ILR-coordinates where the LDA will be peformed}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
  \item{nb }{the nearest balance (for \code{type == "one balance"}), two nearest balances (for \code{type == "two_balances"})  or nearest balance tree  (for \code{type == "tree"}) constructed for the discriminative direction obtained by LDA}
  \item{lda }{result of the linear discriminant analysis}
  \item{coord}{ilr coordinates of all samples and sequntial binary partition used to fit LDA}
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
  require(balance)
  abundance <- cmultRepl(HIV[1:60])
  nb <- nb_lda(abundance,
              f = HIV$HIV_Status,
              type = "two_balances")
  ilr <- balance.fromSBP(abundance, nb$nb$sbp)
  plot(b2~b1, data = ilr, col = HIV$HIV_Status, asp=1)
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
