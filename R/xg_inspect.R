#' Unzip, linkify, and browse an xlsx file
#'
#' @inheritParams xg_unzip
#'
#' @return Path to the directory being browsed, invisibly.
#' @export
#'
#' @examples
#' xg_example("datasets") %>%
#'   xg_inspect()
xg_inspect <- function(path, exdir = NULL) {
  path %>%
    xg_unzip(exdir = exdir) %>%
    xg_linkify() %>%
    xg_browse()
}
