df_coord <- read.table("dataset.txt")[,1:2]
df_info <- read.table("dataset.txt")[,-(1:2)]
# df <- iris
# plot(iris$Sepal.Length, iris$Sepal.Width)
epsilon <- 0.1
alpha <- 0.5

################################################################################
# normalize all columns from the df
################################################################################

normalize_column <- function(x) {
  ranx <- range(x, na.rm = T)
  (x - ranx[1]) / diff(ranx)
}

df_coord <- data.frame(apply(df_coord, 2, normalize_column))
colnames(df_coord) <- c('x', 'y')
df_info <- data.frame(apply(df_info, 2, normalize_column))

################################################################################
# step 1 - create the diffusion matrix
################################################################################

size <- 100 #nrow(df_coord)
l <- matrix(nrow = size, ncol = size)

# l <- apply(df_coord, 2, dist(rbind()))
# dist(rbind(df_coord, df_coord))
for(i in 1:size) {
  for(j in 1:size) {
    l[i,j] <- sqrt(
      (df_coord$x[i] - df_coord$x[j])^2 
      + 
      (df_coord$y[i] - df_coord$y[j])^2
    )
  }
}

################################################################################
# step 2 - apply the matrix normalization
################################################################################

diagonal <- function(matrix) {
  diag(colSums(matrix, na.rm = TRUE))
}

normalize <- function(matrix, alpha) {
  d <- diagonal(matrix)
  d_a <- diag(diag(d^-alpha))
  d_a %*% matrix %*% d_a
}

################################################################################
# step 3 - apply the graph Laplacian normalization
################################################################################

laplacian_norm <- function(matrix) {
  solve(diagonal(normalize(matrix, alpha))) %*% normalize(matrix, alpha)
}

################################################################################
# step 4 - compute the k largest eigenvalues and the corresponding eigenvectors
# http://biom300.weebly.com/eigenvalues-and-eigenvectors-in-r.html
################################################################################

df_eigen <- eigen(t(laplacian_norm(l)))

################################################################################
# step 5 - use diffusion map
################################################################################

