# R code for ecosystem monitoring by remote sensing
# First of all, we need to install additional packages
# The most useful is the raster package to manage image data


install.packages("raster")  # This is the way to download all the different packages (I am using the quotes since I am exiting R)

# At the beginning of your code don't forget to put library(raster)
library(raster)  # This is something I have to write to recall the library


# IMPORTING
# We are going to import satellite data using the function brick(), that create a RasterBrick, that is the set of multiple bands together
# The brick function can be compared with the read.table() function
# For the brick function I need to install the raster package
# Inside brick I should put the raster object I want to read (in this case it is the .grd files)
# My objective will be to compare the 2011 image with the image from 1988

# To use the function I need to set the working directory first
setwd("C:/lab/")

# The l stands for Landsat
# Objects cannot be numbers
l2011 <- brick("p224r63_2011.grd")
l2011

# After entering l2011 I have many informations
# Class: in R objects have a class. In this case it is RasterBrick
# Dimensions: the third value is the number of pixels in just one band. In this case I have 7 bands
# Resolution: each pixels is 30 m x 30 m
# Source: the data in my PC
# Names: it is the names of the bands
# min and max: the reflectance range from 0 to 1 (1 is the maximum reflectance in a certain place)


# Let's plot all of the data set
plot(l2011)

# The first three bands are the three visible channels: blue, green, red
# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band

# The bands are seen in the default colors, let's change it
# c("black", "grey", "light gray") is an array 
# 100 indicates how many tones I want to have in my palette (there are 100 colors from black to light gray)
cl <- colorRampPalette(c("black","grey","light grey"))(100)  
plot(l2011, col=cl)


# RGB is the basic color scheme used in devices. I should march the bands B1, B2, B3 with the correspondent color
# plotRGB() is a function in the raster package
# Inside of that function I put the RasterBrick object, in r I put the band in the red channel, g is for the green channel and b is for the blue channel
# In the stretch argument I state how I want to stretch the data to see the colors better
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")  # This is a natural color image



# ---------- day 2


# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band
# B4 is the reflectance in the near infra-red band

# Let's plot every single band


# Plot only the green band, that is B2
# I can find the name of the band (B2_sre) by running l2011, under the section names
# I am linking the band with the satellite image using the symbol $
plot(l2011$B2_sre)

# Let's change the color scheme with black, grey and light grey
# Everything which is absorbing the green wavelenght is now black, while the higher reflectance is in the white part
cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(l2011$B2_sre, col=cl)

# Now, let's change the colorRampPalette with dark green, green and light green
# The dark green parts are not reflecting in the green band, while the light green parts are reflecting in the green band
clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)


# Let's do the same for the blue band, that is called B1_sre
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)


# I want the two images i plotted to be one beside the other (I want to create a multiframe, mf)
# This is achieved with the par() function, that can be used to make any changes in a graph
# Plot both images in just one multiframe graph (1 row and 2 columns)
par(mfrow=c(1,2))  # Because it is mfrow, the first number in the parenthesis is the number of rows and the second one is the number of columns
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# 2 rows and 1 column
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)



# ---------- day 3


# Plot the first four bands with 2 rows and 2 columns

par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)

clg <- colorRampPalette(c("dark green","green","light green"))(100)

clr <- colorRampPalette(c("dark red", "red", "pink"))(100)

clnir <- colorRampPalette(c("red", "orange", "yellow"))(100)

plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
plot(l2011$B3_sre, col=clr)
plot(l2011$B4_sre, col=clnir)

# Let's plot in RGB
dev.off()

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")   # natural colors

# Now let's see the NIR, shifting from B1, B2, B3 to B2, B3, B4 and other combinations
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")   # false colors
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")   # false colors
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")   # false colors

par(mfrow=c(2,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")


# Final day on this tropical forest reserve

plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Importing past data
l1988 <- brick("p224r63_1988.grd")

par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# Put the NIR in the blue channel
par(mfrow=c(2,1))
plotRGB(l1988, r=2, g=3, b=4, stretch="Lin")
plotRGB(l2011, r=2, g=3, b=4, stretch="Lin")

