\name{find_nearest_balance}
\alias{find_nearest_balance}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Find nearest balance
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Finds balancing element which is the most close to the vector
}
\usage{
find_nearest_balance(ilr_vector, psi)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ilr_vector}{
  coordinates of a vector in an ILR space
%%     ~~Describe \code{ilr_vector} here~~
}
  \item{psi}{
  contrast matrix of the ILR space
%%     ~~Describe \code{psi} here~~
}
\item{balance_name}{
  name of the found balance in sbp
%%     ~~Describe \code{psi} here~~
}
}

\value{
  \item{num}{components in the numerator of the balance}
  \item{den}{components in the  denominator of the balance}
  \item{impact}{the impact of the nearest balance. It is calculated as squared ratio between lenght of the \code{ilr_vect} projection on the balancing element and length of \code{ilr_vect} itself.}
  \item{sbp}{partition of components as input to \code{balance::balance.fromSBP()}}
}
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
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
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
