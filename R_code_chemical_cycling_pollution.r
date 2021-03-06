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


# To avoid doing this manually, I should build a stack
# I am putting all my files in a RasterStack (this is how a satellite image is built)
EN <- stack(en01, en02, en03, en04, en05, en06, en07, en08, en09, en10, en11, en12, en13)  # I have to put all the images altogether in the stack() function

# Ploting the stack altogether
# I don't need par()
plot(EN, col=cl)


# Plotting only the first image of the stack
# First, I should check the original name inside the stack (type EN)
plot(EN$EN_0001, col=cl)  # I have to link the image to the stack by using $


# Let's plot an RGB space with the images inside
# I want to plot, in just one image, three different layers in time
# In the red component I put the first image, in the green the 7th and in the blue the 13th
plotRGB(EN, r=1, g=7, b=13, stretch="lin")  
# Red areas are the ones with more NO2 pollution in January, the green areas have the highest NO2 in the mid-term, and blue areas in March
# The yellow parts are those in which NO2 concentration remains constantly high



# ---------- day 2


# I want to import the data altogether, without writing them one by one
# To do this, I have to use the lapply() function
# lapply function will apply another function to a list of files

# First, I should make the list using the function list.files(), stating the images I want to import directly
# I can use a common pattern for all the images 
# In this case all the images have "EN" in their names
# Don't forget to set the working directory
rlist <- list.files(pattern="EN")  
rlist  # Now I can see a list with the original names of the images (with EN as the common pattern)

# Now, I can use the lapply function
# The second element is the function I want to apply on the list, in this case it's the raster function
list_rast <- lapply(rlist, raster)
list_rast  # Now I can see all the files that has been imported one after the other

# I want to make use of the files altogether, so I have to build a stack
EN_stack <- stack(list_rast)
EN_stack


# Let's use the stack to plot everything altogether
cl <- colorRampPalette(c('red','orange','yellow'))(100)  
plot(EN_stack, col=cl)

# I have the same results as the previous lesson, but this is the best way to obtain them

# Plotting only the first image of the stack
plot(EN_stack$EN_0001, col=cl)


# Differences between the first image and the thirteenth one
# With high values, there has been a high decrease, a higher change in time
# The red parts are those where the change is higher
ENdif <- EN_stack$EN_0001 - EN_stack$EN_0013
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(ENdif, col=cldif)



# How to use a code created by others without copy-pasting with a function that can run the script directly
# Let's use the automated processing source function 
# Let's make an example with a txt file
source("R_code_automatic_script.txt")

# For Window user: never code directly in Word or other things from Office
