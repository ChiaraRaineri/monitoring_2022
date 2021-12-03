library(raster)
setwd("C:/lab/")

# Importing the data

# First list the files available
rlist <- list.files(pattern = "defor")

# Then lapply: apply a function to a list
list_rast <- lapply(rlist, brick)

plot(list_rast[[1]])

# defor NIR 1, red 2, green 3
plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch="lin")

# To avoid to write always list_rast[[1]]
l1992 <- list_rast[[1]]
l2006 <- list_rast[[2]]

# Unsupervised classification
library(RStoolbox)
l1992c <- unsuperClass(l1992, nClasses=2)

plot(l1992c$map)
# Value 1 = agricultural areas and water
# Value 2 = forests

freq(l1992c$map)
# Agricultural areas and water (class 1) = 33914 pixels
# Forests (class 2) = 307378 pixels

# Calculating the proportions of the two areas
total <- 341292  # total pixels
propagri <- 33914 / total  # 0.09936945 - 10%
propforest <- 307378 / total  # 0.9006305 - 90%

# Building a dataframe
cover <- c("Forest", "Agriculture")
prop1992 <- c(0.9006305, 0.09936945)
proportion1992 <- data.frame(cover, prop1992)

library(ggplot2)

# Using ggplot function, aes is aesthetics 
# geom_bar is for bar charts
ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")









