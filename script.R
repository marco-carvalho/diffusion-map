stars <- read.table("oc_12_5000_2000_2.0_p019_0900_1.txt")
colnames(stars) <- c('x', 'y')

epsilon <- 0.1
alpha <- 0.5

#mover colunas para outro data.frame

#normalizar todas as colunas do data.frame
#https://stackoverflow.com/questions/12969623/normalisation-of-a-two-column-data-using-min-and-max-values

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
################################################################################

#https://stackoverflow.com/questions/27455948/in-r-whats-the-simplest-way-to-scale-a-vector-to-a-unit-vector
#https://stats.stackexchange.com/questions/53068/euclidean-distance-score-and-similarity
#http://biom300.weebly.com/eigenvalues-and-eigenvectors-in-r.html

d <- diag(colSums(l, na.rm = TRUE))
da <- d^-alpha #calcular somente para a diagonal
la <- da * l * da
