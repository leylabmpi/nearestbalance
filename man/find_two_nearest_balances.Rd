\name{find_two_nearest_balances}
\alias{find_two_nearest_balances}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Find two orthogonal nearest balances
%%  ~~function to do ... ~~
}
\description{
Finds two balancing elements. The first one is the most close to vect_ilr (the same as found by function find_nearest_balance). The second one is the most close to vect_ilr_2 among all balancing elements orthogonal to the first balancing element.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
find_two_nearest_balances(vect_ilr, psi,  vect_ilr_2 = vect_ilr)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ilr_vector}{
 a vector in ilr coordinates
%%     ~~Describe \code{ilr_vector} here~~
}
  \item{psi}{
  contrast matrix of the ilr system
%%     ~~Describe \code{psi} here~~
}
  \item{vect_ilr_2}{
  a vector in ilr coordinates. By default it is equal to ilr_vector. The second balancing element will the most close to vect_ilr_2 among all balancing elements orthogonal to the first balancing element
%%     ~~Describe \code{psi} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
\item{b1}{first balance}
\item{b2}{second balance}
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

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
