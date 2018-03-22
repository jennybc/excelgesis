#' Add and remove links in an unpacked xlsx directory
#'
#' Things that make an unpacked xlsx less awful to navigate in the browser:
#' \enumerate{
#' \item Each directory has \code{index.html}, listing links to
#'   files/subdirectories
#' \item Links to subdirectories link to the associated \code{index.html}
#' \item XML files that do not have \code{.xml} as file extension are copied
#'   to a file having the same name, but with the extension \code{.XML} added
#'   and this is what is linked.
#' }
#' \code{xg_linkify()} does the above and \code{xg_de_linkify()} undoes it.
#' \code{xg_linkify()} creates and copies files and code{xg_de_linkify()}
#' deletes them.
#'
#' @param path Path to a directory corresponding to a single, unpacked xlsx,
#'   i.e. the output of \code{\link{xg_unzip}()}.
#' @name xg_linkify
#' @examples
#' target <- "datasets"
#' (datasets <- xg_example(target))
#' res <- datasets %>%
#'   xg_unzip() %>%
#'   xg_linkify()
#' xg_browse(res)
#'
#' res <- target %>%
#'   xg_de_linkify()
NULL

#' @rdname xg_linkify
#' @export
xg_linkify <- function(path) {
  if (fs::is_file(path)) {
    stop("Path is a file, not a directory:\n", path, call. = FALSE)
  }
  linkify(path)
  invisible(path)
}

#' @rdname xg_linkify
#' @export
xg_de_linkify <- function(path) {
  path <- strip_xlsx(path)
  if (!dir.exists(path)) {
    stop("Path does not exist, so can't de-linkify:\n", path, call. = FALSE)
  }
  delete_me <- list.files(path, recursive = TRUE,
                          pattern = "^index.html$|\\.XML$")
  status <- file.remove(file.path(path, delete_me))
  if (any(status)) {
    message("Removed these files from ", path, ":\n",
            paste0(paste0("  * ", delete_me[status]), collapse = "\n"))
  } else {
    message("Nothing to remove")
  }
  invisible(path)
}

#' @rdname xg_linkify
#' @export
xg_browse <- function(path) {
  path <- strip_xlsx(path)
  if (basename(path) != "index.html") {
    INDEX <- file.path(path, "index.html")
  } else {
    INDEX <- path
  }
  if (!file.exists(INDEX)) {
    stop("Can't find ", INDEX, call. = FALSE)
  }
  message("Explore by visiting this file in a browser at:\n  * ",
          normalizePath(INDEX))
  if (interactive() && is.null(getOption("knitr.in.progress"))) {
    utils::browseURL(INDEX)
  }
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
