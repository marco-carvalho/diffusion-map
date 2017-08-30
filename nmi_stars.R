# install.packages("infotheo")

################################################################################
# using lib
################################################################################

source("lib.R")
library(ggplot2)
library(infotheo)
library(plot3D)

################################################################################
# defining df and variables
################################################################################

file <- read.table("datasets/oc_12_5000_4000_4.0_p019_0950_1.eigen.csv")
df <- gen_df(file)
df.col <- gen_color_index(file)

################################################################################
# testing the quality of the generated cluster with the NMI
################################################################################

x = kmeans(df[, 2], 2)$cluster
y = df.col
mutinformation(x,y)/((entropy(x) + entropy(y))/2) 

x = kmeans(df[, 2:3], 2)$cluster
y = df.col
mutinformation(x,y)/((entropy(x) + entropy(y))/2) 

x = kmeans(df[, 2:4], 2)$cluster
y = df.col
mutinformation(x,y)/((entropy(x) + entropy(y))/2) 

x = kmeans(df[, 1:4], 2)$cluster
y = df.col
mutinformation(x,y)/((entropy(x) + entropy(y))/2)
