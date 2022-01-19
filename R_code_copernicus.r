# R code for uploading and visualizing Copernicus data in R
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

# First, I should install the ncdf4 package to import the data
# I am using it because the data from copernicus have .nc extension
install.packages("ncdf4")

library(raster)
library(ncdf4)

setwd("C:/lab/copernicus")  # I created a new folder in the lab folder called copernicus

# To see how many layers are in the Copernicus data
# I can use the raster function because the data are single-layer
# The name of the object refers to the date of the data, so the 14th of December 2021
snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
snow20211214
# The true name of the file is Snow.Cover.Extent

# Let's plot the data directly
plot(snow20211214)



# ---------- day 2


# Let's plot with a different palette
cl <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(snow20211214, col=cl)

# This is an example of a bad color ramp palette (color blind people can't see the difference in colors)
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
cl <- colorRampPalette(c("blue","green","red"))(100)
plot(snow20211214, col=cl)


# viridis is a library from ggplot2
# Using the viridis palette I can make sure that color blind people can see the image
# There are several predefined palettes with different names
install.packages("viridis")
library(viridis)

library(RStoolbox)
library(ggplot2)
library(patchwork)


# Let's make a ggplot
# Since I am plotting a raster file I should put geom_raster
# To know what to put in fill= you can recall snow20211214 and see "names"
ggplot() + 
geom_raster(snow20211214, mapping = aes(x = x, y = y, fill = Snow.Cover.Extent)) +
scale_fill_viridis()  # The yellow is put in the maxima parts
# If i don't put anything in scale_fill_viridis() it'll plot with the default palette, that is viridis
# Let's assign it a title
ggtitle("virids palette")

# Let's plot with a different palette, in this case cividis
ggplot() + 
geom_raster(snow20211214, mapping = aes(x = x, y = y, fill = Snow.Cover.Extent)) +
scale_fill_viridis(option = "cividis")
ggtitle("cividis palette")

# These are the different color palettes that can be used: viridis, cividis, magma, inferno, turbo, mako, plasma, rocket



# ---------- day 3


# Now, I'll download another image from the same set (29th of August)

# Let's import a set of data with the lapply function
rlist <- list.files(pattern="SCE")  # SCE means Snow Cover Extent
rlist
list_rast <- lapply(rlist, raster)  # raster function for single layers
list_rast
snowstack <- stack(list_rast)  # I created a stack
snowstack

# Let's assign a name for every element of the stack
# I am doing this just because I have only two files
ssummer <- snowstack$Snow.Cover.Extent.1
swinter <- snowstack$Snow.Cover.Extent.2


# Now, I am making use to the patchwork package and the viridis package
ggplot() +
geom_raster(ssummer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during summer")

ggplot() +
geom_raster(swinter, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during winter")


# Let's patchwork them together
p1 <- ggplot() + 
geom_raster(ssummer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis() +
ggtitle("Snow cover during summer")
 
p2 <- ggplot() + 
geom_raster(swinter, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis() +
ggtitle("Snow cover during winter")
 
p1 / p2  # One on top of the other


# How to crop an image on a certain area: using coordinates
# I want to zoom in Italy
# Longitude from 0 to 20
# Latitude from 30 to 50

# First, I should put the extension I want to crop
ext <- c(0, 20, 30, 50)  # The first two numbers are longitude and the next numbers are latitude
# Then, I'll use the crop() function
ssummer_cropped <- crop(ssummer, ext)
swinter_cropped <- crop(swinter, ext)

# stack_cropped <- crop(snowstack, ext)  # This will crop the whole stack, and then single variables (layers) can be extracted


# Let's plot the cropped images
p1 <- ggplot() + 
geom_raster(ssummer_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis() +
ggtitle("Snow cover during summer in Italy")
 
p2 <- ggplot() + 
geom_raster(swinter_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis() +
ggtitle("Snow cover during winter in Italy")
 
p1 / p2

