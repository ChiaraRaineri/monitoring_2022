# Multi-temporal analysis of deforestation and desertification in Nigeria

# Making sure that the packages are installed and recalling the libraries
# If the package is not installed, install it, if not, recall it
if (!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")  # Package to make beautiful graphs
if (!require("viridis")) install.packages("viridis"); library("viridis")  # Package to use different palettes for ggplots
if (!require("raster")) install.packages("raster"); library("raster")  # Package to read, write, manipulate, analyze and model spatial data
if (!require("ncdf4")) install.packages("ncdf4"); library("ncdf4")  # Package to manage files with .nc extension (from Copernicus)
if (!require("RStoolbox")) install.packages("RStoolbox"); library("RStoolbox")  # Package for quantitative estimates
if (!require("gridExtra")) install.packages("gridExtra"); library("gridExtra")  # Package to build multiframes with different graphs from ggplot2
if (!require("colorspace")) install.packages("colorspace"); library("colorspace")
# if (!require("patchwork")) install.packages("patchwork"); library("patchwork")  # Package to build multiframes


# Setting the working directory
setwd("C:/lab/exam")


# I'll make use of 3 sets of data from Copernicus Global Land Service related to different vegetation indeces:
# 1) LAI (Leaf Area Index)
# 2) FAPAR (Fraction of Absorbed Photosynthetically Active Radiation) 
# 3) NDVI (Normalized Difference Vegetation Index)

# The multi-temporal analysis is based on the data from the month of June of the years 2000, 2007, 2014 and 2020
# In particular, comparisons between the year 2000 and the year 2020 are made


########### LAI ###########

# LAI is useful to see the extent of the vegetation cover in particular for forests, and we can use it to estimate the entity of deforestation

# Make a list with the available files using a common pattern between all of them
lai_list <- list.files(pattern = "LAI")
lai_list
# Use the lapply function to import the data altogether and to apply the function raster to the whole list
# I use the function raster because these data are all single-layer
lai_raster <- lapply(lai_list, raster)
lai_raster
# Put all the data in a stack
lai_stack <- stack(lai_raster)
lai_stack

# Crop only the area of interest (Nigeria) using coordinates
# Choose the extension to crop (the first two numbers are longitude and the next numbers are latitude)
ext <- c(2.3, 14.9, 3.8, 14.3)
lai_crop <- crop(lai_stack, ext)  # Cropping the whole stack
# Let's see if the cropping was effective
plot(lai_crop$Leaf.Area.Index.1km.1)  # I can see the name computing lai_stack and looking at "names"
# I can see the whole Nigeria and a little bit of Cameroon in the bottom right corner

# Because I cropped all the data together with the same extent I should assign a name to each file
LAI_2000 <- lai_crop$Leaf.Area.Index.1km.1
LAI_2007 <- lai_crop$Leaf.Area.Index.1km.2
LAI_2014 <- lai_crop$Leaf.Area.Index.1km.3
LAI_2020 <- lai_crop$Leaf.Area.Index.1km.4

# Let's do a ggplot with the palette "viridis", making the graphs as clean and pleasing as possible
p2000_lai <- ggplot() + geom_raster(LAI_2000, mapping = aes(x=x, y=y, fill=Leaf.Area.Index.1km.1)) + coord_fixed(ratio = 1) +
scale_fill_viridis() + theme_bw() + ggtitle("LAI in 2000") + labs(fill="LAI") +
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p2007_lai <- ggplot() + geom_raster(LAI_2007, mapping = aes(x=x, y=y, fill=Leaf.Area.Index.1km.2)) + coord_fixed(ratio = 1) +
scale_fill_viridis() + theme_bw() + ggtitle("LAI in 2007") + labs(fill="LAI") +
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p2014_lai <- ggplot() + geom_raster(LAI_2014, mapping = aes(x=x, y=y, fill=Leaf.Area.Index.1km.3)) + coord_fixed(ratio = 1) +
scale_fill_viridis() + theme_bw() + ggtitle("LAI in 2014") + labs(fill="LAI") +
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p2020_lai <- ggplot() + geom_raster(LAI_2020, mapping = aes(x=x, y=y, fill=Leaf.Area.Index.1km.4)) + coord_fixed(ratio = 1) +
scale_fill_viridis() + theme_bw() + ggtitle("LAI in 2020") + labs(fill="LAI") +
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
# Put the plots in a multiframe
grid.arrange(p2000_lai, p2007_lai, p2014_lai, p2020_lai, nrow=2)

# The small bell-shaped patch on the left is Old Oyo National park
# In the top right corner we can see Lake Chad

# Export the multiframe
png("outputs/LAI_all_plots.png", res = 300, width = 4000, height = 2500)
grid.arrange(p2000_lai, p2007_lai, p2014_lai, p2020_lai, nrow=2)
dev.off()

# Use the function pairs() to build a plot matrix consisting of scatterplots for each variable-combination of the data frame
names(lai_crop) <- c("LAI_2000", "LAI_2007", "LAI_2014", "LAI_2020")  # Assign a name to each year
pairs(lai_crop)
# Export
png("outputs/LAI_pairs.png", res=300, width=3000, height=3000)
pairs(lai_crop)
dev.off()

# Let's see the differences in LAI between the year 2000 and the year 2020
# This scatterplot is also present in the matrix (bottom left corner)
plot(LAI_2000, LAI_2020, pch = 19, maxpixels=800000, xlab="LAI_2000", ylab="LAI_2020")
# Put a y = bx + a line (where the slope (a) is 1 and the intercept (b) is 0) to better see the differences between the two years
abline(0, 1, col="red")
# Export
png("outputs/LAI_scatterplot_1.png", res=300, width=1500, height=1500)
plot(LAI_2000, LAI_2020, pch = 19, maxpixels=800000, xlab="LAI_2000", ylab="LAI_2020")
abline(0, 1, col="red")
dev.off()

# Now compute the difference between the images (estimate the changes in time in termn of the amount of forest which have been lost or gained)
par(mfrow = c(2,2))
cl <- diverging_hcl(5, "Red-Green")
LAI_dif1 <- LAI_2007 - LAI_2000 # Positive values are those in which LAI was higher in 2007 (green), while negatives were higher in 2000 (red)
plot(LAI_dif1, col = cl, main="LAI difference 2000-2007", colNA = "light blue")
LAI_dif2 <- LAI_2014 - LAI_2007 
plot(LAI_dif2, col = cl, main="LAI difference 2007-2014", colNA = "light blue")
LAI_dif3 <- LAI_2020 - LAI_2014 
plot(LAI_dif3, col = cl, main="LAI difference 2014-2020", colNA = "light blue")
LAI_dif4 <- LAI_2020 - LAI_2000 
plot(LAI_dif4, col = cl, main="LAI difference 2000-2020", colNA = "light blue") 

# Export
png("outputs/LAI_diff.png", res = 300, width = 4000, height = 2500)
par(mfrow = c(2,2))
plot(LAI_dif1, col = cl, main="LAI difference 2000-2007", colNA = "light blue")
plot(LAI_dif2, col = cl, main="LAI difference 2007-2014", colNA = "light blue")
plot(LAI_dif3, col = cl, main="LAI difference 2014-2020", colNA = "light blue")
plot(LAI_dif4, col = cl, main="LAI difference 2000-2020", colNA = "light blue") 
dev.off()

# Since the most relevant differences were between 2007 and 2014, let's do a scatterplot
png("outputs/LAI_scatterplot_2.png", res=300, width=1500, height=1500)
plot(LAI_2007, LAI_2014, pch = 19, maxpixels=800000, xlab="LAI_2007", ylab="LAI_2014")
abline(0, 1, col="red")
dev.off()



# Magari unsuperclass metti 3 classi




########### FAPAR ###########

# FAPAR is useful to estimate the green and alive elements of the canopy, it can be useful to estimate the extent of desertification

# Data import
fapar_list <- list.files(pattern = "FAPAR")
fapar_list
fapar_raster <- lapply(fapar_list, raster)
fapar_raster
fapar_stack <- stack(fapar_raster)
fapar_stack
# Cropping
fapar_crop <- crop(fapar_stack, ext)
FAPAR_2000 <- fapar_crop$Fraction.of.Absorbed.Photosynthetically.Active.Radiation.1km.1
FAPAR_2007 <- fapar_crop$Fraction.of.Absorbed.Photosynthetically.Active.Radiation.1km.2
FAPAR_2014 <- fapar_crop$Fraction.of.Absorbed.Photosynthetically.Active.Radiation.1km.3
FAPAR_2020 <- fapar_crop$Fraction.of.Absorbed.Photosynthetically.Active.Radiation.1km.4

# Let's do a ggplot with the palette "viridis"
p2000_fapar <- ggplot() + geom_raster(FAPAR_2000, mapping = aes(x=x, y=y, fill=Fraction.of.Absorbed.Photosynthetically.Active.Radiation.1km.1)) + coord_fixed(ratio = 1) +
scale_fill_viridis() + theme_bw() + ggtitle("FAPAR in 2000") + labs(fill="Fapar") + 
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p2007_fapar <- ggplot() + geom_raster(FAPAR_2007, mapping = aes(x=x, y=y, fill=Fraction.of.Absorbed.Photosynthetically.Active.Radiation.1km.2)) + coord_fixed(ratio = 1) +
scale_fill_viridis() + theme_bw() + ggtitle("FAPAR in 2007") + labs(fill="Fapar") +
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p2014_fapar <- ggplot() + geom_raster(FAPAR_2014, mapping = aes(x=x, y=y, fill=Fraction.of.Absorbed.Photosynthetically.Active.Radiation.1km.3)) + coord_fixed(ratio = 1) +
scale_fill_viridis() + theme_bw() + ggtitle("FAPAR in 2014") + labs(fill="Fapar") +
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p2020_fapar <- ggplot() + geom_raster(FAPAR_2020, mapping = aes(x=x, y=y, fill=Fraction.of.Absorbed.Photosynthetically.Active.Radiation.1km.4)) + coord_fixed(ratio = 1) +
scale_fill_viridis() + theme_bw() + ggtitle("FAPAR in 2020") + labs(fill="Fapar") +
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
# Put the plots in a multiframe
grid.arrange(p2000_fapar, p2007_fapar, p2014_fapar, p2020_fapar, nrow=2)
# Exporting
png("outputs/FAPAR_all_plots.png", res = 300, width = 4000, height = 2500)
grid.arrange(p2000_fapar, p2007_fapar, p2014_fapar, p2020_fapar, nrow=2)
dev.off()

# Use the function pairs() to build a plot matrix
names(fapar_crop) <- c("FAPAR_2000", "FAPAR_2007", "FAPAR_2014", "FAPAR_2020")  # Assign a name to each year
pairs(fapar_crop)
# Export
png("outputs/FAPAR_pairs.png", res=300, width=3000, height=3000)
pairs(fapar_crop)
dev.off()

# Let's see the differences in FAPAR between the year 2000 and the year 2020
plot(FAPAR_2000, FAPAR_2020, pch = 19, maxpixels=800000, xlab="FAPAR_2000", ylab="FAPAR_2020")
abline(0, 1, col="red")
# Export
png("outputs/FAPAR_scatterplot.png", res=300, width=1500, height=1500)
plot(FAPAR_2000, FAPAR_2020, pch = 19, maxpixels=800000, xlab="FAPAR_2000", ylab="FAPAR_2020")
abline(0, 1, col="red")
dev.off()

# Now compute the difference between the images
# We can see if the photosynthetic activity in the interval years was higher (green) or lower (red) than normal
# This indicator is subjected to a lot of variables, sometimes not even related to drought
par(mfrow = c(2,2))
FAPAR_dif1 <- FAPAR_2007 - FAPAR_2000 # Positive values are those in which FAPAR was higher in 2007 (green), while negatives were higher in 2000 (red)
plot(FAPAR_dif1, col = cl, main="FAPAR difference 2000-2007", colNA = "light blue")
FAPAR_dif2 <- FAPAR_2014 - FAPAR_2007 
plot(FAPAR_dif2, col = cl, main="FAPAR difference 2007-2014", colNA = "light blue")
FAPAR_dif3 <- FAPAR_2020 - FAPAR_2014 
plot(FAPAR_dif3, col = cl, main="FAPAR difference 2014-2020", colNA = "light blue")
FAPAR_dif4 <- FAPAR_2020 - FAPAR_2000 
plot(FAPAR_dif4, col = cl, main="FAPAR difference 2000-2020", colNA = "light blue") 
# Export
png("outputs/FAPAR_diff.png", res = 300, width = 4000, height = 2500)
par(mfrow = c(2,2))
plot(FAPAR_dif1, col = cl, main="FAPAR difference 2000-2007", colNA = "light blue")
plot(FAPAR_dif2, col = cl, main="FAPAR difference 2007-2014", colNA = "light blue")
plot(FAPAR_dif3, col = cl, main="FAPAR difference 2014-2020", colNA = "light blue")
plot(FAPAR_dif4, col = cl, main="FAPAR difference 2000-2020", colNA = "light blue") 
dev.off()






########### NDVI ###########


# I grafici di ggplot non mi dicono niente, meglio ggRGB (guarda code di paola e simone celebrin)

ndvi_list <- list.files(pattern = "NDVI")
ndvi_list
ndvi_raster <- lapply(ndvi_list, raster)
ndvi_raster
ndvi_stack <- stack(ndvi_raster)
ndvi_stack
# Cropping
ndvi_crop <- crop(ndvi_stack, ext)
NDVI_2000 <- ndvi_crop$Normalized.Difference.Vegetation.Index.1km.1
NDVI_2007 <- ndvi_crop$Normalized.Difference.Vegetation.Index.1km.2
NDVI_2014 <- ndvi_crop$Normalized.Difference.Vegetation.Index.1km.3
NDVI_2020 <- ndvi_crop$Normalized.Difference.Vegetation.Index.1km.4

# Let's do a ggplot with the palette "viridis"
p2000_ndvi <- ggplot() + geom_raster(NDVI_2000, mapping = aes(x=x, y=y, fill=Normalized.Difference.Vegetation.Index.1km.1)) +
scale_fill_viridis() + theme_bw() + ggtitle("NDVI in 2000") + labs(fill="NDVI") +
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p2007_ndvi <- ggplot() + geom_raster(NDVI_2007, mapping = aes(x=x, y=y, fill=Normalized.Difference.Vegetation.Index.1km.2)) +
scale_fill_viridis() + theme_bw() + ggtitle("NDVI in 2007") + labs(fill="NDVI") +
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p2014_ndvi <- ggplot() + geom_raster(NDVI_2014, mapping = aes(x=x, y=y, fill=Normalized.Difference.Vegetation.Index.1km.3)) +
scale_fill_viridis() + theme_bw() + ggtitle("NDVI in 2014") + labs(fill="NDVI") +
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p2020_ndvi <- ggplot() + geom_raster(NDVI_2020, mapping = aes(x=x, y=y, fill=Normalized.Difference.Vegetation.Index.1km.4)) +
scale_fill_viridis() + theme_bw() + ggtitle("NDVI in 2020") + labs(fill="NDVI") +
theme(plot.title = element_text(hjust = 0.5)) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
# Put the plots in a multiframe
grid.arrange(p2000_ndvi, p2007_ndvi, p2014_ndvi, p2020_ndvi, nrow=2)
# Exporting
png("outputs/NDVI_all_plots.png", res = 300, width = 4000, height = 2500)
grid.arrange(p2000_ndvi, p2007_ndvi, p2014_ndvi, p2020_ndvi, nrow=2)
dev.off()


plot(ndvi_crop)
ggRGB(ndvi_crop, r=1, g=3, b=2, stretch="Lin")























































# Choose the extension to crop (the first two numbers are longitude and the next numbers are latitude)

ext <- c(19.2, 26.4, -1.1, 3.4)



# Forse si può valutare la deforestazione dal 2000 al 2014
LAI_dif5 <- LAI_2014 - LAI_2000 
plot(LAI_dif5, col = cl, main="LAI difference 2000-2014", colNA = "light blue") 










