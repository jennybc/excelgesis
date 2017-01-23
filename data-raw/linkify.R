examples <- list.dirs(here("docs"))


walk(examples, make_README)

file.rename(here("docs", "README.html"), here("docs", "index.html"))

