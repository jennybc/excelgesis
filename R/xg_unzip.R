#' Unzip an xlsx
#'
#' Extracts the files from an xlsx zip archive. Note it will overwrite existing
#' files, so plan accordingly.
#'
#' @param path Character, length one. Path to xlsx file.
#' @param exdir Passed to \code{tools::unzip}. Directory in which to unpack the
#'   xlsx.
#'
#' @return The path to the top-level directory of the unpacked xlsx, invisibly.
#' @export
#'
#' @examples
#' (path <- xg_example("mini"))
#' (x <- xg_unzip(path))
xg_unzip <- function(path, exdir = character()) {
  stopifnot(is.character(path), length(path) == 1L)
  if (length(exdir) < 1) {
    exdir <- tools::file_path_sans_ext(basename(path))
  }
  fl <- utils::unzip(path, exdir = exdir)
  message("Unpacked these files:\n", paste0(paste0("  * ", fl), collapse = "\n"))
  invisible(least_common_dir(fl))
}

least_common_dir <- function(paths) {
  parts <- stringr::str_split_fixed(paths, pattern = "/", n = 4)
  n_distinct <- apply(parts, 2, function(z) length(unique(z)))
  lcd_index <- max(which(n_distinct == 1))
  parts[[1, lcd_index]]
}
