\name{HFD}
\alias{HFD}
\docType{data}
\title{
Stool microbiome collected before and after high-fiber diet.
}
\description{
A dataset containing metadata and the number of counts of 194 different genera in a group of 368 samples collected before and after a high-fiber diet intervention.
}
\usage{data("HFD")}
\format{
  the data.frame consists of information abount 194 genera counts and 3 variables
  \describe{
    \item{\code{genera}}{counts for 194 genera}
    \item{\code{group}}{wether the sample was collected before of after the diet intervention}
    \item{\code{subject_id}}{identifier of the subject}
    \item{\code{sample_id}}{identifier of the sample}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
https://www.mdpi.com/2072-6643/10/5/576/htm}
\examples{
data("HFD")
}
\keyword{datasets}
