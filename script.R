stars <- read.table("dataset.txt")
epsilon <- 0.1
alpha <- 0.5

################################################################################
# normalize all columns from the df
################################################################################

normalise <- function(x) {
  ranx <- range(x, na.rm = T)
  (x - ranx[1]) / diff(ranx)
}

stars <- apply(stars, 2, normalise)

################################################################################
# creating df with stars x and y
################################################################################

stars_coord <- data.frame(stars[,1:2])
colnames(stars_coord) <- c('x', 'y')

################################################################################
# creating df with stars info
################################################################################

stars_info <- data.frame(stars[,-(1:2)])

################################################################################
# step 1 - create the matrix
################################################################################

size <- 100 #nrow(stars_coord)
l <- matrix(nrow = size, ncol = size)

# dist(rbind(stars_coord, stars_coord))
for(i in 1:size) {
  for(j in 1:size) {
    l[i,j] <- 1 - sqrt(
      (stars_coord$x[i] - stars_coord$x[j])^2 
      + 
      (stars_coord$y[i] - stars_coord$y[j])^2
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
y
