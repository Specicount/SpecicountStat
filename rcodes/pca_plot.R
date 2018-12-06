# Principal component analysis
# Load packages
library(analogue)

# Import data set
raw_data <-
  read.csv(file = "./data/LL2_pollen_raw_data.csv", head = TRUE, sep = ",")

# Remove the total counts and spikes(first 8 columns)
core <- raw_data[, c(8:ncol(raw_data))]

core.pca <- rda(core)
plot(core.pca)

biplot(core.pca, scaling = -1)
