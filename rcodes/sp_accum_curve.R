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

## Fit Lomolino model to the exact accumulation
mod1 <- fitspecaccum(sp1, "lomolino")
coef(mod1)
fitted(mod1)
plot(sp1)
## Add Lomolino model using argument 'add'
plot(mod1, add = TRUE, col=2, lwd=2)
## Fit Arrhenius models to all random accumulations
mods <- fitspecaccum(sp2, "arrh")
plot(mods, col="hotpink")
boxplot(sp2, col = "yellow", border = "blue", lty=1, cex=0.3, add= TRUE)
## Use nls() methods to the list of models
sapply(mods$models, AIC)

mod <- cca(core)