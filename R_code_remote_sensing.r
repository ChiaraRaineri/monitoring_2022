# R code for ecosystem monitoring by remote sensing
# First of all, we need to install additional packages
# raster package to manage image data
# All'inizio del codice devi sempre mettere library(raster), setwd("C/lab/") e l2011 <- brick("p224r63_2011.grd")

install.packages("raster")

library(raster)

setwd("C:/lab/")

# We are going to import satellite data
# l2011 is for the satellite landset
# Objects cannot be numbers
l2011 <- brick("p224r63_2011.grd")

l2011

# 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
# 1499 and 2967 are the number of columns and lines, 4447533 is the number of pxels, 7 is the numbero of layers

plot(l2011)
# B1, B2... are the bands
# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band

cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(l2011, col=cl)
# (black, grey, light gray) is an array
# 100 indicates how many tones we want to have in our palette

plotRGB(l2011, r=3, g=3, b=1, stretch="Lin")

# ---------- day 2
# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band
# B4 is the reflectance in the near infra-red band

# Let's plot the green band
plot(l2011$B2_sre)

cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(l2011$B2_sre, col=cl)

# Change the colorRampPalette with dark green, green and light green
clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# Do the same for the blue band, that is called B1_sre
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

# Plot both images in just one multiframe graph (1 row and 2 columns)
par(mfrow=c(1,2))
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

