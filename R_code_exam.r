# Making sure that the packages are installed and recalling the libraries
# If the package is not installed, install it, if not, recall it
if (!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if (!require("viridis")) install.packages("viridis"); library("viridis")
if (!require("raster")) install.packages("raster"); library("raster")
if (!require("ncdf4")) install.packages("ncdf4"); library("ncdf4")
if (!require("RStoolbox")) install.packages("RStoolbox"); library("RStoolbox")
if (!require("gridExtra")) install.packages("gridExtra"); library("gridExtra")
if (!require("patchwork")) install.packages("patchwork"); library("patchwork")  # Forse puoi usare solo una tra gridExtra e patchwork!




# Setting the working directory
setwd("C:/lab/exam")






