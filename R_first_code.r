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


# The data we developed can be stored in a very simple table that can be visualized directly in R
# a table in R is called data frame

streams <- data.frame(water, fishes)
streams  # Now I can see the data of my table

# If I want to see my table in another tab in R, I can use the View() function (with the initial in uppercase)
# I just have to put the name of the data set and the name I want to give to my table
View(streams, "my table")


####


# From now on, we are going to import and/or export data!

# It is convenient to create a new folder, that I'll call lab, directly in the file system, that is (C:) in Windows
# Mac and Linux users will have it different
# I'll use the setwd() function, that means set working directory, to recall the the lab folder
# I should quote the path, so I am safe with the document leaving R (with " ")
setwd("C:/lab/")

# EXPORTING
# Let's export the table I previously created using the function write.table()
# after file=, I should put, under quotes, the name I want to give to my table, plus the extention
write.table(streams, file="my_first_table.txt")

# IMPORTING
# Some collegues did send us a table. How to import it in R? Answer: by using the function read.table()
# Since I take the table from outside R, I should protect it by using quotes
read.table("my_first_table.txt")

# Let's assign the table to an object inside of R, so I can recall it anytime
chiaratable <- read.table("my_first_table.txt")  # I created a new object
chiaratable  # In R this is not called table, but data frame


# Let's do my first statistics (for lazy people)

# For example, I want to get all the information of my table, such as the minimum value, the maximum, the median, the mean, the 1st quartile and the 3rd quartile
summary(chiaratable)

# Marta doesn't like water, she wants info only on fishes
# I can do the statistics only for one variable of the table
# This is achieved by putting the $ symbol between the name of the table and the variable I'm interested in
summary(chiaratable$fishes)

# I can also visualize the variables as histograms by simply use the function hist()
# The hist() function require a vector
# The histogram will show the frequency of data by showing how many data exist for each interval
hist(chiaratable$fishes)
hist(chiaratable$water)
