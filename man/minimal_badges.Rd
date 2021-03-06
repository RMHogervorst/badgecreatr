% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scenarios.R
\name{minimal_badges}
\alias{minimal_badges}
\title{Add a minimum of badges to your project}
\usage{
minimal_badges(status = "concept", license = NULL, date = NULL)
}
\arguments{
\item{status}{one of concept, wip, suspended, abandoned, active, inactive or unsupported}

\item{license}{one of GPL-3, GPL-2, MIT, or CC0.}

\item{date}{a date of your choosing, defaults to current date.}
}
\value{
text to put into rmd
}
\description{
Returns markdown to manually place in your readme.Rmd file.
This is a function you might want to use in the early stages of your project.
This function returns badges link{projectstatusbadge}, link(licensebadge),
and link(last_change_badge_static).
}
\examples{
minimal_badges("abandoned", "GPL-3")
}
\seealso{
Other scenarios: \code{\link{dynamic_badges_minimal}}
}
\concept{scenarios}
