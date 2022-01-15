# R code for estimating energy in ecosystems
# How much energy is available for other organisms

# As I learned in the last lessons, first of all I need to recall the library raster, that allows me to see satellite images
# install.packages("raster")
library(raster)
# Then, another thing I can't forget is to set the working directory, in this case the lab folder
setwd("C:/lab/")

# To see the .jpg image we have to install another package
install.packages("rgdal")
library(rgdal)


l1992 <- brick("defor1_.jpg")    # Image of 1992
l1992

# Bands: defor_.1, defor_.2, defor_.3

plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")

# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green


# day 2

l2006 <- brick("defor2_.jpg")

# Water become black when there is a complete absorption (pure water) because water absorb all the NIR
# When water is white it means that there is suspended soil in it

plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

# DVI is Different Vegetation Index
# it is calculated by the reflectance in the NIR (higher value) minus the reflectance in the red (lower value, because there is more absorption)
# DVI is equal to create a new layer (NIR-red)

# Let's calculate energy in 1992
# If there are other plottings I have to use dev.off()
dvi1992 <- l1992$defor1_.1 - l1992$defor1_.2
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
plot(dvi1992, col=cl)

# Let's calculate energy in 2006
dvi2006 <- l2006$defor2_.1 - l2006$defor2_.2

par(mfrow=c(2,1))
plot(dvi2006, col=cl)
plot(dvi1992, col=cl)

# The yellow parts indicate the spots in which energy is lost

# Differencing two images of energy in two different times
dvidif <- dvi1992 - dvi2006
cld <- colorRampPalette(c("blue", "white", "red"))(100)
plot(dvidif, col=cld)

# Final plot: original images, dvis, dvi difference
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)

# The function pdf() stores the plot in a pdf
pdf("energy.pdf")
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()

pdf("dvi.pdf")
par(mfrow=c(3,1))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()
