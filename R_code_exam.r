# Making sure that the packages are installed and recalling the libraries
# If the package is not installed, install it, if not, recall it
if (!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if (!require("viridis")) install.packages("viridis"); library("viridis")
if (!require("raster")) install.packages("raster"); library("raster")
if (!require("ncdf4")) install.packages("ncdf4"); library("ncdf4")
if (!require("RStoolbox")) install.packages("RStoolbox"); library("RStoolbox")
if (!require("gridExtra")) install.packages("gridExtra"); library("gridExtra")
if (!require("patchwork")) install.packages("patchwork"); library("patchwork")  # Forse puoi usare solo una tra gridExtra e patchwork!




# Setting the working directory
setwd("C:/lab/exam")



rlist <- list.files(pattern="BIOPAR")
rlist
list_rast <- lapply(rlist, raster)  # raster function for single layers
list_rast
stack <- stack(list_rast)  # I created a stack
stack

# Let's assign a name for every element of the stack
f1 <- stack$g2_BIOPAR_WB.WBFLAG_199909010000_H19V7_VGT_V1.4
f2 <- stack$g2_BIOPAR_WB.WB_202006210000_H0V10_PROBAV_V2.0.1


ggplot() +
geom_raster(f1, mapping = aes(x=x, y=y, fill=g2_BIOPAR_WB.WBFLAG_199909010000_H19V7_VGT_V1.4)) +
scale_fill_viridis(option="viridis") 

ext <- c(12.4, 15.8, 11.9, 14.5)  # The first two numbers are longitude and the next numbers are latitude
# Then, I'll use the crop() function
f1_cropped <- crop(f1, ext)
f2_cropped <- crop(f2, ext)

# stack_cropped <- crop(snowstack, ext)  # This will crop the whole stack, and then single variables (layers) can be extracted


# Let's plot the cropped images
p1 <- ggplot() + 
geom_raster(f1_cropped, mapping = aes(x=x, y=y, fill=g2_BIOPAR_WB.WBFLAG_199909010000_H19V7_VGT_V1.4)) +
scale_fill_viridis() 
 
p2 <- ggplot() + 
geom_raster(f2020_cropped, mapping = aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km.2)) +
scale_fill_viridis() +
ggtitle("fcover in 2020")
 
p1 + p2




