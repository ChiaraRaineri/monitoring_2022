# R code for uploading and visualizing Copernicus data in R
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

library(ncdf4)
library(raster)
setwd("C:/lab/copernicus")

# To see how many layers are in the Copernicus data
snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
snow20211214

plot(snow20211214)

cl <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(snow20211214, col=cl)

# Bad color ramp palette (color blind people can't see the difference in colors)
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
cl <- colorRampPalette(c("blue","green","red"))(100)
plot(snow20211214, col=cl)

install.packages("viridis")
library(viridis)

library(RStoolbox)
library(ggplot2)

ggplot() + geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent))
# To know what to put in fill= you can recall snow20211214 and see "names"

ggplot() + 
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis()
ggtitle("virids palette")

ggplot() + 
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis(option="cividis")
ggtitle("cividis palette")

# viridis, cividis, magma, inferno, turbo, mako, plasma, rocket

