# Multi-temporal analysis of deforestation and desertification in the Congo basin (Democratic Republic of Congo) and in Sahel region

# Making sure that the packages are installed and recalling the libraries
# If the package is not installed, install it, if not, recall it
if (!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")  # Package to make beautiful graphs
if (!require("viridis")) install.packages("viridis"); library("viridis")  # Package to use different palettes for ggplots
if (!require("raster")) install.packages("raster"); library("raster")  # Package to read, write, manipulate, analyze and model spatial data
if (!require("ncdf4")) install.packages("ncdf4"); library("ncdf4")  # Package to manage files with .nc extension (from Copernicus)
if (!require("RStoolbox")) install.packages("RStoolbox"); library("RStoolbox")  # Package for quantitative estimates
if (!require("gridExtra")) install.packages("gridExtra"); library("gridExtra")  # Package to build multiframes with different graphs from ggplot2
if (!require("colorspace")) install.packages("colorspace"); library("colorspace")  # Package to use colorspace palettes
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

# Crop only the area of interest (Democratic Republic of Congo) using coordinates
# Choose the extension to crop (the first two numbers are longitude and the next numbers are latitude)
ext <- c(19.6, 28.5, -4.5, 3.5)
lai_crop <- crop(lai_stack, ext)  # Cropping the whole stack
# Let's see if the cropping was effective
plot(lai_crop$Leaf.Area.Index.1km.1)  # I can see the name computing lai_stack and looking at "names"

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
plot(LAI_2000, LAI_2020, pch = 19, maxpixels=500000, xlab="LAI_2000", ylab="LAI_2020")
# Put a y = bx + a line (where the slope (a) is 1 and the intercept (b) is 0) to better see the differences between the two years
abline(0, 1, col="red")
# Let's see the same graph from 2007 to 2014
plot(LAI_2007, LAI_2014, pch = 19, maxpixels=500000, xlab="LAI_2007", ylab="LAI_2014")
abline(0, 1, col="red")
# Let's see the same graph from 2014 to 2020
plot(LAI_2014, LAI_2020, pch = 19, maxpixels=500000, xlab="LAI_2014", ylab="LAI_2020")
abline(0, 1, col="red")
# Maybe the loss of vegetation in 2014 could be explained by forest fires (or other factors)
# Export
png("outputs/LAI_scatterplot_1.png", res=300, width=1500, height=1500)
plot(LAI_2000, LAI_2020, pch = 19, maxpixels=500000, xlab="LAI_2000", ylab="LAI_2020")
abline(0, 1, col="red")
dev.off()
png("outputs/LAI_scatterplot_2.png", res=300, width=1500, height=1500)
plot(LAI_2007, LAI_2014, pch = 19, maxpixels=500000, xlab="LAI_2007", ylab="LAI_2014")
abline(0, 1, col="red")
dev.off()
png("outputs/LAI_scatterplot_3.png", res=300, width=1500, height=1500)
plot(LAI_2014, LAI_2020, pch = 19, maxpixels=500000, xlab="LAI_2014", ylab="LAI_2020")
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

png("outputs/LAI_diff_1.png", res = 300, width = 4000, height = 2500)
plot(LAI_dif4, col = cl, main="LAI difference 2000-2020", colNA = "light blue") 
dev.off()



########### FAPAR ###########

# FAPAR is useful to estimate the green and alive elements of the canopy
# It's less precise than LAI to visualize differences in vegetation cover

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

# Assign a name to each year
names(fapar_crop) <- c("FAPAR_2000", "FAPAR_2007", "FAPAR_2014", "FAPAR_2020")  

# Now compute the difference between the images
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

png("outputs/FAPAR_diff_1.png", res = 300, width = 4000, height = 2500)
plot(FAPAR_dif4, col = cl, main="FAPAR difference 2000-2020", colNA = "light blue") 
dev.off()



########### Quantitative analysis ###########

# Zoom on the more deforested areas as shown by the LAI and FAPAR qualitative analysis (Congo basin)
ext2 <- c(19.0, 23.6, 0.71, 3.84)
lai_crop2 <- lapply(lai_raster, crop, ext2)
lai_crop2

# Since I'm using only three images it's not very useful to create a stack, I can use the function names() instead
names(lai_crop2) <- c("LAI_2000", "LAI_2007", "LAI_2014", "LAI_2020")
LAI2000_crop <- lai_crop2$LAI_2000
LAI2014_crop <- lai_crop2$LAI_2014
LAI2020_crop <- lai_crop2$LAI_2020

# Compute the differences between 2000, 2014 and 2020 in the cropped area
par(mfrow = c(2,2))
LAI_dif_crop1 <- LAI2020_crop - LAI2000_crop # Positive values are those in which LAI was higher in 2020 (green), while negatives were higher in 2000 (red)
plot(LAI_dif_crop1, col = cl, main="LAI difference 2000-2020", colNA = "light blue")
LAI_dif_crop2 <- LAI2014_crop - LAI2000_crop
plot(LAI_dif_crop2, col = cl, main="LAI difference 2000-2014", colNA = "light blue")
LAI_dif_crop3 <- LAI2020_crop - LAI2014_crop 
plot(LAI_dif_crop3, col = cl, main="LAI difference 2014-2020", colNA = "light blue")
# Export
png("outputs/LAI_diff_crop.png", res = 300, width = 4000, height = 2500)
par(mfrow = c(2,2))
plot(LAI_dif_crop1, col = cl, main="LAI difference 2000-2020", colNA = "light blue")
plot(LAI_dif_crop2, col = cl, main="LAI difference 2000-2014", colNA = "light blue")
plot(LAI_dif_crop3, col = cl, main="LAI difference 2014-2020", colNA = "light blue")
dev.off()

# Analyse the frequency distribution of LAI values
par(mfrow=c(1,3))
hist(LAI2000_crop,  main = "Frequency distribution in 2000", ylim = c(0, 55000), xlim = c(0, 7), xlab = "LAI 2000")
hist(LAI2014_crop,  main = "Frequency distribution in 2014", ylim = c(0, 55000), xlim = c(0, 7), xlab = "LAI 2014")
hist(LAI2020_crop,  main = "Frequency distribution in 2020", ylim = c(0, 55000), xlim = c(0, 7), xlab = "LAI 2020")
# In 2020, compared with 2000, we can see a decrease in frequency of the highest LAI values, while there's an increase in the lowest values
# Export
png("outputs/LAI_crop_hist.png", res=300, width=3000, height=3000)
par(mfrow=c(1,2))
hist(LAI2000_crop, col="green", main="Frequency distribution in 2000", ylim=c(0, 55000), xlim=c(0, 7), xlab="LAI 2000")
hist(LAI2020_crop, col="green", main="Frequency distribution in 2020", ylim=c(0, 55000), xlim=c(0, 7), xlab="LAI 2020")
dev.off()

# Estimate the changes in LAI in time 
# From the difference images it may seem that in 2020 there's more vegetation than in 2000, but is it high vegetation (forest) or low vegetation (croplands)?
# Use classification to divide the pixels of the image into 2 classes (high vegetation and low vegetation)
# Use the library RStoolbox
lai_class <- lapply(lai_crop2, unsuperClass, nClasses = 2)
plot(lai_class[[1]]$map) # In this case class 1 is white, that is high vegetation, and class 2 is green, that is low vegetation and water
# Frequencies of the pixels
freq(lai_class[[1]]$map) # High vegetation (class 1) = 141735 pixels # Low vegetation and water (class 2) = 39381 pixels # 2000
freq(lai_class[[3]]$map) # 2014
freq(lai_class[[4]]$map) # 2020
# The sum of the pixels is the same for every image
# freq(lai_class[[1]]$map)
#      value  count
# [1,]     1 141735
# [2,]     2  39381
total <- length(lai_class[[1]]$map)  # 181116 pixels

prop1 <- freq(lai_class[[1]]$map) / total * 100  # 78.26% of high vegetation, 21.74% of low vegetation
prop2 <- freq(lai_class[[3]]$map) / total * 100  # 83.51% of high vegetation, 16.49% of low vegetation
prop3 <- freq(lai_class[[4]]$map) / total * 100  # 77.99% of high vegetation, 22.01% of low vegetation

# Building a dataframe in order to plot
cover <- c("High vegetation", "Low vegetation")
# Year 2000
percent2000 <- c(78.26, 21.74)
prop2000 <- data.frame(cover, percent2000)
cover2000 <- ggplot(prop2000, aes(x=cover, y=percent2000, fill=cover)) + geom_bar(stat="identity") + ylim(0,100) + labs(title="Vegetation cover proportion in 2000") +
geom_text(aes(label=percent2000), vjust=1.6, color="white", size=3.5) + theme_minimal() + labs(y="Percentage of vegetation cover", x="Cover type") +
theme(plot.title = element_text(hjust = 0.5))
# Year 2014
percent2014 <- c(83.51, 16.49)
prop2014 <- data.frame(cover, percent2014)
cover2014 <- ggplot(prop2014, aes(x=cover, y=percent2014, fill=cover)) + geom_bar(stat="identity") + ylim(0,100) + labs(title="Vegetation cover proportion in 2014") +
geom_text(aes(label=percent2014), vjust=1.6, color="white", size=3.5) + theme_minimal() + labs(y="Percentage of vegetation cover", x="Cover type") +
theme(plot.title = element_text(hjust = 0.5))
# Year 2020
percent2020 <- c(77.99, 22.01)
prop2020 <- data.frame(cover, percent2020)
cover2020 <- ggplot(prop2020, aes(x=cover, y=percent2020, fill=cover)) + geom_bar(stat="identity") + ylim(0,100) + labs(title="Vegetation cover proportion in 2020") +
geom_text(aes(label=percent2020), vjust=1.6, color="white", size=3.5) + theme_minimal() + labs(y="Percentage of vegetation cover", x="Cover type") +
theme(plot.title = element_text(hjust = 0.5))

# 2000 and 2020 together
grid.arrange(cover2000, cover2020, nrow=1)  # In 2020 there's an increase in low vegetation, as we saw in the histogram where low LAI values were higher
# 2000 and 2014 together
grid.arrange(cover2000, cover2014, nrow=1)

# Export
png("outputs/proportions_1.png", res=300, width=3000, height=1500)
grid.arrange(cover2000, cover2020, nrow=1)
dev.off()
png("outputs/proportions_2.png", res=300, width=3000, height=1500)
grid.arrange(cover2000, cover2014, nrow=1)
dev.off()

# Put all the percentages in a data frame
table <- data.frame(cover, percent2000, percent2014, percent2020)


# Sum the differences in LAI and FAPAR and plot it
sum_diff <- LAI_dif4 + FAPAR_dif4
plot(sum_diff, col = cl, main="LAI + FAPAR difference 2000-2020", colNA = "light blue") 




########### NDVI ###########

# NDVI can be used to assess whether the area contain live green vegetation
# NDVI = (REF_nir – REF_red)/(REF_nir + REF_red)

# Import data and apply the raster function 
ndvi_list <- list.files(pattern = "NDVI")
ndvi_list
ndvi_raster <- lapply(ndvi_list, raster)
ndvi_raster
ndvi_stack <- stack(ndvi_raster)
ndvi_stack

# Check for background values with the click() function
click(ndvi_stack$Normalized.Difference.Vegetation.Index.1km.1, n= Inf , id=FALSE, xy =FALSE, cell =FALSE, type ="n", show=TRUE)
# These soil background pixels are a disturbing factor in the analysis
# Transform background values of the whole stack into NAs
ndvi_stack_def <- calc(ndvi_stack, fun=function(x){x[x>0.935] <- NA;return(x)})

# Cropping on Democratic Republic of Congo
ndvi_crop <- crop(ndvi_stack_def, ext)
plot(ndvi_crop)

# Use ggRGB to plot the image with the different years in the RGB channels
# Where there are higher values the image takes the red, green or blue color according to the year assigned to each channel
# In this way we can understand where and in which year there were higher values of NDVI
# In the red channel is the year 2000, in the blue channel is 2014 and in the green channel is 2020
ggRGB(ndvi_crop, r=1, g=4, b=3, stretch="Lin") 

NDVI_2000 <- ndvi_crop$Normalized.Difference.Vegetation.Index.1km.1
NDVI_2007 <- ndvi_crop$Normalized.Difference.Vegetation.Index.1km.2
NDVI_2014 <- ndvi_crop$Normalized.Difference.Vegetation.Index.1km.3
NDVI_2020 <- ndvi_crop$Normalized.Difference.Vegetation.Index.1km.4

# Check for background values with the click() function
click(NDVI_2000, n= Inf , id=FALSE, xy =FALSE, cell =FALSE, type ="n", show=TRUE)
# These soil background pixels are a disturbing factor in the analysis
# Transform background values into NAs
NDVI_2000_def <- calc(NDVI_2000, fun=function(x){x[x>0.935] <- NA;return(x)})
NDVI_2014_def <- calc(NDVI_2014, fun=function(x){x[x>0.935] <- NA;return(x)})
NDVI_2014_def <- calc(NDVI_2020, fun=function(x){x[x>0.935] <- NA;return(x)})

r <- NDVI_2000_def <- calc(NDVI_2000, fun=function(x){x[x>0.935] <- NA;return(x)})
b <- NDVI_2014_def <- calc(NDVI_2014, fun=function(x){x[x>0.935] <- NA;return(x)})
g <- NDVI_2014_def <- calc(NDVI_2020, fun=function(x){x[x>0.935] <- NA;return(x)})

ggRGB(ndvi_crop, r=r, g=g, b=b, stretch="Lin") 














