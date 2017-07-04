################################################################################
# using lib
################################################################################

source("lib.R")

################################################################################
# defining df and variables
################################################################################

# TRANSFORMAR ISSO EM UMA FUNÇÃO
file <- iris
unwanteded_cols <- c(5)
color_col_index <- 5

# TRANSFORMAR ISSO EM UMA FUNÇÃO
# file <- read.table("dataset.txt")
# unwanteded_cols <- c(4,6,8,10,12,14,16,18,19)
# color_col_index <- 19

df <- file[,-(unwanteded_cols)]
df.col <- file[, color_col_index]

epsilon <- 0.1
alpha <- 0.5

################################################################################
# normalize all columns from the df
#######################                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       #########################################################

df <- data.frame(apply(df, 2, normalize_column))

################################################################################
# create the diffusion matrix
################################################################################

l <- as.matrix(dist(df))

################################################################################
# plot the eigenvectors
################################################################################

plot(
  x = eigen_matrix(l)$vectors[,2],
  y = eigen_matrix(l)$vectors[,3],
  pch = 21,
  bg = c(1:length(unique(df.col)))[unclass(df.col)]
)
legend(
  x = 'center',
  pch = 16,
  legend = c(levels(df.col)),
  col = c(1:length(unique(df.col))),
  text.col = c(1:length(unique(df.col)))
)
