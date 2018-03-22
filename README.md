
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-works_for_me-ff69b4.svg)](https://blog.codinghorror.com/the-works-on-my-machine-certification-program/)

# excelgesis

The goal of excelgesis is make the XML files inside `.xlsx` files
navigable in a web browser. It’s a helper package for the development
and debugging of [readxl](http://readxl.tidyverse.org). excelgesis
itself is intended for strictly for personal, diagnostic, and
recreational use.

You can explore some prepared example workbooks here, drawn from the
readxl
[example](https://github.com/tidyverse/readxl/tree/master/inst/extdata)
and
[test](https://github.com/tidyverse/readxl/tree/master/tests/testthat/sheets)
sheets:

<https://jennybc.github.io/excelgesis/>

Those same workbooks are available in `.xlsx` form in the excelgesis
package. Use `xg_example()` to gain access.

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
#>   * Ekaterinburg_IP_9.xlsx
#>   * big-texty-numbers-xlsx.xlsx
#>   * blanks.xlsx
#>   * clippy.xlsx
#>   * datasets.xlsx
#>   * dates-1900-LibreOffice.xlsx
#>   * dates-leap-year-1900-xlsx.xlsx
#>   * datetime-rounding.xlsx
#>   * deaths.xlsx
#>   * embedded-chartsheet.xlsx
#>   * empty-named-column.xlsx
#>   * empty-sheets.xlsx
#>   * geometry.xlsx
#>   * inlineStr.xlsx
#>   * inlineStr2.xlsx
#>   * iris-excel-xlsx.xlsx
#>   * iris-google-doc.xlsx
#>   * list_type.xlsx
#>   * los-angeles-arrests-xlsx.xlsx
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

Here’s how to do the same locally for the example workbook about Clippy:

``` r
xg_example("clippy") %>% 
  xg_inspect()
#> Unpacked these files:
#>   * clippy/[Content_Types].xml
#>   * clippy/_rels/.rels
#>   * clippy/xl/_rels/workbook.xml.rels
#>   * clippy/xl/workbook.xml
#>   * clippy/xl/sharedStrings.xml
#>   * clippy/xl/theme/theme1.xml
#>   * clippy/xl/styles.xml
#>   * clippy/xl/worksheets/sheet1.xml
#>   * clippy/docProps/thumbnail.jpeg
#>   * clippy/docProps/core.xml
#>   * clippy/docProps/app.xml
#> Linkifying:
#>   * clippy/
#> Visit this file in a browser:
#>   * clippy/index.html
```

The convenience function `xg_inspect()` wraps up three operations:

  - Unzip the ZIP archive – `xg_unzip()`
  - Make the unpacked files more pleasant for browsing – `xg_linkify()`
  - Visit the top-level ‘index.html’ in your default browser –
    `xg_browse()`

Here’s one last worked example using the individual functions.

``` r
(mg <- xg_example("datasets"))
#> [1] "/Users/jenny/resources/R/library/excelgesis/extdata/datasets.xlsx"
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
#> Linkifying:
#>   * datasets/
#> Visit this file in a browser:
#>   * datasets/index.html
```
