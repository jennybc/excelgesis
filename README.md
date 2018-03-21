
<!-- README.md is generated from README.Rmd. Please edit that file -->

# excelgesis

The goal of excelgesis is make the XML files inside `.xlsx` files
navigable in a web browser. It’s a helper package for the development
and debugging of [readxl](http://readxl.tidyverse.org). excelgesis
itself is intended for strictly for personal, diagnostic, and
recreational use.

Some prepared example workbooks, mostly drawn from [the Gallery of
Horrors](https://github.com/tidyverse/readxl/tree/master/tests/testthat/sheets),
a.k.a. the test sheets for readxl:

<https://jennybc.github.io/excelgesis/>

The definitive reference for `.xlxs` is Standard ECMA-376 Office Open
XML File
    Formats:

  - <http://www.ecma-international.org/publications/standards/Ecma-376.htm>

## Installation

You can install excelgesis from github with:

``` r
# install.packages("devtools")
devtools::install_github("jennybc/excelgesis")
```

## Usage

List the included examples.

``` r
library(excelgesis)
xg_example()
#> Available examples:
#>   * blanks.xlsx
#>   * datasets.xlsx
#>   * dates-1900-loo.xlsx
#>   * datetime-rounding.xlsx
#>   * Ekaterinburg_IP_9.xlsx
#>   * embedded-chartsheet.xlsx
#>   * empty-named-column.xlsx
#>   * empty-sheets.xlsx
#>   * inlineStr.xlsx
#>   * inlineStr2.xlsx
#>   * iris-excel.xlsx
#>   * iris-google-doc.xlsx
#>   * JMP-no-location-refs.xlsx
#>   * list_type.xlsx
#>   * mini-gap.xlsx
#>   * missing-first-column.xlsx
#>   * missing-values.xlsx
#>   * new_line_errors.xlsx
#>   * no-yes-col-names.xlsx
#>   * richtext-coloured.xlsx
#>   * sheet-xml-lookup.xlsx
#>   * skipping.xlsx
#>   * style-only-cells.xlsx
#>   * types.xlsx
#>   * unnamed-duplicated-columns.xlsx
#>   * utf8-sheets.xlsx
```

Browse around the underlying XML inside those xlsx workbooks:

<https://jennybc.github.io/excelgesis/>

How the examples were prepared: Pick an example and store its path.

``` r
(mg <- xg_example("mini-gap"))
#> [1] "/Users/jenny/resources/R/library/excelgesis/extdata/mini-gap.xlsx"
```

Unpack the xlsx, add some nice touches to make it more browser-friendly,
and, if interactive, point a browser at the top-level directory.

``` r
mg %>% 
  xg_unzip() %>% 
  xg_linkify() %>% 
  xg_browse()
#> Unpacked these files:
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/sheet1.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/_rels/sheet1.xml.rels
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/sheet2.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/_rels/sheet2.xml.rels
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/sheet3.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/_rels/sheet3.xml.rels
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/sheet4.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/_rels/sheet4.xml.rels
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/sheet5.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/_rels/sheet5.xml.rels
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/drawings/worksheetdrawing1.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/drawings/worksheetdrawing2.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/drawings/worksheetdrawing3.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/drawings/worksheetdrawing4.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/drawings/worksheetdrawing5.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/sharedStrings.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/styles.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/workbook.xml
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/_rels/workbook.xml.rels
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/_rels/.rels
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/[Content_Types].xml
#> Created these files:
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/index.html
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/_rels/index.html
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/index.html
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/_rels/index.html
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/drawings/index.html
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/index.html
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/xl/worksheets/_rels/index.html
#> Explore by visiting this file in a browser at:
#>   * /Users/jenny/resources/R/library/excelgesis/extdata/mini-gap/index.html
```
