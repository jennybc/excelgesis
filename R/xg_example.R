#' Get path to excelgesis example
#'
#' excelgesis includes several sheets drawn from examples, tests, and issues on
#' readxl, rexcel, and googlesheets. This function makes it easier to get these
#' filepaths.
#'
#' @param x Character. Each element should be a filename with extension
#'   \code{.xlsx} extension or a regex that matches desired filename(s).
#' @return Character vector of full file paths.
#' @export
#' @examples
#' xg_example()
#' xg_example("mini")
#' xg_example("mini-gap.xlsx")
#' xg_example(c("iris-excel.xlsx", "mini-gap.xlsx"))
#' xg_example("missing")
#' xg_example(c("iris", "missing"))
#' xg_example(c("missing", "mini-gap.xlsx"))
xg_example <- function(x = character()) {
  if (length(x) < 1) {
    x <- list_extdata(pattern = "xlsx")
    message("Available examples:\n", paste0(paste0("  * ", x), collapse = "\n"))
    return(invisible(NULL))
  }
  unlist(lapply(x, f))
}

f <- function(x) {
  stopifnot(is.character(x), length(x) == 1L)
  ext <- tools::file_ext(x)
  if (ext == "xlsx") {
    return(system.file("extdata", x, package = "excelgesis", mustWork = TRUE))
  }
  x <- list_extdata(pattern = x, full.names = TRUE)
  ext <- tools::file_ext(x)
  x[ext == "xlsx"]
}

path_extdata <- function() file.path(system.file(package = "excelgesis"), "extdata")
list_extdata <- function(...) list.files(path_extdata(), ...)
