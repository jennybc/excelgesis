#' Unzip an xlsx
#'
#' Extracts the files from an xlsx zip archive. Note it will overwrite existing
#' files, so plan accordingly.
#'
#' @param path Character, length one. Path to xlsx file.
#' @param exdir Passed to [utils::unzip()]. Directory in which to unpack the
#'   xlsx. By default, if unpacking `foo.xlxs`, this will be `foo/` in
#'   current working directory.
#'
#' @return The path to the top-level directory of the unpacked xlsx, invisibly.
#' @export
#'
#' @examples
#' (path <- xg_example("datasets"))
#' xg_unzip(path)
xg_unzip <- function(path, exdir = NULL) {
  stopifnot(is.character(path), length(path) == 1L)
  exdir <- exdir %||% fs::path_file(strip_xlsx(path))
  fl <- utils::unzip(path, exdir = exdir)
  message(
    "Unpacked these files:\n",
    paste0("  * ", fl, collapse = "\n")
  )
  invisible(exdir)
}

strip_xlsx <- function(path) {
  if (fs::path_ext(path) == "xlsx") {
    fs::path_ext_remove(path)
  } else {
    path
  }
}
