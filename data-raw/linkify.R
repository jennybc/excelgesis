#library(excelgesis)
library(here)
library(htmltools)
library(purrr)

examples <- list.dirs(here("inst", "extdata"))

make_README <- function(ex) {
  unlink(file.path(ex, paste("README", c("md", "html"), sep = ".")))
  fls <- href <- list.files(ex)
  dirs <- list.dirs(ex, full.names = FALSE, recursive = FALSE)
  fixme <- fls %in% dirs
  href[fixme] <- file.path(href[fixme], "README.md")

  README <- file.path(ex, "README.md")

  map2(href, fls, ~ a(href = .x, .y)) %>%
    map_chr(as.character) %>%
    paste("  *", .) %>%
    c(basename(ex), "", .) %>%
    writeLines(README)
}

walk(examples, make_README)
