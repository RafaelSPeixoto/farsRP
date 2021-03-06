% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_analysis.R
\name{fars_map_state}
\alias{fars_map_state}
\title{Plot the fars data from a specific state and year.}
\usage{
fars_map_state(state.num, year)
}
\arguments{
\item{state.num}{numeric; the number of the state.}

\item{year}{the year to be selected.}
}
\description{
Plot the fars cases from a specific year and state in the state map according
to the latitude and longitude of the cases. Return an error if the year is
not valid or if there are not any cases in the state. Longituds greater than
900 and latituds greater than 90 will not be considered.  The files must be
in the working directory.
}
\examples{
\dontrun{
fars_map_state(1, 2014)
}

}
