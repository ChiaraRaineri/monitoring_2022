# R code for species distribution modelling, namely the distribution of individuals of a population in space

# Let's install a package for species distribution modelling
# I am going to use data inside the package, so the default example data (I don't need to set the working directory)
install.packages("sdm")

library(sdm)
library(raster)  # Used for predictors (environmental variables that are useful to predict the distribution of the species over space)
library(rgdal)  # Analysis of spacial data related to species (species are an array of x and y points)


# Let's use the system.file() function
# It shows all of the files in a certain package (in this case sdm)
# external is the folder and the name of the file is species.shp (.shp stands for shape files)
file <- system.file("external/species.shp", package="sdm")
file  # It shows where the file is located in my PC

# Let's plot the species data (they are coordinates in space, points scattered in space)
# Let's recreating the shape file inside R (that means importing data) using the function shapefile()
# This function is exactly like the raster() function for raster files
species <- shapefile(file)
species  # There are 200 points and there is only one variable called Occurrence. The Occurrence data are 0 or 1

species$Occurrence  # Shows all of the 200 occurrences

# How many data have occurrence 1? 
# I have to make a query using the square parenthesis
# Equal is written as == while different is written as !=
# Control symbol, it explains to the software that the query is finished. In R it is the comma at the end of the query
presences <- species[species$Occurrence == 1,]

absences <- species[species$Occurrence == 0,]

# Let's plot
# Plot all of the occurrences
plot(species, pch=19)  # pch means point character
# Plot only the presences
plot(presences, pch=19, col="blue")
# Plot the presences together with the absences (I want to add the absences to the previous plot)
# To do this I should use the points() function, that'll add other points to an extisting graph
points(absences, pch=19, col="red")


# Now, I want to calculate the probability of finding a species in a certain part of the map
# I can use many variables, called predictors, such as temperature, elevation, water availability...



