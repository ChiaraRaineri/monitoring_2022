# Ice melt in Greenland
# Proxy: LST  (land surface temperature)

library(raster)
library(ggplot2)
library(RStoolbox)
# install.packages("rasterVis")

setwd("C:/lab/greenland")

rlist <- list.files(pattern="lst")
rlist
# These are single layers

import <- lapply(rlist,raster)
import

# TGr is Temperature of Greenland
TGr <- stack(import)
TGr
plot(TGr)

#levelplot(TGr)
cl <- colorRampPalette(c("blue","light blue","pink","yellow"))(100)
plot(TGr, col=cl)

library(patchwork)
library(viridis)
# ggplot of first image vs last image

p1 <- ggplot() + 
geom_raster(TGr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2000")

p2 <- ggplot() + 
geom_raster(TGr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2015")

p1+p2

# Plotting frequency distributions of data
par(mfrow=c(1,2))
hist(TGr$lst_2000)
hist(TGr$lst_2015)

par(mfrow=c(2,2))
hist(TGr$lst_2000)
hist(TGr$lst_2005)
hist(TGr$lst_2010)
hist(TGr$lst_2015)

dev.off()
plot(TGr$lst_2010, TGr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
abline(0,1,col="red")

# Plot all histograms and regressions for all the variables
pairs(TGr)
