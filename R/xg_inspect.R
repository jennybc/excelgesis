#' Unzip, linkify, and browse an xlsx file
#'
#' @inheritParams xg_unzip
#'
#' @return Path to the directory being browsed, invisibly.
#' @export
#'
#' @examples
#' file.copy(xg_example("datasets"), "datasets.xlsx")
#' xg_inspect("datasets.xlsx")
#'
#' ## clean up
#' unlink("datasets", recursive = TRUE)
#' file.remove("datasets.xlsx")
xg_inspect <- function(path, exdir = NULL) {
  path %>%
    xg_unzip(exdir = exdir) %>%
    xg_linkify() %>%
    xg_browse()
}
