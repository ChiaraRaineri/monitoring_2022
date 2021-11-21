# R code for estimating energy in ecosystems

library(raster)

setwd("C:/lab/")

# To see the .jpg image we have to install another package
install.packages("rgdal")
library(rgdal)


l1992 <- brick("defor1_.jpg")    # Image of 1992
l1992

# Bands: defor_.1, defor_.2, defor_.3

plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")

# defor1_.1 = NIR
