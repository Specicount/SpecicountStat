# Set working directory
# setwd("../data/")

# Load packages
library(ggplot2)
library(grid)
library(analogue)

# Import raw data set
raw_data <-
  read.csv(file = "./data/LL2_pollen_raw_data.csv", head = TRUE, sep = ",")

# Generate percentage data using raw data
pct_data <- raw_data[, c(0:7)]
# Count the pollens using sum !!Note that it is different from the total column
pct_data$count.sum <- rowSums(raw_data[, c(8:ncol(raw_data))])
core <- raw_data[, c(8:ncol(raw_data))]
core_pct <- core / rowSums(core)*100
pct_data <- cbind(pct_data, core_pct)

# Start creating graphs
# Define y-axis
ids <- raw_data$sample.ID

# Remove the total counts and spikes(first 9 columns) since a count column has been added
core <- pct_data[, c(9:ncol(raw_data))]

# Filt the data using f maximum abundance attained and number of occurrences.
core.fltd <- chooseTaxa(core, n.occ = 0.05, max.abun = 1)

# Draw Palaeoecological Stratigraphic Diagram with percentage data
Stratiplot(
  ids ~ .,
  data = core.fltd,
  sort = "wa",
  type = c("h", "l", "g"),
  ylab = 'Sample ID',
  xlab = 'Percentage'
)