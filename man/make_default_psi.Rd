\name{make_default_psi}
\alias{make_default_psi}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
default contrast matrix
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Constracts a contrast matrix  for an isometric log-ratio transformation according to Gram-Shmidt procedure as described in Egozcue, J. J., V. Pawlowsky-Glahn, G. Mateu-Figueras, and C. Barcelo-Vidal. 2003. “Isometric Logratio Transformations for Compositional Data Analysis1.” Mathematical Geology 35 (3).
}
\usage{
make_default_psi(components)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{component}{
%%     ~~Describe \code{x} here~~
vector with names of the composition components
}
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
contrast matrix
}
\references{
Egozcue, J. J., V. Pawlowsky-Glahn, G. Mateu-Figueras, and C. Barcelo-Vidal. 2003. “Isometric Logratio Transformations for Compositional Data Analysis1.” Mathematical Geology 35 (3).
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
make_default_psi(c("a", "b","c"))

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
