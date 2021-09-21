\name{nb_lm}
\alias{nb_lm}
\title{
Nearest balance method for linear regression problem
}
\description{
Fits single-balance regression model
}
\usage{
nb_lm(abundance, metadata, f, cov, sbp = sbp.fromRandom(abundance), type = c("one_balance", "two_balances", "tree"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{abundance}{table of taxa propotions without zeroes with samples as rows and taxa as colums}
  \item{metadata}{metadata table with predictor and covariates values as columns}
  \item{pred}{name of the predictor in metadata, either continious or categorical with two levels}
  \item{cov}{names of covariates}
  \item{type}{type of output: "one_balance", "two_balances", or "tree".}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
  \item{nb}{The nearest balance (for \code{type == "one balance"}), two nearest balances (for \code{type == "two_balances"})  or nearest balance tree  (for \code{type == "tree"}) constructed for the predictor's coefficient in the regression}
  \item{lm_res}{output of a multivariate linear regression}
  \item{coord}{ILR coordinates used to fit the linear regression}
  \item{sblm_summary}{single-balance linear regression model summary}
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
nb <- nb_lm(abundance = abundance,
            metadata = HIV,
            pred = "HIV_Status",
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
