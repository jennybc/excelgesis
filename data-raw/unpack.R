library(excelgesis)
library(here)
library(purrr)

ex_xlsx <- xg_example(".*")
ex_names <- tools::file_path_sans_ext(basename(ex_xlsx))
ex_dirs <- here("docs", ex_names)

## make clean
unlink(ex_dirs, recursive = TRUE)

walk2(ex_xlsx, ex_dirs, ~ xg_unzip(.x, .y))
