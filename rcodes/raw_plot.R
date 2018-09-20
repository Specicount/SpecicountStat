# Set working directory
# setwd("./data/")

# Load packages
library("rioja")

# Import data set
raw_data <-
  read.csv(file = "./data/LL2_pollen_raw_data.csv", head = TRUE, sep = ",")

# Remove the total counts and spikes
plot_data <- raw_data[, c(8:ncol(raw_data))]

# Remove the data that rebundance less than 10%
data.sum <- colSums(plot_data)
core <- plot_data[, which(data.sum > 100)]



# Define color scheme
p.col <- c(rep("forestgreen", times = ncol(plot_data) - 1))

# Define y axis
y.scale <- raw_data$sample.ID

# Line Plot
pol.plot <-
  strat.plot(
    core,
    yvar = y.scale,
    y.rev = TRUE,
    plot.line = TRUE,
    plot.poly = FALSE,
    plot.bar = FALSE,
    col.line = p.col,
    lwd.line = 2,
    scale.percent = TRUE,
    xSpace = 0.005,
    x.pc.lab = TRUE,
    x.pc.omit0 = TRUE,
    las = 2
  )
