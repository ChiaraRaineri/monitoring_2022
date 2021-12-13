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


# Day 2 (it's the same lesson as before)

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("C:/lab/")

rlist <- list.files(pattern="defor")
rlist

list_rast <- lapply(rlist, brick)
list_rast

l1992 <- list_rast[[1]]
l2006 <- list_rast[[2]]

plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

l1992c <- unsuperClass(l1992, nClasses=2)
l1992c

plot(l1992c$map)
freq(l1992c$map)

total <- 34944 + 306348
propagri <- 306348 / total 
propforest <- 34944 / total 
# [1,] forest
# [2,] agriculture

cover <- c("Forest", "Agriculture")
prop1992 <- c(propforest, propagri)
proportion1992 <- data.frame(cover, prop1992)

#### 

l2006c <- unsuperClass(l2006, nClasses=2)
l2006c

plot(l2006c$map)
freq(l2006c$map)

total2006 <- 179335 + 163391
propagri2006 <- 163391 / total2006
propforest2006 <- 179335 / total2006 
# [1,] forest
# [2,] agriculture

cover <- c("Forest", "Agriculture")
prop2006 <- c(propforest2006, propagri2006)

proportion2006 <- data.frame(cover, prop2006)

# Plotting altogether

p1 <- ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)
p2 <- ggplot(proportion2006, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)

proportion <- data.frame(cover, prop1992, prop2006)
proportion
grid.arrange(p1, p2, nrow=1)


# Day 3

install.packages("patchwork")
library(patchwork)

# With this package we can plot multiple graphs, just like we did before

p1 + p2   # The graphs are one beside the other
p1/p2   # The graphs are one on top of the other

# This package work also with images (raster data), but we need to have ggplot2

# Instead of using plotRGB we are going to use ggRGB
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")

ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
ggRGB(l1992, r=1, g=2, b=3, stretch="hist")
ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")
ggRGB(l1992, r=1, g=2, b=3, stretch="log")   # In R log is natural log

gp1 <- ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
gp2 <- ggRGB(l1992, r=1, g=2, b=3, stretch="hist")
gp3 <- ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")
gp4 <- ggRGB(l1992, r=1, g=2, b=3, stretch="log")
gp1 + gp2 + gp3 + gp4

# Multitemporal patchwork
gp1 <- ggRGB(l1992, r=1, g=2, b=3)
gp5 <- ggRGB(l2006, r=1, g=2, b=3)
gp1 + gp5
gp1 / gp5







