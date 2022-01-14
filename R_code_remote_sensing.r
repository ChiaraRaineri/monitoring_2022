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

# Now I want the two graphs to be one on top of the other
# 2 rows and 1 column
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)



# ---------- day 3


# Let's now plot the first four bands with 2 rows and 2 columns
# I start with building a multiframe
par(mfrow=c(2,2))  # This function is important if I want to have all the graphs together in one tab. Now I need 2 rows and 2 columns

# Before plotting, let's assign each band a palette of colors
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)  # Blue band
clg <- colorRampPalette(c("dark green","green","light green"))(100)  # Green band
clr <- colorRampPalette(c("dark red", "red", "pink"))(100)  # Red band ("light red" does not exist)
clnir <- colorRampPalette(c("red", "orange", "yellow"))(100)  # Near Infra Red band (NIR). These colors are arbitrarily assigned by me

# Now that I have a multiframe and a color for each one I can plot them using their names and the palette I chose
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
plot(l2011$B3_sre, col=clr)
plot(l2011$B4_sre, col=clnir)


# I can also plot the bands altogether using the RGB function (rather than doing single band plotting choosing a color)
# Remember to recall the raster package

# First, I should clean my window using the dev.off() function (it is useful to remove the par function)
dev.off()

# In this function I have to put the satellite image (l2011) and then the different layers (red, green and blue channels with the corresponding band)
# I want also to stretch the values to see the colors better (in this case I am using a linear stretch)
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")   # This is the satellite image with its natural colors, as I am using the bands of the visible spectrum

# Now I want to extend my view to the near infra red
# I can do so by shifting from B1, B2, B3 to B2, B3, B4 and any other combinations
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")   
# Since vegetation is reflecting a lot in the NIR, the new color of vegetation in the image would be red
# This happend because I am putting the NIR component in the red channel
# So, everything that reflect a lot of NIR will become red

# I can put the NIR band in any other channel and see even more things
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")   # false colors, I can see the changes in humidity inside the vegetation
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")   # false colors, I can see better the amount of forest which has been cut (bare soil)

# Let's do a multiframe with these images
par(mfrow=c(2,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")


# The first step in monitoring ecosystems is to do an exploratory analysis to see its current situation
# Then, I have to do a multi-temporal analysis, in which I can see the changes that occur from a previous date until now
# I have the data of the same area in 1988



# ---------- day 4


# Let's see how this landscape has changed from 1988 to 2011

# Don't forget to set the working directory and to recall the raster library
# library(raster)
# setwd("C:/lab/")
# l2011 <- brick("p224r63_2011.grd")

## stretch function
# The NIR band is now in the red channel, so I'll see the vegetation red
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  # What I used until now
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")  # Histogram stretch, it enhances a lot the differences from one place to the other
##


# Now, let's import the data from 1988 using the brick() function
# For this image I have also the different bands
l1988 <- brick("p224r63_1988.grd")
l1988

# Let's compare the two different images of the same landscape by putting them one on top of the other in a multiframe
# There are many differences between the two images, mainly due to the loss of vegetation in 2011 compared with 1988
par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# For exercising, let's put the NIR in the blue channel
plotRGB(l1988, r=2, g=3, b=4, stretch="Lin")
plotRGB(l2011, r=2, g=3, b=4, stretch="Lin")

# And now in the green channel
plotRGB(l1988, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
