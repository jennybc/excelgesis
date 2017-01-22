library(excelgesis)
library(here)
library(purrr)

examples <- xg_example(".*")
walk(examples,
     ~ xg_unzip(.x,
                exdir = here("docs",
                             tools::file_path_sans_ext(basename(.x)))))
