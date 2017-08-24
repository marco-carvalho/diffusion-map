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

  ##############################################################################
  # create the diffusion matrix from a normalized df
  ##############################################################################
  
  eigen <- eigen_matrix(
    matrix = as.matrix(
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

  ##############################################################################
  # saving the eigenvectors plot by: defining the filename, ploting and saving
  ##############################################################################

  write.table(
    x = data.frame(
      eigen$vectors[,2],
      eigen$vectors[,3],
      eigen$vectors[,4],
      eigen$vectors[,5],
      df.col
    ),
    file = paste(
      substr(
        x = i,
        start = 1,
        stop = nchar(i)-3
      ),
      "eigen.csv",
      sep = ""
    ),
    row.names = F,
    col.names = F
  )
}