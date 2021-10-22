# This is my first code in GitHub

# Here are the input data
# Costanza data on streams
water <- c(100,200,300,400,500)

# Marta data on fishes genomes
fishes <- c(10,50,60,100,200)

# Plot the diversity of fishes (y) versus the amount of water (x)
# A functin is used with arguments inside
plot(water, fishes)

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
