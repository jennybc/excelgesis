library(excelgesis)
library(here)
library(purrr)

readxl_test_sheets <- list.files(
  "~/rrr/readxl/tests/testthat/sheets",
  full.names = TRUE,
  pattern = "xlsx$"
)

x <- file.copy(
  readxl_test_sheets,
  here("inst", "extdata", basename(readxl_test_sheets))
)

ex_xlsx <- list.files(here("inst", "extdata"), full.names = TRUE)
ex_names <- tools::file_path_sans_ext(basename(ex_xlsx))
ex_dirs <- here("docs", ex_names)

## make clean
unlink(ex_dirs, recursive = TRUE)
file.remove(here("docs", "index.html"))

walk2(ex_xlsx, ex_dirs, ~ xg_unzip(.x, .y))
xg_linkify(here("docs"))

