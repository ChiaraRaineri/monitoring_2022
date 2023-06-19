# Making sure that the packages are installed and recalling the libraries
# If the package is not installed, install it, if not, recall it
if (!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if (!require("viridis")) install.packages("viridis"); library("viridis")
if (!require("raster")) install.packages("raster"); library("raster")
if (!require("ncdf4")) install.packages("ncdf4"); library("ncdf4")
if (!require("RStoolbox")) install.packages("RStoolbox"); library("RStoolbox")
if (!require("gridExtra")) install.packages("gridExtra"); library("gridExtra")
if (!require("patchwork")) install.packages("patchwork"); library("patchwork")




# Setting the working directory
setwd("C:/lab/exam")



## Code from R_code_copernicus ##

### FCOVER ###

# DENMARK IN GENERAL (data from 1 km files)

rlist <- list.files(pattern="V2")
rlist
list_rast <- lapply(rlist, raster)  # raster function for single layers
list_rast
fcoverstack <- stack(list_rast)  # I created a stack
fcoverstack

# Let's assign a name for every element of the stack
f2000 <- fcoverstack$Fraction.of.green.Vegetation.Cover.1km.1
f2020 <- fcoverstack$Fraction.of.green.Vegetation.Cover.1km.2


# ggplot() +
# geom_raster(f2000, mapping = aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km.1)) +
# scale_fill_viridis(option="viridis") +
# ggtitle("fcover in 2000 worldwide")


ext <- c(8, 11, 53, 58)  # The first two numbers are longitude and the next numbers are latitude
# Then, I'll use the crop() function
f2000_cropped <- crop(f2000, ext)
f2020_cropped <- crop(f2020, ext)

# stack_cropped <- crop(snowstack, ext)  # This will crop the whole stack, and then single variables (layers) can be extracted


# Let's plot the cropped images
p1 <- ggplot() + 
geom_raster(f2000_cropped, mapping = aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km.1)) +
scale_fill_viridis() +
ggtitle("fcover in 2000")
 
p2 <- ggplot() + 
geom_raster(f2020_cropped, mapping = aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.1km.2)) +
scale_fill_viridis() +
ggtitle("fcover in 2020")
 
p1 + p2


### 300 m images ###

rlist300 <- list.files(pattern="V1") 
rlist300
list_rast300 <- lapply(rlist300, raster)  # raster function for single layers
list_rast300
fcoverstack300 <- stack(list_rast300)  # I created a stack
fcoverstack300


f2014 <- fcoverstack300$Fraction.of.green.Vegetation.Cover.333m.2
f2023 <- fcoverstack300$Fraction.of.green.Vegetation.Cover.333m.1

ext2 <- c(8.6, 9.5, 55.6, 56)
f2014_cropped <- crop(f2014, ext2)
f2023_cropped <- crop(f2023, ext2)

p3 <- ggplot() + 
geom_raster(f2014_cropped, mapping = aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.333m.2)) +
scale_fill_viridis() +
ggtitle("fcover in 2014")
 
p4 <- ggplot() + 
geom_raster(f2023_cropped, mapping = aes(x=x, y=y, fill=Fraction.of.green.Vegetation.Cover.333m.1)) +
scale_fill_viridis() +
ggtitle("fcover in 2023")
 
p3 + p4


# quantitative analysis for all Jutland code R_code_quantitative_estimate_land_cover
# NO!!!
f2000c <- unsuperClass(f2000_cropped, nClasses=2)
f2000c
plot(f2000c$map)
freq(f2000c$map)







### NDVI ###
# NON VA BENE

# DENMARK IN GENERAL (data from 1 km files)

rlist <- list.files(pattern="NDVI")  # SCE means Snow Cover Extent
rlist
list_rast <- lapply(rlist, raster)  # raster function for single layers
list_rast
ndvistack <- stack(list_rast)  # I created a stack
ndvistack

# Let's assign a name for every element of the stack
# I am doing this just because I have only two files
n1999 <- ndvistack$Normalized.Difference.Vegetation.Index.1km.1
n2020 <- ndvistack$Normalized.Difference.Vegetation.Index.1km.2


ext <- c(8, 11, 53, 58)  # The first two numbers are longitude and the next numbers are latitude
# Then, I'll use the crop() function
n1999_cropped <- crop(n1999, ext)
n2020_cropped <- crop(n2020, ext)

# stack_cropped <- crop(snowstack, ext)  # This will crop the whole stack, and then single variables (layers) can be extracted


# Let's plot the cropped images
p1 <- ggplot() + 
geom_raster(n1999_cropped, mapping = aes(x=x, y=y, fill=Normalized.Difference.Vegetation.Index.1km.1)) +
scale_fill_viridis() +
ggtitle("ndvi in 1999")
 
p2 <- ggplot() + 
geom_raster(n2020_cropped, mapping = aes(x=x, y=y, fill=Normalized.Difference.Vegetation.Index.1km.2)) +
scale_fill_viridis() +
ggtitle("ndvi in 2020")
 
p1 + p2



ext2 <- c(8.1, 10.11, 55.4, 56.2)
n1999_cropped2 <- crop(n1999, ext2)
n2020_cropped2 <- crop(n2020, ext2)

p3 <- ggplot() + 
geom_raster(n1999_cropped2, mapping = aes(x=x, y=y, fill=Normalized.Difference.Vegetation.Index.1km.1)) +
scale_fill_viridis() +
ggtitle("fcover in 2000")
 
p4 <- ggplot() + 
geom_raster(n2020_cropped2, mapping = aes(x=x, y=y, fill=Normalized.Difference.Vegetation.Index.1km.2)) +
scale_fill_viridis() +
ggtitle("fcover in 2020")
 
p3 + p4




