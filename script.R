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

stars_coord <- data.frame(
  stars[,1:2]
)
colnames(stars_coord) <- c('x', 'y')

################################################################################
# creating df with stars info
################################################################################

stars_info <- data.frame(
  stars[,-(1:2)]
)

################################################################################
# step 1 - create the matrix
################################################################################

size <- 100 #nrow(stars)
l <- matrix(nrow = size, ncol = size)

for(i in 1:size) {
  for(j in 1:size) {
    l[i,j] <- sqrt((stars$x[i] - stars$x[j])^2 + (stars$y[i] - stars$y[j])^2)
  }
}

################################################################################
# step 2 - normalize the matrix
# https://stackoverflow.com/questions/27455948/in-r-whats-the-simplest-way-to-scale-a-vector-to-a-unit-vector
# https://stats.stackexchange.com/questions/53068/euclidean-distance-score-and-similarity
# http://biom300.weebly.com/eigenvalues-and-eigenvectors-in-r.html
################################################################################

d <- diag(colSums(l, na.rm = TRUE))
da <- d^-alpha #calcular somente para a diagonal
la <- da * l * da
