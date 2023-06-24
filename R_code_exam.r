# Making sure that the packages are installed and recalling the libraries
# If the package is not installed, install it, if not, recall it
if (!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if (!require("viridis")) install.packages("viridis"); library("viridis")
if (!require("raster")) install.packages("raster"); library("raster")
if (!require("ncdf4")) install.packages("ncdf4"); library("ncdf4")
if (!require("RStoolbox")) install.packages("RStoolbox"); library("RStoolbox")
if (!require("gridExtra")) install.packages("gridExtra"); library("gridExtra")
if (!require("patchwork")) install.packages("patchwork"); library("patchwork")  # Forse puoi usare solo una tra gridExtra e patchwork!

# Puoi provare a usare i packages RColorBrewer e colorspace



# Setting the working directory
setwd("C:/lab/exam")

# Tutti i commenti in inglese sono da modificare

# se usi le immagini da landsat con più layers usa la funzione brick (R_code_quantitative_estimates_land_cover.r)
# se invece le immagini sono single layer (copernicus) usa la funzione raster

# Importing the data using the lapply function
# First, let's make a list with the files available and with a common pattern (in this case it's defor)
landsat_2004 <- list.files(pattern = "20040801")
landsat_2004
img <- stack(landsat_2004)
plotRGB(img, r=3, g=2, b=1, stretch="Lin")

l2004_stack <- lapply(landsat_2004, stack)
l2004_stack
l2004_brick <- lapply(l2004_stack, brick)
l2004_brick
plotRGB(l2004_brick, r=3, g=2, b=1, stretch="Lin")


# With lapply function, I am applying the function brick to the whole list
# I am using the brick function because I have images with more layers
l2004_raster <- lapply(landsat_2004, raster)
l2004_raster




# RGB is the basic color scheme used in devices. I should march the bands B1, B2, B3 with the correspondent color
# plotRGB() is a function in the raster package
# Inside of that function I put the RasterBrick object, in r I put the band in the red channel, g is for the green channel and b is for the blue channel
# In the stretch argument I state how I want to stretch the data to see the colors better
plotRGB(l2004_brick, r=3, g=2, b=1, stretch="Lin")  # This is a natural color image

plotRGB(l2004_brick, r=band3, g=band2, b=band1, stretch="Lin")





blue = raster("LT05_L2SP_193028_20040801_20200903_02_T1_SR_B2.TIF")
green = raster("LT05_L2SP_193028_20040801_20200903_02_T1_SR_B3.TIF")
red = raster("LT05_L2SP_193028_20040801_20200903_02_T1_SR_B4.TIF")

rgb <- stack(red, green, blue)

plotRGB(rgb, r=3, g=2, b=1, scale=65535)






####


landsat_2017 <- list.files(pattern = "20170805")
img <- lapply(landsat_2017, stack)
plotRGB(img, r=3, g=2, b=1, stretch="Lin")



l2017_raster <- lapply(landsat_2017, raster)
l2017_stack <- lapply(l2017_raster, stack)
plotRGB(l2017_stack, scale=65535)



