## [1] populates the example sheets installed below 'extdata/' and
##   made accessible via `xg_example()`
## [2] unzips + linkifies them into 'docs/' and therefore browsable here:
##   https://github.com/jennybc/excelgesis

library(excelgesis)
library(here)
library(purrr)
library(fs)

readxl_test_sheets <- dir_ls(
  "~/rrr/readxl/tests/testthat/sheets",
  glob = "*.xlsx"
)

readxl_example_sheets <- dir_ls(
  "~/rrr/readxl/inst/extdata",
  glob = "*.xlsx"
)

sheets <- c(readxl_test_sheets, readxl_example_sheets)

x <- file_copy(
  sheets,
  here("inst", "extdata", path_file(sheets)),
  overwrite = TRUE
)

ex_xlsx <- dir_ls(here("inst", "extdata"))
ex_names <- path_ext_remove(path_file(ex_xlsx))
ex_dirs <- here("docs", ex_names)

## make clean
dir_delete(ex_dirs[dir_exists(ex_dirs)])
file_delete(here("docs", "index.html"))

walk2(ex_xlsx, ex_dirs, ~ xg_unzip(.x, .y))
xg_linkify(here("docs"))
