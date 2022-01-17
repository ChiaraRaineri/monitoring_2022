# Let's calculate the AMOUNT of forest loss in the two images I previously used, defor1_ and defor2_
# Land cover means the cover of different land use types over the planet (e.g. the cover by forests, the cover by agriculture...)

# I have to install the RStoolbox package for quantitative estimates
install.packages("RStoolbox")
# And also the ggplot2 package to make beautiful graphs
install.packages("ggplot2")
# Another one is the gridExtra package to build multiframes with different graphs from ggplot2
install.packages("gridExtra")

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("C:/lab/")  # I have to brick the files defor1_ and defor2_ that are already in the lab folder


# Importing the data using the lapply function
# First, let's make a list with the files available and with a common pattern (in this case it's defor)
rlist <- list.files(pattern = "defor")
rlist

# With lapply function, I am applying the function brick to the whole list
# I am using the brick function because I have images with more layers
list_rast <- lapply(rlist, brick)
list_rast  # The first object is list_rast[[1]] and the second is list_rast[[2]]

# I don't need the $ symbol, the double square parenthesis are enough
plot(list_rast[[1]])
plot(list_rast[[2]])

# I am not making a stack this time because I have two different images I want to analyze separately


# Let's plot the images in RGB
# The NIR is in the 1st band, the red in the 2nd, and the green in the 3rd band
plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch="lin")
plotRGB(list_rast[[2]], r=1, g=2, b=3, stretch="lin")

# To avoid always writing list_rast[[1]] and list_rast[[2]] let's assign an object to them
l1992 <- list_rast[[1]]
l2006 <- list_rast[[2]]


# Let's estimate the changes in time in termn of the amount of forest which have been lost (from 1992 to 2006)
# How to explain to the software what pixels represent the forest?
# I have to use a remote sensing technique called classification. I can classify the image creating a new image with forest and agriculture areas
# Unsupervised classification: it means that I am stating to the software the amount of classes I want in the end
# This is the time to use the library RStoolbox

# Let's classify the 1992 image first
l1992c <- unsuperClass(l1992, nClasses=2)
l1992c  
# This object has many things inside, in this case there is only the map
# I have the dimension of the map (number of pixels)
# The minimum value correspond to class number 1 and the maximum with class number 2. One of them is forest and the other is agriculture

# Let's make a plot of the map
plot(l1992c$map)
# In this case class 1 is white, that is agricultural areas and water, and class 2 is green, that is forest
# In some cases the two color may be inverted
# The values are only 1 or 2

# Let's see the frequencies of the pixels (how many pixels inside the map are forest or agriculture areas)
freq(l1992c$map)
# Agricultural areas and water (class 1) = 33914 pixels
# Forests (class 2) = 307378 pixels

# Calculating the proportions of the two areas
total <- 341292  # Total amount of pixels
propagri <- 33914 / total  # 0.09936945 - 10%
propforest <- 307378 / total  # 0.9006305 - 90%

# Building a dataframe in order to plot
cover <- c("Forest", "Agriculture")  # This is the column for the land cover
prop1992 <- c(propforest, propagri)  # This is the column for the proportion
proportion1992 <- data.frame(cover, prop1992)
proportion1992  # These are the real proportion of forest and agriculture

# Let's use the library ggplot2 to do a nice graph
# I'll use the ggplot() function
# aes() indicates the elements that are coloring the graph
# geom_bar() is used for creating bar charts (type of graph). Identity means I am using the values as they are. The fill is the color inside the bars
ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")



# ---------- day 2
 

# Now, I can classify the 2006 image
# Unsupervised classification
l2006c <- unsuperClass(l2006, nClasses=2)
l2006c

# Let's do the same operations as before, so plotting the map and see the frequencies of the pixels
plot(l2006c$map)
# In this case the forest is also value 1 and the agriculture the value 2
freq(l2006c$map)
# Agricultural areas and water (class 1) = 163391 pixels
# Forests (class 2) = 179335 pixels

total2006 <- 179335 + 163391  # The total it's just a little different than the image before
propagri2006 <- 163391 / total2006  # 0,4767394 - 48%
propforest2006 <- 179335 / total2006  # 0,5232605 - 52%
# Notice that the percentages are dramatically different as before

# Let's build a data frame
cover <- c("Forest", "Agriculture")
prop2006 <- c(propforest2006, propagri2006)
proportion2006 <- data.frame(cover, prop2006)
proportion2006

# Just to have both of the data frames together I do another data frame
proportion <- data.frame(cover, prop1992, prop2006)
proportion

# Now, let's plot the data by making two ggplot bar charts
# ylim(0,1) is used to change the limit of the graph in the y axis (from 0 to 1)
p1 <- ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)  
p2 <- ggplot(proportion2006, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)


# Let's plot the two graphs one beside the other
# This require the use of the package gridExtra
# The grid.arrange() function put several ggplot graphs in the same multiframe
grid.arrange(p1, p2, nrow=1)  # 1 row



# ---------- day 3


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

