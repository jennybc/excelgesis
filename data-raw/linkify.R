#library(excelgesis)
library(here)
library(htmltools)
library(purrr)

examples <- list.dirs(here("docs"))

a_chr <- function(...) as.character(a(...))
p_chr <- function(...) as.character(p(...))

make_README <- function(ex) {
  unlink(file.path(ex, paste("README", c("md", "html"), sep = ".")))
  fls <- href <- list.files(ex)
  dirs <- list.dirs(ex, full.names = FALSE, recursive = FALSE)

  fixed <- paste0(href, ".XML")
  fixme <- grepl("xml.+", fls) &
    !grepl("xml$", fls, ignore.case = TRUE) &
    !(fls %in% dirs)
  file.copy(file.path(ex, fls[fixme]),
            file.path(ex, fixed[fixme]))
  href[fixme] <- fixed[fixme]

  fixme <- fls %in% dirs
  href[fixme] <- file.path(href[fixme], "README.html")

  README <- file.path(ex, "README.html")

  map2(href, fls, ~ a_chr(href = .x, .y)) %>%
    paste0("<li>", ., "</li>") %>%
    c("<ul>", ., "</ul>") %>%
    c(p_chr(basename(ex)), "", .) %>%
    writeLines(README)
}

walk(examples, make_README)
