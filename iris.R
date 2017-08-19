################################################################################
# downloading packages
################################################################################

# install.packages("plot3D")

################################################################################
# using downloaded packages
################################################################################

library("plot3D")

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
# saving the eigenvectors plot by: defining the filename, ploting and saving
################################################################################

par(mfrow=c(1,2))

plot(
  x = eigen$vectors[,2],
  y = eigen$vectors[,3],
  col = df.col,
  pch = 16,
  xlab = "",
  ylab = ""
)

scatter3D(
  x = eigen$vectors[,2],
  y = eigen$vectors[,3],
  z = eigen$vectors[,4],
  colvar = NULL,
  col = df.col,
  pch = 16,
  theta = 45,
  phi = 45
)

legend(
  x = 'bottomleft',
  legend = unique(df.col),
  col = 1:length(df.col),
  pch = 16
)