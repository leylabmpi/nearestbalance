\name{heatmap_with_split}
\alias{heatmap_with_split}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
This function creates a heatmap for microbiome composition splitting taxa and samples into groups
}
\description{
This function
}
\usage{
heatmap_with_split(abundance, metadata, formula = NULL, balance = NULL, type = c("perc", "clr"), num_name = "num", den_name = "den", others_name = "others", abund_limits = range(abundance), taxa_colors = c(), sample_col = NULL, show_samp_names = T)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{abundance}{table of taxa propotions without zeroes with samples as rows and taxa as colums}
  \item{metadata}{metadata table with predictor and covariates values as columns}
  \item{formula}{a formula describing the split of samples. For example \code{ ~ x1 + x2}}
  \item{balance}{a balance that will be used to split taxa. It should be a list with two elements named "num" and "den"}
  \item{type}{Type of values showed by color on heatmap. One of "perc" \(for relative proportions\) or "clr" \(for CLR-components\).}
  \item{num_name}{name of the numerator of the balance which will be depicted on the figure. By default "num"}
  \item{den_name}{name of the denominator of the balance which will be depicted on the figure. By default "den"}
  \item{others_name}{name of all other taxa which will be depicted on the figure. By default "others"}
  \item{abund_limits}{vector vith min and max values of abundance. It is used to make the color scale. By default it is the range of values in the abundance table.}
  \item{sample_col}{column in metadata with sample names. If it is empty the metadata is supposed to have the same order of samples as the abundance table.}
  \item{show_samp_names}{boulean. Whether the sample names should be shown or not.}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
ggplot2 plot
}
\examples{
require(selbal)
require(zCompositions)
abundance <- cmultRepl(selbal::HIV[1:60])
nb <- nb_lm(abundance = abundance,
            metadata = HIV,
            pred = "MSM",
            cov = "HIV_Status",
            type = "two_balances")

# proportions
heatmap_with_split(abundance = abundance,
                   metadata = HIV,
                   formula = ~ MSM + HIV_Status,
                   balance = nb$nb$b1,
                   show_samp_names = F,
                   num_name = "taxa_MSM",
                   den_name = "taxa_nonMSM",
                   others_name = "not assosiated with MSM")

# CLR-components
heatmap_with_split(abundance = abundance,
                   metadata = HIV,
                   formula = ~ MSM + HIV_Status,
                   balance = nb$nb$b1,
                   type = "clr",
                   show_samp_names = F,
                   num_name = "taxa_MSM",
                   den_name = "taxa_nonMSM",
                   others_name = "not assosiated with MSM")

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
