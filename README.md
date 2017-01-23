
<!-- README.md is generated from README.Rmd. Please edit that file -->
excelgesis
==========

The goal of excelgesis is to access and edit XML inside xlsx. Helper package for development and debugging of [readxl](https://github.com/hadley/readxl). Intended for personal/diagnostic use.

Some prepared example workbooks:

<https://jennybc.github.io/excelgesis/>

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

Browse around the underlying XML inside those xlsx workbooks:

<https://jennybc.github.io/excelgesis/>

How the examples were prepared: Pick an example and store its path.

``` r
(mg <- xg_example("mini-gap"))
#> [1] "/Users/jenny/resources/R/library/excelgesis/extdata/mini-gap.xlsx"
```

Unpack the xlsx, add some nice touches to make it more browser-friendly, and, if interactive, point a browser at the top-level directory.

``` r
mg %>% 
  xg_unzip() %>% 
  xg_linkify() %>% 
  xg_browse()
#> Unpacked these files:
#>   * mini-gap/xl/worksheets/sheet1.xml
#>   * mini-gap/xl/worksheets/_rels/sheet1.xml.rels
#>   * mini-gap/xl/worksheets/sheet2.xml
#>   * mini-gap/xl/worksheets/_rels/sheet2.xml.rels
#>   * mini-gap/xl/worksheets/sheet3.xml
#>   * mini-gap/xl/worksheets/_rels/sheet3.xml.rels
#>   * mini-gap/xl/worksheets/sheet4.xml
#>   * mini-gap/xl/worksheets/_rels/sheet4.xml.rels
#>   * mini-gap/xl/worksheets/sheet5.xml
#>   * mini-gap/xl/worksheets/_rels/sheet5.xml.rels
#>   * mini-gap/xl/drawings/worksheetdrawing1.xml
#>   * mini-gap/xl/drawings/worksheetdrawing2.xml
#>   * mini-gap/xl/drawings/worksheetdrawing3.xml
#>   * mini-gap/xl/drawings/worksheetdrawing4.xml
#>   * mini-gap/xl/drawings/worksheetdrawing5.xml
#>   * mini-gap/xl/sharedStrings.xml
#>   * mini-gap/xl/styles.xml
#>   * mini-gap/xl/workbook.xml
#>   * mini-gap/xl/_rels/workbook.xml.rels
#>   * mini-gap/_rels/.rels
#>   * mini-gap/[Content_Types].xml
#> Created these files:
#>   * mini-gap/index.html
#>   * mini-gap/_rels/index.html
#>   * mini-gap/xl/index.html
#>   * mini-gap/xl/_rels/index.html
#>   * mini-gap/xl/drawings/index.html
#>   * mini-gap/xl/worksheets/index.html
#>   * mini-gap/xl/worksheets/_rels/index.html
#> Explore by pointing browser at:
#>   * mini-gap/index.html
```
