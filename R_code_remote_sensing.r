# R code for ecosystem monitoring by remote sensing
# First of all, we need to install additional packages
# raster package to manage image data

install.packages("raster")

library(raster)

setwd("C:/lab/")

# We are going to import satellite data
# l2011 is for the satellite landset
# Objects cannot be numbers
l2011 <- brick("p224r63_2011.grd")

l2011

# 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
# 1499 and 2967 are the number of columns and lines, 4447533 is the number of pxels, 7 is the numbero of layers

plot(l2011)
# B1, B2... are the bands
# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band

cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(l2011, col=cl)
# (black, grey, light gray) is an array
# 100 indicates how many tones we want to have in our palette

plotRGB(l2011, r=3, g=3, b=1, stretch="Lin")
