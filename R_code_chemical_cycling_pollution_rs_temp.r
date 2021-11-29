# Lesson 26/22/2021



# Day 2

library(raster)
setwd("C:/lab/en")

# Importing all the data together with the lapply function
# Writing "EN" means list all the files with the same name, i.e. EN
rlist <- list.files(pattern="EN")
rlist

list_rast <- lapply(rlist, raster)
list_rast

EN_stack <- stack(list_rast)
EN_stack

cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(EN_stack, col=cl)

# Plot only the first image of the stack
plot(EN_stack$EN_0001, col=cl)

# Difference between the first picure and the thirteen one
ENdif <- EN_stack$EN_0001 - EN_stack$EN_0013
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(ENdif, col=cldif)

# Let's use the automated processing source function
# It is used to avoid copy pasting the code on an external file (like a shared one)
source("R_code_automatic_script.txt")
