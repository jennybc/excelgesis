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
#'   i.e. the output of \code{\link{xg_unzip}()}. If the extension \code{.xlsx}
#'   is present, it will be stripped.
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
  path <- strip_xlsx(path)
  dirs <- list.dirs(path)
  res <- lapply(dirs, linkify, parent = path)
  message("Created these files:\n",
          paste0(paste0("  * ", unlist(res)), collapse = "\n"))
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





linkify <- function(x, parent = character()) {
  INDEX <- file.path(x, "index.html")
  fls <- href <- list.files(x)
  if (length(fls) < 1) {
    writeLines("no files", INDEX)
    return(invisible(INDEX))
  }
  ignore_me <- grepl("^index.html$|\\.XML$", fls)
  if (any(ignore_me)) {
    message("Do you want to run `xg_de_linkify()`? These files already exist:\n",
            paste0(paste0("  * ", file.path(x, fls[ignore_me])), collapse = "\n"))
    fls <- href <- fls[!ignore_me]
  }
  x_dirs <- list.dirs(x, full.names = FALSE, recursive = FALSE)

  ## most browsers require `.xml` extension to recognize and view XML
  ## several XML files in xlsx end in `.rels`, eg xl/_rels/workbook.xml.rels
  ## create a copy of such files and give extension `.XML`
  fixed <- paste0(href, ".XML")
  fixme <- grepl("xml.+", fls) &
    !grepl("xml$", fls, ignore.case = TRUE) &
    !(fls %in% x_dirs)
  file.copy(file.path(x, fls[fixme]),
            file.path(x, fixed[fixme]))
  href[fixme] <- fixed[fixme]

  ## when linking to a sub-directory, link to it's index.html instead
  fixme <- fls %in% x_dirs
  href[fixme] <- file.path(href[fixme], "index.html")

  links <- mapply(a_chr, href, fls, USE.NAMES = FALSE)
  list_items <- paste0("<li>", links, "</li>")
  ul <- c("<ul>", list_items, "</ul>")
  lines <- c(p_chr(basename(x)), "", ul)
  writeLines(lines, INDEX)
  return(invisible(INDEX))
}

strip_xlsx <- function(path) {
  if (tools::file_ext(path) == "xlsx") {
    tools::file_path_sans_ext(path)
  } else {
    path
  }
}

strip_xlsx <- function(path) {
  if (tools::file_ext(path) == "xlsx") {
    tools::file_path_sans_ext(path)
  } else {
    path
  }
}

a_chr <- function(href, text) as.character(htmltools::a(href = href, text))
p_chr <- function(...) as.character(htmltools::p(...))
