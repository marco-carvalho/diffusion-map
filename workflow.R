################################################################################
# using lib
################################################################################

source("lib.R")

################################################################################
# defining df and variables
################################################################################

# df <- iris_df()
# df.col <- iris_color_index()

for(i in dir(path = "datasets", pattern = "*.txt", full.names = T))
{
  table <- read.table(i)
  file <- rbind(
    head(table[table$V19=='0',], 200),
    head(table[table$V19=='1',], 200)
  )
  unwanteded_cols <- c(4,6,8,10,12,14,16,18,19)
  color_col_index <- 19
  
  df <- file[,-(unwanteded_cols)]
  df.col <- file[, color_col_index]
  
  epsilon <- 0.1
  alpha <- 0.5
  
  ################################################################################
  # normalize all columns from the df
  ################################################################################
  
  df <- data.frame(apply(df, 2, normalize_column))
  
  ################################################################################
  # create the diffusion matrix
  ################################################################################
  
  l <- as.matrix(dist(df))
  
  ################################################################################
  # plot the eigenvectors
  ################################################################################
  
  png(filename = paste(substr(i, 1, nchar(i)-3), "png", sep = ""))
  
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