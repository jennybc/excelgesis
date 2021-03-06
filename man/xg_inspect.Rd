% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xg_inspect.R
\name{xg_inspect}
\alias{xg_inspect}
\title{Unzip, linkify, and browse an xlsx file}
\usage{
xg_inspect(path, exdir = NULL)
}
\arguments{
\item{path}{Character, length one. Path to xlsx file.}

\item{exdir}{Passed to \code{\link[utils:unzip]{utils::unzip()}}. Directory in which to unpack the
xlsx. By default, if unpacking \code{foo.xlxs}, this will be \code{foo/} in
the same directory as \code{foo.xlsx}.}
}
\value{
Path to the directory being browsed, invisibly.
}
\description{
Unzip, linkify, and browse an xlsx file
}
\examples{
file.copy(xg_example("datasets"), "datasets.xlsx")
xg_inspect("datasets.xlsx")

## clean up
unlink("datasets", recursive = TRUE)
file.remove("datasets.xlsx")
}
