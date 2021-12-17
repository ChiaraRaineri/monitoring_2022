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


#######

rlist <- list.files(pattern="SCE")
rlist

list_rast <- lapply(rlist, raster)
list_rast

snowstack <- stack(list_rast)
snowstack

ssummer <- snowstack$Snow.Cover.Extent.1
swinter <- snowstack$Snow.Cover.Extent.2

ggplot() +
geom_raster(ssummer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during my birthday!")

ggplot() +
geom_raster(swinter, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during freezing winter!")

# Let's patchwork them together
library(patchwork)

p1 <- ggplot() + 
geom_raster(ssummer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during summer")
 
p2 <- ggplot() + 
geom_raster(swinter, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during winter")
 
p1 / p2

# Crop a image on a certain area
# Longitude from 0 to 20
# Latitude from 30 to 50

ext <- c(0, 20, 30, 50)
ssummer_cropped <- crop(ssummer, ext)
swinter_cropped <- crop(swinter, ext)

# stack_cropped <- crop(snowstack, ext) will crop the whole stack 

p1 <- ggplot() + 
geom_raster(ssummer_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during summer")
 
p2 <- ggplot() + 
geom_raster(swinter_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during winter")
 
p1 / p2

