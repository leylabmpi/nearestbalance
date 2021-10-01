\name{balance_to_clr}
\alias{balance_to_clr}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
calculate clr-coordinates of balancing element
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
balance_to_clr(balance,components_names)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{balance}{balance as b1 output of nb_shift() function}
  \item{components_names}{names of all parts of the composition}
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

library(selbal)
library(zCompositions)
abundance = cmultRepl(HIV[,1:30])
samp_1 <- rownames(abundance)[1]
samp_2 <- rownames(abundance)[2]

nb_1 <- nb_shift(abundance, samp_1, samp_2)
balance_to_clr(nb_1$b1, colnames(abundance))
}

\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
