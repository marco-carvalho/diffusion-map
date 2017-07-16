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
# loop through the df folder
################################################################################

for(i in dir(path = "datasets", pattern = "*.txt", full.names = T))
{
  file <- read.table(i)
  file <- rbind(
    head(file[file$V19=='0',], 200),
    head(file[file$V19=='1',], 200)
  )
  df <- stars_df(file)
  df.col <- stars_color_index(file)
  
  epsilon <- 0.1
  alpha <- 0.5
  
################################################################################
# create the diffusion matrix from a normalized df
################################################################################

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
  
################################################################################
# saving the eigenvectors plot by: defining the filename, ploting and saving
################################################################################

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
  col = 1:length(unique(df.col)),
  pch = 16
)
legend(
  x = 'center',
  y = 'groups',
  legend = unique(df.col),
  col = 1:length(df.col),
  pch = 16
)

dev.off()
}