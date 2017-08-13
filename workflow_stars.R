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
# loop through the df folder
################################################################################

for(i in dir(path = "datasets", pattern = "*.txt", full.names = T))
{
  file <- read.table(i)
  df <- stars_df(file)
  df.col <- stars_color_index(file)

  epsilon <- 0.1
  alpha <- 0.5

  ##############################################################################
  # create the diffusion matrix from a normalized df
  ##############################################################################

  l <- as.matrix(
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

  ##############################################################################
  # saving the eigenvectors plot by: defining the filename, ploting and saving
  ##############################################################################

  par(mfrow=c(1,2))

  png(
    filename = paste(
      substr(
        x = i,
        start = 1,
        stop = nchar(i)-3
      ),
      "png",
      sep = ""
    )
  )

  plot(
    x = eigen_matrix(l)$vectors[,2],
    y = eigen_matrix(l)$vectors[,3],
    col = df.col,
    pch = 16,
    xlab = "",
    ylab = ""
  )

  scatter3D(
    x = eigen_matrix(l)$vectors[,2],
    y = eigen_matrix(l)$vectors[,3],
    z = eigen_matrix(l)$vectors[,4],
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

  dev.off()
}
