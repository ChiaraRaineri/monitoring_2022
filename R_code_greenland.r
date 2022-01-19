# Ice melt in Greenland
# Proxy: LST  (land surface temperature). It is a measurement of temperature at a surface level (not the air temperature)

library(raster)
library(ggplot2)
library(RStoolbox)
library(patchwork)
library(viridis)
# install.packages("rasterVis")

setwd("C:/lab/greenland")  # I created a new folder called greenland iside the lab folder

# Importing the data
rlist <- list.files(pattern="lst")
rlist  # These are single layers, so I am using the raster function
import <- lapply(rlist,raster)
import  # They are 16 bits images
TGr <- stack(import)  # TGr means Temperature of Greenland
TGr  

# Let's plot the whole stack
cl <- colorRampPalette(c("blue","light blue","pink","yellow"))(100)
plot(TGr, col=cl)


# ggplot of first image vs last image (2000 vs. 2015)
# The names of the images are lst_2000 and lst_2015
p1 <- ggplot() + 
geom_raster(TGr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2000")

p2 <- ggplot() + 
geom_raster(TGr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2015")

p1 + p2  # I can compare the loss of ice in time


# Plotting frequency distributions of data with histograms
# First, the 2000 and 2015 images
par(mfrow=c(1,2))  # 1 row and 2 columns
hist(TGr$lst_2000)  # This is an almost even distribution
hist(TGr$lst_2015)  # Here, there are two peaks, one in the very low temperatures and the other in the very high temperatures

# Now, let's plot all the images altogether
par(mfrow=c(2,2))  # 2 rows and 2 columns
hist(TGr$lst_2000)
hist(TGr$lst_2005)
hist(TGr$lst_2010)  # From here start the two peaks
hist(TGr$lst_2015)

dev.off()  # To remove the par()

# Let's make a plot to compare the values of the 2010 image with the 2015 image
# I use xlim and ylim so the line could start from 0 (I look at the graph and then see the values corresponding to the 0)
plot(TGr$lst_2010, TGr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))

# This function create a straight line in the graph. I should put the intercept and the slope of the line
# y = bx + a (b is intercept, a is slope). In this case the values of one variable are the same of the other, so the slope (a) is 1 and the intercept (b) is 0
abline(0, 1, col="red")  # ab stands for what to put first (a, b, col=...)

# If the values are on top of the red line, they are higher in 2015 than in 2010 (the lowest temperatures are higher in 2015 than in 2010)
# There is a rise in the lowest temperatures!


# Making a plot with all histograms and regressions for all the variables
par(mfrow=c(4,4))
hist(TGr$lst_2000)
hist(TGr$lst_2005)
hist(TGr$lst_2010)
hist(TGr$lst_2015)

plot(TGr$lst_2010, TGr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(TGr$lst_2000, TGr$lst_2005, xlim=c(12500, 15000), ylim=c(12500, 15000))
# .....

# To avoid doing this boring operation I can use directly the function pairs()
# The function pairs creates scatterplot matrices, that is a matrix of several plots
# I am able do this because I made a stack before
pairs(TGr)

# I have 4 histograms for I have 4 variables
# Then I have n(n-1)/2 graphs (in this case 6) for the comparisons
# Then I have coefficients (?)
