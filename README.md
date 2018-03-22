
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-works_for_me-ff69b4.svg)](https://blog.codinghorror.com/the-works-on-my-machine-certification-program/)

# excelgesis

The goal of excelgesis is make the XML files inside `.xlsx` files
navigable in a web browser. It’s a helper package for the development
and debugging of [readxl](http://readxl.tidyverse.org). excelgesis
itself is intended for strictly for personal, diagnostic, and
recreational use.

Some prepared example workbooks, drawn from the readxl
[example](https://github.com/tidyverse/readxl/tree/master/inst/extdata)
and
[test](https://github.com/tidyverse/readxl/tree/master/tests/testthat/sheets)
sheets:

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
#>   * big-texty-numbers-xlsx.xlsx
#>   * blanks.xlsx
#>   * clippy.xlsx
#>   * datasets.xlsx
#>   * dates-1900-LibreOffice.xlsx
#>   * dates-leap-year-1900-xlsx.xlsx
#>   * datetime-rounding.xlsx
#>   * deaths.xlsx
#>   * Ekaterinburg_IP_9.xlsx
#>   * embedded-chartsheet.xlsx
#>   * empty-named-column.xlsx
#>   * empty-sheets.xlsx
#>   * geometry.xlsx
#>   * inlineStr.xlsx
#>   * inlineStr2.xlsx
#>   * iris-excel-xlsx.xlsx
#>   * iris-google-doc.xlsx
#>   * list_type.xlsx
#>   * missing-first-column.xlsx
#>   * missing-values-xlsx.xlsx
#>   * new_line_errors.xlsx
#>   * no-yes-col-names.xlsx
#>   * nonstandard-xml-ns-prefix.xlsx
#>   * numbers-as-na-and-shared-strings-xlsx.xlsx
#>   * richtext-coloured.xlsx
#>   * sheet-xml-lookup.xlsx
#>   * skipping.xlsx
#>   * style-only-cells.xlsx
#>   * texty-dates-xlsx.xlsx
#>   * type-me.xlsx
#>   * types.xlsx
#>   * unnamed-duplicated-columns.xlsx
#>   * utf8-sheet-names.xlsx
#>   * vietnamese-utf8.xlsx
#>   * whitespace-xlsx.xlsx
```

Browse around the underlying XML inside those xlsx workbooks:

<https://jennybc.github.io/excelgesis/>

How the examples were prepared: Pick an example and store its path.

``` r
(mg <- xg_example("datasets"))
#> [1] "/Users/jenny/resources/R/library/excelgesis/extdata/datasets.xlsx"
```

Unpack the xlsx, add some nice touches to make it more browser-friendly,
and, if interactive, point a browser at the top-level directory.

``` r
mg %>% 
  xg_unzip() %>% 
  xg_linkify() %>% 
  xg_browse()
#> Unpacked these files:
#>   * datasets/_rels/.rels
#>   * datasets/[Content_Types].xml
#>   * datasets/docProps/core.xml
#>   * datasets/docProps/app.xml
#>   * datasets/xl/printerSettings/printerSettings1.bin
#>   * datasets/xl/printerSettings/printerSettings3.bin
#>   * datasets/xl/sharedStrings.xml
#>   * datasets/xl/worksheets/_rels/sheet3.xml.rels
#>   * datasets/xl/worksheets/_rels/sheet4.xml.rels
#>   * datasets/xl/worksheets/sheet2.xml
#>   * datasets/xl/_rels/workbook.xml.rels
#>   * datasets/xl/printerSettings/printerSettings2.bin
#>   * datasets/xl/printerSettings/printerSettings4.bin
#>   * datasets/xl/styles.xml
#>   * datasets/xl/theme/theme1.xml
#>   * datasets/xl/workbook.xml
#>   * datasets/xl/worksheets/_rels/sheet1.xml.rels
#>   * datasets/xl/worksheets/sheet1.xml
#>   * datasets/xl/worksheets/_rels/sheet2.xml.rels
#>   * datasets/xl/worksheets/sheet3.xml
#>   * datasets/xl/worksheets/sheet4.xml
#> Explore by visiting this file in a browser at:
#>   * /Users/jenny/rrr/excelgesis/datasets/index.html
```
