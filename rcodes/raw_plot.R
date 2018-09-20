# Set working directory
# setwd("./data/")

# Load packages
library(ggplot2)
library(grid)
library(neotoma)
library(analogue)

# Import data set
raw_data <-
  read.csv(file = "./data/LL2_pollen_raw_data.csv", head = TRUE, sep = ",")

# Remove the total counts and spikes(first 8 columns)
core <- raw_data[, c(8:ncol(raw_data))]

# Define y axis
ids <- raw_data$sample.ID

# Filt the data above given occurance and maximum abundance
core.fltd <- chooseTaxa(core, n.occ = 5, max.abun = 10)

# Draw Palaeoecological Stratigraphic Diagram
# Documentation: https://rdrr.io/cran/analogue/man/Stratiplot.html
# reference from: https://www.fromthebottomoftheheap.net/2011/06/08/stratigraphic-diagrams-using-analogue/
# ids~: the y-axis val
# data: the each x axis val
# sort: weighted average “optima” for the y-axis variable or NULL
# type: type of graph: l line, p points, o overplot line and point, b both line and point, g grid, h, histo, smooth LOESS, poly filled poly
# ylab: y legend
Stratiplot(
  ids ~ .,
  data = core.fltd,
  sort = "wa",
  type = c("h", "l", "g"),
  ylab = 'Sample ID',
  xlab = 'Count'
)
