# install.packages("vegan")
library(vegan)  # It is a package for adding vegetation analysis functions to R


setwd("C:/lab/")

# The function load() is used to reload saved dataset
# Let's import a saved R code
load("biomes_multivar.RData")
ls()  # With this function I can list the names of all the objects that are present in the working directory 

# I can write an object and see the matrices inside
biomes
# With the function head() I can see only the first six data for each category
head(biomes)


# To make the multivariate analysis I should make use of the function decorana(), that is part of the vegan package
# This function performs detrended correspondence analysis and basic reciprocal averaging or orthogonal correspondence analysis
# In This case I am using the function on the biomes object
multivar <- decorana(biomes)
multivar

plot(multivar)  # Now I can see the graph with the variables together

# Let's put different colored ellipses on the graph to indicate the different biomes
# I have to use the attach() function to attach a set of R objects to Search Path
attach(biomes_types)
# I should make use of a function that allow me to add convex hulls, `spider' graphs, ellipses or cluster dendrogram to ordination diagrams
# ordiellipse() make ellipses
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
# ordispider() make spider graphs inside the ellipses
ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 


# Let's save the project as a pdf
pdf("multivar.pdf")
plot(multivar)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
ordispider(multivar, type, col=c("black","red","green","blue"), label = T) 
dev.off()
