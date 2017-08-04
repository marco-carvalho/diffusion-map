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
  
  write.table(
    data.frame(
      eigen_matrix(l)$vectors[,2],
      eigen_matrix(l)$vectors[,3],
      eigen_matrix(l)$vectors[,4],
      eigen_matrix(l)$vectors[,5],
      df.col
    ),
    file = paste(
      substr(
        x = i, 
        start = 1, 
        stop = nchar(i)-3
      ),
      "eigen.txt",
      sep = ""
    ),
    row.names = F,
    col.names = F
  )
}