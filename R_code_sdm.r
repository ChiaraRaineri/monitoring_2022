# R code for species distribution modelling, namely the distribution of individuals of a population in space

# Let's install a package for species distribution modelling
# I am going to use data inside the package, so the default example data (I don't need to set the working directory)
install.packages("sdm")

library(sdm)
library(raster)  # Used for predictors
library(rgdal)  # Analysis of spacial data related to species


# Let's use the system.file() function
# It shows all of the files in a certain package (in this case sdm)
# external is the folder and the name of the file is species.shp (.shp stands for shape files)
file <- system.file("external/species.shp", package="sdm")
file  # It shows where the file is located in my PC

# Let's plot the species data (they are coordinates in space, points scattered in space)
# Let's recreating the shape file inside R (that means importing data) using the function shapefile()
# This function is exactly like the raster() function for raster files
species <- shapefile(file)
species
plot(species, pch=19, col="red")  # pch means point character


