# R code for chemical cycling study
# Time series of NO2 changes in Europe during the lockdown (I want to see if there were changes in NO2 during the lockdown)
# Importing the data from January to March 2020
# I'll use sentinel data that have already been analyzed


library(raster)  # Recalling the raster package
setwd("C:/lab/en")  # Setting the working directory. This time I created a new folder inside lab so I can import the data altogether


# Importing data
# I could use the brick function, but that was useful for importing one image with different layers
# Now that I have several files with just one layer, I'd better use the raster() function, which import every layer one after the other
# The raster function create a RasterLayer object
# To use this function I need the raster library
en01 <- raster("EN_0001.png")  # Now, I have imported just the first image
en01
# The range of these data (min and max values) is from 0 to 255, i.e. 8 bits (2^8) 
# this is a very common range. It is called 8 bit file

# Let's plot this image
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)  # The maximum pollution is in yellow (it is the color that catches the eye more)
plot(en01, col=cl)


# Let's import and plot the last image, that is at the end of March 2020
en13 <- raster("EN_0013.png")
plot(en13, col=cl)


# Building a multiframe window for the two images with 2 rows and 1 column
# I should use the par() function
par(mfrow=c(2,1))
plot(en01, col=cl)
plot(en13, col=cl)


# Importing all the images manually (this is long and boring!)
en02 <- raster("EN_0002.png")
en03 <- raster("EN_0003.png")
en04 <- raster("EN_0004.png")
en05 <- raster("EN_0005.png")
en06 <- raster("EN_0006.png")
en07 <- raster("EN_0007.png")
en08 <- raster("EN_0008.png")
en09 <- raster("EN_0009.png")
en10 <- raster("EN_0010.png")
en11 <- raster("EN_0011.png")
en12 <- raster("EN_0012.png")

# Plot all the data together (also long and boring!)
par(mfrow=c(4,4))
plot(en01, col=cl)
plot(en02, col=cl)
plot(en03, col=cl)
plot(en04, col=cl)
plot(en05, col=cl)
plot(en06, col=cl)
plot(en07, col=cl)
plot(en08, col=cl)
plot(en09, col=cl)
plot(en10, col=cl)
plot(en11, col=cl)
plot(en12, col=cl)
plot(en13, col=cl)

# To avoid doing it manually using the function stack
EN <- stack(en01, en02, en03, en04, en05, en06, en07, en08, en09, en10, en11, en12, en13)

# Plot the stack altogether
plot(EN, col=cl)

# Plot only the first image of the stack
# Check the name inside the stack (type EN)
plot(EN$EN_0001, col=cl)

# Let's plot an RGB space
# In red we put the first image, in g the 7th and in b the 13th
plotRGB(EN, r=1, g=7, b=13, stretch="lin")



# Day 2

library(raster)
setwd("C:/lab/en")

# Importing all the data together with the lapply function
# Writing "EN" means list all the files with the same name, i.e. EN
rlist <- list.files(pattern="EN")
rlist

list_rast <- lapply(rlist, raster)
list_rast

EN_stack <- stack(list_rast)
EN_stack

cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(EN_stack, col=cl)

# Plot only the first image of the stack
plot(EN_stack$EN_0001, col=cl)

# Difference between the first picure and the thirteen one
ENdif <- EN_stack$EN_0001 - EN_stack$EN_0013
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(ENdif, col=cldif)

# Let's use the automated processing source function
# It is used to avoid copy pasting the code on an external file (like a shared one)
source("R_code_automatic_script.txt")
