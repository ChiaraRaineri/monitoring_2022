# Multi-temporal analysis of deforestation and desertification in Nigeria

# Making sure that the packages are installed and recalling the libraries
# If the package is not installed, install it, if not, recall it
if (!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")  # Package to make beautiful graphs
if (!require("viridis")) install.packages("viridis"); library("viridis")  # Package to use different palettes for ggplots
if (!require("raster")) install.packages("raster"); library("raster")  # Package to read, write, manipulate, analyze and model spatial data
if (!require("ncdf4")) install.packages("ncdf4"); library("ncdf4")  # Package to manage files with .nc extension (from Copernicus)
if (!require("RStoolbox")) install.packages("RStoolbox"); library("RStoolbox")  # Package for quantitative estimates
if (!require("gridExtra")) install.packages("gridExtra"); library("gridExtra")  # Package to build multiframes with different graphs from ggplot2
# if (!require("patchwork")) install.packages("patchwork"); library("patchwork")  # Forse puoi usare solo una tra gridExtra e patchwork!

# Puoi provare a usare i packages RColorBrewer e colorspace


# Setting the working directory
setwd("C:/lab/exam")


# I'll make use of 3 sets of data from Copernicus Global Land Service related to different vegetation indeces:
# 1) LAI (Leaf Area Index)
# 2) FAPAR (Fraction of Absorbed Photosynthetically Active Radiation) 
# 3) NDVI (Normalized Difference Vegetation Index)

# The multi-temporal analysis is based on the data from the month of June of the years 2000, 2007, 2014 and 2020
# In particular, comparisons between the year 2000 and the year 2020 are made


### LAI ###

# Make a list with the available files using a common pattern between all of them
lai_list <- list.files(pattern = "LAI")
lai_list
# Use the lapply function to import the data altogether and to apply the function raster to the whole list
# I use the function raster because these data are all single-layer
lai_raster <- lapply(lai_list, raster)
lai_raster
# Put all the data in a stack
lai_stack <- stack(lai_raster)
lai_stack












