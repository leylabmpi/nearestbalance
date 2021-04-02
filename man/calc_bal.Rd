\name{calc_bal.Rd}
\alias{calc_bal.Rd}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
calculate balance for compositional data
%%  ~~function to do ... ~~
}
\description{
Calculates balance of two groups of components for all samples in the dataset.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
calc_bal.Rd(data, balance)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{ \code{data.frame} with compositional data, with samples as rows and components as columns}
  \item{balance}{\code{list} with two components ("pos" and "neg") containing \code{vectors} of balance groups' components. For example, result of function find_nearest_balance()}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
\code{vector} with balances for each sample
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
\code{\link{find_nearest_balance}}
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
