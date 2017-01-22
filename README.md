
<!-- README.md is generated from README.Rmd. Please edit that file -->
excelgesis
==========

The goal of excelgesis is to access and edit XML inside xlsx. Helper package for development and debugging of [readxl](https://github.com/hadley/readxl).

Installation
------------

You can install excelgesis from github with:

``` r
# install.packages("devtools")
devtools::install_github("jennybc/excelgesis")
```

Usage
-----

List the included examples.

``` r
library(excelgesis)
xg_example()
#> Available examples:
#>   * blanks.xlsx
#>   * datasets.xlsx
#>   * Ekaterinburg_IP_9.xlsx
#>   * empty-named-column.xlsx
#>   * inlineStr2.xlsx
#>   * iris-excel.xlsx
#>   * iris-google-doc.xlsx
#>   * mini-gap.xlsx
#>   * missing-first-column.xlsx
#>   * missing-values.xlsx
#>   * new_line_errors.xlsx
#>   * richtext-coloured.xlsx
#>   * sheet-xml-lookup.xlsx
#>   * utf8-sheets.xlsx
```
