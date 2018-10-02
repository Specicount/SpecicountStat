---
title: "BioCount Specs"
output: html_document
---
# BioCount Application Specs

**R Version:** 3.5

## Installed Packages

1. tidyverse [v1.2.1] (https://www.tidyverse.org/)
2. gridExtra [v2.3]
3. analogue
4. vegan
5. dplyr

``` bash
$ sudo apt install libcurl4-openssl-dev libssl-dev libxml2-dev libgit2-dev
$ Rscript install_env.R
```

## Data Format
The data must in particular format.

| sample.ID | depth.cm | age.cal.yrs.BP | volume.cc | total.spike | counted.spike | total.pollen.count | [pollen name] |
| --------- | -------- | -------------- | --------- | ----------- | ------------- | ------------------ | ------------- |
|           |          |                |           |             |               |                    |               |

http://192.168.64.137/BioDataStat/docs/R_Application_Specs.html

Access the shiny app at: http://192.168.64.137:3838/UI/