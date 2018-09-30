# Detrended correspondence analysis
# Load packages
library(analogue)

# Import data set
raw_data <-
  read.csv(file = "./data/LL2_pollen_raw_data.csv", head = TRUE, sep = ",")

# Remove the total counts and spikes(first 8 columns)
core <- raw_data[, c(8:ncol(raw_data))]

# get the dca data
core.dca <- decorana(core)

# plot the dca plot
plot(core.dca)

shnam <- make.cepnames(names(core))

# pl <- plot(core.dca, display = "sp")
# identify(pl, "sp", labels = shnam)
stems <- colSums(core)
plot(core.dca, dis="sp", type="n")
sel <- orditorp(core.dca, dis="sp", lab=shnam, priority=stems, pcol = "red", pch="+")