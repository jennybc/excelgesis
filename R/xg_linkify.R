#' Add and remove links in an unpacked xlsx directory
#'
#' Things that make an unpacked xlsx less awful to navigate in the browser:
#' * Each directory has `index.html`, listing links to files/subdirectories
#' * Links to subdirectories link to the associated `index.html`
#' * XML files that do not have `.xml` as file extension are copied to a file
#'   having the same name, but with the extension `.XML` added and this is what
#'   is linked.
#'
#' `xg_linkify()` does the above and `xg_de_linkify()` undoes it.
#'
#' @param path Path to a directory corresponding to a single, unpacked xlsx,
#'   i.e. the output of [xg_unzip()] or, alternatively, a directory of such
#'   things.
#' @name xg_linkify
#' @examples
#' target <- "datasets"
#' (datasets <- xg_example(target))
#' res <- datasets %>%
#'   xg_unzip() %>%
#'   xg_linkify()
#' xg_browse(res)
#'
#' xg_de_linkify(target)
NULL

#' @rdname xg_linkify
#' @export
xg_linkify <- function(path) {
  check_dir(path)
  message("Linkifying:\n", paste0("  * ", path, "/"))
  linkify(path)
  invisible(path)
}

#' @rdname xg_linkify
#' @export
xg_de_linkify <- function(path) {
  check_dir(path)
  message(
    "Removing 'index.html' and *.XML files, recursively, from:\n",
    paste0("  * ", path, "/")
  )
  to_delete <- fs::dir_ls(path, recursive = TRUE, regexp = "index.html$|[.]XML$")
  n <- length(to_delete)
  if (n > 0) {
    message("    ", n, " files deleted")
  } else {
    message("Nothing to delete")
  }
  fs::file_delete(to_delete)
  invisible(path)
}

linkify <- function(x) {

  if (fs::is_file(x)) return()

  ## `all = TRUE` so we don't lose .rels
  fls <- fs::dir_ls(x, all = TRUE)
  ## filter out files that are products of this process
  ## they will presumably get overwritten (or, at least, not linked)
  fls <- fs::path_filter(fls, regexp = "index.html$|[.]XML$", invert = TRUE)
  ## filter out '.nojekyll' which exists at top-level of 'docs/'
  fls <- fs::path_filter(fls, regexp = ".nojekyll$", invert = TRUE)

  write_index(fls, fs::path(x, "index.html"))

  purrr::walk(fls, linkify)

}

write_index <- function(fls, INDEX) {

  if (length(fls) < 1) {
    writeLines("no files to list", INDEX)
    return()
  }

  ## fls holds nominal paths
  ## href holds what we actually link to in index.html
  href <- fls

  ## most browsers require `.xml` extension to recognize and view XML
  ## however, several XML files in xlsx end in '.rels',
  ##   e.g., _rels/.rels and xl/_rels/workbook.xml.rels
  ## create a copy of such files, with extension `.XML`
  ## capitalized so these copies are easier to identify later
  suffixed <- paste0(fls, ".XML")
  copy_me <- grepl("[.]rels$", fls) & !fs::is_dir(fls)
  fs::file_copy(fls[copy_me], suffixed[copy_me], overwrite = TRUE)
  href[copy_me] <- suffixed[copy_me]

  ## when linking to sub-directory 'foo/', link to 'foo/index.html' instead
  index_me <- fs::is_dir(fls)
  href[index_me] <- fs::path(href[index_me], "index.html")

  ## make paths relative to parent of INDEX
  parent <- fs::path_dir(INDEX)
  href <- fs::path_rel(href, parent)
  link_text <- fs::path_rel(fls, parent)

  list_items <- stringr::str_glue("<li><a href=\"{href}\">{link_text}</a></li>")
  lines <- c(
    stringr::str_glue("<p>{fs::path_file(parent)}</p>"),
    "",
    "<ul>",
    list_items,
    "</ul>"
  )
  writeLines(lines, INDEX)
}

check_dir <- function(path) {
  if (!fs::dir_exists(path)) {
    if (fs::is_file(path)) {
      stop("Path is a file, not a directory:\n", path, call. = FALSE)
    }
    stop("No directory at this path:\n", path, call. = FALSE)
  }
  invisible(path)
}
