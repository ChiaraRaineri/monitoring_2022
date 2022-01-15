# R code for estimating energy in ecosystems
# How much energy is available for other organisms
# I'll calculate the net primary production in 1992 and in 2006 to see the differences over that period of time

# As I learned in the last lessons, first of all I need to recall the library raster, that allows me to see satellite images
# install.packages("raster")
library(raster)
# Then, another thing I can't forget is to set the working directory, in this case the lab folder
setwd("C:/lab/")

# The .jpg data I have are from Rio Peixoto (Brazil). They have been downloaded from NASA Earth Observatory
# To see the .jpg image I have to install another package called gdal
# gdal is a library for graphical data extraction. In R it is called rgdal
install.packages("rgdal")  # I put the quotes because I am exiting R
library(rgdal)  # Remember to recall it

# To import the first image, the one from 1992, I have to use the brick() function (from the raster package)
# but I also need the rgdal package
l1992 <- brick("defor1_.jpg")  
l1992  # Now I can see all the details from this image

# In the image there are 3 bands: defor1_.1, defor1_.2, defor1_.3


# Let's make an RGB plot
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")

# defor1_.1 = NIR, because I put it in the red component and everything turned red (everything that reflect a lot in this band become red)
# defor1_.2 = red
# defor1_.3 = green
# If I put the number 1 in g, it becomes green, and in b it becomes blue. With every color I can see different details
# Usually water absorb all the NIR, so it becomes blue or black. In this case water is not black because the water is turbid (it looks like bare soil)



# ---------- day 2


# Let's import the second image using the brick() function. 
# These data are from the same area, but in 2006
l2006 <- brick("defor2_.jpg")
l2006

# In the image there are 3 bands: defor2_.1, defor2_.2, defor2_.3

# Now, let's make an RGB plot of the new image
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")  # Like before, the NIR band is in the r channel, so it is defor2_.1


# Let's plot the two images together, one on top of the other (2 rows, 1 column)
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")


# Let's now calculate energy
# DVI = Difference Vegetation Index
# This index is calculated by the reflectance in the NIR (higher value) minus the reflectance in the red 
# For high reflectance in the NIR it means the vegetation is healty, the lower reflectance in red happens because vegetation absorb red wave lenght for photosynthesis
# DVI is equal to create a new layer (NIR-red) obtained by subtracting the red band to the NIR band


# Calculating energy in 1992
# I have to look at the bands' names to do the operation, so I'll run l1992
# Then I have to link together the image with the NIR and red layers by using $
dvi1992 <- l1992$defor1_.1 - l1992$defor1_.2   # dvi1992 is assigned to an algebra operation. For every pixel in the image there will be an operation

# Before plotting, let's create a ramp palette
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)  # Dark blue is the smallest value and black is the highest value
# To remove the par() function I have to use dev.off() before plotting
dev.off()
plot(dvi1992, col=cl) 


# Calculating energy in 2006
dvi2006 <- l2006$defor2_.1 - l2006$defor2_.2


# Let's plot the two images together, one on top of the other (2 rows, 1 column)
par(mfrow=c(2,1))
plot(dvi2006, col=cl)
plot(dvi1992, col=cl)

# The yellow parts indicate the spots in which energy is lost (the energy has been removed from the system), that is where vegetation was cut off
# The use of yellow is not accidental, as it is the color that immediately catch the eye (I use it to stress a key concept)


# Differencing two images of energy in two different times (let's calculate the difference between 1992's DVI and 2006's DVI)
dvidif <- dvi1992 - dvi2006

cld <- colorRampPalette(c("blue", "white", "red"))(100)  # Using a new ramp palette
plot(dvidif, col=cld)

# The red areas have a high value of difference, so they represent the parts in which energy has been completely lost
# These are the areas that turned from an high value of DVI in 1992 to a low value in 2006


# Let's make a final plot of this area with: original images, DVIs and the final DVI difference
par(mfrow=c(3,2))  # I need three rows and two columns
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)


# The function pdf() stores the plot in a pdf
# I can find the pdf file in the lab folder
pdf("energy.pdf")  # I should assign a name to my pdf
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()  # By this function I am closing the pdf file


# Just putting in a pdf the DVI plots, all one on top of the other (3 rows and 1 column)
pdf("dvi.pdf")
par(mfrow=c(3,1))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()
