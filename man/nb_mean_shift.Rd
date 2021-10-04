\name{nb_mean_shift}
\alias{nb_mean_shift}
\title{
Nearest balance to the mean shift in a sample.
}
\description{
This function applies \code{nb_shift} to the mean shift in a sample
}
\usage{
nb_mean_shift(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{abundance}{table of taxa relative abundances with samples as rows and taxa as columns}
  \item{samp_1, sampl_2}{ names of "start" and "end" samples for the shifts in the sampe order}
  \item{type}{type of output: "one_balance", "two_balances", or "tree".}
  \item{bal_list}{only if \code{type == "one_balance"}. If \code{True} the best balance for each total number of taxa in it (from 2 to all) will be returned}
  \item{plot_list}{only if \code{bal_list == T}. If \code{True} the impacts for the balances list will be plotted}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
  \item{nb}{result of \code{nb_shift} for the mean shift}
  \item{coord}{ILR coordinates and sequential binary partition used to calculate the mean shift}
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
library(zCompositions)
library(reshape2)

counts <- HFD[1:193]
counts_filt <- counts[, colSums(counts > 0) > 0.5*nrow(counts)]
abundance <- cmultRepl(counts_filt)

meta <- HFD[, c("sample_id", "subject_id", "group")]
pairs <- dcast(meta, subject_id ~ group, value.var = "sample_id")
nb <- nb_mean_shift(abundance, pairs$before, pairs$after, "two_balances")

plot(nb$coord$b1, nb$coord$b2, col = as.factor(HFD$group), xlab = "b1", ylab = "b2")
arrows(mean(nb$coord[pairs$before, "b1"]),
  mean(nb$coord[pairs$before, "b2"]),
  mean(nb$coord[pairs$before, "b1"]) + nb$nb$coord["b1"],
  mean(nb$coord[pairs$before, "b2"]) + nb$nb$coord["b2"],
  lwd =3)
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
