#' Get path to excelgesis example
#'
#' excelgesis includes many sheets drawn from examples, tests, and issues on
#' readxl, rexcel, and googlesheets. This function makes it easier to get these
#' filepaths. You probably want to make a copy in, e.g., working directory
#' before unpacking an example. Or specify the `exdir` in `xg_unzip()`.
#'
#' @param x Character. A regex that matches desired filename(s).
#' @return Character vector of full file paths.
#' @export
#' @examples
#' xg_example()
#' xg_example("iris-excel-xlsx.xlsx")
#' xg_example("datasets")
#' xg_example("missing")
xg_example <- function(x = NULL) {
  fls <- fs::dir_ls(
    system.file("extdata", package = "excelgesis"),
    glob = "*.xlsx"
  )
  if (is.null(x)) {
    x <- fs::path_file(fls)
    message("Available examples:\n", paste0("  * ", x, collapse = "\n"))
    return(invisible(fls))
  }
  system.file(
    "extdata",
    fs::path_filter(fs::path_file(fls), regexp = x),
    package = "excelgesis",
    mustWork = TRUE
  )
}
