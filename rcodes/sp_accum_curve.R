# Species Accumulation Curves
# ref: http://cc.oulu.fi/~jarioksa/softhelp/vegan/html/specaccum.html

# Import Libaries
library(vegan)

# Import raw data set
raw_data <-
  read.csv(file = "./data/LL2_pollen_raw_data.csv", head = TRUE, sep = ",")

# Remove the total counts and spikes(first 8 columns)
core <- raw_data[, c(8:ncol(raw_data))]

# Draw Species Accumulation Curve
sp1 <- specaccum(core)
sp2 <- specaccum(core, "random", permutations = 100)
sp2
summary(sp2)
plot(sp1, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")
boxplot(sp2, col="white", add=TRUE, pch="+")