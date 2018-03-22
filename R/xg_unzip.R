#' Unzip an xlsx
#'
#' Extracts the files from an xlsx zip archive. Note it will overwrite existing
#' files, so plan accordingly.
#'
#' @param path Character, length one. Path to xlsx file.
#' @param exdir Passed to \code{tools::unzip}. Directory in which to unpack the
#'   xlsx. By default, if unpacking \code{foo.xlxs}, this will be \code{foo}
#'   (unlike the default for \code{tools::unzip}).
#'
#' @return The path to the top-level directory of the unpacked xlsx, invisibly.
#' @export
#'
#' @examples
#' (path <- xg_example("mini"))
#' (x <- xg_unzip(path))
xg_unzip <- function(path, exdir = NULL) {
  stopifnot(is.character(path), length(path) == 1L)
  if (is.null(exdir)) {
    exdir <- fs::path_ext_remove(path)
  }
  fl <- utils::unzip(path, exdir = exdir)
  message(
    "Unpacked these files:\n",
    paste0("  * ", fl, collapse = "\n")
  )
  invisible(exdir)
}
