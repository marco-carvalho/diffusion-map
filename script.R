#df <- read.table("dataset.txt")
df <- iris
plot(iris$Sepal.Length, iris$Sepal.Width)
epsilon <- 0.1
alpha <- 0.5

################################################################################
# normalize all columns from the df
################################################################################

normalise <- function(x) {
  ranx <- range(x, na.rm = T)
  (x - ranx[1]) / diff(ranx)
}

df <- apply(df, 2, normalise)

################################################################################
# creating df with df x and y
################################################################################

df_coord <- data.frame(df[,1:2])
colnames(df_coord) <- c('x', 'y')

################################################################################
# creating df with df info
################################################################################

df_info <- data.frame(df[,-(1:2)])

################################################################################
# step 1 - create the matrix
################################################################################

size <- 100 #nrow(df_coord)
l <- matrix(nrow = size, ncol = size)

# dist(rbind(df_coord, df_coord))
for(i in 1:size) {
  for(j in 1:size) {
    l[i,j] <- 1 - sqrt(
      (df_coord$x[i] - df_coord$x[j])^2 
      + 
      (df_coord$y[i] - df_coord$y[j])^2
    )
  }
}

################################################################################
# step 2 - normalize the matrix
################################################################################

d <- diag(colSums(l, na.rm = TRUE))
d_a <- diag(diag(d^-alpha))
la <- d_a %*% l %*% d_a

################################################################################
# step 3 - form the normalized matrix
################################################################################

da <- diag(colSums(la, na.rm = TRUE))
m <- solve(da) %*% la

################################################################################
# step 4 - Compute the k largest eigenvalues and the corresponding eigenvectors
# http://biom300.weebly.com/eigenvalues-and-eigenvectors-in-r.html
################################################################################

y <- eigen(t(m))