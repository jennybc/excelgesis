#' Browse around an unpacked xlsx
#'
#' @param path Path to a directory containing an unpacked, linkified `.xlsx` or
#'   to an `index.html` within.
#'
#' @return The input path, invisibly.
#' @export
#'
#' @examples
#' xg_example("datasets") %>%
#'   xg_unzip() %>%
#'   xg_linkify() %>%
#'   xg_browse()
xg_browse <- function(path) {
  if (fs::path_file(path) != "index.html") {
    path <- fs::path(path, "index.html")
  }
  if (!fs::file_exists(path)) {
    stop("Path does not exist:\n", path, call. = FALSE)
  }
  if (interactive() && is.null(getOption("knitr.in.progress"))) {
    utils::browseURL(path, encodeIfNeeded = TRUE)
  } else {
    message(
      "Visit this file in a browser:\n  * ",
      fs::path_norm(path)
    )
  }
  invisible(path)
}
