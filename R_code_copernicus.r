# R code for uploading and visualizing Copernicus data in R

library(ncdf4)
library(raster)
setwd("C:/lab/copernicus")

snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
snow20211214

plot(snow20211214)


