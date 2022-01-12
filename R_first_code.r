# About the name of the code: spaces must always be protected with a symbol (in our case is _ )
# .r is the extension for all the scripts in R


# This is my first code in GitHub!

# First I have to store my data into something, so I create an array
# Arrays are the R data objects which can store data in more than two dimensions, they are structured like this: c(1, 2, 3) because they are a series of characters
# the arguments inside have to be separated by a comma ( , )
## Remember that R is case-sensitive !
# Then I need an object (a vector) to put the array in so that I can recall my data anytime
# this is done by assignin a name for the vector (for example water) and then putting a left arrow ( <- ) before the array

# Here are the input data
# Costanza data on streams
water <- c(100, 200, 300, 400, 500)
water  # By writing water on R I can now look at the arguments in the array

# Here are other data to compare with the previous ones
# Marta data on fishes genomes
fishes <- c(10, 50, 60, 100, 200)
fishes


# Now let's plot the diversity of fishes (y) versus the amount of water (x)
# A functin (plot) is used with arguments inside!
plot(water, fishes)

# In doing a plot I can customize it by, for example, changing the dots in the bulleted list
# every symbol has a number I can find on Google images (R plot pch symbols)
# for example: 
plot (water, fishes, pch=15)  # turn the white circles into black squares
# I can also change the color of the dots (col) and the dimension of them (cex)
plot (water, fishes, pch=15, col="blue", cex=3)


#############################################################

# The data we developed can be stored in a table
# a table in R is called data frame

streams <- data.frame(water, fishes)

# From now on we are going to import or export data
setwd("C:/lab/")

# Let's export our table
write.table(streams, file="my_first_table.txt")

# Some collegues did send us a table we should import to R

read.table("my_first_table.txt")
# Let's assign it to an object inside R
chiaratable <- read.table("my_first_table.txt")
chiaratable

# The first statistics for lazy people
summary(chiaratable)

# Marta doesn't like water
# Marta wants info only on fishes
summary(chiaratable$fishes)

#histogram
hist(chiaratable$fishes)
hist(chiaratable$water)
