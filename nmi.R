library(ggplot2)

################################################################################
# using lib
################################################################################

source("lib.R")

################################################################################
# defining df and variables
################################################################################

df <- iris_df()
df.col <- iris_color_index()

################################################################################
# create the diffusion matrix from a normalized df
################################################################################

eigen <- eigen_matrix(
  as.matrix(
    x = dist(
      data.frame(
        apply(
          X = df,
          MARGIN = 2,
          FUN = normalize_column
        )
      )
    )
  )
)

################################################################################
# testing the quality of the generated cluster with the NMI
################################################################################

x = kmeans(eigen$vectors[, 2], 3)$cluster
y = iris$Species
mutinformation(x,y)/((entropy(x) + entropy(y))/2) 

x = kmeans(eigen$vectors[, 2:3], 3)$cluster
y = iris$Species
mutinformation(x,y)/((entropy(x) + entropy(y))/2) 

x = kmeans(eigen$vectors[, 2:4], 3)$cluster
y = iris$Species
mutinformation(x,y)/((entropy(x) + entropy(y))/2) 
